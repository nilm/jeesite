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
import com.thinkgem.jeesite.modules.account.entity.PointDetail;
import com.thinkgem.jeesite.modules.account.service.PointDetailService;

/**
 * 用户积分Controller
 * @author evan
 * @version 2015-04-05
 */
@Controller
@RequestMapping(value = "${adminPath}/account/pointDetail")
public class PointDetailController extends BaseController {

	@Autowired
	private PointDetailService pointDetailService;
	
	@ModelAttribute
	public PointDetail get(@RequestParam(required=false) String id) {
		PointDetail entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = pointDetailService.get(id);
		}
		if (entity == null){
			entity = new PointDetail();
		}
		return entity;
	}
	
	@RequiresPermissions("account:pointDetail:view")
	@RequestMapping(value = {"list", ""})
	public String list(PointDetail pointDetail, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<PointDetail> page = pointDetailService.findPage(new Page<PointDetail>(request, response), pointDetail); 
		model.addAttribute("page", page);
		return "modules/account/pointDetailList";
	}

	@RequiresPermissions("account:pointDetail:view")
	@RequestMapping(value = "form")
	public String form(PointDetail pointDetail, Model model) {
		model.addAttribute("pointDetail", pointDetail);
		return "modules/account/pointDetailForm";
	}

	@RequiresPermissions("account:pointDetail:edit")
	@RequestMapping(value = "save")
	public String save(PointDetail pointDetail, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, pointDetail)){
			return form(pointDetail, model);
		}
		pointDetailService.save(pointDetail);
		addMessage(redirectAttributes, "保存用户积分成功");
		return "redirect:"+Global.getAdminPath()+"/account/pointDetail/?repage";
	}
	
	@RequiresPermissions("account:pointDetail:edit")
	@RequestMapping(value = "delete")
	public String delete(PointDetail pointDetail, RedirectAttributes redirectAttributes) {
		pointDetailService.delete(pointDetail);
		addMessage(redirectAttributes, "删除用户积分成功");
		return "redirect:"+Global.getAdminPath()+"/account/pointDetail/?repage";
	}

}