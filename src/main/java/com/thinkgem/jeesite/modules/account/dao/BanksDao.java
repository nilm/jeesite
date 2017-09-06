/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.account.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.account.entity.Banks;

/**
 * 用户银行卡DAO接口
 * @author evan
 * @version 2015-04-04
 */
@MyBatisDao
public interface BanksDao extends CrudDao<Banks> {
	/**
	 * 根据用户查询银行卡
	 * @param userId
	 * @return
	 */
	public List<Banks> findListByUser(Banks bank);
}