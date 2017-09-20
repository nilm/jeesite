package cn.helloan.appservice.rest.json;

import java.io.Serializable;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.codehaus.jackson.JsonGenerationException;

import cn.helloan.appservice.enums.ResponseStatusCode;
import net.cloudsun.util.DateUtils;
import net.cloudsun.util.StringUtils;

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
		result.put("responseTime", DateUtils.parseDateForStandard(new Date()));
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

	public String toJson(){
		if(result == null){
			
			return fail();
		}
		return StringUtils.paseObjToString(result);
	}

	private String fail() {
		result = new HashMap<String, Object>();
		result.put("code", ResponseStatusCode.serverError.getCode());
		result.put("message", "failed");
		result.put("responseTime", DateUtils.parseDateForStandard(new Date()));
		return null;
	}

	
	
}
