/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.accountant.web;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.money.FundAbacusUtil;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.accountant.dto.BizBookTemplateDto;
import com.thinkgem.jeesite.modules.accountant.entity.*;
import com.thinkgem.jeesite.modules.accountant.service.BizBookTemplateService;
import com.thinkgem.jeesite.modules.accountant.service.BookService;
import com.thinkgem.jeesite.modules.accountant.service.BusinessService;
import com.thinkgem.jeesite.modules.accountant.service.SourceDocService;
import com.thinkgem.jeesite.modules.rest.json.BaseJson;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

/**
 * 原始业务记录Controller
 * @author 倪得渊
 * @version 2017-09-16
 */
@Controller
@RequestMapping(value = "${adminPath}/accountant/sourceDoc")
public class SourceDocController extends BaseController {

	@Autowired
	private SourceDocService sourceDocService;
	@Autowired
	private BusinessService businessService;
	@Autowired
	private BizBookTemplateService bizBookTemplateService;
	@Autowired
	private BookService bookService;

	@ModelAttribute
	public SourceDoc get(@RequestParam(required=false) String id) {
		SourceDoc entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = sourceDocService.get(id);
		}
		if (entity == null){
			entity = new SourceDoc();
		}
		return entity;
	}
	
	@RequiresPermissions("accountant:sourceDoc:view")
	@RequestMapping(value = {"list", ""})
	public String list(SourceDoc sourceDoc, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SourceDoc> page = sourceDocService.findPage(new Page<SourceDoc>(request, response), sourceDoc); 
		model.addAttribute("page", page);
		return "modules/accountant/sourceDocList";
	}
	@RequestMapping(value = "getBizSubjects")
	@ResponseBody
	public String getBizSubjects(BizBookTemplate bizBookTemplate, HttpServletRequest request, HttpServletResponse response, Model model) {
		String  bizId = request.getParameter("bizId");
		BaseJson json = new BaseJson();
			List<BizBookTemplate> bizBookTemplates = bizBookTemplateService.findList(bizBookTemplate);
			List<BizBookTemplateDto> bizBookTemplateDtos = convertList2Dto(bizBookTemplates);
			if(bizBookTemplateDtos != null ){
				json.putData(bizBookTemplateDtos);
				return  json.toJson();
			}
		json.fail("请选择所发生的业务");
		return json.toJson();
	}

	private List<BizBookTemplateDto> convertList2Dto(List<BizBookTemplate> bizBookTemplates){
		if(bizBookTemplates == null || bizBookTemplates.size() <= 0){
			return null;
		}
		List<BizBookTemplateDto> dtos =  new ArrayList<BizBookTemplateDto>();
		for (BizBookTemplate template: bizBookTemplates ) {
			BizBookTemplateDto dto = new BizBookTemplateDto();
			dto.setBizId(template.getBiz().getId());
			dto.setSubjectId(template.getBook().getId());
			dto.setSubjectName(template.getBookName());
			dto.setDirection(template.getDirection());
			dto.setLrDirection(template.getLrDirection());
			dto.setFixed(template.getFixed());
			dto.setSelectType(template.getSelectType());
			dto.setGroupTag(template.getGroupTag());
			//TODO:增加 多单选 分组区分等
			dtos.add(dto);
		}
		return dtos;
	}

	@RequiresPermissions("accountant:sourceDoc:view")
	@RequestMapping(value = "form")
	public String form(SourceDoc sourceDoc, Model model) {
		model.addAttribute("sourceDoc", sourceDoc);
		Business business = new Business();
		business.setDelFlag("0");
		business.setShowHide("1");

		List<Business> businesses = businessService.findList(business);
		logger.info("businesses == "+businesses.size());
		model.addAttribute("businesses",businesses);

		return "modules/accountant/sourceDocForm";
	}

	@RequiresPermissions("accountant:sourceDoc:edit")
	@RequestMapping(value = "save")
	public String save(SourceDoc sourceDoc, Model model, HttpServletRequest request ,RedirectAttributes redirectAttributes) {
		sourceDoc.setUser(UserUtils.getUser());
		sourceDoc.setCompany(UserUtils.getUser().getCompany());
		sourceDoc.setStatus("draf");
		String filesPath = request.getParameter("filesPath");

		if (!beanValidator(model, sourceDoc)){
			return form(sourceDoc, model);
		}
		if (!accountantRuleValidator(sourceDoc) ){
			addMessage(redirectAttributes, "不符合记账规则，请重新填写");
			return form(sourceDoc, model);
		}
		sourceDocService.save(sourceDoc,filesPath);

		addMessage(redirectAttributes, "保存原始业务记录成功");
		return "redirect:"+Global.getAdminPath()+"/accountant/sourceDoc/?repage";
	}

	/**
	 * 可分为以下几种情况
	 *  基础前提： 现金 银行存款 应付账款 为 左账本
	 *  依据左左增为前提会出现的情况为
	 *  	1.左右减
	 *  	2.右右增
	 *  依据左右减为前提会出现以下情况
	 *  	1.左左增
	 *  	2.右左减
	 *  应付与之相反
	 *
	 * @param sourceDoc
	 * @return
	 */
	private boolean accountantRuleValidator(SourceDoc sourceDoc){
		// 四种账户类型校验
		//"bank" payable --应付账款  receivable  应收账款 cash  现金
		String bizId = sourceDoc.getBizId();
		String money = sourceDoc.getMoney();

		Business business = businessService.get(bizId);
		String bizType = business.getBizType();
		// 资产  左  增|减  看对面

		BigDecimal targetSubjectMoney = new BigDecimal("0");
		boolean validatorDirection  = true;
		for (SourceDocSubject sourceDocSubject : sourceDoc.getSourceDocSubjectList()){
			if (sourceDocSubject.getId() == null){
				continue;
			}
			if (SourceDocSubject.DEL_FLAG_NORMAL.equals(sourceDocSubject.getDelFlag())){
				String subjectId = sourceDocSubject.getSubjectId();
				Book suject = bookService.get(subjectId);
				if (isLeftAccountType(sourceDoc.getAccountType())) { // 必须为左账户类型的 现金 银行存款 应付账款
					if ("income".equals(bizType)) {//收入-- 增加类 ---  左左增
						if ("left".equals(suject.getCategory())) {// 左右减
							sourceDocSubject.setDirection("0");
						} else {
							sourceDocSubject.setDirection("1");// 右右增
						}
					} else if ("expense".equals(bizType)) {//支付  本科目减少类 类型 --- 左右减
						if ("left".equals(suject.getCategory())) {// 左左增
							sourceDocSubject.setDirection("1");
						} else {
							sourceDocSubject.setDirection("0");// 右左减
						}
					} else {//转账  --  左右减
						sourceDocSubject.setDirection("0");
					}
				} else { //右账户 应付账款 变化  右右 情况
					if ("expense".equals(bizType)) {//支出类 右右增 购买商品 未付款
						if ("left".equals(suject.getCategory())) {// 左左增
							sourceDocSubject.setDirection("1");
						} else {
							sourceDocSubject.setDirection("0");// 右左减
						}
					}
					// 偿还应付款
				}

				targetSubjectMoney.add(new BigDecimal(sourceDocSubject.getAmount()));
			}
		}

		if ( FundAbacusUtil.compare(targetSubjectMoney,money) == 0 ){

		}

		if ("bank".equals(sourceDoc.getAccountType())){
			if (bizType.equals("income")){


			}
		}else if ("receivable".equals(sourceDoc.getAccountType())){

		}else if ("cash".equals(sourceDoc.getAccountType())){

		}else if ("payable".equals(sourceDoc.getAccountType())){

		}

		return false;
	}

	/**
	 * 记账时是否为做账本类型
	 * @param accountType
	 * @return
	 */
	private boolean isLeftAccountType(String accountType){
		String leftAccountType = "bank,cash,receivable";
		return  leftAccountType.contains(accountType);
	}
	@RequiresPermissions("accountant:sourceDoc:edit")
	@RequestMapping(value = "delete")
	public String delete(SourceDoc sourceDoc, RedirectAttributes redirectAttributes) {
		sourceDocService.delete(sourceDoc);
		addMessage(redirectAttributes, "删除原始业务记录成功");
		return "redirect:"+Global.getAdminPath()+"/accountant/sourceDoc/?repage";
	}

}