/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.accountant.web;

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
import com.thinkgem.jeesite.modules.accountant.entity.BizBookTemplate;
import com.thinkgem.jeesite.modules.accountant.service.BizBookTemplateService;

/**
 * 业务账本关系模板Controller
 * @author 倪得渊
 * @version 2017-09-10
 */
@Controller
@RequestMapping(value = "${adminPath}/accountant/bizBookTemplate")
public class BizBookTemplateController extends BaseController {

	@Autowired
	private BizBookTemplateService bizBookTemplateService;
	
	@ModelAttribute
	public BizBookTemplate get(@RequestParam(required=false) String id) {
		BizBookTemplate entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = bizBookTemplateService.get(id);
		}
		if (entity == null){
			entity = new BizBookTemplate();
		}
		return entity;
	}
	
	@RequiresPermissions("accountant:bizBookTemplate:view")
	@RequestMapping(value = {"list", ""})
	public String list(BizBookTemplate bizBookTemplate, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BizBookTemplate> page = bizBookTemplateService.findPage(new Page<BizBookTemplate>(request, response), bizBookTemplate); 
		model.addAttribute("page", page);
		return "modules/accountant/bizBookTemplateList";
	}

	@RequiresPermissions("accountant:bizBookTemplate:view")
	@RequestMapping(value = "form")
	public String form(BizBookTemplate bizBookTemplate, Model model) {
		model.addAttribute("bizBookTemplate", bizBookTemplate);
		return "modules/accountant/bizBookTemplateForm";
	}

	@RequiresPermissions("accountant:bizBookTemplate:edit")
	@RequestMapping(value = "save")
	public String save(BizBookTemplate bizBookTemplate, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, bizBookTemplate)){
			return form(bizBookTemplate, model);
		}
		bizBookTemplateService.save(bizBookTemplate);
		addMessage(redirectAttributes, "保存业务账本关系模板成功");
		return "redirect:"+Global.getAdminPath()+"/accountant/bizBookTemplate/?repage";
	}
	
	@RequiresPermissions("accountant:bizBookTemplate:edit")
	@RequestMapping(value = "delete")
	public String delete(BizBookTemplate bizBookTemplate, RedirectAttributes redirectAttributes) {
		bizBookTemplateService.delete(bizBookTemplate);
		addMessage(redirectAttributes, "删除业务账本关系模板成功");
		return "redirect:"+Global.getAdminPath()+"/accountant/bizBookTemplate/?repage";
	}

}