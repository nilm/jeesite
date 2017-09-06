package com.thinkgem.jeesite.common.utils.shield;

/**
 * 邮箱屏蔽表达式
 * 
 * @author 俞建波
 * 
 */
public class EmailShieldExpression {
	/** 原始字符串 */
	private String originalString;
	/** @左边的表达式 */
	private ShieldExpression firstExpression;
	/** @右边的表达式 */
	private ShieldExpression secondExpression;

	/**
	 * 
	 * @return @左边的表达式
	 */
	public ShieldExpression getFirstExpression() {
		return firstExpression;
	}

	/**
	 * 
	 * @return @右边的表达式
	 */
	public ShieldExpression getSecondExpression() {
		return secondExpression;
	}

	/**
	 * 
	 * @param originalString
	 *            原始字符串
	 * @throws ShieldException 
	 */
	public EmailShieldExpression(String originalString) throws ShieldException {
		super();
		this.originalString = originalString;
		this.compile();
	}

	private void compile() throws ShieldException{
		if(this.originalString==null || this.originalString.isEmpty()){
			throw new ShieldException("输入字符串不能为空");
		}
		
		if(!this.originalString.contains("@")){
			throw new ShieldException("不是合法的邮箱屏蔽表达式");
		}
		
		String [] data = this.originalString.split("@");
		this.firstExpression = new ShieldExpression(data[0]);
		if(data.length>1){
			this.secondExpression = new ShieldExpression(data[1]);
		}else{
			this.secondExpression = new ShieldExpression("");
		}
	}

}
