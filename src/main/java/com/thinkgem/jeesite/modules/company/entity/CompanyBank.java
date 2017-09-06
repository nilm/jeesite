/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.company.entity;

import com.thinkgem.jeesite.modules.sys.entity.Office;
import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 商户资金明细Entity
 * @author evan
 * @version 2015-11-13
 */
public class CompanyBank extends DataEntity<CompanyBank> {
	
	private static final long serialVersionUID = 1L;
	private Office company;		// 商户主键
	private String bankcardOwner;		// 开户名称
	private String bankName;		// 开户行
	private String bankBranchName;		// 开户支行
	private String bankNo;		// 银行卡号
	private String bankCode;		// 银行代码
	private String useable;		// 是否可用
	private User auditBy;		// 审核人
	private Date auditDate;		// 审核时间
	
	//辅助查询字段
	private String companyId;		// 开户名称
	
	public CompanyBank() {
		super();
	}

	public CompanyBank(String id){
		super(id);
	}

	@NotNull(message="商户不能为空")
	public Office getCompany() {
		return company;
	}

	public void setCompany(Office company) {
		this.company = company;
	}
	
	@Length(min=1, max=60, message="开户名称长度必须介于 1 和 60 之间")
	public String getBankcardOwner() {
		return bankcardOwner;
	}

	public void setBankcardOwner(String bankcardOwner) {
		this.bankcardOwner = bankcardOwner;
	}
	
	@Length(min=1, max=50, message="开户行长度必须介于 1 和 50 之间")
	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	
	@Length(min=0, max=500, message="开户支行长度必须介于 0 和 500 之间")
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
	
	@Length(min=0, max=64, message="银行代码长度必须介于 0 和 64 之间")
	public String getBankCode() {
		return bankCode;
	}

	public void setBankCode(String bankCode) {
		this.bankCode = bankCode;
	}
	
	@Length(min=0, max=64, message="是否可用长度必须介于 0 和 64 之间")
	public String getUseable() {
		return useable;
	}

	public void setUseable(String useable) {
		this.useable = useable;
	}
	
	public User getAuditBy() {
		return auditBy;
	}

	public void setAuditBy(User auditBy) {
		this.auditBy = auditBy;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="审核时间不能为空")
	public Date getAuditDate() {
		return auditDate;
	}

	public void setAuditDate(Date auditDate) {
		this.auditDate = auditDate;
	}

	public String getCompanyId() {
		return companyId;
	}

	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
		
}