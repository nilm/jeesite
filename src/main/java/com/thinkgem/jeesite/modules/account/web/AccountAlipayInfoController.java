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
import com.thinkgem.jeesite.modules.account.entity.AccountAlipayInfo;
import com.thinkgem.jeesite.modules.account.service.AccountAlipayInfoService;

/**
 * 用户支付宝信息Controller
 * @author evan
 * @version 2015-04-04
 */
@Controller
@RequestMapping(value = "${adminPath}/account/accountAlipayInfo")
public class AccountAlipayInfoController extends BaseController {

	@Autowired
	private AccountAlipayInfoService accountAlipayInfoService;
	
	@ModelAttribute
	public AccountAlipayInfo get(@RequestParam(required=false) String id) {
		AccountAlipayInfo entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = accountAlipayInfoService.get(id);
		}
		if (entity == null){
			entity = new AccountAlipayInfo();
		}
		return entity;
	}
	
	@RequiresPermissions("account:accountAlipayInfo:view")
	@RequestMapping(value = {"list", ""})
	public String list(AccountAlipayInfo accountAlipayInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AccountAlipayInfo> page = accountAlipayInfoService.findPage(new Page<AccountAlipayInfo>(request, response), accountAlipayInfo); 
		model.addAttribute("page", page);
		return "modules/account/accountAlipayInfoList";
	}

	@RequiresPermissions("account:accountAlipayInfo:view")
	@RequestMapping(value = "form")
	public String form(AccountAlipayInfo accountAlipayInfo, Model model) {
		model.addAttribute("accountAlipayInfo", accountAlipayInfo);
		return "modules/account/accountAlipayInfoForm";
	}

	@RequiresPermissions("account:accountAlipayInfo:edit")
	@RequestMapping(value = "save")
	public String save(AccountAlipayInfo accountAlipayInfo, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, accountAlipayInfo)){
			return form(accountAlipayInfo, model);
		}
		accountAlipayInfoService.save(accountAlipayInfo);
		addMessage(redirectAttributes, "保存支付宝信息成功");
		return "redirect:"+Global.getAdminPath()+"/account/accountAlipayInfo/?repage";
	}
	
	@RequiresPermissions("account:accountAlipayInfo:edit")
	@RequestMapping(value = "delete")
	public String delete(AccountAlipayInfo accountAlipayInfo, RedirectAttributes redirectAttributes) {
		accountAlipayInfoService.delete(accountAlipayInfo);
		addMessage(redirectAttributes, "删除支付宝信息成功");
		return "redirect:"+Global.getAdminPath()+"/account/accountAlipayInfo/?repage";
	}

}