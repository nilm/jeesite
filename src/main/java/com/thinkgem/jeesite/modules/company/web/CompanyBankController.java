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
import com.thinkgem.jeesite.modules.company.entity.CompanyBank;
import com.thinkgem.jeesite.modules.company.service.CompanyBankService;

/**
 * 商户资金明细Controller
 * @author evan
 * @version 2015-11-13
 */
@Controller
@RequestMapping(value = "${adminPath}/company/companyBank")
public class CompanyBankController extends BaseController {

	@Autowired
	private CompanyBankService companyBankService;
	
	@ModelAttribute
	public CompanyBank get(@RequestParam(required=false) String id) {
		CompanyBank entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = companyBankService.get(id);
		}
		if (entity == null){
			entity = new CompanyBank();
		}
		return entity;
	}
	
	@RequiresPermissions("company:companyBank:view")
	@RequestMapping(value = {"list", ""})
	public String list(CompanyBank companyBank, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CompanyBank> page = companyBankService.findPage(new Page<CompanyBank>(request, response), companyBank); 
		model.addAttribute("page", page);
		return "modules/company/companyBankList";
	}

	@RequiresPermissions("company:companyBank:view")
	@RequestMapping(value = "form")
	public String form(CompanyBank companyBank, Model model) {
		model.addAttribute("companyBank", companyBank);
		return "modules/company/companyBankForm";
	}
	@RequiresPermissions("company:companyBank:view")
	@RequestMapping(value = "view")
	public String view(CompanyBank companyBank, Model model) {
		model.addAttribute("companyBank", companyBank);
		return "modules/company/companyBankForm";
	}

	@RequiresPermissions("company:companyBank:audit")
	@RequestMapping(value = "save")
	public String save(CompanyBank companyBank, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, companyBank)){
			return form(companyBank, model);
		}
		companyBankService.save(companyBank);
		addMessage(redirectAttributes, "保存商户资金明细成功");
		return "redirect:"+Global.getAdminPath()+"/company/companyBank/?repage";
	}
	
	@RequiresPermissions("company:companyBank:edit")
	@RequestMapping(value = "delete")
	public String delete(CompanyBank companyBank, RedirectAttributes redirectAttributes) {
		companyBankService.delete(companyBank);
		addMessage(redirectAttributes, "删除商户资金明细成功");
		return "redirect:"+Global.getAdminPath()+"/company/companyBank/?repage";
	}

}