/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.account.entity;

import org.hibernate.validator.constraints.Length;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;

import com.thinkgem.jeesite.modules.base.entity.WebUser;
import com.thinkgem.jeesite.modules.sys.entity.User;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 用户提现申请Entity
 * @author evan
 * @version 2015-04-06
 */
public class Cashout extends DataEntity<Cashout> {
	
	private static final long serialVersionUID = 1L;
	private String siteId;		// 站点
	private String companyId;		// 合作机构
	private WebUser webUser;		// 前台用户
	private BigDecimal applyAmount;		// 提现金额
	private BigDecimal cashoutFee;		// 提现费用
	private String status;		// 状态- 审核中-处理中-提现成功
	private String content;		// 描述
	private Date auditDate;		// 审核时间
	private String cardType;		// 提现到账类型 alipay bank
	private String cardId;		// 支付宝或银行id
	private User user;		// 审核人
	private String applyIp;		// 申请ip
	
	/**
	 *  伪字段 只为查询
	 */
	private String bankName;		// 开户银行
	private String bankBranchName;		// 开户支行
	private String bankNo;		// 银行卡号
	private String alipayNo;		// 银行卡号
	
	
	
	public Cashout() {
		super();
	}

	public Cashout(String id){
		super(id);
	}

	@Length(min=0, max=64, message="站点长度必须介于 0 和 64 之间")
	public String getSiteId() {
		return siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}
	
	@Length(min=0, max=64, message="合作机构长度必须介于 0 和 64 之间")
	public String getCompanyId() {
		return companyId;
	}

	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
	
	public WebUser getWebUser() {
		return webUser;
	}

	public void setWebUser(WebUser webUser) {
		this.webUser = webUser;
	}
	
	public BigDecimal getApplyAmount() {
		return applyAmount;
	}

	public void setApplyAmount(BigDecimal applyAmount) {
		this.applyAmount = applyAmount;
	}
	
	public BigDecimal getCashoutFee() {
		return cashoutFee;
	}

	public void setCashoutFee(BigDecimal cashoutFee) {
		this.cashoutFee = cashoutFee;
	}
	
	@Length(min=1, max=255, message="状态- 审核中-处理中-提现成功长度必须介于 1 和 255 之间")
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
	
	@Length(min=1, max=64, message="提现到账类型 alipay bank长度必须介于 1 和 64 之间")
	public String getCardType() {
		return cardType;
	}

	public void setCardType(String cardType) {
		this.cardType = cardType;
	}
	
	@Length(min=1, max=64, message="支付宝或银行id长度必须介于 1 和 64 之间")
	public String getCardId() {
		return cardId;
	}

	public void setCardId(String cardId) {
		this.cardId = cardId;
	}
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@Length(min=1, max=100, message="申请ip长度必须介于 1 和 100 之间")
	public String getApplyIp() {
		return applyIp;
	}

	public void setApplyIp(String applyIp) {
		this.applyIp = applyIp;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getBankBranchName() {
		return bankBranchName;
	}

	public void setBankBranchName(String bankBranchName) {
		this.bankBranchName = bankBranchName;
	}

	public String getBankNo() {
		return bankNo;
	}

	public void setBankNo(String bankNo) {
		this.bankNo = bankNo;
	}

	public String getAlipayNo() {
		return alipayNo;
	}

	public void setAlipayNo(String alipayNo) {
		this.alipayNo = alipayNo;
	}
	
}