/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.accountant.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 原始业务记录Entity
 * @author 倪得渊
 * @version 2017-09-26
 */
public class Source extends DataEntity<Source> {
	
	private static final long serialVersionUID = 1L;
	private String type;		// 信息类型
	private String bizId;		// 业务主键
	private String text;		// 文本信息
	private String filePath;		// 文件路径
	private String convetStatus;		// 语音状转换态
	private Date convertTime;		// 语音状转换时间
	private Date fixedConvertTime;		// 语音文本修正时间
	private String fixedVoiceConvertText;		// 语音修正文本
	private String voiceConvertText;		// 语音转换文本
	
	public Source() {
		super();
	}

	public Source(String id){
		super(id);
	}

	@Length(min=0, max=255, message="信息类型长度必须介于 0 和 255 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	@Length(min=0, max=64, message="业务主键长度必须介于 0 和 64 之间")
	public String getBizId() {
		return bizId;
	}

	public void setBizId(String bizId) {
		this.bizId = bizId;
	}
	
	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}
	
	@Length(min=0, max=255, message="文件路径长度必须介于 0 和 255 之间")
	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	
	@Length(min=1, max=11, message="语音状转换态长度必须介于 1 和 11 之间")
	public String getConvetStatus() {
		return convetStatus;
	}

	public void setConvetStatus(String convetStatus) {
		this.convetStatus = convetStatus;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getConvertTime() {
		return convertTime;
	}

	public void setConvertTime(Date convertTime) {
		this.convertTime = convertTime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getFixedConvertTime() {
		return fixedConvertTime;
	}

	public void setFixedConvertTime(Date fixedConvertTime) {
		this.fixedConvertTime = fixedConvertTime;
	}
	
	public String getFixedVoiceConvertText() {
		return fixedVoiceConvertText;
	}

	public void setFixedVoiceConvertText(String fixedVoiceConvertText) {
		this.fixedVoiceConvertText = fixedVoiceConvertText;
	}
	
	public String getVoiceConvertText() {
		return voiceConvertText;
	}

	public void setVoiceConvertText(String voiceConvertText) {
		this.voiceConvertText = voiceConvertText;
	}
	
}