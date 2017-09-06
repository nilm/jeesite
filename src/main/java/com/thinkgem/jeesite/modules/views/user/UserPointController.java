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
import com.thinkgem.jeesite.modules.account.enums.FundIO;
import com.thinkgem.jeesite.modules.account.service.AccountAlipayInfoService;
import com.thinkgem.jeesite.modules.account.service.BanksService;
import com.thinkgem.jeesite.modules.account.service.PointDetailService;
import com.thinkgem.jeesite.modules.account.service.UserEventService;
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
@RequestMapping(value = "${frontPath}/user/point")
public class UserPointController  extends BaseController{
	// ========== 字段 ==========
	
	/**
	 * 用户业务层对象
	 */
	private WebUserService webUserService;
	
	@Autowired
	private BanksService bankService;
	
	@Autowired
	private AccountAlipayInfoService alipayservice;
	
	@Autowired
	private PointDetailService pointDetailService;
	
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
	 *    用户业务层对象
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
	 * 跳转至 用户基本信息页面
	 * 
	 * @return 用户基本信息页面
	 */
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String goUserPonit(PointDetail pointDetail, HttpServletRequest request, HttpServletResponse response, Model model) {
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		WebUser currentUser = WebUtils.getWebUser();
		if (currentUser == null){
			return  WebUtils.redirectLoginUrl(WebUtils.getLastUrl(request));
		}
		
		
		pointDetail.setUserId(currentUser.getId());
		
		Page<PointDetail> page = pointDetailService.findWebUserPage(new Page<PointDetail>(request, response), pointDetail);
		
		model.addAttribute("page", page);
		
//		pointDetailService.findWebUserPointUseStatus(currentUser.getId());
		int inSumPoints = pointDetailService.findWebUserSumFundDirection(currentUser.getId(), FundIO.IN.toString());
		int outSumPoints = pointDetailService.findWebUserSumFundDirection(currentUser.getId(), FundIO.OUT.toString());
		
		model.addAttribute("inSumPoints",inSumPoints);
		model.addAttribute("outSumPoints",outSumPoints);
		
		model.addAttribute("mymenu", UserMenus.point.toString());
		return "web/themes/"+site.getTheme()+"/user/point/index";
	}
	
	@RequestMapping(value = "/rechange", method = RequestMethod.POST)
	@ResponseBody
	public String doRechanguserPoint(HttpServletRequest request, HttpServletResponse response, Model model) {
		WebUser currentUser = WebUtils.getWebUser();
		if (currentUser == null){
			return  "-1";
		}

		String pointCount = request.getParameter("pointCount");
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		String companyId= "0";
		// 积分记录  资金记录 user余额
		userEventService.doExchangePoint2Cash(site.getId(),companyId,currentUser.getId(), pointCount);
		
		model.addAttribute("mymenu", UserMenus.point.toString());
		return "1";
	}

}
