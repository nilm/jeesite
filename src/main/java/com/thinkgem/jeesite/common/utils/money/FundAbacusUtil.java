/**
 * 
 */
package com.thinkgem.jeesite.common.utils.money;

import java.math.BigDecimal;

import com.thinkgem.jeesite.common.utils.StringUtils;


/**
 * 金钱的运算工具
 * 
 * @author J.L evan
 *
 */
public class FundAbacusUtil {
	
	
	public static final int DEFAULT_SCALE=30;//运算保留位数
	public static final int RESULT_SCALE=2;//结果保留位数
	
	/**
	 *   用于 天 单位 和月单位的转换 基准
	 */
	public static final int  DAYS_MONTH=30;
	
	public static Bead createZero(){
		return new Bead(BigDecimal.ZERO);
	}

	public static Bead turnToBead(BigDecimal bigDecimal){
		if(bigDecimal==null)bigDecimal=BigDecimal.ZERO;
		return new Bead(bigDecimal);
	}
	
	public static Bead turnToBead(String str){
		if(StringUtils.isEmpty(str))return turnToBead(BigDecimal.ZERO);
		return turnToBead(new BigDecimal(str));
	}
	
	public static Bead halfToHalf(BigDecimal bigDecimal){
		return turnToBead(divide(bigDecimal,2));
	}

	public static boolean greaterThanO(Bead bead){
		if(bead!=null){
			return bead.compareToZero()>0;
		}
		return false;
	}
	
	public static boolean lessThanO(BigDecimal decimal) {
		if(decimal!=null){
			return compareToZERO(decimal)<0;
		}
		return false;
	}
	
	
	public static boolean greaterThanO(BigDecimal bigDecimal){
		if(bigDecimal!=null){
			return compareToZERO(bigDecimal)>0;
		}
		return false;
	}
	

	


	public static BigDecimal min(BigDecimal b1,BigDecimal b2){
		return b1.min(b2);
	}
	
	public static BigDecimal max(BigDecimal b1,BigDecimal b2){
		return b1.max(b2);
	}
	

	/**
	 * 获得月利率lijie
	 * @param rate
	 * @return
	 */
	public static BigDecimal getMonthlyRate(BigDecimal rate){
		return divide(parsePercent(rate), 12);
	}
	
	
	/**
	 * 解析百分比
	 * @param rate
	 * @return
	 */
	public static BigDecimal parsePercent(BigDecimal rate){
		return divide(rate,100);
	}
	
	/**
	 * 格式化至两位
	 * @param b
	 * @return
	 */
	public static BigDecimal format(BigDecimal b){
		return divide(b,BigDecimal.ONE,RESULT_SCALE);
	}
	
	/**
	 * 格式化至两位
	 * @param b
	 * @return
	 */
	public static String formatString(BigDecimal b){
		
		if(b==null){
			return "0.00";
		}
		
		if(b.compareTo(BigDecimal.ZERO)==0){
			return "0.00";
		}
		
		return divide(b,BigDecimal.ONE,RESULT_SCALE).toString();
	}

	/**
	 * 加法运算
	 * @param p1
	 * @param p2
	 * @return p1+p2
	 */
	public static BigDecimal add(BigDecimal p1,BigDecimal p2){
		
		return p1.add(p2);
	}
	public static BigDecimal add(BigDecimal p1,double p2){
		
		return add(p1,new BigDecimal(p2));
	}
	
	
	public static BigDecimal add(BigDecimal p1,String p2){
		
		return add(p1,new BigDecimal(p2));
	}
	/**
	 * 减法运算
	 * @param p1
	 * @param p2
	 * @return p1-p2
	 */
	public static BigDecimal subtract(BigDecimal p1,BigDecimal p2){
		
		return p1.subtract(p2);
	}
	public static BigDecimal subtract(BigDecimal p1,int p2){
		return p1.subtract(new BigDecimal(p2));
	}
	public static BigDecimal subtract(BigDecimal p1,String p2){
		
		return subtract(p1, new BigDecimal(p2));
	}
	public static Bead subtract(BigDecimal p1,Bead p2){
		
		return turnToBead(subtract(p1, p2.getValue()));
	}
	


	/**
	 * 两数相乘
	 * @param p1
	 * @param p2
	 * @return p1*p2
	 */
	public static BigDecimal multiply(BigDecimal p1,BigDecimal p2){
		return p1.multiply(p2);
	}
	public static BigDecimal multiply(BigDecimal p1,String p2){
		return multiply(p1, new BigDecimal(p2));
	}
	public static BigDecimal multiply(BigDecimal p1,int p2){
		return multiply(p1, String.valueOf(p2));
	}
	
	public static BigDecimal multiply(String p1,String p2){
		return multiply(new BigDecimal(p1), p2);
	}
	/**
	 * 两数相除
	 * @param p1
	 * @param p2
	 * @param scale 小数点后的标度
	 * @return p1/p2
	 */
	public static BigDecimal divide(BigDecimal p1,BigDecimal p2,int scale){
		if(scale<0){
			scale = DEFAULT_SCALE;
		}
		
		return p1.divide(p2, scale, BigDecimal.ROUND_HALF_UP);
	}
	public static BigDecimal divide(BigDecimal p1,BigDecimal p2){
		return divide(p1,p2,DEFAULT_SCALE);
	}
	public static BigDecimal divide(BigDecimal p1,String p2){
		return divide(p1,new BigDecimal(p2),DEFAULT_SCALE);
	}
	public static BigDecimal divide(BigDecimal p1,int p2){
		return divide(p1,new BigDecimal(p2),DEFAULT_SCALE);
	}
	public static BigDecimal divide(BigDecimal p1,double p2){
		return divide(p1,new BigDecimal(p2),DEFAULT_SCALE);
	}
	public static Bead divide(BigDecimal p1,Bead p2){
		return turnToBead(p1).divide(p2);
	}
	
	/**
	 * 比较两数大小
	 * @param p1
	 * @param p2
	 * @return -1 小于  0 等于  1 大于
	 */
	public static int compare(BigDecimal p1,BigDecimal p2){
		return p1.compareTo(p2);
	}
	public static int compare(BigDecimal p1,int p2){
		return compare(p1,new BigDecimal(String.valueOf(p2)));
	}
	
	public static int compareToZERO(BigDecimal p1){
		return compare(p1, BigDecimal.ZERO);
	}
	
	public static int compare(BigDecimal p1,double p2){
		return compare(p1,new BigDecimal(String.valueOf(p2)));
	}
	
	public static int compare(BigDecimal p1,String p2){
		return compare(p1,new BigDecimal(p2));
	}
	
	/**
	 * 四舍五入
	 * @param value
	 * @param scale 小数点后的标度
	 * @return
	 */
	public static BigDecimal round(BigDecimal value,int scale){
		if(scale<0){
			scale = DEFAULT_SCALE;
		}
		return value.divide(BigDecimal.ONE, scale, BigDecimal.ROUND_HALF_UP);
	}
	
	/**
	 * 每月还息 到期还本法 的 每月利息
	 */
	public static Bead everyMonthInterestForPayInterest(BigDecimal money,BigDecimal monthlyRate){
		return  turnToBead(multiply(money, monthlyRate));
	}
	
	/**
	 * 
	 * 只针对 于 天标 的还款方式： 一次还本付息法  ，需将年利率  转换成 日利率  按 30进行计算
	 * 
	 * return 总付 本息
	 */
	public static Bead oneOffPay(BigDecimal money,int day,BigDecimal rate){
		BigDecimal dayRate = divide(getMonthlyRate(rate), DAYS_MONTH);
		BigDecimal dm1 = add(multiply(dayRate, day),BigDecimal.ONE);
		return turnToBead(multiply(money, dm1));
	}
	
	public static int overlookThousand(BigDecimal money){
		int moneyLimit = money.intValue();
		if(moneyLimit>=2000){
			moneyLimit = moneyLimit/1000;
			moneyLimit = moneyLimit*1000;				
		}else{
			moneyLimit = 1000;
		}
		return moneyLimit;
	}
	

	/**
	 * 按等额本息还款发   每月需要还款的金额
	 * 公式：x= Aβ(1+β)^m/[(1+β)^m-1]
	 * @param money 本金
	 * @param rate  年利率 传入 百分之多少进来
	 * @param month 还几个月
	 * @return 每月的还款额度
	 */
	public static Bead averageAmount(BigDecimal money,int month,BigDecimal monthlyRate){
		BigDecimal b1 = add(monthlyRate,BigDecimal.ONE);//(1+β)
		BigDecimal b1m = b1.pow(month);//(1+β)^m
		BigDecimal ab= multiply(money, monthlyRate);//Aβ
		BigDecimal abb1m = multiply(ab, b1m);//Aβ(1+β)^m
		BigDecimal down = subtract(b1m, BigDecimal.ONE);//(1+β)^m-1
		return turnToBead(divide(abb1m, down));
	}
	
	/**
	 * 计算某期等额本息还款法 需要还的本金
	 * 公式： B=Mr(1+r)^(n-1)÷[(1+r)^N-1]
	 * @param money 本金
	 * @param rate 年利率
	 * @param month 总期数
	 * @param now 当前期数
	 * @return now期 的本金
	 */
	public static Bead getStageHaveToPay(BigDecimal money,int month,BigDecimal monthlyRate,int now){
		BigDecimal b1 = add(monthlyRate,BigDecimal.ONE);//(1+r)
		BigDecimal b1m = b1.pow(now-1);//(1+r)^(n-1)
		BigDecimal ab= multiply(money, monthlyRate);//Mr
		BigDecimal abb1m = multiply(ab, b1m);//Mr(1+r)^(n-1)
		BigDecimal b1n=b1.pow(month);//(1+r)^N
		BigDecimal b1n1=subtract(b1n,BigDecimal.ONE);//(1+r)^N-1
		return turnToBead(divide(abb1m, b1n1));
	}

	public static BigDecimal turnToDecimal(Object obj) {
		return obj==null?BigDecimal.ZERO:new BigDecimal(String.valueOf(obj));
	}

	
	/**
	 * 计算管理费
	 * @param rate 为百分数
	 */
	public static BigDecimal getFeeForEach(BigDecimal total, BigDecimal rate,
			int amount) {
		BigDecimal r = parsePercent(rate);
		return FundAbacusUtil.multiply(
				FundAbacusUtil.multiply(total,r)
				, amount);
	}

}
