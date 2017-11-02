/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.accountant.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.accountant.entity.Book;
import com.thinkgem.jeesite.modules.accountant.entity.BookRecordDetail;

import java.util.List;

/**
 * 账本记录DAO接口
 * @author 倪得渊
 * @version 2017-09-24
 */
@MyBatisDao
public interface BookRecordDetailDao extends CrudDao<BookRecordDetail> {

    /**
     * 获取指定账本最新的一条记录
     * @param book
     * @return
     */
    public List<BookRecordDetail> getLastDetailByBook(BookRecordDetail book);

}