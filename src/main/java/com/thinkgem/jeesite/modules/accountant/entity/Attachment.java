/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.accountant.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 账本记录Entity
 * @author 倪得渊
 * @version 2017-09-24
 */
public class Attachment extends DataEntity<Attachment> {

	private static final long serialVersionUID = 1L;
	private BookRecord record;		// 账本id 父类
	private String sourceDocId;		// 原始业务id
	private String filesPath;		// 文件路径
	private String type;		// 文件类型

	public Attachment() {
		super();
	}

	public Attachment(String id){
		super(id);
	}

	public Attachment(BookRecord record){
		this.record = record;
	}

	@Length(min=0, max=64, message="账本id长度必须介于 0 和 64 之间")
	public BookRecord getRecord() {
		return record;
	}


	@Length(min=1, max=64, message="原始业务id长度必须介于 1 和 64 之间")
	public String getSourceDocId() {
		return sourceDocId;
	}

	public void setSourceDocId(String sourceDocId) {
		this.sourceDocId = sourceDocId;
	}

	@Length(min=1, max=200, message="文件路径长度必须介于 1 和 200 之间")
	public String getFilesPath() {
		return filesPath;
	}

	public void setFilesPath(String filesPath) {
		this.filesPath = filesPath;
	}

	@Length(min=1, max=125, message="文件类型长度必须介于 1 和 125 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

}