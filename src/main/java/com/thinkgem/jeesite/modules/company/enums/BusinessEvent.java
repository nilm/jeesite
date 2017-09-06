package com.thinkgem.jeesite.modules.company.enums;

public enum BusinessEvent {
	
	settle("结算","结算"),referreAward("推荐奖励","推荐奖励"),
	cashoutApply("提现申请","提现申请"),cashoutSuccess("提现成功","提现成功"),cashoutFail("提现失败","提现失败"),
	pointExchangeCash("积分兑换现金","积分兑换现金"),other("其他","其他");
	
	private String text;
	private String comment;

	private BusinessEvent(String text,String comment) {
		this.text = text;
		this.comment = comment;
	}

	public static BusinessEvent get(int id) {
		for (BusinessEvent g : values()) {
			if (g.ordinal() == id) {
				return g;
			}
		}
		return BusinessEvent.other;
	}

	public String getText(){
		return text;
	}

	public String getComment() {
		return comment;
	}

}
