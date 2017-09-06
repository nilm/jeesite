/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.account.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.account.dao.AccountAlipayInfoDao;
import com.thinkgem.jeesite.modules.account.entity.AccountAlipayInfo;

/**
 * 用户支付宝信息Service
 * @author evan
 * @version 2015-04-04
 */
@Service
@Transactional(readOnly = true)
public class AccountAlipayInfoService extends CrudService<AccountAlipayInfoDao, AccountAlipayInfo> {

	@Autowired
	private AccountAlipayInfoDao alipayInfoDao;
	
	public AccountAlipayInfo get(String id) {
		return super.get(id);
	}
	
	public List<AccountAlipayInfo> findList(AccountAlipayInfo accountAlipayInfo) {
		return super.findList(accountAlipayInfo);
	}
	
	public Page<AccountAlipayInfo> findPage(Page<AccountAlipayInfo> page, AccountAlipayInfo accountAlipayInfo) {
		return super.findPage(page, accountAlipayInfo);
	}
	
	@Transactional(readOnly = false)
	public AccountAlipayInfo save(AccountAlipayInfo accountAlipayInfo) {
		return super.save(accountAlipayInfo);
	}
	
	@Transactional(readOnly = false)
	public void delete(AccountAlipayInfo accountAlipayInfo) {
		super.delete(accountAlipayInfo);
	}
	//==============业务定制方法===========
	
	public List<AccountAlipayInfo> findListByUser(String userId) {
		AccountAlipayInfo alipayInfo = new AccountAlipayInfo();
		alipayInfo.setUserId(userId);
		return  alipayInfoDao.findListByUser(alipayInfo);
	}
}