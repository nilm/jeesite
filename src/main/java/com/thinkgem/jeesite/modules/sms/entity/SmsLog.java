/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sms.entity;

import org.hibernate.validator.constraints.Length;
import com.thinkgem.jeesite.modules.sys.entity.User;
import javax.validation.constraints.NotNull;
import java.util.Date;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 短信记录Entity
 * @author evan
 * @version 2015-11-13
 */
public class SmsLog extends DataEntity<SmsLog> {
	
	private static final long serialVersionUID = 1L;
	private String siteId;		// 站点
	private String companyId;		// 商户
	private User user;		// 用户
	private String mobile;		// 手机号码
	private String status;		// 发送状态
	private String content;		// 信息内容
	private String userType;		// 用户类型（前后台）
	private String applyIp;		// 申请ip
	private String result;		// 发送结果
	private Date beginCreateDate;		// 开始 发送时间
	private Date endCreateDate;		// 结束 发送时间
	
	public SmsLog() {
		super();
	}

	public SmsLog(String id){
		super(id);
	}

	@Length(min=0, max=64, message="站点长度必须介于 0 和 64 之间")
	public String getSiteId() {
		return siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}
	
	@Length(min=0, max=64, message="商户长度必须介于 0 和 64 之间")
	public String getCompanyId() {
		return companyId;
	}

	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
	
	@NotNull(message="用户不能为空")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@Length(min=1, max=12, message="手机号码长度必须介于 1 和 12 之间")
	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	
	@Length(min=1, max=25, message="发送状态长度必须介于 1 和 25 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=1, max=2000, message="信息内容长度必须介于 1 和 2000 之间")
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	@Length(min=0, max=64, message="用户类型（前后台）长度必须介于 0 和 64 之间")
	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}
	
	@Length(min=0, max=100, message="申请ip长度必须介于 0 和 100 之间")
	public String getApplyIp() {
		return applyIp;
	}

	public void setApplyIp(String applyIp) {
		this.applyIp = applyIp;
	}
	
	@Length(min=1, max=64, message="发送结果长度必须介于 1 和 64 之间")
	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
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