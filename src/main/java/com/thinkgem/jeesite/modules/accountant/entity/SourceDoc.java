/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.accountant.entity;

import com.thinkgem.jeesite.modules.sys.entity.User;
import javax.validation.constraints.NotNull;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import java.util.List;
import com.google.common.collect.Lists;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 原始业务记录Entity
 * @author 倪得渊
 * @version 2017-09-16
 */
public class SourceDoc extends DataEntity<SourceDoc> {
	
	private static final long serialVersionUID = 1L;
	private User user;		// 用户id
	private Office company;		// 公司id
	private String bizId;		// 业务id
	private String accountType;		// 账户类型
	private String digest;		// 摘要
	private String money;		// 金额
	private String attachmentCount;		// 附件数
	private Date recordDate;		// 记账时间
	private String status;		// 当前状态
	private Date assignDate;		// 分配时间
	private User accountantUserId;		// 处理人
	private Date handleDate;		// 处理时间
	private List<SourceDocSubject> sourceDocSubjectList = Lists.newArrayList();		// 子表列表
	
	public SourceDoc() {
		super();
	}

	public SourceDoc(String id){
		super(id);
	}

	@NotNull(message="用户id不能为空")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@NotNull(message="公司id不能为空")
	public Office getCompany() {
		return company;
	}

	public void setCompany(Office company) {
		this.company = company;
	}
	
	@Length(min=1, max=64, message="业务id长度必须介于 1 和 64 之间")
	public String getBizId() {
		return bizId;
	}

	public void setBizId(String bizId) {
		this.bizId = bizId;
	}
	
	@Length(min=0, max=125, message="账户类型长度必须介于 0 和 125 之间")
	public String getAccountType() {
		return accountType;
	}

	public void setAccountType(String accountType) {
		this.accountType = accountType;
	}
	
	@Length(min=0, max=255, message="摘要长度必须介于 0 和 255 之间")
	public String getDigest() {
		return digest;
	}

	public void setDigest(String digest) {
		this.digest = digest;
	}
	
	public String getMoney() {
		return money;
	}

	public void setMoney(String money) {
		this.money = money;
	}
	
	@Length(min=0, max=128, message="附件数长度必须介于 0 和 128 之间")
	public String getAttachmentCount() {
		return attachmentCount;
	}

	public void setAttachmentCount(String attachmentCount) {
		this.attachmentCount = attachmentCount;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="记账时间不能为空")
	public Date getRecordDate() {
		return recordDate;
	}

	public void setRecordDate(Date recordDate) {
		this.recordDate = recordDate;
	}
	
	@Length(min=0, max=125, message="当前状态长度必须介于 0 和 125 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getAssignDate() {
		return assignDate;
	}

	public void setAssignDate(Date assignDate) {
		this.assignDate = assignDate;
	}
	
	public User getAccountantUserId() {
		return accountantUserId;
	}

	public void setAccountantUserId(User accountantUserId) {
		this.accountantUserId = accountantUserId;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getHandleDate() {
		return handleDate;
	}

	public void setHandleDate(Date handleDate) {
		this.handleDate = handleDate;
	}
	
	public List<SourceDocSubject> getSourceDocSubjectList() {
		return sourceDocSubjectList;
	}

	public void setSourceDocSubjectList(List<SourceDocSubject> sourceDocSubjectList) {
		this.sourceDocSubjectList = sourceDocSubjectList;
	}
}