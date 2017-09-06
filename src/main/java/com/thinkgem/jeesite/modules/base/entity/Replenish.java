/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.base.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 充值记录Entity
 * @author binger
 * @version 2016-03-16
 */
public class Replenish extends DataEntity<Replenish> {
	
	private static final long serialVersionUID = 1L;
	private String orderid;		// orderid
	private String replenishfee;		// replenishfee
	private String replenishusefee;		// replenishusefee
	private Date replenishday;		// replenishday
	private String replenishstatus;		// 枚举 ：Replenishstatus
	private String replenishtype;		// replenishtype
	private Date replenishendday;		// replenishendday
	private String userid;		// userid
	
	public Replenish() {
		super();
	}

	public Replenish(String id){
		super(id);
	}

	@Length(min=1, max=255, message="orderid长度必须介于 1 和 255 之间")
	public String getOrderid() {
		return orderid;
	}

	public void setOrderid(String orderid) {
		this.orderid = orderid;
	}
	
	public String getReplenishfee() {
		return replenishfee;
	}

	public void setReplenishfee(String replenishfee) {
		this.replenishfee = replenishfee;
	}
	
	public String getReplenishusefee() {
		return replenishusefee;
	}

	public void setReplenishusefee(String replenishusefee) {
		this.replenishusefee = replenishusefee;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getReplenishday() {
		return replenishday;
	}

	public void setReplenishday(Date replenishday) {
		this.replenishday = replenishday;
	}
	
	@Length(min=0, max=255, message="replenishstatus长度必须介于 0 和 255 之间")
	public String getReplenishstatus() {
		return replenishstatus;
	}

	public void setReplenishstatus(String replenishstatus) {
		this.replenishstatus = replenishstatus;
	}
	
	@Length(min=0, max=255, message="replenishtype长度必须介于 0 和 255 之间")
	public String getReplenishtype() {
		return replenishtype;
	}

	public void setReplenishtype(String replenishtype) {
		this.replenishtype = replenishtype;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getReplenishendday() {
		return replenishendday;
	}

	public void setReplenishendday(Date replenishendday) {
		this.replenishendday = replenishendday;
	}
	
	@Length(min=1, max=255, message="userid长度必须介于 1 和 255 之间")
	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}
	
}