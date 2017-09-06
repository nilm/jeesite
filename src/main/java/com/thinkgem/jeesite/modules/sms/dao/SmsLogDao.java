/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sms.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.sms.entity.SmsLog;

/**
 * 短信记录DAO接口
 * @author evan
 * @version 2015-11-13
 */
@MyBatisDao
public interface SmsLogDao extends CrudDao<SmsLog> {
	
}