package com.thinkgem.jeesite.modules.account.service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.TimeUtils;
import com.thinkgem.jeesite.common.utils.money.FundAbacusUtil;
import com.thinkgem.jeesite.modules.account.dao.FunddetailDao;
import com.thinkgem.jeesite.modules.account.entity.Funddetail;
import com.thinkgem.jeesite.modules.account.enums.FundIO;
import com.thinkgem.jeesite.modules.account.enums.TargetType;
import com.thinkgem.jeesite.modules.account.enums.UserEvent;
import com.thinkgem.jeesite.modules.base.entity.WebUser;

/**
 * 资金记录Service
 * @author evan
 * @version 2015-04-04
 */
@Service
@Transactional(readOnly = true)
public class FundDetailService extends CrudService<FunddetailDao, Funddetail> {

	@Autowired
	private FunddetailDao funddetailDao;
	public Page<Funddetail> findPage(Page<Funddetail> page, Funddetail funddetail) {
		
		
		Date now = DateUtils.parseDate(DateUtils.getDate());
		if(funddetail.getTimeRange()== null || funddetail.getTimeRange().equals("1")){//全部
			funddetail.setBeginDate(null);
			funddetail.setEndDate(null);
		}else if(funddetail.getTimeRange().equals("2")){//近一周
			funddetail.setBeginDate(DateUtils.addDays(now, -6));
			funddetail.setEndDate(DateUtils.addDays(funddetail.getBeginDate(), 7));
		}else if(funddetail.getTimeRange().equals("3")){//近一月
			funddetail.setBeginDate(DateUtils.addMonths(now, -1));
			funddetail.setEndDate(DateUtils.addDays(now, 1));
		}else if(funddetail.getTimeRange().equals("4")){//最近三个月
			funddetail.setBeginDate(DateUtils.addMonths(now, -3));
			funddetail.setEndDate(DateUtils.addDays(now, 1));
		}else if(funddetail.getTimeRange().equals("5")){//最近半年
			funddetail.setBeginDate(DateUtils.addMonths(now, -6));
			funddetail.setEndDate(DateUtils.addDays(now, 1));
		}
		
		return super.findPage(page, funddetail);
		
	}
	
	/**
	 *  处理积分--生成资金变化记录
	 * @param siteId
	 * @param companyId
	 * @param webUser
	 * @param operateCash
	 * @param userEvent
	 * @param tartTypeVal
	 * @return
	 */
	@Transactional(readOnly = false)
	public BigDecimal genFundDetail(String siteId,String companyId,WebUser webUser, BigDecimal operateCash,
			UserEvent userEvent,String tartTypeVal) {
		
		//TODO: 使用合适的设计模式处理 如策略模式 可以灵活切换不同的 积分策略
		Funddetail fundDetail = new Funddetail();
		fundDetail.setUserId(webUser.getId());
		fundDetail.setSiteId(siteId);
		fundDetail.setCompanyId(companyId);
		fundDetail.setCreateDate(new Date());
		fundDetail.setFundTimestamp(TimeUtils.getCurrentTimeMillis());
		
		fundDetail.setChangeType(userEvent.toString());
		fundDetail.setOperate(operateCash);//  注册奖励可以有数据库中取得
		fundDetail.setChangeDesc(userEvent.getComment());
		
		BigDecimal resultBanlace  = webUser.getBalance();
		
		if(UserEvent.register == userEvent){
			fundDetail.setFundDirection(FundIO.IN.toString());// IN OUT KEEP
			fundDetail.setTargetType(TargetType.Portal.toString());
			fundDetail.setTarget(TargetType.Portal.toString());
			
			fundDetail.setFrozenAmount(BigDecimal.ZERO);
			resultBanlace = FundAbacusUtil.add(BigDecimal.ZERO,operateCash);//注册送钱
			fundDetail.setBalance(resultBanlace);// 加还是减
			
		}else if(UserEvent.pointExchangeCash == userEvent){
			fundDetail.setFundDirection(FundIO.IN.toString());// IN OUT KEEP
			fundDetail.setTargetType(TargetType.Portal.toString());
			fundDetail.setTarget(TargetType.Portal.toString());
			fundDetail.setFrozenAmount(webUser.getFrozenAmount());
			
			resultBanlace =  FundAbacusUtil.add(webUser.getBalance(),operateCash);
			fundDetail.setBalance(resultBanlace);// 加还是减
		}else if(UserEvent.cashoutApply == userEvent){//提现申请
			fundDetail.setFundDirection(FundIO.KEEP.toString());// IN OUT KEEP
			fundDetail.setTargetType(TargetType.Portal.toString());
			fundDetail.setTarget(TargetType.Portal.toString());
			
			fundDetail.setFrozenAmount(FundAbacusUtil.add(webUser.getFrozenAmount() ==null ?BigDecimal.ZERO:webUser.getFrozenAmount(),operateCash));
			
			resultBanlace =  FundAbacusUtil.subtract(webUser.getBalance(),operateCash);//减
			
			fundDetail.setBalance(resultBanlace);
		}else if(UserEvent.cashoutSuccess == userEvent){//提现审核成功
			fundDetail.setFundDirection(FundIO.OUT.toString());// IN OUT KEEP
			fundDetail.setTargetType(TargetType.Portal.toString());
			fundDetail.setTarget(TargetType.Portal.toString());
			
			fundDetail.setFrozenAmount(FundAbacusUtil.subtract(webUser.getFrozenAmount() ==null ?BigDecimal.ZERO:webUser.getFrozenAmount(),operateCash));
			
//			resultBanlace =  webUser.getBalance();  // 他不变
			
			fundDetail.setBalance(resultBanlace);
		}else if(UserEvent.cashoutFail == userEvent){//提现审核失败
			fundDetail.setFundDirection(FundIO.IN.toString());// IN OUT KEEP
			fundDetail.setTargetType(TargetType.Portal.toString());
			fundDetail.setTarget(TargetType.Portal.toString());
			
			fundDetail.setFrozenAmount(FundAbacusUtil.subtract(webUser.getFrozenAmount() ==null ?BigDecimal.ZERO:webUser.getFrozenAmount(),operateCash));
			
			resultBanlace =  FundAbacusUtil.add(webUser.getBalance(),operateCash);
			
			fundDetail.setBalance(resultBanlace);
		}else if(UserEvent.referreAward == userEvent){//推荐奖励
			fundDetail.setFundDirection(FundIO.IN.toString());// IN OUT KEEP
			fundDetail.setTargetType(TargetType.WebUser.toString());
			fundDetail.setTarget((tartTypeVal == null || tartTypeVal.equals(""))?TargetType.Portal.toString():tartTypeVal);
			fundDetail.setFrozenAmount(webUser.getFrozenAmount());
			resultBanlace =  FundAbacusUtil.add(webUser.getBalance(),operateCash);
			
			fundDetail.setBalance(resultBanlace);
		}
//		if(FundAbacusUtil.compareToZERO(operateCash)>0) // 控制要不要记录 操作资金为0时的记录
			super.save(fundDetail);
		
		return resultBanlace;
		
	}
	
	@Transactional(readOnly = false)
	public Funddetail getLatelyByUserId(String userId){
		Funddetail fund = new Funddetail();
		fund.setUserId(userId);
		List<Funddetail> list = funddetailDao.getLatelyByUserId(fund);
		if(list!=null && list.size()>0){
			return list.get(0);
		}
		return null;
	}
	
}
