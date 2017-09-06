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
import com.thinkgem.jeesite.modules.company.entity.CompanyFunddetail;
import com.thinkgem.jeesite.modules.company.service.CompanyFunddetailService;

/**
 * 商户资金明细Controller
 * @author evan
 * @version 2015-11-13
 */
@Controller
@RequestMapping(value = "${adminPath}/company/companyFunddetail")
public class CompanyFunddetailController extends BaseController {

	@Autowired
	private CompanyFunddetailService companyFunddetailService;
	
	@ModelAttribute
	public CompanyFunddetail get(@RequestParam(required=false) String id) {
		CompanyFunddetail entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = companyFunddetailService.get(id);
		}
		if (entity == null){
			entity = new CompanyFunddetail();
		}
		return entity;
	}
	
	@RequiresPermissions("company:companyFunddetail:view")
	@RequestMapping(value = {"list", ""})
	public String list(CompanyFunddetail companyFunddetail, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CompanyFunddetail> page = companyFunddetailService.findPage(new Page<CompanyFunddetail>(request, response), companyFunddetail); 
		model.addAttribute("page", page);
		return "modules/company/companyFunddetailList";
	}

	@RequiresPermissions("company:companyFunddetail:view")
	@RequestMapping(value = "form")
	public String form(CompanyFunddetail companyFunddetail, Model model) {
		model.addAttribute("companyFunddetail", companyFunddetail);
		return "modules/company/companyFunddetailForm";
	}

	@RequiresPermissions("company:companyFunddetail:edit")
	@RequestMapping(value = "save")
	public String save(CompanyFunddetail companyFunddetail, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, companyFunddetail)){
			return form(companyFunddetail, model);
		}
		companyFunddetailService.save(companyFunddetail);
		addMessage(redirectAttributes, "保存商户资金明细成功");
		return "redirect:"+Global.getAdminPath()+"/company/companyFunddetail/?repage";
	}
	
	@RequiresPermissions("company:companyFunddetail:edit")
	@RequestMapping(value = "delete")
	public String delete(CompanyFunddetail companyFunddetail, RedirectAttributes redirectAttributes) {
		companyFunddetailService.delete(companyFunddetail);
		addMessage(redirectAttributes, "删除商户资金明细成功");
		return "redirect:"+Global.getAdminPath()+"/company/companyFunddetail/?repage";
	}

}