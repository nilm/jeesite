package com.thinkgem.jeesite.modules.accountant.dto;

public class BookDto {

	private String id;
	
	private String name;

	private String sumAmount;

	private String beginningAmount;//科目期初金额

	public String getBeginningAmount() {
		return beginningAmount;
	}

	public void setBeginningAmount(String beginningAmount) {
		this.beginningAmount = beginningAmount;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSumAmount() {
		return sumAmount;
	}

	public void setSumAmount(String sumAmount) {
		this.sumAmount = sumAmount;
	}
}
