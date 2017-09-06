/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.company.entity;

import java.math.BigDecimal;

import com.thinkgem.jeesite.modules.sys.entity.Office;
import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 商户账户Entity
 * @author evan
 * @version 2015-11-13
 */
public class CompanyAccount extends DataEntity<CompanyAccount> {
	
	private static final long serialVersionUID = 1L;
	private Office company;		// 商户主键
	private BigDecimal balance;		// 余额
	private BigDecimal frozenAmount;		// 冻结金额
	private String createIp;		// 创建ip
	private BigDecimal beginBalance;		// 开始 余额
	private BigDecimal endBalance;		// 结束 余额
	//辅助查询字段
	private String companyId;	// 
	
	public CompanyAccount() {
		super();
	}

	public CompanyAccount(String id){
		super(id);
	}

	@NotNull(message="商户主键不能为空")
	public Office getCompany() {
		return company;
	}

	public void setCompany(Office company) {
		this.company = company;
	}
	
	public BigDecimal getBalance() {
		return balance;
	}

	public void setBalance(BigDecimal balance) {
		this.balance = balance;
	}
	
	public BigDecimal getFrozenAmount() {
		return frozenAmount;
	}

	public void setFrozenAmount(BigDecimal frozenAmount) {
		this.frozenAmount = frozenAmount;
	}
	
	public String getCreateIp() {
		return createIp;
	}

	public void setCreateIp(String createIp) {
		this.createIp = createIp;
	}
	
	public BigDecimal getBeginBalance() {
		return beginBalance;
	}

	public void setBeginBalance(BigDecimal beginBalance) {
		this.beginBalance = beginBalance;
	}
	
	public BigDecimal getEndBalance() {
		return endBalance;
	}

	public void setEndBalance(BigDecimal endBalance) {
		this.endBalance = endBalance;
	}

	public String getCompanyId() {
		return companyId;
	}

	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
		
}