package com.thinkgem.jeesite.modules.company.enums;

public enum TargetType{
	
	Portal("平台"),WebUser("用户"),StaffUser("后台用户"),Company("合作机构");
	
	private String text;   
 
	private TargetType(String text) {
		this.text = text;
	}

	public String getText() {
		return text;
	}
	
}
