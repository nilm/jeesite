package com.thinkgem.jeesite.modules.accountant.web;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.accountant.entity.BookRecordDetail;
import com.thinkgem.jeesite.modules.accountant.enums.BookRecordType;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.accountant.entity.BookRecord;
import com.thinkgem.jeesite.modules.accountant.entity.Business;
import com.thinkgem.jeesite.modules.accountant.service.BizBookTemplateService;
import com.thinkgem.jeesite.modules.accountant.service.BookRecordService;
import com.thinkgem.jeesite.modules.accountant.service.BusinessService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

@Controller
@RequestMapping(value = "${adminPath}/accountant/account")
public class AccountRecordController  extends BaseController {
	
	@Autowired
	private BookRecordService bookRecordService;
	@Autowired
	private BusinessService businessService;
	@Autowired
	private BizBookTemplateService bizBookTemplateService;
	
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
	/**
	 * 列表查询
	 * @param bookRecord
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @author Mars9527
	 * @date 2017年10月11日
	 */
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

		return "modules/accountant/accountRecordList";
	}
	
	/**
	 * 跳到录入页面
	 * @param bookRecord
	 * @param model
	 * @return
	 */
	@RequiresPermissions("accountant:bookRecord:view")
	@RequestMapping(value = "accountForm")
	public String accountForm(BookRecord bookRecord, Model model) {

		if (bookRecord==null || StringUtils.isBlank(bookRecord.getId())){
			bookRecord.setRecordDate(new Date());
		}

		List<BookRecordDetail> bookRecordDetails = bookRecord.getBookRecordDetailList();
		for (BookRecordDetail bookRecordDetail : bookRecordDetails) {
			String lr = bookRecordDetail.getBook().getCategory();
			String bookDisplayName =bookRecordDetail.getBookName()+"（"+ DictUtils.getDictLabel(lr,"accountant_left_right","")+"）";
			bookRecordDetail.setBookName(bookDisplayName);
		}
		bookRecord.setBookRecordDetailList(bookRecordDetails);

		model.addAttribute("bookRecord", bookRecord);

		Business business = new Business();
		business.setDelFlag("0");
		business.setShowHide("1");
		
		List<Business> businesses = businessService.findList(business);
		model.addAttribute("businesses",businesses);
		return "modules/accountant/accountRecordForm";
	}

	/**
	 * 保存记录
	 * @param bookRecord
	 * @param request
	 * @param model
	 * @param redirectAttributes
	 * @return
	 * @author Mars9527
	 * @date 2017年10月11日
	 */
	@RequiresPermissions("accountant:bookRecord:edit")
	@RequestMapping(value = "save")
	public String save(BookRecord bookRecord, HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {

		bookRecord.setUser(UserUtils.getUser());
		bookRecord.setCompany(UserUtils.getUser().getCompany());
		bookRecord.setStatus("user_record");
		bookRecord.setBookRecordType(BookRecordType.DAILY);
		String filesPath = request.getParameter("filesPath");

		if (!beanValidator(model, bookRecord)){
			return form(bookRecord, model);
		}
		bookRecordService.save(bookRecord,filesPath);
		addMessage(redirectAttributes, "保存账本记录成功");
		return "redirect:"+Global.getAdminPath()+"/accountant/account/?repage";
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
	

}
