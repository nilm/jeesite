/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.company.entity;

import com.thinkgem.jeesite.modules.company.enums.FundIO;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import javax.validation.constraints.NotNull;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.validator.constraints.Length;
import com.thinkgem.jeesite.modules.sys.entity.User;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 商户订单 -- 结算单Entity
 * 
 * ===== 结算单不想要审核了
 * 
 * @author evan
 * @version 2015-11-14
 */
public class CompanySettleLog extends DataEntity<CompanySettleLog> {
	
	private static final long serialVersionUID = 1L;
	private Office company;		// 商户主键
	private BigDecimal payNetMoney;		// 支付净额
	private BigDecimal poundage;		// 手续费金额
	private BigDecimal settleMoney;		// 划账金额
	private FundIO settleType;		// 单据类别 进账OR 出账
	private Date beginTime;		// 开始时间
	private Date endTime;		// 结束时间
	private String billsCount;		// 单据数量
	private String auditStatus;		// 审核状态
	private User auditBy;		// 审核人
	private Date auditDate;		// 审核时间
	private String needAudit;		// 是否需要审核
	// 辅助查询字段
	private Date beginCreateDate;		// 开始 划账日期
	private Date endCreateDate;		// 结束 划账日期
	
	private String companyStatus;		// 商户订单状态
	private String auditById;		// 审核人	 不要审核了
	private String companyId;		
	private String minOrderId;		
	private String maxOrderId;		
	
	public CompanySettleLog() {
		super();
	}

	public CompanySettleLog(String id){
		super(id);
	}

	@NotNull(message="商户主键不能为空")
	public Office getCompany() {
		return company;
	}

	public void setCompany(Office company) {
		this.company = company;
	}
	
	@NotNull(message="支付净额不能为空")
	public BigDecimal getPayNetMoney() {
		return payNetMoney;
	}

	public void setPayNetMoney(BigDecimal payNetMoney) {
		this.payNetMoney = payNetMoney;
	}
	
	@NotNull(message="手续费金额不能为空")
	public BigDecimal getPoundage() {
		return poundage;
	}

	public void setPoundage(BigDecimal poundage) {
		this.poundage = poundage;
	}
	
	@NotNull(message="划账金额不能为空")
	public BigDecimal getSettleMoney() {
		return settleMoney;
	}

	public void setSettleMoney(BigDecimal settleMoney) {
		this.settleMoney = settleMoney;
	}
	
	@NotNull(message="单据类别不能为空")
	public FundIO getSettleType() {
		return settleType;
	}

	public void setSettleType(FundIO settleType) {
		this.settleType = settleType;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(Date beginTime) {
		this.beginTime = beginTime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	
	@Length(min=1, max=64, message="单据数量长度必须介于 1 和 64 之间")
	public String getBillsCount() {
		return billsCount;
	}

	public void setBillsCount(String billsCount) {
		this.billsCount = billsCount;
	}
	
	@Length(min=0, max=64, message="审核状态长度必须介于 0 和 64 之间")
	public String getAuditStatus() {
		return auditStatus;
	}

	public void setAuditStatus(String auditStatus) {
		this.auditStatus = auditStatus;
	}
	
	public User getAuditBy() {
		return auditBy;
	}

	public void setAuditBy(User auditBy) {
		this.auditBy = auditBy;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getAuditDate() {
		return auditDate;
	}

	public void setAuditDate(Date auditDate) {
		this.auditDate = auditDate;
	}
	
	@Length(min=0, max=32, message="是否需要审核长度必须介于 0 和 32 之间")
	public String getNeedAudit() {
		return needAudit;
	}

	public void setNeedAudit(String needAudit) {
		this.needAudit = needAudit;
	}
	
	public Date getBeginCreateDate() {
		return beginCreateDate;
	}

	public void setBeginCreateDate(Date beginCreateDate) {
		this.beginCreateDate = beginCreateDate;
	}
	
	public Date getEndCreateDate() {
		return endCreateDate;
	}

	public void setEndCreateDate(Date endCreateDate) {
		this.endCreateDate = endCreateDate;
	}

	public String getCompanyId() {
		return companyId;
	}

	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}

	public String getMinOrderId() {
		return minOrderId;
	}

	public void setMinOrderId(String minOrderId) {
		this.minOrderId = minOrderId;
	}

	public String getMaxOrderId() {
		return maxOrderId;
	}

	public void setMaxOrderId(String maxOrderId) {
		this.maxOrderId = maxOrderId;
	}

	public String getAuditById() {
		return auditById;
	}

	public void setAuditById(String auditById) {
		this.auditById = auditById;
	}

	public String getCompanyStatus() {
		return companyStatus;
	}

	public void setCompanyStatus(String companyStatus) {
		this.companyStatus = companyStatus;
	}
		
}