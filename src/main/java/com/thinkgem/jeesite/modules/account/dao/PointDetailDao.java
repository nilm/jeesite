/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.account.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.account.entity.PointDetail;

/**
 * 用户积分DAO接口
 * @author evan
 * @version 2015-04-05
 */
@MyBatisDao
public interface PointDetailDao extends CrudDao<PointDetail> {
	
	/**
	 * 查询前台用户分页数据
	 * @param entity
	 * @return
	 */
	public List<PointDetail> findWebUserList(PointDetail pointDetail);
	/**
	 * 
	 * @param userId
	 * @return
	 */
//	public List<Map<String,Integer>> findWebUserPointUseStatus(String userId);
	/**
	 *根据changeType 查询用户的累计积分
	 * @param userId
	 * @return
	 */
	public PointDetail findWebUserSumFundDirection(PointDetail pointDetail);
}