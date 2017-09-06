package com.thinkgem.jeesite.common.utils.shield;

import java.util.Arrays;
import java.util.List;

import org.springframework.util.StringUtils;

/**
 * 屏蔽字符工具
 * 
 * @author 俞建波
 * 
 * 邮箱 屏蔽
 * 手机号中间屏蔽 
 * 
 */
public class ShieldUtil {
    public static enum MetaType {
	NUMBER, SHILED
    };

    public static class ShieldExpr {

    }

    static String str = "ABCD";
    // 造出3个shield unit
    static ShieldUnit unit1 = new ShieldUnit(false, (double) 1 / 4);
    static ShieldUnit unit2 = new ShieldUnit(true, -1, 8);
    static ShieldUnit unit3 = new ShieldUnit(false, 1);
    static List<ShieldUnit> unitList = Arrays.asList(unit1, unit2, unit3);

    public static final String sheild(String expr, final String str) {
	if (!StringUtils.hasLength(expr) || !StringUtils.hasLength(str)) {
	    return str;
	}
	if (expr.contains("@")) {
	    try {
		return sheild(new EmailShieldExpression(expr), str);
	    } catch (ShieldException e) {
		return str;
	    }
	}
	return sheild(new ShieldExpression(expr), str);
    }

    private static final String sheild(EmailShieldExpression expr,
	    final String str) {
	String[] data = str.split("@");
	StringBuilder sb = new StringBuilder();
	sb.append(sheild(expr.getFirstExpression(), data[0]));
	sb.append("@");
	sb.append(sheild(expr.getSecondExpression(), data[1]));
	return sb.toString();
    }

    private static final String sheild(ShieldExpression expr, final String str) {
	return sheild(expr.getShieldUnits(), str);
    }

    private static final String sheild(List<ShieldUnit> expr, final String str) {
	if (expr == null || expr.isEmpty()) {
	    return str;
	}
	char[] chars = str.toCharArray();
	int strLength = chars.length;
	// 首先将长度为-1的正确长度计算出来
	int masklength = 0;
	int exprLength = 0;
	for (ShieldUnit shieldUnit : expr) {
	    double d = shieldUnit.getLength();
	    if (d < 0) {

	    } else if (d == (int) d) {
		exprLength += d;
	    } else {
		exprLength += d * strLength;
	    }
	}

	masklength = strLength - exprLength;
	StringBuilder sb = new StringBuilder();
	int point = 0;
	for (ShieldUnit shieldUnit : expr) {
	    int unitLength = 0;
	    double d = shieldUnit.getLength();
	    if (d < 0) {
		unitLength = masklength;
	    } else if (d == (int) d) {
		unitLength = (int) d;
	    } else {
		unitLength = (int) (d * strLength);
	    }
	    if (shieldUnit.getMask()) {
		// 屏蔽
		if (shieldUnit.getMaskLength() == 0) {
		    sb.append(repeatChars('*', unitLength));
		} else {
		    sb.append(repeatChars('*', shieldUnit.getMaskLength()));
		}
		point += unitLength;
	    } else {
		// 不屏蔽
		for (int i = 0; i < unitLength; i++) {
		    sb.append(chars[point++]);
		}
	    }
	}

	return sb.toString();
    }

    private static final String repeatChars(char c, int count) {
	StringBuilder sb = new StringBuilder();
	for (int i = 0; i < count; i++) {
	    sb.append(c);
	}
	return sb.toString();
    }

    public static void main(String[] args) {
		
	}
}
