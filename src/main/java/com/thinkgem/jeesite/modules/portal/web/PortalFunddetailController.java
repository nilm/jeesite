/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.portal.web;

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
import com.thinkgem.jeesite.modules.portal.entity.PortalFunddetail;
import com.thinkgem.jeesite.modules.portal.service.PortalFunddetailService;

/**
 * 平台资金流动Controller
 * @author evan
 * @version 2015-11-21
 */
@Controller
@RequestMapping(value = "${adminPath}/portal/portalFunddetail")
public class PortalFunddetailController extends BaseController {

	@Autowired
	private PortalFunddetailService portalFunddetailService;
	
	@ModelAttribute
	public PortalFunddetail get(@RequestParam(required=false) String id) {
		PortalFunddetail entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = portalFunddetailService.get(id);
		}
		if (entity == null){
			entity = new PortalFunddetail();
		}
		return entity;
	}
	
	@RequiresPermissions("portal:portalFunddetail:view")
	@RequestMapping(value = {"list", ""})
	public String list(PortalFunddetail portalFunddetail, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<PortalFunddetail> page = portalFunddetailService.findPage(new Page<PortalFunddetail>(request, response), portalFunddetail); 
		model.addAttribute("page", page);
		return "modules/portal/portalFunddetailList";
	}

	@RequiresPermissions("portal:portalFunddetail:view")
	@RequestMapping(value = "form")
	public String form(PortalFunddetail portalFunddetail, Model model) {
		model.addAttribute("portalFunddetail", portalFunddetail);
		return "modules/portal/portalFunddetailForm";
	}

	@RequiresPermissions("portal:portalFunddetail:edit")
	@RequestMapping(value = "save")
	public String save(PortalFunddetail portalFunddetail, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, portalFunddetail)){
			return form(portalFunddetail, model);
		}
		portalFunddetailService.save(portalFunddetail);
		addMessage(redirectAttributes, "保存平台资金流动成功");
		return "redirect:"+Global.getAdminPath()+"/portal/portalFunddetail/?repage";
	}
	
	@RequiresPermissions("portal:portalFunddetail:edit")
	@RequestMapping(value = "delete")
	public String delete(PortalFunddetail portalFunddetail, RedirectAttributes redirectAttributes) {
		portalFunddetailService.delete(portalFunddetail);
		addMessage(redirectAttributes, "删除平台资金流动成功");
		return "redirect:"+Global.getAdminPath()+"/portal/portalFunddetail/?repage";
	}

}