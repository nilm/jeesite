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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.base.entity.WebUser;
import com.thinkgem.jeesite.modules.base.service.WebUserService;
import com.thinkgem.jeesite.modules.sys.service.SystemService;

/**
 * 前台基本类Controller
 * @author evan
 * @version 2015-03-21
 */
@Controller
@RequestMapping(value = "${adminPath}/base/webUser")
public class WebUserController extends BaseController {

	@Autowired
	private WebUserService webUserService;
	
	@ModelAttribute
	public WebUser get(@RequestParam(required=false) String id) {
		WebUser entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = webUserService.get(id);
		}
		if (entity == null){
			entity = new WebUser();
		}
		return entity;
	}
	
	@RequiresPermissions("base:webUser:view")
	@RequestMapping(value = {"list", ""})
	public String list(WebUser webUser, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<WebUser> page = webUserService.findPage(new Page<WebUser>(request, response), webUser); 
		model.addAttribute("page", page);
		return "modules/base/webUserList";
	}

	@RequiresPermissions("base:webUser:view")
	@RequestMapping(value = "form")
	public String form(WebUser webUser, Model model) {
		model.addAttribute("webUser", webUser);
		return "modules/base/webUserForm";
	}

	@RequiresPermissions("base:webUser:edit")
	@RequestMapping(value = "save")
	public String save(WebUser webUser, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, webUser)){
			return form(webUser, model);
		}
		// 如果密码为空，则不更换密码
		if (StringUtils.isNotBlank(webUser.getPassword())) {
			webUser.setPassword(SystemService.entryptPassword(webUser.getPassword()));
		}
		
		if (!"true".equals(checkLoginName(webUser.getUserName()))){
			addMessage(model, "保存用户'" + webUser.getUserName() + "'失败，用户名已存在");
			return form(webUser, model);
		}
		webUserService.save(webUser);
		addMessage(redirectAttributes, "保存前台用户成功");
		return "redirect:"+Global.getAdminPath()+"/base/webUser/?repage";
	}
	
/*	
 * 不提供删除用户操作
 	@RequiresPermissions("base:webUser:edit")
	@RequestMapping(value = "delete")
	public String delete(WebUser webUser, RedirectAttributes redirectAttributes) {
		webUserService.delete(webUser);
		addMessage(redirectAttributes, "删除前台用户成功");
		return "redirect:"+Global.getAdminPath()+"/base/webUser/?repage";
	}*/
//=================扩张方法============================
	
	/**
	 * 验证用户名是否重复
	 * @param userName
	 * @return
	 */
	@ResponseBody
	@RequiresPermissions("base:webUser:edit")
	@RequestMapping(value = "checkUserName")
	public String checkLoginName(String userName) {
		
		if (userName !=null && webUserService.getByUserName(userName) == null) {
			return "true";
		}
		return "false";
	}
}