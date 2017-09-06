package com.thinkgem.jeesite.modules.views.user;

import java.util.List;

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

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.TimeUtils;
import com.thinkgem.jeesite.common.utils.WebUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.account.entity.AccountAlipayInfo;
import com.thinkgem.jeesite.modules.account.entity.Banks;
import com.thinkgem.jeesite.modules.account.entity.Funddetail;
import com.thinkgem.jeesite.modules.account.service.AccountAlipayInfoService;
import com.thinkgem.jeesite.modules.account.service.BanksService;
import com.thinkgem.jeesite.modules.account.service.FundDetailService;
import com.thinkgem.jeesite.modules.base.entity.WebUser;
import com.thinkgem.jeesite.modules.base.service.WebUserService;
import com.thinkgem.jeesite.modules.cms.entity.Site;
import com.thinkgem.jeesite.modules.cms.utils.CmsUtils;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
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
public class AccountController  extends BaseController{
	// ========== 字段 ==========
	
	/**
	 * 用户业务层对象
	 */
	private WebUserService webUserService;
	
	@Autowired
	private BanksService bankService;
	
	@Autowired
	private AccountAlipayInfoService alipayService;
	
	@Autowired
	private FundDetailService fundDetailService;
	
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
	@RequestMapping(value = "/account", method = RequestMethod.GET)
	public String goUserBaseinfo(Funddetail fundDetail, HttpServletRequest request, HttpServletResponse response, Model model) {
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		WebUser currentUser = WebUtils.getWebUser();
		if (currentUser == null){
			return  WebUtils.redirectLoginUrl(WebUtils.getLastUrl(request));
		}
		
		
		fundDetail.setUserId(currentUser.getId());
		
		Page<Funddetail> page = fundDetailService.findPage(new Page<Funddetail>(request, response), fundDetail);
		
		model.addAttribute("page", page);
        model.addAttribute("fundDetail", fundDetail);
		
		model.addAttribute("mymenu", UserMenus.account.toString());
		return "web/themes/"+site.getTheme()+"/user/account/index";
	}
	/**
	 * 跳转至 用户基本信息修改页面
	 * account/bankAdd
	 * @return 用户基本信息修改页面
	 */
	@RequestMapping(value = "/account/bankAdd", method = RequestMethod.POST)
	@ResponseBody
	public String doBankAdd(HttpServletRequest request) {
		WebUser currentUser = WebUtils.getWebUser();
		if (currentUser == null){
			return  "-1";
		}
		String bankType = request.getParameter("bankType");
		
		if(logger.isDebugEnabled()){
			logger.debug("bankType==="+bankType);
		}
		if(bankType == null){
			return "-2";
		}
			
		if(bankType.equals("bank")){
			return createBank(currentUser,request);
		}
		
		if(bankType.equals("alipay")){
			return createAlipayInfo(currentUser,request);
		}
		
		
		return "1";
	}
	private String createAlipayInfo(WebUser currentUser,
			HttpServletRequest request) {
		
		List<AccountAlipayInfo> userAlipayInfo = alipayService.findListByUser(currentUser.getId());
		if(userAlipayInfo != null && userAlipayInfo.size() > 0){
			return "-3";
		}
		
		String alipayNO = request.getParameter("alipayNO");
		String reAlipayNO = request.getParameter("reAlipayNO");
		if( alipayNO.equals(reAlipayNO) ==  false) {
			return "12";//二货 能填的不一样
		}
		String owner = request.getParameter("owner");
		AccountAlipayInfo alipayInfo = new AccountAlipayInfo(currentUser.getId(), owner, alipayNO);
		alipayService.save(alipayInfo);
		return "1";
	}


	private String createBank(WebUser currentUser ,HttpServletRequest request) {

		String bankNO = request.getParameter("bankNO");
		String reBankNO = request.getParameter("reBankNO");
		if( reBankNO.equals(bankNO) ==  false) {
			return "12";//二货 能填的不一样
		}
		
		String bankCardOwner = request.getParameter("bankCardOwner");
		String bankCode = request.getParameter("bankCode");
		
		String bankName = DictUtils.getDictLabel(bankCode, "base_bank", "");
		String bankBranchName = request.getParameter("bankBranchName");
		
		Banks banks = new Banks();
		banks.setBankcardOwner(bankCardOwner);
		banks.setBankName(bankName);
		banks.setBankBranchName(bankBranchName);
		banks.setBankNo(bankNO);
		banks.setCreateDate(TimeUtils.getCurrentTimestamp());
		banks.setUserId(currentUser.getId());
		banks.setDelFlag(Global.NO);
		banks.setBankCode(bankCode);
		bankService.save(banks);
		
		return "1";
	}

}
