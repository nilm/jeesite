/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.company.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.company.entity.CompanyBank;
import com.thinkgem.jeesite.modules.company.dao.CompanyBankDao;

/**
 * 商户资金明细Service
 * @author evan
 * @version 2015-11-13
 */
@Service
@Transactional(readOnly = true)
public class CompanyBankService extends CrudService<CompanyBankDao, CompanyBank> {

	public CompanyBank get(String id) {
		return super.get(id);
	}
	
	public List<CompanyBank> findList(CompanyBank companyBank) {
		return super.findList(companyBank);
	}
	
	public Page<CompanyBank> findPage(Page<CompanyBank> page, CompanyBank companyBank) {
		return super.findPage(page, companyBank);
	}
	
	@Transactional(readOnly = false)
	public CompanyBank save(CompanyBank companyBank) {
		return super.save(companyBank);
	}
	
	@Transactional(readOnly = false)
	public void delete(CompanyBank companyBank) {
		super.delete(companyBank);
	}
	
}