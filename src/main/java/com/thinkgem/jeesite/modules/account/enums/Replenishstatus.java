package com.thinkgem.jeesite.modules.account.enums;

public enum Replenishstatus {
	success("充值成功"),fail("充值失败"),waiting("充值中");

	private String text;


	private Replenishstatus(String text) {
		this.text = text;
	}

	public static Replenishstatus get(int id) {
		for (Replenishstatus g : values()) {
			if (g.ordinal() == id) {
				return g;
			}
		}
		return Replenishstatus.fail;
	}

	public String getText() {
		return text;
	}
}
