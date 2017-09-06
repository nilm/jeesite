/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.portal.entity;

import java.math.BigDecimal;
import java.util.Date;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.company.enums.BusinessEvent;
import com.thinkgem.jeesite.modules.company.enums.FundIO;
import com.thinkgem.jeesite.modules.company.enums.TargetType;

/**
 * 平台资金流动Entity
 * @author evan
 * @version 2015-11-21
 */
public class PortalFunddetail extends DataEntity<PortalFunddetail> {
	
	private static final long serialVersionUID = 1L;
	private BusinessEvent changeType;		// 资金类型
	private BigDecimal operate;		// 操作资金
	private FundIO direction;		// 资金流动方向
	private TargetType target;		// 资金对象
	private String targetId;		// 对象主键-- 商户或用户id
	private String businessClass;		// 资金业务对象 业务对象的 ClassName
	private String businessId;		// 对象业务主键 
	private String descContent;		// 资金描述


	private Date beginCreateDate;		// 开始 创建时间
	private Date endCreateDate;		// 结束 创建时间
	
	public PortalFunddetail() {
		super();
	}

	public PortalFunddetail(String id){
		super(id);
	}

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
	
	public FundIO getDirection() {
		return direction;
	}

	public void setDirection(FundIO direction) {
		this.direction = direction;
	}
	
	public TargetType getTarget() {
		return target;
	}

	public void setTarget(TargetType target) {
		this.target = target;
	}
	
	@Length(min=0, max=255, message="对象主键长度必须介于 0 和 255 之间")
	public String getTargetId() {
		return targetId;
	}

	public void setTargetId(String targetId) {
		this.targetId = targetId;
	}
	
	@Length(min=0, max=255, message="资金描述长度必须介于 0 和 255 之间")
	public String getDescContent() {
		return descContent;
	}

	public void setDescContent(String descContent) {
		this.descContent = descContent;
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

	public String getBusinessClass() {
		return businessClass;
	}

	public void setBusinessClass(String businessClass) {
		this.businessClass = businessClass;
	}
	public String getBusinessId() {
		return businessId;
	}

	public void setBusinessId(String businessId) {
		this.businessId = businessId;
	}	
}