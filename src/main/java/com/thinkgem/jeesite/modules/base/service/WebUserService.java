/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.base.service;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.money.FundAbacusUtil;
import com.thinkgem.jeesite.modules.account.enums.FundIO;
import com.thinkgem.jeesite.modules.account.enums.TargetType;
import com.thinkgem.jeesite.modules.account.enums.UserEvent;
import com.thinkgem.jeesite.modules.account.service.FundDetailService;
import com.thinkgem.jeesite.modules.account.service.PointDetailService;
import com.thinkgem.jeesite.modules.base.dao.WebUserDao;
import com.thinkgem.jeesite.modules.base.entity.WebUser;

/**
 * 前台基本类Service
 * @author evan
 * @version 2015-03-21
 */
@Service
@Transactional(readOnly = true)
public class WebUserService extends CrudService<WebUserDao, WebUser> {
	@Autowired
	private WebUserDao webUserDao;
	
	@Autowired
	private FundDetailService fundDetailService;
	
//	@Autowired
//	private PointDetailService pointDetailService;
	
	public WebUser get(String id) {
		return super.get(id);
	}
	
	public List<WebUser> findList(WebUser webUser) {
		return super.findList(webUser);
	}
	
	public Page<WebUser> findPage(Page<WebUser> page, WebUser webUser) {
		return super.findPage(page, webUser);
	}
	
	@Transactional(readOnly = false)
	public WebUser save(WebUser webUser) {
		return super.save(webUser);
	}
	
	@Transactional(readOnly = false)
	public void delete(WebUser webUser) {
		super.delete(webUser);
	}
	//==================新增个性业务方法=============
	
	@Transactional(readOnly = false)
	public void doRegister(WebUser webUser) {

		super.save(webUser);

	}
	
	/**
	 * 根据用户名获取用户
	 * @param mobile
	 * @return
	 */
	public WebUser getByMobile(String mobile) {
		return webUserDao.getByMobile(mobile);
	}
	/**
	 * 根据微信OpenId获取用户
	 * @param wxOpenId
	 * @return
	 */
	public WebUser getByWxOpenId(String wxOpenId) {
		return webUserDao.getByWxOpenId(wxOpenId);
	}
	/**
	 * 根据用户名获取用户
	 * @param userName
	 * @return
	 */
	public WebUser getByUserName(String userName) {
		return webUserDao.getByUserName(userName);
	}
	/**
	 * 根据推荐Id获取用户
	 * @param inviteCode
	 * @return
	 */
	public WebUser getByInviteCode(String inviteCode) {
		return webUserDao.getByInviteCode(inviteCode);
	}
	/**
	 * 查询推荐的朋友
	 * @param page
	 * @param webUser
	 * @return
	 */
	public Page<WebUser> findReferrerList(Page<WebUser> page,WebUser webUser) {
		
		webUser.setPage(page);
		page.setList(webUserDao.findReferrerList(webUser));
		return page;
	}
	/**
	 * 获得所有的推荐奖励之和
	 * @param webUser
	 * @return
	 */
	public WebUser getSumAward(WebUser webUser) {
		
		return webUserDao.getSumAward(webUser);
		
	}
	/**
	 * 根据用户名获取用户
	 * @param email
	 * @return
	 */
	public WebUser getByEmail(String email) {
		return webUserDao.getByEmail(email);
	}
	
	@Transactional(readOnly = false)
	public void updateUserLoginInfo(WebUser user) {
		webUserDao.updateUserLoginInfo(user);
	}


	/**
	 * 更新用户资金或积分总计
	 * @param webUser
	 * @param operatePoints
	 * @param operateCash
	 * @param userEvent
	 */
	@Transactional(readOnly = false)
	public void updateWebUserAccount(WebUser webUser, Integer operatePoints,
			BigDecimal operateCash,UserEvent userEvent) {

		BigDecimal resultBanlace  = webUser.getBalance();
		Integer resultPoints = webUser.getPoints();
		BigDecimal frozenAmount = webUser.getFrozenAmount();
		
		if(UserEvent.register == userEvent){
			resultBanlace = operateCash;
			resultPoints = webUser.getPoints()+operatePoints;
			
		}else if(UserEvent.pointExchangeCash == userEvent){
			
			resultPoints = webUser.getPoints()-operatePoints;
			resultBanlace =  FundAbacusUtil.add(webUser.getBalance(),operateCash);
			
		}else if(UserEvent.cashoutApply == userEvent){//提现申请
			
			frozenAmount = FundAbacusUtil.add(webUser.getFrozenAmount() == null ?BigDecimal.ZERO:webUser.getFrozenAmount(),operateCash);
			resultBanlace =  FundAbacusUtil.subtract(webUser.getBalance(),operateCash);//减
			
		}else if(UserEvent.cashoutSuccess == userEvent){//提现审核成功
			frozenAmount = FundAbacusUtil.subtract(webUser.getFrozenAmount() == null ?BigDecimal.ZERO:webUser.getFrozenAmount(),operateCash);

		}else if(UserEvent.cashoutFail == userEvent){//提现审核失败
			
			frozenAmount = FundAbacusUtil.subtract(webUser.getFrozenAmount() ==null ?BigDecimal.ZERO:webUser.getFrozenAmount(),operateCash);
			
			resultBanlace =  FundAbacusUtil.add(webUser.getBalance(),operateCash);
		}else if(UserEvent.referreAward == userEvent){//推荐奖励
			resultBanlace =  FundAbacusUtil.add(webUser.getBalance(),operateCash);
		}
			
		if(frozenAmount != null){
			webUser.setFrozenAmount(frozenAmount);
		}
		if(resultBanlace != null ){
			webUser.setBalance(resultBanlace);
		}
		
		if(resultPoints != null){
			webUser.setPoints(resultPoints);
		}
		super.save(webUser);
	}

}