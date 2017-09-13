/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.accountant.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import org.hibernate.validator.constraints.Length;
import javax.validation.constraints.NotNull;
import com.thinkgem.jeesite.modules.base.entity.WebUser;

import com.thinkgem.jeesite.common.persistence.TreeEntity;

/**
 * 会计国标账本(科目)Entity
 * @author nideyuan
 * @version 2017-09-10
 */
public class Book extends TreeEntity<Book> {
	
	private static final long serialVersionUID = 1L;
	private Book parent;		// 父级主键
	private String parentIds;		// 所有父级主键
	private String code;		// 科目编码
	private Integer sort;		// 排序
	private WebUser user;		// 用户id
	private String companyId;		// 商户id
	private String name;		// 账本名称
	private String assistCode;		// 辅助码
	private String category;		// 账本方向
	private String accountantCategory;		// 账本性质
	private String property;		// 账本属性
	private String assetsCategory;		// 资产负债表分类
	private String profitsCategory;		// 利润表分类
	private String version;		// 会计科目版本（标准）
	private String type;		// 账本类型
	private String status;		// 当前状态
	
	public Book() {
		super();
	}

	public Book(String id){
		super(id);
	}

	@JsonBackReference
	public Book getParent() {
		return parent;
	}

	public void setParent(Book parent) {
		this.parent = parent;
	}
	
	@Length(min=0, max=2000, message="所有父级主键长度必须介于 0 和 2000 之间")
	public String getParentIds() {
		return parentIds;
	}

	public void setParentIds(String parentIds) {
		this.parentIds = parentIds;
	}
	
	@Length(min=1, max=20, message="科目编码长度必须介于 1 和 20 之间")
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
	@NotNull(message="排序不能为空")
	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}
	
	public WebUser getUser() {
		return user;
	}

	public void setUser(WebUser user) {
		this.user = user;
	}
	
	@Length(min=0, max=64, message="商户id长度必须介于 0 和 64 之间")
	public String getCompanyId() {
		return companyId;
	}

	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
	
	@Length(min=1, max=125, message="账本名称长度必须介于 1 和 125 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=128, message="辅助码长度必须介于 0 和 128 之间")
	public String getAssistCode() {
		return assistCode;
	}

	public void setAssistCode(String assistCode) {
		this.assistCode = assistCode;
	}
	
	@Length(min=1, max=125, message="账本方向长度必须介于 1 和 125 之间")
	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}
	
	@Length(min=1, max=125, message="账本性质长度必须介于 1 和 125 之间")
	public String getAccountantCategory() {
		return accountantCategory;
	}

	public void setAccountantCategory(String accountantCategory) {
		this.accountantCategory = accountantCategory;
	}
	
	@Length(min=1, max=125, message="账本属性长度必须介于 1 和 125 之间")
	public String getProperty() {
		return property;
	}

	public void setProperty(String property) {
		this.property = property;
	}
	
	@Length(min=0, max=125, message="资产负债表分类长度必须介于 0 和 125 之间")
	public String getAssetsCategory() {
		return assetsCategory;
	}

	public void setAssetsCategory(String assetsCategory) {
		this.assetsCategory = assetsCategory;
	}
	
	@Length(min=0, max=125, message="利润表分类长度必须介于 0 和 125 之间")
	public String getProfitsCategory() {
		return profitsCategory;
	}

	public void setProfitsCategory(String profitsCategory) {
		this.profitsCategory = profitsCategory;
	}
	
	@Length(min=0, max=125, message="会计科目版本（标准）长度必须介于 0 和 125 之间")
	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}
	
	@Length(min=0, max=125, message="账本类型长度必须介于 0 和 125 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	@Length(min=0, max=125, message="当前状态长度必须介于 0 和 125 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getParentId() {
		return parent != null && parent.getId() != null ? parent.getId() : "0";
	}
}