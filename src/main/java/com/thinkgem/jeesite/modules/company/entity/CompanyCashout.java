/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.company.entity;

import org.hibernate.validator.constraints.Length;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import javax.validation.constraints.NotNull;
import com.thinkgem.jeesite.modules.sys.entity.User;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 商户提现记录Entity
 * @author evan
 * @version 2015-11-13
 */
public class CompanyCashout extends DataEntity<CompanyCashout> {
	
	private static final long serialVersionUID = 1L;
	private String siteId;		// 站点
	private Office company;		// 合作机构
	private User user;		// 用户
	private BigDecimal applyAmount;		// 提现金额
	private BigDecimal cashoutFee;		// 提现费用
	private String status;		// 状态
	private String content;		// 描述
	private Date auditDate;		// 审核时间
	private User audit;		// 审核人
	private String applyIp;		// 申请ip
	private BigDecimal beginApplyAmount;		// 开始 提现金额
	private BigDecimal endApplyAmount;		// 结束 提现金额
	private Date beginAuditDate;		// 开始 审核时间
	private Date endAuditDate;		// 结束 审核时间
	private Date beginCreateDate;		// 开始 申请时间
	private Date endCreateDate;		// 结束 申请时间
	// 辅助查询字段
	private String companyId;		//
	
	public CompanyCashout() {
		super();
	}

	public CompanyCashout(String id){
		super(id);
	}

	@Length(min=0, max=64, message="站点长度必须介于 0 和 64 之间")
	public String getSiteId() {
		return siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}
	
	@NotNull(message="合作机构不能为空")
	public Office getCompany() {
		return company;
	}

	public void setCompany(Office company) {
		this.company = company;
	}
	
	@NotNull(message="用户不能为空")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@NotNull(message="提现金额不能为空")
	public BigDecimal getApplyAmount() {
		return applyAmount;
	}

	public void setApplyAmount(BigDecimal applyAmount) {
		this.applyAmount = applyAmount;
	}
	
	@NotNull(message="提现费用不能为空")
	public BigDecimal getCashoutFee() {
		return cashoutFee;
	}

	public void setCashoutFee(BigDecimal cashoutFee) {
		this.cashoutFee = cashoutFee;
	}
	
	@Length(min=1, max=255, message="状态长度必须介于 1 和 255 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=0, max=2000, message="描述长度必须介于 0 和 2000 之间")
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getAuditDate() {
		return auditDate;
	}

	public void setAuditDate(Date auditDate) {
		this.auditDate = auditDate;
	}
	
	public User getAudit() {
		return audit;
	}

	public void setAudit(User audit) {
		this.audit = audit;
	}
	
	public String getApplyIp() {
		return applyIp;
	}

	public void setApplyIp(String applyIp) {
		this.applyIp = applyIp;
	}
	
	public BigDecimal getBeginApplyAmount() {
		return beginApplyAmount;
	}

	public void setBeginApplyAmount(BigDecimal beginApplyAmount) {
		this.beginApplyAmount = beginApplyAmount;
	}
	
	public BigDecimal getEndApplyAmount() {
		return endApplyAmount;
	}

	public void setEndApplyAmount(BigDecimal endApplyAmount) {
		this.endApplyAmount = endApplyAmount;
	}
		
	public Date getBeginAuditDate() {
		return beginAuditDate;
	}

	public void setBeginAuditDate(Date beginAuditDate) {
		this.beginAuditDate = beginAuditDate;
	}
	
	public Date getEndAuditDate() {
		return endAuditDate;
	}

	public void setEndAuditDate(Date endAuditDate) {
		this.endAuditDate = endAuditDate;
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
		
}