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
import com.thinkgem.jeesite.modules.account.entity.Banks;
import com.thinkgem.jeesite.modules.account.dao.BanksDao;

/**
 * 用户银行卡Service
 * @author evan
 * @version 2015-04-04
 */
@Service
@Transactional(readOnly = true)
public class BanksService extends CrudService<BanksDao, Banks> {

	@Autowired
	private BanksDao banksDao;
	
	public Banks get(String id) {
		return super.get(id);
	}
	
	public List<Banks> findList(Banks banks) {
		return super.findList(banks);
	}
	
	public Page<Banks> findPage(Page<Banks> page, Banks banks) {
		return super.findPage(page, banks);
	}
	
	@Transactional(readOnly = false)
	public Banks save(Banks banks) {
		return super.save(banks);
	}
	
	@Transactional(readOnly = false)
	public void delete(Banks banks) {
		super.delete(banks);
	}
	//==============业务定制方法===========
	
	public List<Banks> findListByUser(String userId) {
		Banks bank = new Banks();
		bank.setUserId(userId);
		return  banksDao.findListByUser(bank);
	}
}