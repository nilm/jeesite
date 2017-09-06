package com.thinkgem.jeesite.modules.views.user;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.RandomStringUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.session.Session;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.enums.AuditStatus;
import com.thinkgem.jeesite.common.servlet.ValidateCodeServlet;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.TimeUtils;
import com.thinkgem.jeesite.common.utils.WebUtils;
import com.thinkgem.jeesite.common.utils.money.FundAbacusUtil;
import com.thinkgem.jeesite.common.utils.shield.ShieldUtil;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.account.entity.AccountAlipayInfo;
import com.thinkgem.jeesite.modules.account.entity.Banks;
import com.thinkgem.jeesite.modules.account.entity.Cashout;
import com.thinkgem.jeesite.modules.account.service.AccountAlipayInfoService;
import com.thinkgem.jeesite.modules.account.service.BanksService;
import com.thinkgem.jeesite.modules.account.service.CashoutService;
import com.thinkgem.jeesite.modules.account.service.FundDetailService;
import com.thinkgem.jeesite.modules.base.entity.WebUser;
import com.thinkgem.jeesite.modules.base.service.WebUserService;
import com.thinkgem.jeesite.modules.cms.entity.Site;
import com.thinkgem.jeesite.modules.cms.utils.CmsUtils;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.views.user.enums.UserMenus;



/**
 * 
 * 会员中心控制器
 * @version 2015-3-21
 * @author evan
 * 
 */
@Controller
@RequestMapping(value = "${frontPath}/user/account/cashout")
public class AccountCashoutController  extends BaseController{
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
	private CashoutService cashoutService;
	
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
	 * 检查用户是否满足提现的条件
	 * 
	 * @return 用户基本信息页面
	 */
	@RequestMapping(value = "/checkStatus", method = RequestMethod.GET)
	@ResponseBody
	public HashMap<String, Object> doCheckUserCashoutStatus(HttpServletRequest request) {
		
		HashMap<String, Object> map  = validateCashOutStatus();
		if(map != null){
			return map;
		}else{
			map = new HashMap<String, Object>();
		}
		
		WebUser currentUser = WebUtils.getWebUser();
		
		// 检查银行卡或支付宝绑定情况
		List<AccountAlipayInfo> userAlipayInfo = alipayService.findListByUser(currentUser.getId());
		List<Banks> userBanks = bankService.findListByUser(currentUser.getId());
		if(logger.isDebugEnabled()){
			logger.debug("userBanks.size() ===" +userBanks.size() );
		}
		if((userAlipayInfo == null || userAlipayInfo.size() <= 0) && (userBanks == null || userBanks.size() <= 0)){
			map.put("status", "-4");// 需要添加银行卡
			return map;
		}else if(userAlipayInfo != null && userAlipayInfo.size() > 0){ // 只能填一张银行卡时 加else 否则去掉else
			// Bank类型为支付吧
			map.put("bankType", "alipay");
			map.put("alipayId", userAlipayInfo.get(0).getId());
			map.put("alipayOwner", userAlipayInfo.get(0).getOwner());
			map.put("alipayNO", userAlipayInfo.get(0).getAlipayNo());
			
		}else if(userBanks != null && userBanks.size() > 0){
			map.put("bankType", "bank");
			map.put("bankId", userBanks.get(0).getId());
			map.put("bankName", userBanks.get(0).getBankName());
			map.put("bankcardOwner", userBanks.get(0).getBankcardOwner());
			map.put("bankNO", ShieldUtil.sheild("", userBanks.get(0).getBankNo()));
		}
		
		map.put("balance", currentUser.getBalance());
		map.put("mobile", currentUser.getMobile());
		map.put("status", "1");
		
		return map;
	}
	
	/**
	 * 提现申请
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/apply", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> deCashOutApply(@RequestParam String captcha,HttpServletRequest request) {

		//检查检图片验证码是否正确
		HashMap<String, Object> map = checkCaptcha(captcha, request);
		if(map != null){
			return map;
		}
		
		String validateCode = request.getParameter("validateCode");
		if(StringUtils.isEmpty(validateCode)){
			 map = new HashMap<String, Object>();
			 map.put("status", "-5");
			 return map;
		}
		WebUser currentUser = WebUtils.getWebUser();
		// 检查手机验证是否正确
		int validateResult = checkMobileValidateCode("cashoutValideCode",validateCode,currentUser.getMobile());
		
		if(validateResult > 20){
			 map = new HashMap<String, Object>();
			 map.put("status", validateResult);
			 return map;
		}
		
		map = validateCashOutStatus();
		
		if(map != null){
			return map;
		}else {
			map = new HashMap<String, Object>();
		}
		
		currentUser = WebUtils.getWebUser();
		// 银行卡校验
		String bankType = request.getParameter("bankType");
		String bankId = request.getParameter("bankId");
		String applyCashoutAmount = request.getParameter("applyCashoutAmount");
		if(logger.isDebugEnabled()){
			logger.debug(bankType+"====bankType");
		}
		if(StringUtils.isEmpty(bankType) || StringUtils.isEmpty(bankId) || StringUtils.isEmpty(applyCashoutAmount)){
			map.put("status", "-5");
			return map;
		}
		
/*		balance:110
		status:1
		bankType:bank
		bankName:中国工商银行
		bankcardOwner:等等
		bankNO:1234567890123456
		mobile:13311319862
		bankId:1
		applyCashoutAmount:80
		captcha:eeeee
		validateCode:011620*/
		
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		Cashout cashout = new Cashout();
		cashout.setCompanyId("0");
		cashout.setSiteId(site.getId());
		
		cashout.setWebUser(currentUser);
		cashout.setApplyAmount(new  BigDecimal(applyCashoutAmount));
		cashout.setCardId(bankId);
		cashout.setCardType(bankType);
		cashout.setCashoutFee(BigDecimal.ZERO);
		cashout.setCreateDate(TimeUtils.getCurrentTimestamp());
		cashout.setStatus(AuditStatus.audit.toString());
		cashout.setApplyIp(StringUtils.getRemoteAddr(request));
		
		cashoutService.saveCashoutApply(currentUser,cashout);
		
		map.put("status", "1");
		
		return map;
	}
	
	private HashMap<String, Object> checkCaptcha(String captcha,HttpServletRequest request) {
		
//		if (captcha.equals(getGeneratedKey(request)) == false) {
		HttpSession session = request.getSession();
		String code = (String)session.getAttribute(ValidateCodeServlet.VALIDATE_CODE);
		if (captcha.toUpperCase().equals(code) == false){
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("status", "-6");
			return map;
		}
		return null;
	}
	/**
	 * -1 == 用户未登录或登录超时
	 * -2 == 需要完善用户信息
	 * -3 == 可以提现资金不足50元
	 * 
	 * @return
	 */
	private HashMap<String, Object> validateCashOutStatus(){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		WebUser currentUser = WebUtils.getWebUser();
		if (currentUser == null){
			// 用户未登录或登录超时
			map.put("status", "-1");
			return  map;
		}
		
		currentUser = webUserService.get(currentUser);
		
		if(currentUser.isAllUserInfo() == false){
			// 需要完善用户信息
			map.put("status", "-2");
			return  map;
		}
		if(FundAbacusUtil.compare(currentUser.getBalance(), 50) <0 ){
			// 可以提现资金不足50元
			map.put("status", "-3");
			return  map;
		}
		WebUtils.putWebUser(currentUser);// 更新session 为最新的 webUser
		return  null;
	}

	/**
	 * 发送提现验证码
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/sendVildateCode", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> sendSMS(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
	    WebUser currentUser = WebUtils.getWebUser();
		if (currentUser == null){
			// 用户未登录或登录超时
			map.put("status", "-1");
			return  map;
		}

		map.put("mobile", currentUser.getMobile().trim());
		
		
		sendSMS(map);//发送提现验证码		
		return map;
		
    }
	
	private Map<String, Object> sendSMS(Map<String, Object> map){
		//TODO:发送手机验证码
		String val = RandomStringUtils.randomNumeric(6);
		
		if(logger.isInfoEnabled()){
			logger.info("发送的提现手机验证码为: "+ val);
		}
		map.put("result", "1");
		map.put("cashoutValideCode", val);
		WebUtils.put(WebUtils.SMS_VALIDE_CODE, map);
		return map;
	}

}
