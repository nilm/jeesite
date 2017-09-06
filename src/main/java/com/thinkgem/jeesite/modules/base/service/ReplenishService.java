/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.base.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.base.entity.Replenish;
import com.thinkgem.jeesite.modules.base.dao.ReplenishDao;

/**
 * 充值记录Service
 * @author binger
 * @version 2016-03-16
 */
@Service
@Transactional(readOnly = true)
public class ReplenishService extends CrudService<ReplenishDao, Replenish> {

	@Autowired
	private ReplenishDao replenishDao;
	
	public Replenish get(String id) {
		return super.get(id);
	}
	
	public List<Replenish> findList(Replenish replenish) {
		return super.findList(replenish);
	}
	
	public Page<Replenish> findPage(Page<Replenish> page, Replenish replenish) {
		return super.findPage(page, replenish);
	}
	
	@Transactional(readOnly = false)
	public Replenish save(Replenish replenish) {
		return super.save(replenish);
	}
	
	@Transactional(readOnly = false)
	public void delete(Replenish replenish) {
		super.delete(replenish);
	}
	
	public Replenish findByOrderNo(String orderNo) {
		Replenish replenish = new Replenish();
		replenish.setOrderid(orderNo);
		return replenishDao.findByOrderNo(replenish);
	}
}