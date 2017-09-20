package com.thinkgem.jeesite.modules.rest;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.utils.*;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.base.entity.WebUser;
import com.thinkgem.jeesite.modules.base.service.WebUserService;
import com.thinkgem.jeesite.modules.cms.entity.Site;
import com.thinkgem.jeesite.modules.cms.utils.CmsUtils;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.Map;


/**
 * 
 * 注册控制器
 * @version 2015-3-21
 * @author evan
 * 
 */
@Controller
@RequestMapping(value = "${frontPath}/rest/user")
public class RegisterRestController   extends BaseController{
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
	public WebUser getWebUser() {
		return new WebUser();
	}
	
	
	// ========== 控制器 ==========
	/**
	 * 跳转到注册页面
	 * 
	 * @return 注册页面
	 */
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String goRegister(Model model,HttpServletRequest request) {
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		
		if (logger.isInfoEnabled()) {
			logger.info("message:" + request.getParameter("message"));
		}
		WebUser entity = WebUtils.getWebUser();
		if (entity == null){
			return "modules/cms/front/themes/"+site.getTheme()+"/common/register";
		}
		return WebUtils.redirectLastUrl(request);
	}
	/**
	 * 进行注册页面
	 * 
	 * @return 注册页面
	 */
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String doRegister(WebUser webUser,Model model,HttpServletRequest request ,
			RedirectAttributes redirectAttrs,boolean ajaxRequest) {
		//TODO:
		
		/*				// 验证码
		String vaildateCode = webUser.getVaildateCode();
		
		// 验证码有误
		if (!vaildateCode.equals(getGeneratedKey(request))) {
			redirectAttrs.addFlashAttribute("vaildateCodeFailed", 1);
			return "redirect:"+frontPath+"/login";
		}
		 */
		String mobile = webUser.getMobile().trim();
		//检查手机号是正确
		if(StringUtils.isMobile(mobile) == false){
			addMessage(redirectAttrs, "你输入的手机号非法");
			return "redirect:"+frontPath+"/u/register";
		}
		
		//检查两次密码是否一致
		if(webUser.isNewPasswdOk() == false){
			addMessage(redirectAttrs, "你输入的两次密码不一致");
			return "redirect:"+frontPath+"/u/register";
		}
		String vaildateCode = webUser.getValidateCode();
		int validateResult = checkMobileValidateCode("",vaildateCode,mobile);
		
		if(validateResult ==21 ){
			addMessage(redirectAttrs, "手机验证码超时或不正确");
			return "redirect:"+frontPath+"/u/register";	
		}else if(validateResult == 22){
			addMessage(redirectAttrs, "接受验证码的手机号与现在的手机号不一致");
			return "redirect:"+frontPath+"/u/register";
		}else if(validateResult == 23){
			addMessage(redirectAttrs, "验证码不正确");
			return "redirect:"+frontPath+"/u/register";
		}
		//检查推荐人是否存在
		String referrer = webUser.getReferrer();
		String inviteCode = request.getParameter("inviteCode");
		
		WebUser referrerUser = null;
		boolean isMobileReferrer = StringUtils.isMobile(referrer);
		boolean isIdReferrer = referrer.equals("") == false;
		if(isMobileReferrer){
			//如果推荐人填写的为手机号则按手机号查询用户是否存在
			referrerUser = webUserService.getByMobile(webUser.getReferrer().trim());
		}else if(isIdReferrer){
			// 否则则按照 id查询用户是否存在 --- 使用与通过推广链接过来的用户注册
			referrerUser = webUserService.get(referrer);
		}else if (StringUtils.isEmpty(inviteCode) == false){
			referrerUser = webUserService.getByInviteCode(inviteCode.trim());
		}
		
		if(referrerUser == null && isIdReferrer){
			addMessage(redirectAttrs, "推荐人不存在");
			
			return "redirect:"+frontPath+"/u/register";
		}else if(isIdReferrer){
			webUser.setReferrer(referrerUser.getId());
		}else if (StringUtils.isEmpty(inviteCode) == false){
			webUser.setReferrer(referrerUser.getId());
		}
		
		
		// 检查手机号是已经存在	
		
		WebUser existsUser = webUserService.getByMobile(mobile);
		
		if(existsUser != null){
			redirectAttrs.addFlashAttribute("existsUser", 1);
			addMessage(redirectAttrs, "手机号已存在！");
			return "redirect:"+frontPath+"/u/register";
		}
		
		webUser.setCreateIp(StringUtils.getRemoteAddr(request));
		webUser.setCreateDate(TimeUtils.getCurrentTimestamp());
		webUser.setUserType(DictUtils.getDictValue("普通用户", "web_user_type", "0"));
		webUser.setLoginFlag(Global.NO);
		webUser.setMobileValidated(Global.YES);
		webUser.setPassword(SystemService.entryptPassword(webUser.getPassword()));
		webUser.setInviteCode(IdGen.randomBase62(5));
		webUser.setFrozenAmount(BigDecimal.ZERO);
		webUser.setBalance(BigDecimal.ZERO);
		webUserService.doRegister(webUser);
		
		if(ajaxRequest){
			return "1";
		}
		
		return WebUtils.redirectLastUrl(request);
	}


	//========================
	

	/**
	 * 检查用户用户是否存在
	 * 
	 * @param token
	 * @return
	 */
	@RequestMapping(value = "/check_referrer_user_exists", method = RequestMethod.GET, produces = { "text/html;charset=UTF-8" })
	@ResponseBody
	public String checkReferrerUserExists(@RequestParam String referrer) {
		String returnMessage = "true";
		
		WebUser referrerUser = null;
		boolean isMobileReferrer = StringUtils.isMobile(referrer.trim());
		boolean isIdReferrer = referrer.equals("") == false;
		if(isMobileReferrer){
			//如果推荐人填写的为手机号则按手机号查询用户是否存在
			referrerUser = webUserService.getByMobile(referrer.trim());
		}else if(isIdReferrer){
			// 否则则按照 id查询用户是否存在 --- 使用与通过推广链接过来或填写的用户Id的用户注册
			referrerUser = webUserService.get(referrer);
		}
		
		if(referrerUser == null ){
			returnMessage = "false";// 不存在
		}
		if (logger.isInfoEnabled()) {
			logger.info("mobilePhone of referrer:" + referrer);
		}
		return returnMessage;
		
	}
	/**
	 * 根据手机号 检查用户是否存在
	 * 
	 * @param token
	 * @return
	 */
	@RequestMapping(value = "/check_user_exists", method = RequestMethod.GET, produces = { "text/html;charset=UTF-8" })
	@ResponseBody
	public String checkUserExists(@RequestParam String mobile) {
		String returnMessage = "false";
		boolean isMobile = StringUtils.isMobile(mobile.trim());
		if(isMobile){
			WebUser loginUser =  webUserService.getByMobile(mobile);
			if(loginUser == null ){
				returnMessage = "true";// 不存在
			}
		}
		if (logger.isInfoEnabled()) {
			logger.info("mobilePhone:" + mobile);
		}
		return returnMessage;
		
	}
	/**
	 * 根据用户名或手机号 检查用户是否存在
	 * 
	 * @param token
	 * @return
	 */
	@RequestMapping(value = "/check_user_name_exists ", method = RequestMethod.GET, produces = { "text/html;charset=UTF-8" })
	@ResponseBody
	public String checkUserExists4UserName(@RequestParam String userName,HttpServletRequest request) {
		String returnMessage = "false";
		
		WebUser loginUser =   webUserService.getByUserName(userName);
		WebUser currentUser = WebUtils.getWebUser();
		
		if(loginUser == null ){
			return "true";// 不存在
		}
		// 如果允许修改用户名
		if (currentUser == null){
			return  WebUtils.redirectLoginUrl(WebUtils.getLastUrl(request));
		}
		
		if(currentUser.getId().equals(loginUser.getId())){
			returnMessage = "true";
		}
		if (logger.isInfoEnabled()) {
			logger.info("userName:" + userName);
		}
		return returnMessage;
		
	}
	/**
	 * 检查重复邮箱
	 * 
	 * @param token
	 * @return
	 */
	@RequestMapping(value = "/check_user_email_exists", produces = { "text/html;charset=UTF-8" })
	@ResponseBody
	public String checkUserEmail(@RequestParam String email,HttpServletRequest request) {
		String returnMessage = "false";
		
		WebUser loginUser =   webUserService.getByEmail(email);
		WebUser currentUser = WebUtils.getWebUser();
		
		if(loginUser == null ){
			return "true";// 不存在
		}
		// 如果允许修改用户名
		if (currentUser == null){
			return  WebUtils.redirectLoginUrl(WebUtils.getLastUrl(request));
		}
		
		if(currentUser.getId().equals(loginUser.getId())){
			returnMessage = "true";
		}
		if (logger.isInfoEnabled()) {
			logger.info("email:" + email);
		}
		return returnMessage;

	}
	
	/**
	 * 跳转到忘记密码页面
	 * 
	 * @return 忘记密码页面
	 */
	@RequestMapping(value = "/forgetPwd", method = RequestMethod.GET)
	public String goForgetPwd(Model model,HttpServletRequest request) {
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		
		if (logger.isInfoEnabled()) {
			logger.info("message:" + request.getParameter("message"));
		}
		WebUser entity = WebUtils.getWebUser();
		if (entity == null){
			return "modules/cms/front/themes/"+site.getTheme()+"/common/forgetPwd";
		}
		return WebUtils.redirectLastUrl(request);
	}
	
	/**
	 * 重置密码
	 * @param webUser
	 * @param model
	 * @param request
	 * @param redirectAttrs
	 * @return
	 */
	@RequestMapping(value = "/resetPwd", method = RequestMethod.POST)
	@ResponseBody
	public String resetPwd(WebUser webUser,Model model,HttpServletRequest request,	RedirectAttributes redirectAttrs ) {
			WebUser loginUser = webUserService.getByMobile(webUser.getMobile());

			if(loginUser == null ){
				addMessage(redirectAttrs, "手机号不存在！");
			}
			
			//检查两次密码是否一致
			if(webUser.isNewPasswdOk() == false){
				addMessage(redirectAttrs, "你输入的两次密码不一致");
				return "redirect:"+frontPath+"/u/forgetPwd";
			}
			// 检查手机验证码是否匹配
			String vaildateCode = webUser.getValidateCode();
			@SuppressWarnings("unchecked")
			Map<String, Object> sendMobileResult = (Map<String, Object>) WebUtils.get(WebUtils.SMS_VALIDE_CODE);
			
			String mobile = webUser.getMobile().trim();
			
			if (sendMobileResult == null) {
				addMessage(redirectAttrs, "会话到期请重新设置！");
				return "redirect:"+frontPath+"/u/forgetPwd";
			}
			
			if(StringUtils.isMobile(mobile) == false || mobile.equals(sendMobileResult.get("mobile")) == false) {
				addMessage(redirectAttrs, "接受验证码的手机号与现在的手机号不一致");
				return "redirect:"+frontPath+"/u/forgetPwd";
			}
			
			if(vaildateCode == null ||vaildateCode.equals(sendMobileResult.get("valideCode")) == false){
				addMessage(redirectAttrs, "验证码不正确");
				return "redirect:"+frontPath+"/u/forgetPwd";
			}
			
			sendMobileResult.remove(sendMobileResult);
			
		
			loginUser.setUpdateDate(TimeUtils.getCurrentTimestamp());
			loginUser.setMobileValidated(Global.YES);
			loginUser.setPassword(SystemService.entryptPassword(webUser.getPassword()));
			
			webUserService.save(loginUser);
			
			return "redirect:"+frontPath;

	}

	/**
	 * http://lcoahost/${frontPath}/u/sign-in/invite/CDSW
	 * @param captcha
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/sign-in/{inviteCode}")
	public String invite(@PathVariable String inviteCode,Model model,HttpServletRequest request,HttpServletResponse response) {
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		
		if (logger.isInfoEnabled()) {
			logger.info("message:" + request.getParameter("message"));
		}
		model.addAttribute("inviteCode", inviteCode);
		CookieUtils.setCookie(response, "inviteCode", inviteCode, (60*60*12));//邀请一天内有效
		
		WebUser entity = WebUtils.getWebUser();
		if (entity == null){
			return "modules/cms/front/themes/"+site.getTheme()+"/common/register";
		}
		return WebUtils.redirectLastUrl(request);
	}
	
}
