/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.account.entity;

import org.hibernate.validator.constraints.Length;
import javax.validation.constraints.NotNull;
import java.util.Date;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 用户积分Entity
 * @author evan
 * @version 2015-04-05
 */
public class PointDetail extends DataEntity<PointDetail> {
	
	private static final long serialVersionUID = 1L;
	private String userId;		// web用户
	private String siteId;		// 站点
	private String companyId;		// 合作机构
	private String changeType;		// 积分交易类型 @see UserEvent
	private int operate;		// 变化数
	private int balance;		// 积分余额
	private String fundDirection;		// 积分流动方向
	private String changeDesc;		// 积分交易描述
	private String targetType;		// 积分交易对象类型
	private String target;		// 积分交易对象
	private Long fundTimestamp;		// 时间戳
	private String remark;		// 备注
	
	private Date beginDate;		// 开始日期
	private Date endDate;		// 结束日期
	
	private String timeRange; //查询的时间范围 1-全部  2-近一周  3-近一月  4-最近三个月 5-最近半年
	
	private int sumPoints = 0;		// 总积分
	
	public PointDetail() {
		super();
	}

	public PointDetail(String id){
		super(id);
	}

	@Length(min=1, max=64, message="web用户长度必须介于 1 和 64 之间")
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
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
	
	@Length(min=1, max=255, message="积分交易类型长度必须介于 1 和 255 之间")
	public String getChangeType() {
		return changeType;
	}

	public void setChangeType(String changeType) {
		this.changeType = changeType;
	}
	
	public int getOperate() {
		return operate;
	}

	public void setOperate(int operate) {
		this.operate = operate;
	}
	
	public int getBalance() {
		return balance;
	}

	public void setBalance(int balance) {
		this.balance = balance;
	}
	
	@Length(min=1, max=255, message="积分流动方向长度必须介于 1 和 255 之间")
	public String getFundDirection() {
		return fundDirection;
	}

	public void setFundDirection(String fundDirection) {
		this.fundDirection = fundDirection;
	}
	
	@Length(min=1, max=255, message="积分交易描述长度必须介于 1 和 255 之间")
	public String getChangeDesc() {
		return changeDesc;
	}

	public void setChangeDesc(String changeDesc) {
		this.changeDesc = changeDesc;
	}
	
	@Length(min=1, max=120, message="积分交易对象类型长度必须介于 1 和 120 之间")
	public String getTargetType() {
		return targetType;
	}

	public void setTargetType(String targetType) {
		this.targetType = targetType;
	}
	
	@Length(min=1, max=255, message="积分交易对象长度必须介于 1 和 255 之间")
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

	public int getSumPoints() {
		return sumPoints;
	}

	public void setSumPoints(int sumPoints) {
		this.sumPoints = sumPoints;
	}
		
}