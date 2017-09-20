package com.thinkgem.jeesite.modules.rest;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.TimeUtils;
import com.thinkgem.jeesite.common.utils.WebUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.account.service.UserEventService;
import com.thinkgem.jeesite.modules.base.entity.WebUser;
import com.thinkgem.jeesite.modules.base.service.WebUserService;
import com.thinkgem.jeesite.modules.cms.entity.Site;
import com.thinkgem.jeesite.modules.cms.utils.CmsUtils;
import com.thinkgem.jeesite.modules.rest.json.BaseJson;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * 
 * 登录控制器
 * @version 2015-3-21
 * @author evan
 * 
 */
@Controller
@RequestMapping(value = "${frontPath}/rest/user")
public class LoginRestController   extends BaseController{
	// ========== 字段 ==========
	
	/**
	 * 用户业务层对象
	 */
	private WebUserService webUserService;
	
	@Autowired
	private UserEventService userEventService;
	
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
		return new WebUser();
	}
	
	
	// ========== 控制器 ==========
	/**
	 * 跳转到登录页面
	 * 
	 * @return 登录页面
	 */
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String goLogin(Model model,HttpServletRequest request) {
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		WebUser entity = WebUtils.getWebUser();
		if (entity == null){
			return "modules/cms/front/themes/"+site.getTheme()+"/common/login";
		}
		// 已经登录则返回到  之前的页面
		return WebUtils.redirectLastUrl(request);
	}
	/**
	 * 进行登录页面
	 * 
	 * @return 登录结果
	 */
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	@ResponseBody
	private String doLogin(WebUser webUser,HttpServletRequest request) {

		BaseJson json = new BaseJson();
		WebUser entity = WebUtils.getWebUser();

		if (entity != null){
			// 已经登录则返回到首页
//			model.addAttribute("message","已经登录");
			json.putMsg("已经登录");
			return json.toJson();
		}
		
		String mobile = webUser.getMobile();
		WebUser loginUser = webUserService.getByMobile(mobile);
		
		if(loginUser == null){//限制登录了
			json.fail("登录失败，您的账号或密码错误！");
			return json.toJson();
		}
		if(loginUser.getLoginFlag().equals(Global.YES)){//限制登录了
			json.fail("该手机号登录限制，请联系管理员！");
			return json.toJson();
		}
		
		String password = request.getParameter("password");
		
		boolean loginError = false;// 默认登录不出错
		loginError = loginUser == null ; //用户不存在，那么错误
		loginError = loginError || loginUser.getPassword() == null; // 密码不存在，错误
		loginError = loginError || !SystemService.validatePassword(password, loginUser.getPassword());// 密码不一致出错
		// 验证密码是否正确
		if (loginError) {
			json.fail("手机号或密码不正确！");
			return json.toJson();
		}
		

		WebUtils.putWebUser(loginUser);
		
		updateLoginUserInfo(loginUser,request);
		// 积分金钱 大奉送(仅限第一次登陆)
		userEventService.doAward4First(CmsUtils.getSite(Site.defaultSiteId()).getId(),loginUser);
		json.putMsg("成功");
		json.put("userName",mobile);
		json.put("userType",1);//用来区分用户是什么类型的用户
		json.put("token",request.getSession().getId());
		return json.toJson();
	}


	private void updateLoginUserInfo(WebUser loginUser ,HttpServletRequest request) {
		loginUser.setLoginIp(StringUtils.getRemoteAddr(request));
		loginUser.setLoginDate(TimeUtils.getCurrentTimestamp());
		loginUser.setVisitCount(loginUser.getVisitCount()+1);
		
		webUserService.updateUserLoginInfo(loginUser);
		
	}
	
	@RequestMapping(value = "/loginout", method = RequestMethod.GET)
	@ResponseBody
	private String loginout() {
		WebUtils.removeWebUser();
		BaseJson json = new BaseJson();
		json.putMsg("成功退出");
		return json.toJson();
	}

}
