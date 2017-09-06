/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.base.web;

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
import com.thinkgem.jeesite.modules.base.entity.Replenish;
import com.thinkgem.jeesite.modules.base.service.ReplenishService;

/**
 * 充值记录Controller
 * @author binger
 * @version 2016-03-16
 */
@Controller
@RequestMapping(value = "${adminPath}/base/replenish")
public class ReplenishController extends BaseController {

	@Autowired
	private ReplenishService replenishService;
	
	@ModelAttribute
	public Replenish get(@RequestParam(required=false) String id) {
		Replenish entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = replenishService.get(id);
		}
		if (entity == null){
			entity = new Replenish();
		}
		return entity;
	}
	
	@RequiresPermissions("base:replenish:view")
	@RequestMapping(value = {"list", ""})
	public String list(Replenish replenish, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Replenish> page = replenishService.findPage(new Page<Replenish>(request, response), replenish); 
		model.addAttribute("page", page);
		return "modules/base/replenishList";
	}

	@RequiresPermissions("base:replenish:view")
	@RequestMapping(value = "form")
	public String form(Replenish replenish, Model model) {
		model.addAttribute("replenish", replenish);
		return "modules/base/replenishForm";
	}

	@RequiresPermissions("base:replenish:edit")
	@RequestMapping(value = "save")
	public String save(Replenish replenish, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, replenish)){
			return form(replenish, model);
		}
		replenishService.save(replenish);
		addMessage(redirectAttributes, "保存充值记录成功");
		return "redirect:"+Global.getAdminPath()+"/base/replenish/?repage";
	}
	
	@RequiresPermissions("base:replenish:edit")
	@RequestMapping(value = "delete")
	public String delete(Replenish replenish, RedirectAttributes redirectAttributes) {
		replenishService.delete(replenish);
		addMessage(redirectAttributes, "删除充值记录成功");
		return "redirect:"+Global.getAdminPath()+"/base/replenish/?repage";
	}

}