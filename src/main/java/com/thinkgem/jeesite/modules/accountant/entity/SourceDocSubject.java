/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.accountant.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 原始业务记录Entity
 * @author 倪得渊
 * @version 2017-09-16
 */
public class SourceDocSubject extends DataEntity<SourceDocSubject> {
	
	private static final long serialVersionUID = 1L;
	private SourceDoc sourceDoc;		// 详尽业务id 父类
	private String subjectId;		// 科目
	private String amount;		// 金额
	private String direction;		// 方向 左栏右栏
	
	public SourceDocSubject() {
		super();
	}

	public SourceDocSubject(String id){
		super(id);
	}

	public SourceDocSubject(SourceDoc sourceDoc){
		this.sourceDoc = sourceDoc;
	}

	@Length(min=0, max=64, message="详尽业务id长度必须介于 0 和 64 之间")
	public SourceDoc getSourceDoc() {
		return sourceDoc;
	}

	public void setSourceDoc(SourceDoc sourceDoc) {
		this.sourceDoc = sourceDoc;
	}
	
	@Length(min=0, max=64, message="科目长度必须介于 0 和 64 之间")
	public String getSubjectId() {
		return subjectId;
	}

	public void setSubjectId(String subjectId) {
		this.subjectId = subjectId;
	}
	
	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}
	
	@Length(min=1, max=125, message="方向 左栏右栏长度必须介于 1 和 125 之间")
	public String getDirection() {
		return direction;
	}

	public void setDirection(String direction) {
		this.direction = direction;
	}
	
}