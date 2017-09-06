/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.account.entity;

import java.math.BigDecimal;
import java.util.Date;

import org.hibernate.validator.constraints.Length;
import javax.validation.constraints.NotNull;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 资金记录Entity
 * @author evan
 * @version 2015-04-04
 */
public class Funddetail extends DataEntity<Funddetail> {
	
	private static final long serialVersionUID = 1L;
	private String userId;		// 用户Id
	private String siteId;		// 站点Id
	private String companyId;		// 合作机构Id
	private String changeType;		// 交易类型  // 对应枚举 userEvent
	private BigDecimal operate;		// 变化数
	private BigDecimal balance;		// 余额
	private BigDecimal frozenAmount;		// 冻结资金
	private String fundDirection;		// 自己流动方向
	private String changeDesc;		// 交易描述
	private String targetType;		// 交易对象类型
	private String target;		// 交易对象
	private Long fundTimestamp;		// 时间戳
	private String remark;		// 备注
	
	private Date beginDate;		// 开始日期
	private Date endDate;		// 结束日期
	
	private String timeRange; //查询的时间范围 1-全部  2-近一周  3-近一月  4-最近三个月 5-最近半年
	
	public Funddetail() {
		super();
	}

	public Funddetail(String id){
		super(id);
	}

	@Length(min=1, max=64, message="用户Id长度必须介于 1 和 64 之间")
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public String getSiteId() {
		return siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}
	
	public String getCompanyId() {
		return companyId;
	}

	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
	
	@Length(min=1, max=255, message="交易类型长度必须介于 1 和 255 之间")
	public String getChangeType() {
		return changeType;
	}

	public void setChangeType(String changeType) {
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

	@Length(min=1, max=255, message="自己流动方向长度必须介于 1 和 255 之间")
	public String getFundDirection() {
		return fundDirection;
	}

	public void setFundDirection(String fundDirection) {
		this.fundDirection = fundDirection;
	}
	
	@Length(min=1, max=255, message="交易描述长度必须介于 1 和 255 之间")
	public String getChangeDesc() {
		return changeDesc;
	}

	public void setChangeDesc(String changeDesc) {
		this.changeDesc = changeDesc;
	}
	
	public String getTargetType() {
		return targetType;
	}

	public void setTargetType(String targetType) {
		this.targetType = targetType;
	}
	
	@Length(min=1, max=255, message="交易对象长度必须介于 1 和 255 之间")
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
	
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Date getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getTimeRange() {
		return timeRange;
	}

	public void setTimeRange(String timeRange) {
		this.timeRange = timeRange;
	}
	
}