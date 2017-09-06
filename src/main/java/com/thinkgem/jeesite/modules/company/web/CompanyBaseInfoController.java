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
import com.thinkgem.jeesite.modules.company.service.CompanyBankService;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 账户概览Controller
 * @author evan
 * @version 2015-11-22
 */
@Controller
@RequestMapping(value = "${adminPath}/company/companyBaseInfo")
public class CompanyBaseInfoController extends BaseController {

	@Autowired
	private CompanyAccountService companyAccountService;
	@Autowired
	private CompanyBankService companyBankService;
	
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
	
	@RequiresPermissions("company:companyBaseInfo:view")
	@RequestMapping(value = {"view", ""})
	public String view(CompanyAccount companyAccount,  Model model) {
		
		User user = UserUtils.getUser();
		
		Office company  = user.getCompany();
		
		logger.info("company ===" + company.getName());
		model.addAttribute("company", company);
		
		
		
		return "modules/company/companyBaseInfo";
	}

	@RequiresPermissions("company:companyAccount:view")
	@RequestMapping(value = "form")
	public String form(CompanyAccount companyAccount, Model model) {
		model.addAttribute("companyAccount", companyAccount);
		return "modules/company/companyAccountIndex";
	}
	

}