/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.company.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.company.entity.CompanyCashout;
import com.thinkgem.jeesite.modules.company.service.CompanyCashoutService;
import com.thinkgem.jeesite.modules.sys.entity.Role;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 商户提现记录Controller
 * @author evan
 * @version 2015-11-13
 */
@Controller
@RequestMapping(value = "${adminPath}/company/companyCashout")
public class CompanyCashoutController extends BaseController {
	@Autowired
	private SystemService systemService;
	
	@Autowired
	private CompanyCashoutService companyCashoutService;
	
	@ModelAttribute
	public CompanyCashout get(@RequestParam(required=false) String id) {
		CompanyCashout entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = companyCashoutService.get(id);
		}
		if (entity == null){
			entity = new CompanyCashout();
		}
		return entity;
	}
	
	@RequiresPermissions("company:companyCashout:view")
	@RequestMapping(value = {"list", ""})
	public String list(CompanyCashout companyCashout, HttpServletRequest request, HttpServletResponse response, Model model) {
		
		Page<CompanyCashout> page = companyCashoutService.findPage(new Page<CompanyCashout>(request, response), companyCashout); 
		model.addAttribute("page", page);
		model.addAttribute("noAllDate", systemService.isOwnDataScope(UserUtils.getUser(), Role.DATA_SCOPE_ALL));
		return "modules/company/companyCashoutList";
	}
	/**
	 * 跳转到提现详情页
	 * @param companyCashout
	 * @param model
	 * @return
	 */
	@RequiresPermissions("company:companyCashout:view")
	@RequestMapping(value = "view")
	public String view(CompanyCashout companyCashout, Model model) {
		model.addAttribute("companyCashout", companyCashout);
		return "modules/company/companyCashoutIndex";
	}
	/**
	 * 跳转至体现审核 列表
	 * @param companyCashout
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("company:companyCashout:audit")
	@RequestMapping(value = "/audit/list")
	public String toAuditList(CompanyCashout companyCashout, HttpServletRequest request, HttpServletResponse response, Model model) {
		companyCashout.setStatus(DictUtils.getDictValue("audit", "base_audit_status", "audit"));
		Page<CompanyCashout> page = companyCashoutService.findPage(new Page<CompanyCashout>(request, response), companyCashout); 
		model.addAttribute("page", page);
		
		model.addAttribute("tag", "");
		
		return "modules/company/companyCashoutAuditList";
	}
	/**
	 * 跳转提现审核处理中 列表
	 * @param companyCashout
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("company:companyCashout:doing")
	@RequestMapping(value = "/audit/doing")
	public String toDoingList(CompanyCashout companyCashout, HttpServletRequest request, HttpServletResponse response, Model model) {
		companyCashout.setStatus(DictUtils.getDictValue("doing", "base_audit_status", "doing"));
		Page<CompanyCashout> page = companyCashoutService.findPage(new Page<CompanyCashout>(request, response), companyCashout); 
		model.addAttribute("page", page);
		model.addAttribute("tag", "doing");
		return "modules/company/companyCashoutAuditList";
	}
	/**
	 * 跳转至 提现详情审核页面
	 * @param companyCashout
	 * @param model
	 * @return
	 */
	@RequiresPermissions("company:companyCashout:audit")
	@RequestMapping(value = "audit")
	public String audit(CompanyCashout companyCashout, Model model) {
		model.addAttribute("companyCashout", companyCashout);
		if(companyCashout.getStatus().equals("doing")){
			model.addAttribute("tag", "doing");
		}
		return "modules/company/companyCashoutAudit";
	}
	
	/**
	 * 提现审核处理
	 * @param companyCashout
	 * @param model
	 * @param request
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("company:companyCashout:audit")
	@RequestMapping(value = "save")
	public String save(CompanyCashout companyCashout, Model model, HttpServletRequest request,RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, companyCashout)){
			return view(companyCashout, model);
		}
		String auditStatus = request.getParameter("auditStatus");
		String tag = request.getParameter("tag");
		if(auditStatus.equals("1")){//审核通过
			if(companyCashout.getStatus().equals("audit")){
				companyCashout.setStatus(DictUtils.getDictValue("doing", "base_audit_status", "doing"));
			}else if (companyCashout.getStatus().equals("doing")){
				companyCashout.setStatus(DictUtils.getDictValue("success", "base_audit_status", "success"));
			}
		}else { //审核失败
			companyCashout.setStatus(DictUtils.getDictValue("fail", "base_audit_status", "fail"));
		}

		companyCashoutService.audit(companyCashout);
		if("doing".equals(tag)){
			addMessage(redirectAttributes, "商户提现记录已经审核成功");
			return "redirect:"+Global.getAdminPath()+"/company/companyCashout/audit/doing?repage";
		}else{
			addMessage(redirectAttributes, "商户提现记录已经审核为处理中状态");
			return "redirect:"+Global.getAdminPath()+"/company/companyCashout/audit/list?repage";
		}
	}
	
	@RequiresPermissions("company:companyCashout:audit")
//	@RequestMapping(value = "delete")
	public String delete(CompanyCashout companyCashout, RedirectAttributes redirectAttributes) {
		companyCashoutService.delete(companyCashout);
		addMessage(redirectAttributes, "删除商户提现记录成功");
		return "redirect:"+Global.getAdminPath()+"/company/companyCashout/?repage";
	}
	//==============商户申请===============
	/**
	 * 跳转至商户申请页面
	 * @param companyCashout
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/apply")
	public String apply(CompanyCashout companyCashout, Model model) {
		model.addAttribute("companyCashout", companyCashout);
		return "modules/company/companyCashoutApply";
	}
	/**
	 * 保存商户申请
	 * @param companyCashout
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/apply/save",method=RequestMethod.POST)
	public String saveApply(CompanyCashout companyCashout, Model model,HttpServletRequest request, RedirectAttributes redirectAttributes) {
		User user =UserUtils.getUser();
		companyCashout.setCompany(user.getCompany());
		companyCashout.setApplyIp(StringUtils.getRemoteAddr(request));
		companyCashout.setStatus(DictUtils.getDictValue("audit", "base_audit_status", "audit"));
		companyCashout.setUser(user);
		
		companyCashoutService.save(companyCashout);
		addMessage(redirectAttributes, "您已经成功申请提现！");
		
		return "redirect:"+Global.getAdminPath()+"/company/companyCashout/apply";
	}
}