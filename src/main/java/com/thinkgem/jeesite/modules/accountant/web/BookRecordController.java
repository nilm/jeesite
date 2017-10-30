/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.accountant.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.accountant.dto.BizBookTemplateDto;
import com.thinkgem.jeesite.modules.accountant.entity.BizBookTemplate;
import com.thinkgem.jeesite.modules.accountant.entity.Business;
import com.thinkgem.jeesite.modules.accountant.service.BizBookTemplateService;
import com.thinkgem.jeesite.modules.accountant.service.BookService;
import com.thinkgem.jeesite.modules.accountant.service.BusinessService;
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

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.accountant.entity.BookRecord;
import com.thinkgem.jeesite.modules.accountant.service.BookRecordService;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

/**
 * 账本记录Controller
 * @author 倪得渊
 * @version 2017-09-24
 */
@Controller
@RequestMapping(value = "${adminPath}/accountant/bookRecord")
public class BookRecordController extends BaseController {

	@Autowired
	private BookRecordService bookRecordService;
	@Autowired
	private BusinessService businessService;
	@Autowired
	private BizBookTemplateService bizBookTemplateService;
	@Autowired
	private BookService bookService;
	
	@ModelAttribute
	public BookRecord get(@RequestParam(required=false) String id) {
		BookRecord entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = bookRecordService.get(id);
		}
		if (entity == null){
			entity = new BookRecord();
		}

		return entity;
	}
	
	@RequiresPermissions("accountant:bookRecord:view")
	@RequestMapping(value = {"list", ""})
	public String list(BookRecord bookRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BookRecord> page = bookRecordService.findPage(new Page<BookRecord>(request, response), bookRecord); 
		model.addAttribute("page", page);
		Business business = new Business();
		business.setDelFlag("0");
		business.setShowHide("1");

		List<Business> businesses = businessService.findList(business);
		model.addAttribute("businesses",businesses);

		return "modules/accountant/bookRecordList";
	}

	@RequiresPermissions("accountant:bookRecord:view")
	@RequestMapping(value = "form")
	public String form(BookRecord bookRecord, Model model) {
		model.addAttribute("bookRecord", bookRecord);
		Business business = new Business();
		business.setDelFlag("0");
		business.setShowHide("1");

		List<Business> businesses = businessService.findList(business);
		model.addAttribute("businesses",businesses);
		return "modules/accountant/bookRecordForm";
	}
	@RequiresPermissions("accountant:bookRecord:view")
	@RequestMapping(value = "accountForm")
	public String accountForm(BookRecord bookRecord, Model model) {
		model.addAttribute("bookRecord", bookRecord);
		Business business = new Business();
		business.setDelFlag("0");
		business.setShowHide("1");
		
		List<Business> businesses = businessService.findList(business);
		model.addAttribute("businesses",businesses);
		return "modules/accountant/accountRecordForm";
	}

	
	@RequiresPermissions("accountant:bookRecord:edit")
	@RequestMapping(value = "save")
	public String save(BookRecord bookRecord, HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {

		bookRecord.setUser(UserUtils.getUser());
		bookRecord.setCompany(UserUtils.getUser().getCompany());
		bookRecord.setStatus("user_record");
		String filesPath = request.getParameter("filesPath");

		if (!beanValidator(model, bookRecord)){
			return form(bookRecord, model);
		}
		bookRecordService.save(bookRecord,filesPath);
		addMessage(redirectAttributes, "保存账本记录成功");
		return "redirect:"+Global.getAdminPath()+"/accountant/bookRecord/?repage";
	}
	
	@RequiresPermissions("accountant:bookRecord:edit")
	@RequestMapping(value = "delete")
	public String delete(BookRecord bookRecord, RedirectAttributes redirectAttributes) {
		bookRecordService.delete(bookRecord);
		addMessage(redirectAttributes, "删除账本记录成功");
		return "redirect:"+Global.getAdminPath()+"/accountant/bookRecord/?repage";
	}

	@RequestMapping(value = "getBizBooks")
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
	@RequestMapping(value = "getBiz")
	@ResponseBody
	public String getBiz(HttpServletRequest request, HttpServletResponse response, Model model) {
		String  bizId = request.getParameter("bizId");
		Business biz = businessService.gedById(bizId);
		BaseJson json = new BaseJson();
		if(biz != null ){
			json.putData(biz.getRemarks());
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
			dto.setBookId(template.getBook().getId());
//			String  lr = template.getBook().getCategory().equals("left")?"左":"右";
			dto.setBookName(template.getBookName());
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
}