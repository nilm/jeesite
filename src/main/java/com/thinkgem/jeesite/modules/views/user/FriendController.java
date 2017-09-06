package com.thinkgem.jeesite.modules.views.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.WebUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.account.entity.PointDetail;
import com.thinkgem.jeesite.modules.account.service.AccountAlipayInfoService;
import com.thinkgem.jeesite.modules.account.service.BanksService;
import com.thinkgem.jeesite.modules.account.service.PointDetailService;
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
@RequestMapping(value = "${frontPath}/user/friend")
public class FriendController  extends BaseController{
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
		return currentUser;
	}
	
	
	// ========== 控制器 ==========
	/**
	 * 跳转至 用户基本信息页面
	 * 
	 * @return 用户基本信息页面
	 */
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String goUserFriends(HttpServletRequest request, HttpServletResponse response, Model model) {
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		WebUser currentUser = WebUtils.getWebUser();
		if (currentUser == null){
			return  WebUtils.redirectLoginUrl(WebUtils.getLastUrl(request));
		}
		
		currentUser.setReferrer(currentUser.getId());
		
		Page<WebUser> page = webUserService.findReferrerList(new Page<WebUser>(request, response), currentUser);
		WebUser sumAwardUser = webUserService.getSumAward(currentUser);
		
		model.addAttribute("sumAwardUser", sumAwardUser);
		model.addAttribute("page", page);
		
		model.addAttribute("mymenu", UserMenus.friend.toString());
		return "web/themes/"+site.getTheme()+"/user/friend/index";
	}

}
