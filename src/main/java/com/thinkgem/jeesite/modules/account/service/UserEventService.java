package com.thinkgem.jeesite.modules.account.service;

import java.math.BigDecimal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.money.FundAbacusUtil;
import com.thinkgem.jeesite.modules.account.enums.UserEvent;
import com.thinkgem.jeesite.modules.base.dao.WebUserDao;
import com.thinkgem.jeesite.modules.base.entity.WebUser;
import com.thinkgem.jeesite.modules.base.service.WebUserService;

/**
 * 用户事件  Service
 * 与用户相关积分 或资金操作的总入口
 * @author evan
 * @version 2015-04-04
 */
@Service
@Transactional(readOnly = true)
public class UserEventService {
	
	@Autowired
	private FundDetailService fundDetailService;
	
	@Autowired
	private PointDetailService pointDetailService;
	
	
	@Autowired
	private WebUserService webUserService;
	
	/**
	 * 第一次登陆奖励
	 * 
	 * @param siteId
	 * @param loginUser
	 */
	@Transactional(readOnly = false)
	public void doAward4First(String siteId, WebUser loginUser) {
		// TODO Auto-generated method stub
		if(loginUser.getVisitCount() >0){
			return;
		}
		// 新用户的积分与奖金
		int newUserPointCount =10000;
		BigDecimal newUserCash = new BigDecimal("1000");
		// 推荐用户的积分与奖金
		int referreUserPointCount =0;
		BigDecimal referreUserCash = new BigDecimal("500");
		
		WebUser referreUser = webUserService.get(loginUser.getReferrer());
		
	//积分记录
		//积分要赠送 --- 送钱也不爽
		pointDetailService.genPointDetail(siteId, "0", loginUser, newUserPointCount, UserEvent.register,"");
		pointDetailService.genPointDetail(siteId, "0", referreUser, referreUserPointCount, UserEvent.referreAward,loginUser.getId());


	//  资金记录
		// 新注册用户  金钱要赠送  给一千 爽吧
		fundDetailService.genFundDetail(siteId, "0", loginUser, newUserCash, UserEvent.register,"");
		//推荐用户所得
		fundDetailService.genFundDetail(siteId, "0", referreUser, referreUserCash, UserEvent.referreAward,loginUser.getId());
		
	//账户
		// 第一次登陆送 10000 积分  1000 人民币
		webUserService.updateWebUserAccount(loginUser, newUserPointCount, newUserCash, UserEvent.register);
		
		// 第一次登陆送 10000 积分  1000 人民币
		webUserService.updateWebUserAccount(referreUser, referreUserPointCount, referreUserCash, UserEvent.referreAward);
		
	}
	
	
	/**
	 * 积分兑换现金
	 * @param page
	 * @param pointDetail
	 * @return
	 * -2 非法数据
	 * -3 积分不足
	 * -
	 */
	@Transactional(readOnly=false)
	public String doExchangePoint2Cash(String siteId,String companyId,String webUserId , String pointCount) {
		
		if(StringUtils.isNumeric(pointCount) == false){
			return "-2";//非法数据
		}
		
		WebUser webUser = webUserService.get(webUserId);
		
		int dbPoints = webUser.getPoints();
		int pointCountInt = Integer.parseInt(pointCount);
		
		if( dbPoints - pointCountInt < 0){
			return "-3";// 积分不足
		}
		
		// 当前的积分对应的现金数 100:1
		BigDecimal rechangeMoney = FundAbacusUtil.format(FundAbacusUtil.divide(new BigDecimal(pointCount), 100));
		
		// 开始兑换 
		
		// 扣除积分
		 pointDetailService.genPointDetail(siteId,companyId,webUser,pointCountInt,UserEvent.pointExchangeCash,"");
		
		
		//增加现金
		fundDetailService.genFundDetail(siteId, companyId, webUser, rechangeMoney, UserEvent.pointExchangeCash,"");
		
		//最后汇总数据
		webUserService.updateWebUserAccount(webUser,pointCountInt,rechangeMoney,UserEvent.pointExchangeCash);
//		webUserService.updateWebUser(webUser,resultPoints,resultBanlace,null);
		
		return "1";
	}
	
}
