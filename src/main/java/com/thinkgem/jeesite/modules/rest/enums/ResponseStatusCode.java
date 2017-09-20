package com.thinkgem.jeesite.modules.rest.enums;

/**
 * 
 * @author nilm
 * 
 */
public enum ResponseStatusCode {
	
	success("0","操作成功"), 
	badRequest("100","请求错误"), 
	appKeyError("101","缺少appKey"),
	signError("102","缺少签名"),
	paramError("103","缺少参数"), 
	requestRedirect("104","请求重定向"),
	userError("105","需要用户登录"),
	reloginError("106","已有登录用户"),
	authError("107","需要实名认证"),
	tradePwdError("108","用户交易密码出错"),
	serverError("200","服务器内部错误"),
	serverDisable("201","服务不可用");
	
/*	0：成功
	100：请求错误
	101：缺少appKey
	102：缺少签名
	103：缺少参数
	200：服务器出错
	201：服务不可用
	202：服务器正在重启*/
	
	private final String code;
    private final String desc;

    public String getCode() {
    	return code;
    }
	public String getDesc() {
		return desc;
	}

	private ResponseStatusCode(String code,String desc) {
		this.code = code;
		this.desc = desc;
	}
	

}
