/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.common.utils;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.modules.base.entity.WebUser;



/**
 * Web工具类
 * @author evan
 * @version 2015-3-21
 */
public class WebUtils {
	
	public static final String WEB_USER = "WEB_USER";
	public static final String LAST_URL = "last_url";
	public static final String SMS_VALIDE_CODE = "SMS_VALIDE_CODE";
	
	/**
	 * 用户登录保存用户信息到session
	 * @param user
	 */
	public static void putWebUser(WebUser user){
		getRequest().getSession().setAttribute(WEB_USER,  user);
	}
	
	/**
	 * 将值放入session
	 * @param name
	 * @param value
	 */
	public static void put(String name, Object value){
		getRequest().getSession().setAttribute(name, value);
	}
	/**
	 * 将值放入session
	 * @param name
	 * @param value
	 */
	public static WebUser getWebUser(){
		return  (WebUser)getRequest().getSession().getAttribute(WEB_USER);
	}
	/**
	 * 从session取出指定对象
	 * @param name
	 * @param value
	 */
	public static Object get(String name){
		return  getRequest().getSession().getAttribute(name);
	}
	
	/**
	 * 从session取出指定对象
	 * @param name
	 */
	public static void removeWebUser(){
		remove(WebUtils.WEB_USER);
	}
	/**
	 * 从session取出指定对象
	 * @param name
	 */
	public static void remove(String name){
		getRequest().getSession().removeAttribute(name);
	}

	
	/**
	 * 从spring中 获得request
	 * @return
	 */
	public static HttpServletRequest getRequest() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		return request;
	}
	

	/**
	 * 获得 LastUrl request的中参数为last_url @see WebUtils.LAST_URL
	 * @param request
	 * @return
	 */
	public static  String getLastUrl(HttpServletRequest request){
		String lastUrl = request.getParameter(WebUtils.LAST_URL);//如果有最后传来的访问地址则登录完后重定向的那里
		if(StringUtils.isEmpty(lastUrl) == false){
			return  lastUrl;
		}else{
			lastUrl = request.getRequestURL().toString();
		}
		return lastUrl;
	}
	/**
	 * 1.重定向到最后浏览的地址
	 * 没有参数则返回到首页
	 * @param request
	 * @return
	 */
	public static  String redirectLastUrl(HttpServletRequest request){
		String lastUrl = request.getParameter(WebUtils.LAST_URL);//如果有最后传来的访问地址则登录完后重定向的那里
		return redirectLastUrl(lastUrl);
	}
	
	public static  String redirectLastUrl(String lastUrl){
		
		if(StringUtils.isEmpty(lastUrl)){
			return "redirect:/"+Global.getFrontPath();
		}
        String url = null;
        try {
            url = URLDecoder.decode(lastUrl, "UTF-8");
        } catch (UnsupportedEncodingException e) {
        }
		
		if(StringUtils.isEmpty(url) == false){
			return "redirect:"+url;
		}
/*		if(StringUtils.isEmpty(defaultUrl) == false){
			return "redirect:"+ defaultUrl;
		}*/
		return "redirect:/"+Global.getFrontPath();
	}
	
	
	// =================前台公共方法=========================
	

	/**
	 * 获得登录地址
	 * @param last_url
	 * @return
	 */
	public static  String getLoginUrl(String last_url) {
        String url = null;
        try {
            url = URLEncoder.encode(last_url, "UTF-8");
        } catch (UnsupportedEncodingException e) {
        }
		return Global.getFrontPath()+"/u/login?"+WebUtils.LAST_URL+"="+url;
	}
	
	/**
	 *  重定向到登录页面
	 * @param String last_url
	 * @return
	 */
	public static  String redirectLoginUrl(String last_url){
		return "redirect:"+ getLoginUrl(last_url);
	}
	
	
	/**
	 * 获得手机端登录地址
	 * @param last_url
	 * @return
	 */
	public static  String getMobileLoginUrl(String last_url) {
		String url = null;
		try {
			url = URLEncoder.encode(last_url, "UTF-8");
		} catch (UnsupportedEncodingException e) {
		}
		return Global.getFrontPath()+"/m/u/login?"+WebUtils.LAST_URL+"="+url;
	}
	
	/**
	 *  重定向到手机端登录页面
	 * @param String last_url
	 * @return
	 */
	public static  String redirectMobileLoginUrl(String last_url){
		return "redirect:"+ getMobileLoginUrl(last_url);
	}
	
	/**
	 * 获得手机端登录地址
	 * @param last_url
	 * @return
	 */
	public static  String getWxAuthUrl(String last_url) {
        String url = null;
        try {
            url = URLEncoder.encode(last_url, "UTF-8");
        } catch (UnsupportedEncodingException e) {
        }
		return Global.getFrontPath()+"/weixin/toOauth?"+WebUtils.LAST_URL+"="+url;
	}
	
	/**
	 *  重定向到手机端登录页面
	 * @param String last_url
	 * @return
	 */
	public static  String redirectWxAuthUrl(String last_url){
		return "redirect:"+ getWxAuthUrl(last_url);
	}
	
	
	/**
	 * 根据user-agent 判断是否是来自微信内置浏览器
	 * @param user_agent
	 * @return
	 */
	public static boolean isWeixin(String  user_agent){
		user_agent = user_agent.toLowerCase();
		boolean validation = false;
		if (user_agent.indexOf("micromessenger") > 0) {// 是微信浏览器
	        validation = true;
	      }
		return validation;
	}
}
