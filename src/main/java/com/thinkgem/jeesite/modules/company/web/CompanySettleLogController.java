/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.company.web;

import java.util.Date;

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
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.company.entity.CompanySettleLog;
import com.thinkgem.jeesite.modules.company.service.CompanySettleLogService;
import com.thinkgem.jeesite.modules.sys.entity.Role;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 商户结算单Controller
 * @author evan
 * @version 2015-11-14
 */
@Controller
@RequestMapping(value = "${adminPath}/company/companySettleLog")
public class CompanySettleLogController extends BaseController {

	@Autowired
	private SystemService systemService;
	
	@Autowired
	private CompanySettleLogService companySettleLogService;
	
	@ModelAttribute
	public CompanySettleLog get(@RequestParam(required=false) String id) {
		CompanySettleLog entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = companySettleLogService.get(id);
			
		}
		if (entity == null){
			entity = new CompanySettleLog();
		}
		return entity;
	}
	
	@RequiresPermissions("company:companySettleLog:view")
	@RequestMapping(value = {"list", ""})
	public String list(CompanySettleLog companySettleLog, HttpServletRequest request, HttpServletResponse response, Model model) {

		Page<CompanySettleLog> page = companySettleLogService.findPage(new Page<CompanySettleLog>(request, response), companySettleLog); 
		model.addAttribute("page", page);
		model.addAttribute("noAllDate", systemService.isOwnDataScope(UserUtils.getUser(), Role.DATA_SCOPE_ALL));
		
		return "modules/company/companySettleLogList";
	}

	@RequiresPermissions("company:companySettleLog:view")
	@RequestMapping(value = "form")
	public String form(CompanySettleLog companySettleLog, Model model) {
		model.addAttribute("companySettleLog", companySettleLog);
		
		return "modules/company/companySettleLogForm";
	}

	@RequiresPermissions("company:companySettleLog:audit")
	@RequestMapping(value = "save")
	public String save(CompanySettleLog companySettleLog, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, companySettleLog)){
			return form(companySettleLog, model);
		}
		companySettleLog.setAuditBy(UserUtils.getUser());
		companySettleLog.setAuditDate(new Date());
		companySettleLogService.save(companySettleLog);
		addMessage(redirectAttributes, "保存商户结算单成功");
		return "redirect:"+Global.getAdminPath()+"/company/companySettleLog/?repage";
	}
	
	@RequiresPermissions("company:companySettleLog:edit")
//	@RequestMapping(value = "delete")
	public String delete(CompanySettleLog companySettleLog, RedirectAttributes redirectAttributes) {
		companySettleLogService.delete(companySettleLog);
		addMessage(redirectAttributes, "删除商户结算单成功");
		return "redirect:"+Global.getAdminPath()+"/company/companySettleLog/?repage";
	}

}