/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.accountant.service;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.TreeService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.accountant.dao.BookDao;
import com.thinkgem.jeesite.modules.accountant.dao.BookRecordDetailDao;
import com.thinkgem.jeesite.modules.accountant.dto.BookDto;
import com.thinkgem.jeesite.modules.accountant.entity.Book;
import com.thinkgem.jeesite.modules.accountant.entity.BookRecordDetail;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * 会计国标账本(科目)Service
 * @author nideyuan
 * @version 2017-09-10
 */
@Service
@Transactional(readOnly = true)
public class BookService extends TreeService<BookDao, Book> {

	@Autowired
	public  BookDao bookDao;

	@Autowired
	private BookRecordDetailDao bookRecordDetailDao;

	public Book get(String id) {
		return super.get(id);
	}
	
	public List<Book> findList(Book book) {
		if (StringUtils.isNotBlank(book.getParentIds())){
			book.setParentIds(","+book.getParentIds()+",");
		}
		return super.findList(book);
	}
	
	@Transactional(readOnly = false)
	public Book save(Book book) {
		return super.save(book);
	}
	
	@Transactional(readOnly = false)
	public void delete(Book book) {
		super.delete(book);
	}

	/**
	 * 获取账本明细记录
	 * @param page
	 * @param book
	 * @return
	 */
	public Page<BookRecordDetail> findBookRecordDetailPage(Page<BookRecordDetail> page, Book book){
		BookRecordDetail bookrecordDetail = new BookRecordDetail();
		bookrecordDetail.setBookId(book.getId());
		bookrecordDetail.setPage(page);
		page.setList(bookRecordDetailDao.findBookRecordDetailPage(bookrecordDetail));
		return page;
	}
	/**
	 * 获得左右账本 左右栏 的合计值
	 * @param bookCatetory
	 * @return
	 */
	public BookRecordDetail getCategorySumAmount(String bookCatetory){
		Book book = new Book();
		book.setCategory(bookCatetory);
		BookRecordDetail bookRecordDetail = new BookRecordDetail();
		bookRecordDetail.setBook(book);
		return bookRecordDetailDao.getCategorySumAmount(bookRecordDetail);
	}

	/**
	 * 根据账本 账本性质  accountantCategory 查询 账本 String category
	 * @param book
	 * @return
	 */
	public List<Book> findByCategoryList(Book  book) {
//		select b.* from  accountant_book b  where
//		b.company_id is null and category='left' and
//		b.level=2 ORDER BY sort;
		book.setLevel("2");
		List<Book> books =  bookDao.findByCategoryList(book); // sql
		return books;

	}

	/**
	 * 根据账本 账本性质  accountantCategory  账本 String category 查询 === BookDto 全名称 余额
	 * @param book
	 * @return
	 */
	public List<BookDto> findBookDtoByCategoryList(Book  book) {
//		select b.* from  accountant_book b  where
//		b.company_id is null and category='left' and
//		b.final_stage=1 ORDER BY sort;
		book.setFinalStage("1");
		List<Book> books =  bookDao.findByCategoryList(book); // sql
		if(books != null && books.size() >0 ){
			return  convertBookDtos(books);
		}
		return null;

	}

	private  List<BookDto> convertBookDtos(List<Book> books){
		if(books == null || books.size() <= 0 ){
			return  null;
		}
		List<BookDto> bookDtos = new ArrayList<BookDto>();
		for (Book book:books) {
			BookDto bookDto = new BookDto();
			bookDto.setId(book.getId());
			bookDto.setName(book.getName());
//			bookDto.setName(getParentNames(book));
			bookDto.setSumAmount(getSumAmount(book));
			bookDtos.add(bookDto);
		}

		return bookDtos;
	}
	private String getParentNames(Book book){
// select name,GROUP_CONCAT(name Separator " / ") from  accountant_book b1  where  id in (0,66,48) order by FIELD(id,0,66,48)
		if (StringUtils.isNotBlank(book.getParentIds())){
			String parentIds = book.getParentIds().replace(",","','");
			book.setParentIds("'"+parentIds+book.getId()+"'");
		}
		Book book4pName = bookDao.getParentNames(book);
		return book4pName != null ?book4pName.getName():"";
	}

	private String getSumAmount(Book book){
		BookRecordDetail bookRecordDetail =  new BookRecordDetail();
		bookRecordDetail.setBookId(book.getId());

		bookRecordDetail = bookRecordDetailDao.getSumAmount(bookRecordDetail);

		if (bookRecordDetail ==null){
			logger.warn("bookRecordDetail 获取失败！！");
			return "0.00";
		}
		float leftSumAmount = bookRecordDetail.getLeftSumAmount();
		float rightSumAmount = bookRecordDetail.getRightSumAmount();

		float sumAmountf =  leftSumAmount - rightSumAmount;// 默认计算左栏（左账本）

		if("right".equals(book.getCategory())){
			 sumAmountf =  rightSumAmount - leftSumAmount;
		}

		return sumAmountf != 0 ? sumAmountf+"":"0.00";
	}
}