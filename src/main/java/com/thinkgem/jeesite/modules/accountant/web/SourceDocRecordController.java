/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.accountant.web;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.accountant.entity.Book;
import com.thinkgem.jeesite.modules.accountant.entity.Business;
import com.thinkgem.jeesite.modules.accountant.service.BookService;
import com.thinkgem.jeesite.modules.accountant.service.BusinessService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 记账Controller
 * @author 倪得渊
 * @version 2017-09-10
 */
@Controller
@RequestMapping(value = "${adminPath}/accountant/sourcerecord")
public class SourceDocRecordController extends BaseController {

	@Autowired
	private BusinessService businessService;

	@Autowired
	private BookService bookService;

	@ModelAttribute
	public Business get(@RequestParam(required=false) String id) {
		Business entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = businessService.get(id);
		}
		if (entity == null){
			entity = new Business();
		}
		return entity;
	}
	
	@RequiresPermissions("source:record:view")
	@RequestMapping(value = {"list", ""})
	public String list(Business business, HttpServletRequest request, HttpServletResponse response, Model model) {
//		business.setBizType("income");
		business.setShowHide("1");// 显示 收入的

		Page<Business> businesses = businessService.findPage(new Page<Business>(request, response), business);
		model.addAttribute("businesses", businesses);

		return "modules/accountant/sourceRecord";
	}

	@RequiresPermissions("accountant:business:view")
	@RequestMapping(value = "form")
	public String form(Business business, Model model) {
		model.addAttribute("business", business);

		return "modules/accountant/businessForm";
	}

	@RequiresPermissions("accountant:business:edit")
	@RequestMapping(value = "save")
	public String save(Business business, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, business)){
			return form(business,model);
		}
		businessService.save(business);
		addMessage(redirectAttributes, "保存会计业务成功");
		return "redirect:"+Global.getAdminPath()+"/accountant/business/?repage";
	}
	
	@RequiresPermissions("accountant:business:edit")
	@RequestMapping(value = "delete")
	public String delete(Business business, RedirectAttributes redirectAttributes) {
		businessService.delete(business);
		addMessage(redirectAttributes, "删除会计业务成功");
		return "redirect:"+Global.getAdminPath()+"/accountant/business/?repage";
	}

}