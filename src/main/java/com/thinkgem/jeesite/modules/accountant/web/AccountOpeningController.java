package com.thinkgem.jeesite.modules.accountant.web;

import java.util.List;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.accountant.entity.BookRecord;
import com.thinkgem.jeesite.modules.accountant.entity.Business;
import com.thinkgem.jeesite.modules.accountant.service.BookRecordService;
import com.thinkgem.jeesite.modules.accountant.service.BusinessService;

/**
 * 科目期初
 * @author Mars9527
 * @date 2017年10月11日
 */
@Controller
@RequestMapping(value = "${adminPath}/accountant/opening")
public class AccountOpeningController {
	@Autowired
	private BookRecordService bookRecordService;
	@Autowired
	private BusinessService businessService;
	
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
	 * 预览
	 * @param bookRecord
	 * @param model
	 * @return
	 * @author Mars9527
	 * @date 2017年10月11日
	 */
	@RequiresPermissions("accountant:bookRecord:view")
	@RequestMapping(value = {"list", ""})
	public String view(BookRecord bookRecord, Model model) {
		model.addAttribute("bookRecord", bookRecord);
		
		

		return "modules/accountant/accountOpeningList";
	}
	/**
	 * 跳到新增或者编辑页面
	 * @param bookRecord
	 * @param model
	 * @return
	 * @author Mars9527
	 * @date 2017年10月11日
	 */
	@RequiresPermissions("accountant:bookRecord:edit")
	@RequestMapping(value = {"form"})
	public String form(BookRecord bookRecord, Model model) {
		Business business = new Business();
		business.setDelFlag("0");
		business.setShowHide("0");
		business.setName("账本期初");
		List<Business> businesses = businessService.findList(business);
		model.addAttribute("businesses",businesses);
		model.addAttribute("bookRecord", bookRecord);
		return "modules/accountant/accountOpeningForm";
	}
	
}
