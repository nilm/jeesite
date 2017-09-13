/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.accountant.entity;

import com.thinkgem.jeesite.modules.base.entity.WebUser;
import org.hibernate.validator.constraints.Length;
import java.util.List;
import com.google.common.collect.Lists;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 发生的业务Entity
 * @author 倪得渊
 * @version 2017-09-10
 */
public class Business extends DataEntity<Business> {
	
	private static final long serialVersionUID = 1L;
	private WebUser user;		// 用户id
	private String companyId;		// 公司id
	private String name;		// 业务名称
	private String sort;		// 排序
	private String showHide;		// 显示否
	private List<BizBookTemplate> bizBookTemplateList = Lists.newArrayList();		// 子表列表
	
	public Business() {
		super();
	}

	public Business(String id){
		super(id);
	}

	public WebUser getUser() {
		return user;
	}

	public void setUser(WebUser user) {
		this.user = user;
	}
	
	@Length(min=0, max=64, message="公司id长度必须介于 0 和 64 之间")
	public String getCompanyId() {
		return companyId;
	}

	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
	
	@Length(min=1, max=125, message="业务名称长度必须介于 1 和 125 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}
	
	@Length(min=1, max=1, message="显示否长度必须介于 1 和 1 之间")
	public String getShowHide() {
		return showHide;
	}

	public void setShowHide(String showHide) {
		this.showHide = showHide;
	}
	
	public List<BizBookTemplate> getBizBookTemplateList() {
		return bizBookTemplateList;
	}

	public void setBizBookTemplateList(List<BizBookTemplate> bizBookTemplateList) {
		this.bizBookTemplateList = bizBookTemplateList;
	}
}