/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.accountant.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.accountant.entity.Business;
import com.thinkgem.jeesite.modules.accountant.service.BusinessService;
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
import com.thinkgem.jeesite.modules.accountant.entity.Source;
import com.thinkgem.jeesite.modules.accountant.service.SourceService;

import java.util.List;

/**
 * 原始业务记录Controller
 * @author 倪得渊
 * @version 2017-09-26
 */
@Controller
@RequestMapping(value = "${adminPath}/accountant/source")
public class SourceController extends BaseController {

	@Autowired
	private SourceService sourceService;
	@Autowired
	private BusinessService businessService;

	@ModelAttribute
	public Source get(@RequestParam(required=false) String id) {
		Source entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = sourceService.get(id);
		}
		if (entity == null){
			entity = new Source();
		}
		return entity;
	}
	
	@RequiresPermissions("accountant:source:view")
	@RequestMapping(value = {"list", ""})
	public String list(Source source, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Source> page = sourceService.findPage(new Page<Source>(request, response), source); 
		model.addAttribute("page", page);
		Business business = new Business();
		business.setDelFlag("0");
		business.setShowHide("1");

		List<Business> businesses = businessService.findList(business);
		model.addAttribute("businesses",businesses);

		return "modules/accountant/sourceList";
	}

	@RequiresPermissions("accountant:source:view")
	@RequestMapping(value = "form")
	public String form(Source source, Model model) {
		model.addAttribute("source", source);
		Business business = new Business();
		business.setDelFlag("0");
		business.setShowHide("1");

		List<Business> businesses = businessService.findList(business);
		model.addAttribute("businesses",businesses);

		return "modules/accountant/sourceForm";
	}

	@RequiresPermissions("accountant:source:edit")
	@RequestMapping(value = "save")
	public String save(Source source, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, source)){
			return form(source, model);
		}
		sourceService.save(source);
		addMessage(redirectAttributes, "保存原始业务记录成功");
		return "redirect:"+Global.getAdminPath()+"/accountant/source/?repage";
	}
	
	@RequiresPermissions("accountant:source:edit")
	@RequestMapping(value = "delete")
	public String delete(Source source, RedirectAttributes redirectAttributes) {
		sourceService.delete(source);
		addMessage(redirectAttributes, "删除原始业务记录成功");
		return "redirect:"+Global.getAdminPath()+"/accountant/source/?repage";
	}

}