/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sms.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.sms.entity.SmsLog;
import com.thinkgem.jeesite.modules.sms.dao.SmsLogDao;

/**
 * 短信记录Service
 * @author evan
 * @version 2015-11-13
 */
@Service
@Transactional(readOnly = true)
public class SmsLogService extends CrudService<SmsLogDao, SmsLog> {

	public SmsLog get(String id) {
		return super.get(id);
	}
	
	public List<SmsLog> findList(SmsLog smsLog) {
		return super.findList(smsLog);
	}
	
	public Page<SmsLog> findPage(Page<SmsLog> page, SmsLog smsLog) {
		return super.findPage(page, smsLog);
	}
	
	@Transactional(readOnly = false)
	public SmsLog save(SmsLog smsLog) {
		return super.save(smsLog);
	}
	
	@Transactional(readOnly = false)
	public void delete(SmsLog smsLog) {
		super.delete(smsLog);
	}
	
}