/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.accountant.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.accountant.entity.BizBookTemplate;
import com.thinkgem.jeesite.modules.accountant.dao.BizBookTemplateDao;

/**
 * 业务账本关系模板Service
 * @author 倪得渊
 * @version 2017-09-10
 */
@Service
@Transactional(readOnly = true)
public class BizBookTemplateService extends CrudService<BizBookTemplateDao, BizBookTemplate> {

	public BizBookTemplate get(String id) {
		return super.get(id);
	}
	
	public List<BizBookTemplate> findList(BizBookTemplate bizBookTemplate) {
		return super.findList(bizBookTemplate);
	}
	
	public Page<BizBookTemplate> findPage(Page<BizBookTemplate> page, BizBookTemplate bizBookTemplate) {
		return super.findPage(page, bizBookTemplate);
	}
	
	@Transactional(readOnly = false)
	public BizBookTemplate save(BizBookTemplate bizBookTemplate) {
		return super.save(bizBookTemplate);
	}
	
	@Transactional(readOnly = false)
	public void delete(BizBookTemplate bizBookTemplate) {
		super.delete(bizBookTemplate);
	}
	
}