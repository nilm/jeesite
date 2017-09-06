/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sms.web;

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
import com.thinkgem.jeesite.modules.sms.entity.SmsLog;
import com.thinkgem.jeesite.modules.sms.service.SmsLogService;

/**
 * 短信记录Controller
 * @author evan
 * @version 2015-11-13
 */
@Controller
@RequestMapping(value = "${adminPath}/sms/smsLog")
public class SmsLogController extends BaseController {

	@Autowired
	private SmsLogService smsLogService;
	
	@ModelAttribute
	public SmsLog get(@RequestParam(required=false) String id) {
		SmsLog entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = smsLogService.get(id);
		}
		if (entity == null){
			entity = new SmsLog();
		}
		return entity;
	}
	
	@RequiresPermissions("sms:smsLog:view")
	@RequestMapping(value = {"list", ""})
	public String list(SmsLog smsLog, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SmsLog> page = smsLogService.findPage(new Page<SmsLog>(request, response), smsLog); 
		model.addAttribute("page", page);
		return "modules/sms/smsLogList";
	}

	@RequiresPermissions("sms:smsLog:view")
	@RequestMapping(value = "form")
	public String form(SmsLog smsLog, Model model) {
		model.addAttribute("smsLog", smsLog);
		return "modules/sms/smsLogForm";
	}

	@RequiresPermissions("sms:smsLog:edit")
	@RequestMapping(value = "save")
	public String save(SmsLog smsLog, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, smsLog)){
			return form(smsLog, model);
		}
		smsLogService.save(smsLog);
		addMessage(redirectAttributes, "保存短信记录成功");
		return "redirect:"+Global.getAdminPath()+"/sms/smsLog/?repage";
	}
	
	@RequiresPermissions("sms:smsLog:edit")
	@RequestMapping(value = "delete")
	public String delete(SmsLog smsLog, RedirectAttributes redirectAttributes) {
		smsLogService.delete(smsLog);
		addMessage(redirectAttributes, "删除短信记录成功");
		return "redirect:"+Global.getAdminPath()+"/sms/smsLog/?repage";
	}

}