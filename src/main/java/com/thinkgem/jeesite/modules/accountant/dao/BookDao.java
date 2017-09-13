/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.accountant.dao;

import com.thinkgem.jeesite.common.persistence.TreeDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.accountant.entity.Book;

/**
 * 会计国标账本(科目)DAO接口
 * @author nideyuan
 * @version 2017-09-10
 */
@MyBatisDao
public interface BookDao extends TreeDao<Book> {
	
}