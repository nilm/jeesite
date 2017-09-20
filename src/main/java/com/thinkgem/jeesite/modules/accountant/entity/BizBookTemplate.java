/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.accountant.entity;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.thinkgem.jeesite.modules.base.entity.WebUser;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;


/**
 * 发生的业务Entity
 * @author 倪得渊
 * @version 2017-09-10
 */
public class BizBookTemplate extends DataEntity<BizBookTemplate> {
	
	private static final long serialVersionUID = 1L;
	private WebUser user;		// 用户id
	private Office companyId;		// 公司
	private Business biz;		// 业务 父类
	private Book book;		// 账本
	private String direction;		// 方向
	private String fixed;		// 定选否
	private String category;		// 账本类型
	private String selectType;		// 单选 多选
	private String groupTag;		// 组别辨识-- 同一业务不同组标识不一样
	private String status;		// 当前状态
	private String useCount="10";		// 使用次数

	/**
	 * 表单辅助字段
	 */
	@JsonProperty
	private String lrDirection;
	private String bookName;

	public BizBookTemplate() {
		super();
	}

	public BizBookTemplate(String id){
		super(id);
	}

	public BizBookTemplate(Business biz){
		this.biz = biz;
	}

	public WebUser getUser() {
		return user;
	}

	public void setUser(WebUser user) {
		this.user = user;
	}
	
	public Office getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Office companyId) {
		this.companyId = companyId;
	}
	
	@Length(min=0, max=64, message="业务长度必须介于 0 和 64 之间")
	public Business getBiz() {
		return biz;
	}

	public void setBiz(Business biz) {
		this.biz = biz;
	}
	

	@Length(min=0, max=64, message="业务长度必须介于 0 和 64 之间")
	public Book getBook() {
		return book;
	}

	public void setBook(Book book) {
		this.book = book;
	}

	@Length(min=0, max=1, message="方向长度必须介于 0 和 1 之间")
	public String getDirection() {
		return direction;
	}

	public void setDirection(String direction) {
		this.direction = direction;
	}
	
	@Length(min=0, max=1, message="定选否长度必须介于 0 和 1 之间")
	public String getFixed() {
		return fixed;
	}

	public void setFixed(String fixed) {
		this.fixed = fixed;
	}
	
	@Length(min=0, max=16, message="账本类型长度必须介于 0 和 16 之间")
	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}
	
	@Length(min=0, max=125, message="当前状态长度必须介于 0 和 125 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=0, max=64, message="使用次数长度必须介于 0 和 64 之间")
	public String getUseCount() {
		return useCount;
	}

	public void setUseCount(String useCount) {
		this.useCount = useCount;
	}


	public String getLrDirection() {
//		if (this.direction.equals("1") && this.category.equals("left")){
//			return "l1";
//		}else if (this.direction.equals("0") && this.category.equals("left")){
//			return "l0";
//		}else if (this.direction.equals("1") && this.category.equals("right")){
//			return "r1";
//		}else if (this.direction.equals("0") && this.category.equals("right")){
//			return "r0";
//		}
		return this.category+"_"+this.direction;
	}

	public void setLrDirection(String lrDirection) {
		this.lrDirection = lrDirection;
		String lr_direction[] = lrDirection.split("_");
		if(lr_direction.length>0){
			this.category=lr_direction[0];
			this.direction=lr_direction[1];
		}
//		if ("left_0".equals(lrDirection)){
//			this.direction = "0";//注意这里与字典值一致
//			this.category = "left"; //注意这里与字典值一致
//		}else if ("l1".equals(lrDirection)){
//			this.direction = "1";//注意这里与字典值一致
//			this.category = "left"; //注意这里与字典值一致
//		}else if ("r0".equals(lrDirection)){
//			this.direction = "0";//注意这里与字典值一致
//			this.category = "right"; //注意这里与字典值一致
//		}else if ("r1".equals(lrDirection)){
//			this.direction = "1";//注意这里与字典值一致
//			this.category = "right"; //注意这里与字典值一致
//		}

	}

	public String getBookName() {
		return bookName;
	}

	public void setBookName(String bookName) {
		this.bookName = bookName;
	}

	public String getSelectType() {
		return selectType;
	}

	public void setSelectType(String selectType) {
		this.selectType = selectType;
	}

	public String getGroupTag() {
		return groupTag;
	}

	public void setGroupTag(String groupTag) {
		this.groupTag = groupTag;
	}
}