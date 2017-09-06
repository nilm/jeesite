/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.account.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 用户支付宝信息Entity
 * @author evan
 * @version 2015-04-04
 */
public class AccountAlipayInfo extends DataEntity<AccountAlipayInfo> {
	
	private static final long serialVersionUID = 1L;
	private String userId;		// 用户Id
	private String owner;		// 支付宝持有人
	private String alipayNo;		// 支付宝账号
	
	public AccountAlipayInfo(String userId,String owner,String alipayNo) {
		this.userId = userId;
		this.owner = owner;
		this.alipayNo = alipayNo;
	}
	public AccountAlipayInfo() {
		super();
	}

	public AccountAlipayInfo(String id){
		super(id);
	}

	@Length(min=1, max=64, message="用户Id长度必须介于 1 和 64 之间")
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	@Length(min=1, max=60, message="支付宝持有人长度必须介于 1 和 60 之间")
	public String getOwner() {
		return owner;
	}

	public void setOwner(String owner) {
		this.owner = owner;
	}
	
	@Length(min=1, max=128, message="支付宝账号长度必须介于 1 和 128 之间")
	public String getAlipayNo() {
		return alipayNo;
	}

	public void setAlipayNo(String alipayNo) {
		this.alipayNo = alipayNo;
	}
	
}