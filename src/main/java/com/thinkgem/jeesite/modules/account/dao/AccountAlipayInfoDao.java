/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.account.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.account.entity.AccountAlipayInfo;

/**
 * 用户支付宝信息DAO接口
 * @author evan
 * @version 2015-04-04
 */
@MyBatisDao
public interface AccountAlipayInfoDao extends CrudDao<AccountAlipayInfo> {
	/**
	 * 根据用户查询支付宝信息
	 * @param alipayInfo
	 * @return
	 */
	public List<AccountAlipayInfo> findListByUser(AccountAlipayInfo alipayInfo);
}