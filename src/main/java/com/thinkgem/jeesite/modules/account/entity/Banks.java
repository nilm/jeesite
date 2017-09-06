/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.account.entity;

import com.thinkgem.jeesite.modules.base.entity.WebUser;
import com.thinkgem.jeesite.modules.sys.entity.User;
import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 用户银行卡Entity
 * @author evan
 * @version 2015-04-04
 */
public class Banks extends DataEntity<Banks> {
	
	private static final long serialVersionUID = 1L;
	private String userId;		// 用户Id
	private String bankcardOwner;		// 开户名
	private String bankName;		// 开户银行
	private String bankBranchName;		// 开户支行
	private String bankNo;		// 银行卡号
	private String bankCode;		// 银行代码
	private String defaultBank;		// 是否默认
	
	public Banks() {
		super();
	}

	public Banks(String id){
		super(id);
	}

	@NotNull(message="用户Id不能为空")
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	@Length(min=1, max=60, message="开户名长度必须介于 1 和 60 之间")
	public String getBankcardOwner() {
		return bankcardOwner;
	}

	public void setBankcardOwner(String bankcardOwner) {
		this.bankcardOwner = bankcardOwner;
	}
	
	@Length(min=1, max=50, message="开户银行长度必须介于 1 和 50 之间")
	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	
	@Length(min=1, max=500, message="开户支行长度必须介于 1 和 500 之间")
	public String getBankBranchName() {
		return bankBranchName;
	}

	public void setBankBranchName(String bankBranchName) {
		this.bankBranchName = bankBranchName;
	}
	
	@Length(min=1, max=50, message="银行卡号长度必须介于 1 和 50 之间")
	public String getBankNo() {
		return bankNo;
	}

	public void setBankNo(String bankNo) {
		this.bankNo = bankNo;
	}
	
	@Length(min=1, max=64, message="银行代码长度必须介于 1 和 64 之间")
	public String getBankCode() {
		return bankCode;
	}

	public void setBankCode(String bankCode) {
		this.bankCode = bankCode;
	}
	
	@Length(min=1, max=1, message="是否默认长度必须介于 1 和 1 之间")
	public String getDefaultBank() {
		return defaultBank;
	}

	public void setDefaultBank(String defaultBank) {
		this.defaultBank = defaultBank;
	}
	
}