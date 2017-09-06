/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.portal.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.portal.entity.PortalFunddetail;

/**
 * 平台资金流动DAO接口
 * @author evan
 * @version 2015-11-21
 */
@MyBatisDao
public interface PortalFunddetailDao extends CrudDao<PortalFunddetail> {
	
}