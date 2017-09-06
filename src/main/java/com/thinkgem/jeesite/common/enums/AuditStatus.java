/**
 * 
 */
package com.thinkgem.jeesite.common.enums;

/**
 * @author  evan 2015年4月8日
 *
 */
public enum AuditStatus {
	
	audit("审核中"),doing("处理中"),success("成功"),fail("失败");
	private String text;
	private AuditStatus(String text) {
		this.text = text;
	}

	public String getText() {
		return text;
	}

	
}
