/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.accountant.entity;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;

import com.thinkgem.jeesite.modules.accountant.enums.BookRecordType;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import org.hibernate.validator.constraints.Length;
import java.util.List;
import com.google.common.collect.Lists;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 账本记录Entity
 * @author 倪得渊
 * @version 2017-09-24
 */
public class BookRecord extends DataEntity<BookRecord> {
	
	private static final long serialVersionUID = 1L;
	private Date recordDate;		// 记账时间
	private User user;		// 用户id
	private Office company;		// 公司id
	private Business biz;	// 业务
	private String bizId;		// 业务id
	private String sourceDocId;		// 原始凭证id
	private String digest;		// 摘要
	private String amount;		// 金额
	private String status;		// 当前状态
	private String attachmentCount= 0+"";		// 附件数
	private String auditUserId;		// 审核用户id
	private Date auditDate;		// 审核日期
	private Date assignDate;		// 分配时间
	private List<Attachment> attachmentList = Lists.newArrayList();		// 子表列表
	private List<BookRecordDetail> bookRecordDetailList = Lists.newArrayList();		// 子表列表
	private BookRecordType bookRecordType=BookRecordType.DAILY; //账本记录类型
	public BookRecord() {
		super();
	}

	public BookRecord(String id){
		super(id);
	}

	public BookRecordType getBookRecordType() {
		return bookRecordType;
	}

	public void setBookRecordType(BookRecordType bookRecordType) {
		this.bookRecordType = bookRecordType;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="记账时间不能为空")
	public Date getRecordDate() {
		return recordDate;
	}

	public void setRecordDate(Date recordDate) {
		this.recordDate = recordDate;
	}
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	public Office getCompany() {
		return company;
	}

	public void setCompany(Office company) {
		this.company = company;
	}
	
	@Length(min=0, max=64, message="业务id长度必须介于 0 和 64 之间")
	public String getBizId() {
		return bizId;
	}

	public void setBizId(String bizId) {
		this.bizId = bizId;
	}
	
	public String getSourceDocId() {
		return sourceDocId;
	}

	public void setSourceDocId(String sourceDocId) {
		this.sourceDocId = sourceDocId;
	}
	
	@Length(min=0, max=255, message="摘要长度必须介于 0 和 255 之间")
	public String getDigest() {
		return digest;
	}

	public void setDigest(String digest) {
		this.digest = digest;
	}
	
	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}
	
	@Length(min=1, max=125, message="当前状态长度必须介于 1 和 125 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=0, max=128, message="附件数长度必须介于 0 和 128 之间")
	public String getAttachmentCount() {
		return attachmentCount;
	}

	public void setAttachmentCount(String attachmentCount) {
		this.attachmentCount = attachmentCount;
	}
	
	public String getAuditUserId() {
		return auditUserId;
	}

	public void setAuditUserId(String auditUserId) {
		this.auditUserId = auditUserId;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getAuditDate() {
		return auditDate;
	}

	public void setAuditDate(Date auditDate) {
		this.auditDate = auditDate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getAssignDate() {
		return assignDate;
	}

	public void setAssignDate(Date assignDate) {
		this.assignDate = assignDate;
	}
	
	public List<Attachment> getAttachmentList() {
		return attachmentList;
	}

	public void setAttachmentList(List<Attachment> attachmentList) {
		this.attachmentList = attachmentList;
	}
	public List<BookRecordDetail> getBookRecordDetailList() {
		return bookRecordDetailList;
	}

	public void setBookRecordDetailList(List<BookRecordDetail> bookRecordDetailList) {
		this.bookRecordDetailList = bookRecordDetailList;
	}

	public Business getBiz() {
		return biz;
	}

	public void setBiz(Business biz) {
		this.biz = biz;
	}
}