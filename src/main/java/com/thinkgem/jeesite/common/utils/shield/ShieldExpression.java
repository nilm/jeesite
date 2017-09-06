package com.thinkgem.jeesite.common.utils.shield;

import java.util.ArrayList;
import java.util.List;

/**
 * 屏蔽表达式
 * @author 俞建波
 *
 */
public class ShieldExpression {
	
	/**原始字符串*/
	private String originalString;
	/**屏蔽单元*/
	private List<ShieldUnit> shieldUnits = new ArrayList<ShieldUnit>();
	
	/**
	 * 
	 * @return 原始字符串
	 */
	public String getOriginalString() {
		return originalString;
	}

	public void setOriginalString(String originalString) {
		this.originalString = originalString;
		analysis();
	}

	public List<ShieldUnit> getShieldUnits() {
		return shieldUnits;
	}

	public ShieldExpression() {
		super();
	}

	public ShieldExpression(String originalString) {
		super();
		setOriginalString(originalString);
	}

	private void analysis() {
		if(originalString==null|| originalString.isEmpty()){
			return;
		}
		String[] strList = analysis(originalString);
		for (String str : strList) {
			this.shieldUnits.add(strToUnit(str));
		}
	}

	enum CharType {
		SHARP, ASTERISK, DIVISION, PERCENT, DIGIT, LEFT_BRACKET, RIGHT_BRACKET, LEFT_SQUARE_BRACKET, RIGHT_SQUARE_BRACKET, OR
	}

	private static ShieldUnit strToUnit(String str) {

		char[] chars = str.toCharArray();
		if (chars[0] == '*') {
			return getMask(str.substring(1));
		}
		if (chars[chars.length - 1] == '%') {
			String num = str.substring(0, chars.length - 1);
			return new ShieldUnit(false, Double.parseDouble(num)/100, 0);
		}
		return new ShieldUnit(false, Double.parseDouble(str), 0);
	}

	private static ShieldUnit getMask(String str) {
		double length = -1;
		int maskLength = 0;
		char[] chars = str.toCharArray();
		boolean brbegin = false;
		boolean sbrbegin = false;
		StringBuilder numBuf = new StringBuilder();
		for (int i = 0; i < chars.length; i++) {
			char c = chars[i];
			if (c == '(') {
				brbegin = true;
				continue;
			}

			if (c == '[') {
				sbrbegin = true;
				continue;
			}
			if (c == ')') {
				length = Double.parseDouble(numBuf.toString());
				numBuf = new StringBuilder();
				brbegin = false;
				continue;
			}

			if (c == ']') {
				maskLength = Integer.parseInt(numBuf.toString());
				numBuf = new StringBuilder();
				sbrbegin = false;
				continue;
			}
			if (brbegin) {
				numBuf.append(chars[i]);
				continue;
			}
			if (sbrbegin) {
				numBuf.append(chars[i]);
			}
		}
		return new ShieldUnit(true, length, maskLength);
	}

	private static String[] analysis(String expr) {

		return expr.split("\\|");
	}

	public static void main(String[] args) {
	}
}
