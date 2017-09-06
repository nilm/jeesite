/**
 * 
 */
package com.thinkgem.jeesite.modules.account.enums;

/**
 * @author J.L evan 2015年4月5日
 *
 */
public enum FundIO {
	
	IN("+",1),OUT("-",-1),KEEP("",0);
	private String text;
	private int dir;
	private FundIO(String text, int dir) {
		this.text = text;
		this.dir = dir;
	}

	public String getText() {
		return text;
	}

	public int getDir() {
		return dir;
	}
	
}
