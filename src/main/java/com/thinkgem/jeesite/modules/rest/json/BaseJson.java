package com.thinkgem.jeesite.modules.rest.json;

import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.modules.rest.enums.ResponseStatusCode;

import java.io.Serializable;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;


public class BaseJson implements Serializable {

	private static final long serialVersionUID = -6475681946464041197L;
	
	
	public Map<String, Object> result = null;

	
	/**
	 * 返回数据 json 数据
	 */
	public Object data;
	
	

	public BaseJson() {
		result = new HashMap<String, Object>();
		result.put("code", ResponseStatusCode.success.getCode());
		result.put("message", ResponseStatusCode.success.getDesc());
		result.put("responseTime", DateUtils.formatDateTime(new Date()));
	}
	
	public void putData(Object value){
		result.put("data", value);
	}
	
	public void putPageData(int pageNow,Object value){
		result.put("pageNow", pageNow);
		result.put("data", value);
	}
	
	public void put(String key, Object value){
		result.put(key, value);
	}


	public void get(String key){
		result.get(key);
	}

	public  void putMsg(String msg){
		put("message",msg);
	}

	public String toJson(){
		if(result == null){
			fail("");
		}
		return JsonMapper.toJsonString(result);
	}

	public BaseJson fail(String msg) {
		result = new HashMap<String, Object>();
		result.put("code", ResponseStatusCode.serverError.getCode());
		result.put("message", (msg == null || "".equals(msg))?"failed":msg);
		result.put("responseTime", DateUtils.formatDateTime(new Date()));
		return this;
	}

	
	
}
