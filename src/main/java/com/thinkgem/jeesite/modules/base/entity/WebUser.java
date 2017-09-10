/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.base.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.validator.constraints.Length;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.StringUtils;

/**
 * 前台基本类Entity
 * @author evan
 * @version 2015-03-21
 */
public class WebUser extends DataEntity<WebUser> {
	
	private static final long serialVersionUID = 1L;
	private String userName;		// 用户名
	private String password;		// 密码
	private String realName;		// 姓名
	private String email;		// 邮箱
	private String emailValidated;		// 邮箱已验证
	private String mobile;		// 手机
	private String mobileValidated;		// 手机已验证
	private String userType;		// 用户类型
	private String idCard;		// 头像
	private String photo;		// 头像
	private String sex;		// 性别
	private Date birthday;		// 生日
	
	private String province;		// 省份
	private String city;		// 地级市
	private String region;		// 市、县级市
	private String address;		// 具体地址
	
	private String createIp;		// 创建账户的ip
	private String loginIp;		// 最后登录ip
	private Date loginDate;		// 最后登录时间
	private String loginFlag=Global.NO;		// 登录限制
	private String referrer;		// 推荐人
	private BigDecimal balance;		// 账户余额 
	private BigDecimal frozenAmount;		// 冻结资金
	private int points=0;		// 积分
	private int visitCount;		// 登录次数
	private String qq;		// qq
	private String salt;		// 校验码
	private String inviteCode;		// 校验码
	private String passwdQuestion;		// 密保问题
	private String passwdAnswer;		// 密保答案
	@JsonIgnore
	private String newPassword;	// 新密码
	private String validateCode;  
	private String wxOpenId;// 微信openId  
	
	
	private BigDecimal awardMoney;  //推荐好友奖励的资金
	private BigDecimal sumAwardMoney;  //推荐好友奖励的资金总计
	
	public WebUser() {
		super();
	}

	public WebUser(String id){
		super(id);
	}

	@Length(min=0, max=100, message="用户名长度必须介于 0 和 100 之间")
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	@Length(min=6, max=20, message="密码长度必须介于6 和 20 之间")
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	@Length(min=0, max=36, message="姓名长度必须介于 0 和 36 之间")
	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}
	
	@Length(min=0, max=56, message="邮箱长度必须介于 0 和 56 之间")
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	@Length(min=0, max=2, message="邮箱已验证长度必须介于 0 和 2 之间")
	public String getEmailValidated() {
		return emailValidated;
	}

	public void setEmailValidated(String emailValidated) {
		this.emailValidated = emailValidated;
	}
	
	@Length(min=1, max=11, message="手机长度必须介于 1 和 11 之间")
	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	
	@Length(min=1, max=2, message="手机已验证长度必须介于 1 和 2 之间")
	public String getMobileValidated() {
		return mobileValidated;
	}

	public void setMobileValidated(String mobileValidated) {
		this.mobileValidated = mobileValidated;
	}
	
	@Length(min=1, max=2, message="用户类型长度必须介于 1 和 2 之间")
	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}
	
	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}
	
	@Length(min=0, max=10, message="性别长度必须介于 0 和 10 之间")
	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	
	@Length(min=0, max=100, message="最后登录ip长度必须介于 0 和 100 之间")
	public String getLoginIp() {
		return loginIp;
	}

	public void setLoginIp(String loginIp) {
		this.loginIp = loginIp;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getLoginDate() {
		return loginDate;
	}

	public void setLoginDate(Date loginDate) {
		this.loginDate = loginDate;
	}
	
	@Length(min=0, max=64, message="登录限制长度必须介于 0 和 64 之间")
	public String getLoginFlag() {
		return loginFlag;
	}

	public void setLoginFlag(String loginFlag) {
		this.loginFlag = loginFlag;
	}
	
	@Length(min=0, max=64, message="推荐人长度必须介于 0 和 64 之间")
	public String getReferrer() {
		return referrer;
	}

	public void setReferrer(String referrer) {
		this.referrer = referrer;
	}
	
	public int getPoints() {
		return points;
	}

	public void setPoints(int points) {
		this.points = points;
	}
	
	public int getVisitCount() {
		return visitCount;
	}

	public void setVisitCount(int visitCount) {
		this.visitCount = visitCount;
	}
	
	@Length(min=0, max=20, message="qq长度必须介于 0 和 20 之间")
	public String getQq() {
		return qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}
	
	@Length(min=0, max=128, message="校验码长度必须介于 0 和 128 之间")
	public String getSalt() {
		return salt;
	}

	public void setSalt(String salt) {
		this.salt = salt;
	}
	
	public String getInviteCode() {
		return inviteCode;
	}

	public void setInviteCode(String inviteCode) {
		this.inviteCode = inviteCode;
	}

	@Length(min=0, max=128, message="密保问题长度必须介于 0 和 128 之间")
	public String getPasswdQuestion() {
		return passwdQuestion;
	}

	public void setPasswdQuestion(String passwdQuestion) {
		this.passwdQuestion = passwdQuestion;
	}
	
	@Length(min=0, max=255, message="密保答案长度必须介于 0 和 255 之间")
	public String getPasswdAnswer() {
		return passwdAnswer;
	}

	public void setPasswdAnswer(String passwdAnswer) {
		this.passwdAnswer = passwdAnswer;
	}

	public String getNewPassword() {
		return newPassword;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}
	/**
	 * 检查两次输入的密码是否一致
	 * @return
	 */
	@JsonIgnore
	public boolean isNewPasswdOk(){
		return this.password.equals(this.newPassword);
	}

	public String getValidateCode() {
		return validateCode;
	}

	public void setValidateCode(String validateCode) {
		this.validateCode = validateCode;
	}

	public BigDecimal getBalance() {
		return balance;
	}

	public void setBalance(BigDecimal balance) {
		this.balance = balance;
	}

	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	public String getCreateIp() {
		return createIp;
	}

	public void setCreateIp(String createIp) {
		this.createIp = createIp;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public BigDecimal getFrozenAmount() {
		return frozenAmount;
	}

	public void setFrozenAmount(BigDecimal frozenAmount) {
		this.frozenAmount = frozenAmount;
	}
	
	public boolean isAllUserInfo(){
		return 
				(StringUtils.isEmpty(this.userName) 
				|| StringUtils.isEmpty(this.email) 
				|| StringUtils.isEmpty(this.idCard) 
				|| StringUtils.isEmpty(this.realName) 
				|| StringUtils.isEmpty(this.province) 
				|| StringUtils.isEmpty(this.city) 
				|| StringUtils.isEmpty(this.region) 
				|| StringUtils.isEmpty(this.address) 
				|| StringUtils.isEmpty(this.sex)) == false ;
	}

	public BigDecimal getAwardMoney() {
		return awardMoney;
	}

	public void setAwardMoney(BigDecimal awardMoney) {
		this.awardMoney = awardMoney;
	}

	public BigDecimal getSumAwardMoney() {
		return sumAwardMoney;
	}

	public void setSumAwardMoney(BigDecimal sumAwardMoney) {
		this.sumAwardMoney = sumAwardMoney;
	}
	public String getWxOpenId() {
		return wxOpenId;
	}

	public void setWxOpenId(String wxOpenId) {
		this.wxOpenId = wxOpenId;
	}
}