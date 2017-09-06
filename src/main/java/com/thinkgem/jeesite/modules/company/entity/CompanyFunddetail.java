/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.company.entity;

import com.thinkgem.jeesite.modules.company.enums.BusinessEvent;
import com.thinkgem.jeesite.modules.company.enums.FundIO;
import com.thinkgem.jeesite.modules.company.enums.TargetType;
import com.thinkgem.jeesite.modules.sys.entity.User;
import org.hibernate.validator.constraints.Length;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import javax.validation.constraints.NotNull;

import java.math.BigDecimal;
import java.util.Date;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 商户资金明细Entity
 * @author evan
 * @version 2015-11-13
 */
public class CompanyFunddetail extends DataEntity<CompanyFunddetail> {
	
	private static final long serialVersionUID = 1L;
	private User user;		// 用户
	private String siteId;		// site_id
	private Office company;		// 商户
	private BusinessEvent changeType;		// 交易类型
	private BigDecimal operate;		// 变化数
	private BigDecimal balance;		// 余额
	private BigDecimal frozenAmount;		// 冻结资金
	private FundIO fundDirection;		// 资金流动方向
	private String changeDesc;		// 交易描述
	private TargetType targetType;		// 交易对象类型
	/**
	 * -- targetType 为 portal时， 此为Portal.getText() 即平台--- 记录商户的资金记录
	 *    targetType 为 Company时， 此为 商户的Id--- 可能是 商户给予用户的奖励之类
	 */
	private String target;		// 交易对象  
	private Long fundTimestamp;		// 时间戳
	private String remark;		// 备注
	private Date beginCreateDate;		// 开始 交易时间
	private Date endCreateDate;		// 结束 交易时间
	
	public CompanyFunddetail() {
		super();
	}

	public CompanyFunddetail(String id){
		super(id);
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	public String getSiteId() {
		return siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}
	
	@NotNull(message="商户不能为空")
	public Office getCompany() {
		return company;
	}

	public void setCompany(Office company) {
		this.company = company;
	}
	
	@Length(min=1, max=255, message="交易类型长度必须介于 1 和 255 之间")
	public BusinessEvent getChangeType() {
		return changeType;
	}

	public void setChangeType(BusinessEvent changeType) {
		this.changeType = changeType;
	}
	
	public BigDecimal getOperate() {
		return operate;
	}

	public void setOperate(BigDecimal operate) {
		this.operate = operate;
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
	
	@Length(min=1, max=255, message="资金流动方向长度必须介于 1 和 255 之间")
	public FundIO getFundDirection() {
		return fundDirection;
	}

	public void setFundDirection(FundIO fundDirection) {
		this.fundDirection = fundDirection;
	}
	
	@Length(min=1, max=255, message="交易描述长度必须介于 1 和 255 之间")
	public String getChangeDesc() {
		return changeDesc;
	}

	public void setChangeDesc(String changeDesc) {
		this.changeDesc = changeDesc;
	}
	
	@Length(min=1, max=120, message="交易对象类型长度必须介于 1 和 120 之间")
	public TargetType getTargetType() {
		return targetType;
	}

	public void setTargetType(TargetType targetType) {
		this.targetType = targetType;
	}
	
	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}
	
	@NotNull(message="时间戳不能为空")
	public Long getFundTimestamp() {
		return fundTimestamp;
	}

	public void setFundTimestamp(Long fundTimestamp) {
		this.fundTimestamp = fundTimestamp;
	}
	
	@Length(min=0, max=255, message="备注长度必须介于 0 和 255 之间")
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
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
		
}