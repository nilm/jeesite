package com.thinkgem.jeesite.modules.views.user.enums;

/**
 * 用户活动事件类型
 * @author evan
 * @version 2015-04-04
 */
public enum UserMenus {
	
	home("账户首页"),baseInfo("基本信息"),account("我的账户"),point("我的积分"),friend("邀请好友");
	
	private String text;

	private UserMenus(String text) {
		this.text = text;
	}

	public static UserMenus get(int id) {
		for (UserMenus g : values()) {
			if (g.ordinal() == id) {
				return g;
			}
		}
		return UserMenus.home;
	}

	public String getText(){
		return text;
	}
}
