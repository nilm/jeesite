/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.accountant.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.Page;
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
     * @param bookRecordDetail
     * @return
     */
    public List<BookRecordDetail> getLastDetailByBook(BookRecordDetail bookRecordDetail);

    /**
     * 获得指定账本的的余额信息
     * @param bookRecordDetail
     * @return
     */
    public BookRecordDetail getSumAmount(BookRecordDetail bookRecordDetail);

    /**
     * 获取左右账本的合计 bookRecordDetail --》 book  --》category
     * @param bookRecordDetail
     * @return
     */
    public BookRecordDetail getCategorySumAmount(BookRecordDetail bookRecordDetail);

    /**
     * 获取明细账记录
     * @param bookRecordDetail
     * @return
     */
    public List<BookRecordDetail> findBookRecordDetailPage(BookRecordDetail bookRecordDetail);

    List<BookRecordDetail> findListByMonthAndType(BookRecordDetail bookRecordDetail);
    
}