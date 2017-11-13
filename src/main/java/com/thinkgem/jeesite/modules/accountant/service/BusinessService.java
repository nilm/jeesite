/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.accountant.service;

import java.util.List;

import com.thinkgem.jeesite.modules.accountant.dao.BookDao;
import com.thinkgem.jeesite.modules.accountant.entity.Book;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.accountant.entity.Business;
import com.thinkgem.jeesite.modules.accountant.dao.BusinessDao;
import com.thinkgem.jeesite.modules.accountant.entity.BizBookTemplate;
import com.thinkgem.jeesite.modules.accountant.dao.BizBookTemplateDao;

/**
 * 发生的业务Service
 * @author 倪得渊
 * @version 2017-09-10
 */
@Service
@Transactional(readOnly = true)
public class BusinessService extends CrudService<BusinessDao, Business> {

	@Autowired
	private BizBookTemplateDao bizBookTemplateDao;

	@Autowired
	private BusinessDao businessDao;

	@Autowired
	private BookDao bookDao;

	public Business get(String id) {
		Business business = super.get(id);
		business.setBizBookTemplateList(bizBookTemplateDao.findList(new BizBookTemplate(business)));
		return business;
	}
	public Business gedById(String id) {
		Business business = super.get(id);
		return business;
	}

	public List<Business> findList(Business business) {
		return super.findList(business);
	}
	
	public Page<Business> findPage(Page<Business> page, Business business) {
		return super.findPage(page, business);
	}
	
	@Transactional(readOnly = false)
	public Business save(Business business) {
		super.save(business);
		for (BizBookTemplate bizBookTemplate : business.getBizBookTemplateList()){
			if (bizBookTemplate.getId() == null){
				continue;
			}
			if(bizBookTemplate.getUseCount() == null || "".equals(bizBookTemplate.getUseCount())){
				bizBookTemplate.setUseCount("10");
			}
			if (BizBookTemplate.DEL_FLAG_NORMAL.equals(bizBookTemplate.getDelFlag())){
				String bookId = bizBookTemplate.getBook().getId();
				Book book = bookDao.get(bookId);
				bizBookTemplate.setCategory(book.getCategory());
				if (StringUtils.isBlank(bizBookTemplate.getId())){
					bizBookTemplate.setBiz(business);
					bizBookTemplate.preInsert();
					bizBookTemplateDao.insert(bizBookTemplate);
				}else{
					bizBookTemplate.preUpdate();
					bizBookTemplateDao.update(bizBookTemplate);
				}
			}else{
				bizBookTemplateDao.delete(bizBookTemplate);
			}
		}
	return business;
	}
	
	@Transactional(readOnly = false)
	public void delete(Business business) {
		super.delete(business);
		bizBookTemplateDao.delete(new BizBookTemplate(business));
	}
	
}