/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.account.web;

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
import com.thinkgem.jeesite.modules.account.entity.Banks;
import com.thinkgem.jeesite.modules.account.service.BanksService;

/**
 * 用户银行卡Controller
 * @author evan
 * @version 2015-04-04
 */
@Controller
@RequestMapping(value = "${adminPath}/account/banks")
public class BanksController extends BaseController {

	@Autowired
	private BanksService banksService;
	
	@ModelAttribute
	public Banks get(@RequestParam(required=false) String id) {
		Banks entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = banksService.get(id);
		}
		if (entity == null){
			entity = new Banks();
		}
		return entity;
	}
	
	@RequiresPermissions("account:banks:view")
	@RequestMapping(value = {"list", ""})
	public String list(Banks banks, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Banks> page = banksService.findPage(new Page<Banks>(request, response), banks); 
		model.addAttribute("page", page);
		return "modules/account/banksList";
	}

	@RequiresPermissions("account:banks:view")
	@RequestMapping(value = "form")
	public String form(Banks banks, Model model) {
		model.addAttribute("banks", banks);
		return "modules/account/banksForm";
	}

	@RequiresPermissions("account:banks:edit")
	@RequestMapping(value = "save")
	public String save(Banks banks, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, banks)){
			return form(banks, model);
		}
		banksService.save(banks);
		addMessage(redirectAttributes, "保存用户银行卡成功");
		return "redirect:"+Global.getAdminPath()+"/account/banks/?repage";
	}
	
	@RequiresPermissions("account:banks:edit")
	@RequestMapping(value = "delete")
	public String delete(Banks banks, RedirectAttributes redirectAttributes) {
		banksService.delete(banks);
		addMessage(redirectAttributes, "删除用户银行卡成功");
		return "redirect:"+Global.getAdminPath()+"/account/banks/?repage";
	}

}