/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.accountant.entity;

import com.thinkgem.jeesite.modules.accountant.enums.BookRecordType;
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
	private Date recordDate;
	private Date createDate;
	private long recordTimestamp;
	private BookRecordType bookRecordType=BookRecordType.DAILY;

	// 查询辅助字段
	private String bookId;
	private String bookName;
	private float leftSumAmount;// 左栏余额
	private float rightSumAmount;// 右栏余额
	private String recDate;//按月查询辅助字段

	public String getRecDate() {
		return recDate;
	}

	public void setRecDate(String recDate) {
		this.recDate = recDate;
	}

	public Date getRecordDate() {
		return recordDate;
	}

	public void setRecordDate(Date recordDate) {
		this.recordDate = recordDate;
	}

	public float getLeftSumAmount() {
		return leftSumAmount;
	}

	public void setLeftSumAmount(float leftSumAmount) {
		this.leftSumAmount = leftSumAmount;
	}

	public float getRightSumAmount() {
		return rightSumAmount;
	}

	public void setRightSumAmount(float rightSumAmount) {
		this.rightSumAmount = rightSumAmount;
	}

	public BookRecordDetail() {
		super();
	}

	public BookRecordDetail(String id){
		super(id);
	}

	public BookRecordDetail(BookRecord record){
		this.record = record;
	}

	public BookRecordType getBookRecordType() {
		return bookRecordType;
	}

	public void setBookRecordType(BookRecordType bookRecordType) {
		this.bookRecordType = bookRecordType;
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