package com.thinkgem.jeesite.modules.views.common;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.RandomStringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.WebUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.base.entity.WebUser;
import com.thinkgem.jeesite.modules.base.service.WebUserService;


/**
 * 
 * web 公共 控制器
 * 用于发送短信  请求验证码
 * @version 2015-3-21
 * @author evan
 * 
 */
@Controller
public class WebCommonController  extends BaseController{
	/**
	 * 用户业务层对象
	 */
	private WebUserService webUserService;
	
	/**
	 * 日志服务对象
	 */
	private Logger _log = LoggerFactory.getLogger(this.getClass());

	// ========== get，set方法 ==========
	/**
	 * 自动织入
	 * 
	 * @param webUserService
	 *            用户业务层对象
	 */
	@Autowired
	public void setWebUserService(WebUserService webUserService) {
		this.webUserService = webUserService;
	}
	// ========== 控制器 ==========
	/**
	 * 发送传来手机验证码
	 * 
	 * @return 
	 */
	@RequestMapping(value = "${frontPath}/common/sendVildateCode4phone", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> sendAllSMS(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		String phone=request.getParameter("phone");
		if(phone == null || StringUtils.isMobile(phone) == false){
			
			map.put("result", "2");// 注册手机号码不正确
			return map;	
		}
		
		map.put("mobile", phone.trim()); 
		
		return sendSMS(map);
		
	}
	/**
	 * 只发送已经注册的手机用户验证码
	 * 
	 * @return 
	 */
	@RequestMapping(value = "${frontPath}/common/sendVildateCode", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> sendSMS(HttpServletRequest request) {
	    Map<String, Object> map = new HashMap<String, Object>();
		String phone=request.getParameter("phone");
		String reset=request.getParameter("reset");
		if(phone == null || StringUtils.isMobile(phone) == false){
			
			map.put("result", "2");// 注册手机号码不正确
			return map;	
		}
		
		map.put("mobile", phone);  //TODO:这样是不对的 会被 覆盖掉
		
		WebUser loginUser = webUserService.getByMobile(phone.trim());
		
		if(loginUser != null){
			if(reset != null && reset.equals("1")){
				return sendSMS(map);
			}else{
				map.put("result", "0");// 注册手机号已经注册 了
				return map;
			}
		}
		else{
			return sendSMS(map);
		}
    }
	
	private Map<String, Object> sendSMS(Map<String, Object> map){
		//TODO:发送手机验证码
		String val = RandomStringUtils.randomNumeric(6);
		
		if(logger.isInfoEnabled()){
			logger.info("发送的手机验证码为: "+ val);
		}
		map.put("result", "1");
		map.put("valideCode", val);
		WebUtils.put(WebUtils.SMS_VALIDE_CODE, map);
		return map;
	}
	/**
	 * 请求图片验证码
	 */
	@RequestMapping(value = "${frontPath}/common/captcha.jpg", method = RequestMethod.GET)
	public void captcha(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		super.captcha(req, resp);
	}

	
	
	/**
	 * 检查验证码是否正确
	 * 
	 * @param captcha
	 * @return
	 */
	@RequestMapping(value = "${frontPath}/common/checkCaptcha", produces = { "text/html;charset=UTF-8" })
	@ResponseBody
	public String checkCaptcha(@RequestParam String captcha,HttpServletRequest request) {
		if (captcha.equals(getGeneratedKey(request))) {
			return "1";
		}
		return "0";
	}
	
	
}
