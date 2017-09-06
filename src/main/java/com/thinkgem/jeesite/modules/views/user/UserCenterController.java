package com.thinkgem.jeesite.modules.views.user;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.utils.TimeUtils;
import com.thinkgem.jeesite.common.utils.WebUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.base.entity.WebUser;
import com.thinkgem.jeesite.modules.base.service.WebUserService;
import com.thinkgem.jeesite.modules.cms.entity.Site;
import com.thinkgem.jeesite.modules.cms.utils.CmsUtils;
import com.thinkgem.jeesite.modules.views.user.enums.UserMenus;


/**
 * 
 * 会员中心控制器
 * @version 2015-3-21
 * @author evan
 * 
 */
@Controller
@RequestMapping(value = "${frontPath}/user")
public class UserCenterController  extends BaseController{
	// ========== 字段 ==========
	
	/**
	 * 用户业务层对象
	 */
	private WebUserService webUserService;
	
	/**
	 * 日志服务对象
	 */
	private Logger _log = LoggerFactory.getLogger(this.getClass());

	// ========== get，set方法 ==========
	/**
	 * 自动织入
	 * 
	 * @param webUserService
	 *            用户业务层对象
	 */
	@Autowired
	public void setWebUserService(WebUserService webUserService) {
		this.webUserService = webUserService;
	}

	
	@ModelAttribute
	public WebUser get() {
		WebUser currentUser = WebUtils.getWebUser();
		currentUser = webUserService.get(currentUser);
		return currentUser;
	}
	
	
	// ========== 控制器 ==========
	/**
	 * 跳转到会员中心页面
	 * 
	 * @return 登录页面
	 */
	@RequestMapping(value = {"home", ""})
	public String goLogin(Model model,HttpServletRequest request) {
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		WebUser currentUser = WebUtils.getWebUser();
		if (currentUser == null){
			return  WebUtils.redirectLoginUrl(WebUtils.getLastUrl(request));
		}
		
		model.addAttribute("mymenu", UserMenus.home.toString());
		return "web/themes/"+site.getTheme()+"/user/home/index";
		
	}
	/**
	 * 跳转至 用户基本信息页面
	 * 
	 * @return 用户基本信息页面
	 */
	@RequestMapping(value = "/baseinfo", method = RequestMethod.GET)
	public String goUserBaseinfo(Model model,HttpServletRequest request) {
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		WebUser currentUser = WebUtils.getWebUser();
		if (currentUser == null){
			return  WebUtils.redirectLoginUrl(WebUtils.getLastUrl(request));
		}
		
		model.addAttribute("mymenu", UserMenus.baseInfo.toString());
		return "web/themes/"+site.getTheme()+"/user/baseinfo/index";
	}
	/**
	 * 跳转至 用户基本信息修改页面
	 * 
	 * @return 用户基本信息修改页面
	 */
	@RequestMapping(value = "/baseinfo/update", method = RequestMethod.GET)
	public String goBaseInfoUpdate(Model model,HttpServletRequest request) {
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		WebUser currentUser = WebUtils.getWebUser();
		if (currentUser == null){
			return  WebUtils.redirectLoginUrl(WebUtils.getLastUrl(request));
		}
		
		model.addAttribute("mymenu", UserMenus.baseInfo.toString());
		return "web/themes/"+site.getTheme()+"/user/baseinfo/update";
	}
	/**
	 *  用户基本信息修改 
	 * 
	 * @return 用户基本信息修改 
	 */
	@RequestMapping(value = "/baseinfo/update", method = RequestMethod.POST)
	public String doBaseInfoUpdate(WebUser webUser,Model model,HttpServletRequest request,
			RedirectAttributes redirectAttributes,boolean ajaxRequest) {
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		WebUser user = WebUtils.getWebUser();
		if (user == null){
			return  WebUtils.redirectLoginUrl(WebUtils.getLastUrl(request));
		}
		String userName = webUser.getUserName();
		WebUser nameUser = webUserService.getByUserName(userName);
		if(nameUser != null && nameUser.getId().equals(user.getId()) == false){
			addMessage(redirectAttributes, "用户名已存在！");
			return "redirect:"+frontPath+"/user/baseinfo/update";
		}
		user.setUserName(userName);
		user.setRealName(webUser.getRealName());
		user.setIdCard(webUser.getIdCard());
		
		String email = webUser.getEmail();
		WebUser mailUser = webUserService.getByEmail(email);
		if(mailUser != null && mailUser.getId().equals(user.getId()) == false){
			addMessage(redirectAttributes, "邮件已存在！");
			return "redirect:"+frontPath+"/user/baseinfo/update";
		}
		
		//TODO:  发送激活邮件
		user.setEmail(webUser.getEmail());
//		user.setEmailValidated(emailValidated)
		user.setSex(webUser.getSex());
		user.setProvince(webUser.getProvince());
		user.setCity(webUser.getCity());
		user.setRegion(webUser.getRegion());
		user.setAddress(webUser.getAddress());
		user.setUpdateDate(TimeUtils.getCurrentTimestamp());
		
		webUserService.save(user);
		
		model.addAttribute("mymenu", UserMenus.baseInfo.toString());
		addMessage(redirectAttributes, "修改成功");
		
		if(ajaxRequest){
			 return "1";
		}
		
		return 	 "redirect:"+frontPath+"/user/baseinfo/update";
	}
	
}
