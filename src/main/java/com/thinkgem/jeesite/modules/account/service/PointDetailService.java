/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.account.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.TimeUtils;
import com.thinkgem.jeesite.modules.account.dao.PointDetailDao;
import com.thinkgem.jeesite.modules.account.entity.PointDetail;
import com.thinkgem.jeesite.modules.account.enums.FundIO;
import com.thinkgem.jeesite.modules.account.enums.TargetType;
import com.thinkgem.jeesite.modules.account.enums.UserEvent;
import com.thinkgem.jeesite.modules.base.entity.WebUser;

/**
 * 用户积分Service
 * @author evan
 * @version 2015-04-05
 */
@Service
@Transactional(readOnly = true)
public class PointDetailService extends CrudService<PointDetailDao, PointDetail> {
	
	@Autowired
	private PointDetailDao pointDetailDao;
	
	@Autowired
	private FundDetailService fundDetailService;
	
	public PointDetail get(String id) {
		return super.get(id);
	}
	
	public List<PointDetail> findList(PointDetail pointDetail) {
		return super.findList(pointDetail);
	}
	
	public Page<PointDetail> findPage(Page<PointDetail> page, PointDetail pointDetail) {
		return super.findPage(page, pointDetail);
	}
	
	@Transactional(readOnly = false)
	public PointDetail save(PointDetail pointDetail) {
		return super.save(pointDetail);
	}
	
	@Transactional(readOnly = false)
	public void delete(PointDetail pointDetail) {
		super.delete(pointDetail);
	}
	
	
	// =================================定制方法 =========================================
	
	public String findWebUserPointUseStatus(String userId){
//		List<Map<String,Integer>>  result = pointDetailDao.findWebUserPointUseStatus(userId);
		return "";
	}
	
	public int findWebUserSumFundDirection(String userId,String fundDirection){
		PointDetail pointDetail = new PointDetail();
		pointDetail.setUserId(userId);
		pointDetail.setFundDirection(fundDirection);
		PointDetail  result = pointDetailDao.findWebUserSumFundDirection(pointDetail);
		if(result == null){
			return 0;
		}
		return result.getSumPoints();
	}
	
	/**
	 * 查询前台用户分页数据
	 * @param page 分页对象
	 * @param pointDetail
	 * @return
	 */
	public Page<PointDetail> findWebUserPage(Page<PointDetail> page, PointDetail pointDetail) {
		
		Date now = DateUtils.parseDate(DateUtils.getDate());
		if(pointDetail.getTimeRange()== null || pointDetail.getTimeRange().equals("1")){//全部
			pointDetail.setBeginDate(null);
			pointDetail.setEndDate(null);
		}else if(pointDetail.getTimeRange().equals("2")){//近一周
			pointDetail.setBeginDate(DateUtils.addDays(now, -6));
			pointDetail.setEndDate(DateUtils.addDays(pointDetail.getBeginDate(), 7));
		}else if(pointDetail.getTimeRange().equals("3")){//近一月
			pointDetail.setBeginDate(DateUtils.addMonths(now, -1));
			pointDetail.setEndDate(DateUtils.addDays(now, 1));
		}else if(pointDetail.getTimeRange().equals("4")){//最近三个月
			pointDetail.setBeginDate(DateUtils.addMonths(now, -3));
			pointDetail.setEndDate(DateUtils.addDays(now, 1));
		}else if(pointDetail.getTimeRange().equals("5")){//最近半年
			pointDetail.setBeginDate(DateUtils.addMonths(now, -6));
			pointDetail.setEndDate(DateUtils.addDays(now, 1));
		}
		
		pointDetail.setPage(page);
		page.setList(pointDetailDao.findWebUserList(pointDetail));
		return page;
	}
	
	

	
	/**
	 * 处理积分--生成积分变化记录
	 * @param siteId
	 * @param companyId
	 * @param webUser
	 * @param pointCountInt
	 * @param userEvent
	 * @param tartTypeVal
	 * @return
	 */
	@Transactional(readOnly=false)
	public int genPointDetail(String siteId,String companyId,WebUser webUser, int pointCountInt,
			UserEvent userEvent,String tartTypeVal) {
		
		//TODO: 使用合适的设计模式处理 如策略模式 可以灵活切换不同的 积分策略
		int resultPoints = webUser.getPoints();
		PointDetail pointDetail = new PointDetail();
		pointDetail.setUserId(webUser.getId());
		pointDetail.setSiteId(siteId);
		pointDetail.setCompanyId(companyId);
		
		pointDetail.setFundTimestamp(TimeUtils.getCurrentTimeMillis());
		
		pointDetail.setChangeType(userEvent.toString());
		pointDetail.setOperate(pointCountInt);
		pointDetail.setChangeDesc(userEvent.getComment());
		
		if(UserEvent.register == userEvent){
			pointDetail.setFundDirection(FundIO.IN.toString());// IN OUT KEEP
			pointDetail.setTargetType(TargetType.Portal.toString());
			pointDetail.setTarget(TargetType.Portal.toString());
			
			resultPoints = webUser.getPoints()+pointCountInt;
			pointDetail.setBalance(resultPoints);// 加还是减
			
		}else if(UserEvent.pointExchangeCash == userEvent){
			pointDetail.setFundDirection(FundIO.OUT.toString());// IN OUT KEEP
			pointDetail.setTargetType(TargetType.Portal.toString());
			pointDetail.setTarget(TargetType.Portal.toString());
			resultPoints = webUser.getPoints()-pointCountInt;
			pointDetail.setBalance(resultPoints);// 加还是减
		}else if(UserEvent.referreAward == userEvent){
			pointDetail.setFundDirection(FundIO.IN.toString());// IN OUT KEEP
			pointDetail.setTargetType(TargetType.WebUser.toString());
			pointDetail.setTarget((tartTypeVal == null || tartTypeVal.equals(""))?TargetType.Portal.toString():tartTypeVal);
			resultPoints = webUser.getPoints()+pointCountInt;
			pointDetail.setBalance(resultPoints);// 加还是减
		}
		
		this.save(pointDetail);
		return resultPoints;
		
	}

}