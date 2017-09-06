/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.base.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.base.entity.WebUser;

/**
 * 前台基本类DAO接口
 * @author evan
 * @version 2015-03-21
 */
@MyBatisDao
public interface WebUserDao extends CrudDao<WebUser> {
	
	/**
	 * 根据用户名获取用户
	 * @param userName
	 * @return
	 */
	public WebUser getByUserName(String userName);
	/**
	 * 根据推荐人获取用户
	 * @param userName
	 * @return
	 */
	public WebUser getByInviteCode(String inviteCode);
	/**
	 * 根据手机号获得用户
	 * @param mobile
	 * @return
	 */
	public WebUser getByMobile(String mobile);
	/**
	 * 根据微信OpenId获得用户
	 * @param wxOpenId
	 * @return
	 */
	public WebUser getByWxOpenId(String wxOpenId);
	/**
	 * 根据邮箱获得用户
	 * @param mobile
	 * @return
	 */
	public WebUser getByEmail(String email);
	
	/**
	 * 更新用户登录信息
	 * @param mobile
	 * @return
	 */
	public void updateUserLoginInfo(WebUser user);
	/**
	 * 查询推荐的朋友
	 * @param user
	 * @return
	 */
	public List<WebUser> findReferrerList(WebUser webUser);
	/**
	 * 统计所有的推荐奖励
	 * @param webUser
	 * @return
	 */
	public WebUser getSumAward(WebUser webUser);
}