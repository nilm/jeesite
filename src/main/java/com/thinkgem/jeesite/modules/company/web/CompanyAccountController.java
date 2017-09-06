/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.company.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.company.entity.CompanyAccount;
import com.thinkgem.jeesite.modules.company.service.CompanyAccountService;

/**
 * 商户账户Controller
 * @author evan
 * @version 2015-11-13
 */
@Controller
@RequestMapping(value = "${adminPath}/company/companyAccount")
public class CompanyAccountController extends BaseController {

	@Autowired
	private CompanyAccountService companyAccountService;
	
	@ModelAttribute
	public CompanyAccount get(@RequestParam(required=false) String id) {
		CompanyAccount entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = companyAccountService.get(id);
		}
		if (entity == null){
			entity = new CompanyAccount();
		}
		return entity;
	}
	
	@RequiresPermissions("company:companyAccount:view")
	@RequestMapping(value = {"list", ""})
	public String list(CompanyAccount companyAccount, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CompanyAccount> page = companyAccountService.findPage(new Page<CompanyAccount>(request, response), companyAccount); 
		model.addAttribute("page", page);
		return "modules/company/companyAccountList";
	}

	@RequiresPermissions("company:companyAccount:view")
	@RequestMapping(value = "form")
	public String form(CompanyAccount companyAccount, Model model) {
		model.addAttribute("companyAccount", companyAccount);
		return "modules/company/companyAccountIndex";
	}

	@RequiresPermissions("company:companyAccount:edit")
//	@RequestMapping(value = "save")
	public String save(CompanyAccount companyAccount, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, companyAccount)){
			return form(companyAccount, model);
		}
		companyAccountService.save(companyAccount);
		addMessage(redirectAttributes, "保存商户账户成功");
		return "redirect:"+Global.getAdminPath()+"/company/companyAccount/?repage";
	}
	
	@RequiresPermissions("company:companyAccount:edit")
//	@RequestMapping(value = "delete")
	public String delete(CompanyAccount companyAccount, RedirectAttributes redirectAttributes) {
		companyAccountService.delete(companyAccount);
		addMessage(redirectAttributes, "删除商户账户成功");
		return "redirect:"+Global.getAdminPath()+"/company/companyAccount/?repage";
	}

}