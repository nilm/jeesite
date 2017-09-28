/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.accountant.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.accountant.entity.Source;
import com.thinkgem.jeesite.modules.accountant.dao.SourceDao;

/**
 * 原始业务记录Service
 * @author 倪得渊
 * @version 2017-09-26
 */
@Service
@Transactional(readOnly = true)
public class SourceService extends CrudService<SourceDao, Source> {

	public Source get(String id) {
		return super.get(id);
	}
	
	public List<Source> findList(Source source) {
		return super.findList(source);
	}
	
	public Page<Source> findPage(Page<Source> page, Source source) {
		return super.findPage(page, source);
	}
	
	@Transactional(readOnly = false)
	public Source save(Source source) {
		return super.save(source);
	}
	
	@Transactional(readOnly = false)
	public void delete(Source source) {
		super.delete(source);
	}
	
}