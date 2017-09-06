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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.enums.AuditStatus;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.TimeUtils;
import com.thinkgem.jeesite.modules.account.entity.Cashout;
import com.thinkgem.jeesite.modules.account.service.CashoutService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 用户提现申请Controller
 * @author evan
 * @version 2015-04-06
 */
@Controller
@RequestMapping(value = "${adminPath}/account/cashout")
public class CashoutController extends BaseController {

	@Autowired
	private CashoutService cashoutService;
	
	@ModelAttribute
	public Cashout get(@RequestParam(required=false) String id) {
		Cashout entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cashoutService.get(id);
		}
		if (entity == null){
			entity = new Cashout();
		}
		return entity;
	}
	
	@RequiresPermissions("account:cashout:view")
	@RequestMapping(value = {"list", ""})
	public String list(Cashout cashout, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Cashout> page = cashoutService.findPage(new Page<Cashout>(request, response), cashout); 
		model.addAttribute("page", page);
		return "modules/account/cashoutList";
	}

	@RequiresPermissions("account:cashout:view")
	@RequestMapping(value = "form")
	public String form(Cashout cashout, Model model) {
		model.addAttribute("cashout", cashout);
		return "modules/account/cashoutForm";
	}

	@RequiresPermissions("account:cashout:edit")
	@RequestMapping(value = "save")
	public String save(Cashout cashout, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, cashout)){
			return form(cashout, model);
		}
		cashoutService.save(cashout);
		addMessage(redirectAttributes, "保存提现申请成功");
		return "redirect:"+Global.getAdminPath()+"/account/cashout/?repage";
	}
	
	@RequiresPermissions("account:cashout:edit")
	@RequestMapping(value = "delete")
	public String delete(Cashout cashout, RedirectAttributes redirectAttributes) {
		cashoutService.delete(cashout);
		addMessage(redirectAttributes, "删除提现申请成功");
		return "redirect:"+Global.getAdminPath()+"/account/cashout/?repage";
	}
	
	
	@RequiresPermissions(value={"account:cashout:doing","account:cashout:audit"})
	@RequestMapping(value = "/{action}/toAudit")
	public String toAudit(Cashout cashout, @PathVariable("action")String action,HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("cashout", cashout);
		model.addAttribute("targetAction",action);
		return "modules/account/cashoutDetail";
	}
	
	/**
	 * 
	 * @param cashout
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions(value={"account:cashout:doing","account:cashout:audit"})
	@RequestMapping(value = "/audit")
	public String auditDoing(Cashout cashout, Model model,HttpServletRequest request,  RedirectAttributes redirectAttributes) {
		
		String action  =  request.getParameter("action");
		if(StringUtils.isEmpty(action)){
			addMessage(redirectAttributes, "非常参数,处理失败!");
			return "redirect:"+Global.getAdminPath()+"/account/cashout/?repage";
		}
		Cashout dbCashout = cashoutService.get(cashout);
		
		// 修改状态为处理中
		if(action.equals(AuditStatus.doing.toString()) && dbCashout.getStatus().equals(AuditStatus.audit.toString())){
			dbCashout.setStatus(action);
			dbCashout.setUser(UserUtils.getUser());
			cashoutService.save(dbCashout);
		}else{
			
			cashoutService.doCashoutApplyAudit(dbCashout,action);
			
		}
		
		addMessage(redirectAttributes, "修改提现申请为"+AuditStatus.valueOf(action).getText()+"成功");
		return "redirect:"+Global.getAdminPath()+"/account/cashout/?repage";
	}

}