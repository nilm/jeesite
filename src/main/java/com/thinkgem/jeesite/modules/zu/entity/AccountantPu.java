/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zu.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.TreeEntity;

/**
 * 族谱Entity
 * @author 倪得渊
 * @version 2017-10-06
 */
public class AccountantPu extends TreeEntity<AccountantPu> {
	
	private static final long serialVersionUID = 1L;
	private AccountantPu parent;		// 父级主键
	private String parentIds;		// 所有父级主键
	private String name;		// 名称

	public AccountantPu() {
		super();
	}

	public AccountantPu(String id){
		super(id);
	}

	@JsonBackReference
	@NotNull(message="父级主键不能为空")
	public AccountantPu getParent() {
		return parent;
	}

	public void setParent(AccountantPu parent) {
		this.parent = parent;
	}
	
	@Length(min=1, max=2000, message="所有父级主键长度必须介于 1 和 2000 之间")
	public String getParentIds() {
		return parentIds;
	}

	public void setParentIds(String parentIds) {
		this.parentIds = parentIds;
	}
	
	@Length(min=1, max=125, message="名称长度必须介于 1 和 125 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getParentId() {
		return parent != null && parent.getId() != null ? parent.getId() : "0";
	}
}