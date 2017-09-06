package com.thinkgem.jeesite.modules.account.enums;

public enum UserEvent {
	
	register("注册","注册"),referreAward("推荐奖励","推荐奖励"),
	cashoutApply("提现申请","提现申请"),cashoutSuccess("提现成功","提现成功"),cashoutFail("提现失败","提现失败"),
	pointExchangeCash("积分兑换现金","积分兑换现金"),other("其他","其他"),
	replenish("充值","成功");
	
	private String text;
	private String comment;

	private UserEvent(String text,String comment) {
		this.text = text;
		this.comment = comment;
	}

	public static UserEvent get(int id) {
		for (UserEvent g : values()) {
			if (g.ordinal() == id) {
				return g;
			}
		}
		return UserEvent.other;
	}

	public String getText(){
		return text;
	}

	public String getComment() {
		return comment;
	}

}
