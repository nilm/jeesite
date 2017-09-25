/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.accountant.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

import java.util.Date;

/**
 * 账本记录Entity
 * @author 倪得渊
 * @version 2017-09-24
 */
public class BookRecordDetail extends DataEntity<BookRecordDetail> {
	
	private static final long serialVersionUID = 1L;
	private BookRecord record;		// 记录id 父类
	private Book book;		// 账本id
	private String amount;		// 金额
	private String balance;		// 余额
	private String direction;		// 栏类型 left right
	private Date createDate;
	private long recordTimestamp;

	private String bookId;
	private String bookName;

	public BookRecordDetail() {
		super();
	}

	public BookRecordDetail(String id){
		super(id);
	}

	public BookRecordDetail(BookRecord record){
		this.record = record;
	}

	public BookRecord getRecord() {
		return record;
	}

	public void setRecord(BookRecord record) {
		this.record = record;
	}
	
	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}
	
	public String getBalance() {
		return balance;
	}

	public void setBalance(String balance) {
		this.balance = balance;
	}
	
	@Length(min=0, max=16, message="栏类型 left right长度必须介于 0 和 16 之间")
	public String getDirection() {
		return direction;
	}

	public void setDirection(String direction) {
		this.direction = direction;
	}

	@Override
	public Date getCreateDate() {
		return createDate;
	}

	@Override
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public long getRecordTimestamp() {
		return recordTimestamp;
	}

	public void setRecordTimestamp(long recordTimestamp) {
		this.recordTimestamp = recordTimestamp;
	}

	public Book getBook() {
		return book;
	}

	public void setBook(Book book) {
		this.book = book;
	}

	public String getBookId() {
		return bookId;
	}

	public void setBookId(String bookId) {
		this.bookId = bookId;
	}

	public String getBookName() {
		return bookName;
	}

	public void setBookName(String bookName) {
		this.bookName = bookName;
	}
}