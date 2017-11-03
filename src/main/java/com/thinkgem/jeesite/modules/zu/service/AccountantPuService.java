/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zu.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.service.TreeService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.zu.entity.AccountantPu;
import com.thinkgem.jeesite.modules.zu.dao.AccountantPuDao;

/**
 * 族谱Service
 * @author 倪得渊
 * @version 2017-10-06
 */
@Service
@Transactional(readOnly = true)
public class AccountantPuService extends TreeService<AccountantPuDao, AccountantPu> {

	public AccountantPu get(String id) {
		return super.get(id);
	}
	
	public List<AccountantPu> findList(AccountantPu accountantPu) {
		if (StringUtils.isNotBlank(accountantPu.getParentIds())){
			accountantPu.setParentIds(","+accountantPu.getParentIds()+",");
		}
		return super.findList(accountantPu);
	}
	
	@Transactional(readOnly = false)
	public AccountantPu save(AccountantPu accountantPu) {
		return super.save(accountantPu);
	}
	
	@Transactional(readOnly = false)
	public void delete(AccountantPu accountantPu) {
		super.delete(accountantPu);
	}
	
}