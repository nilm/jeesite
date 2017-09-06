/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.account.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.account.entity.Cashout;

/**
 * 用户提现申请DAO接口
 * @author evan
 * @version 2015-04-06
 */
@MyBatisDao
public interface CashoutDao extends CrudDao<Cashout> {
	
}