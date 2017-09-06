/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.account.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.account.entity.Funddetail;

/**
 * 资金记录DAO接口
 * @author evan
 * @version 2015-04-04
 */
@MyBatisDao
public interface FunddetailDao extends CrudDao<Funddetail> {
	
	public List<Funddetail> getLatelyByUserId(Funddetail funddetail);
}