/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.company.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.company.entity.CompanyCashout;

/**
 * 商户提现记录DAO接口
 * @author evan
 * @version 2015-11-13
 */
@MyBatisDao
public interface CompanyCashoutDao extends CrudDao<CompanyCashout> {
	
}