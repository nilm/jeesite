/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.base.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.base.entity.Replenish;

/**
 * 充值记录DAO接口
 * @author binger
 * @version 2016-03-16
 */
@MyBatisDao
public interface ReplenishDao extends CrudDao<Replenish> {
	
	public Replenish findByOrderNo(Replenish replenish);
}