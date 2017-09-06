/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.company.service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.TimeUtils;
import com.thinkgem.jeesite.common.utils.money.FundAbacusUtil;
import com.thinkgem.jeesite.modules.company.dao.CompanyFunddetailDao;
import com.thinkgem.jeesite.modules.company.entity.CompanyAccount;
import com.thinkgem.jeesite.modules.company.entity.CompanyFunddetail;
import com.thinkgem.jeesite.modules.company.enums.BusinessEvent;
import com.thinkgem.jeesite.modules.company.enums.FundIO;
import com.thinkgem.jeesite.modules.company.enums.TargetType;
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * 商户资金明细Service
 * @author evan
 * @version 2015-11-13
 */
@Service
@Transactional(readOnly = true)
public class CompanyFunddetailService extends CrudService<CompanyFunddetailDao, CompanyFunddetail> {

	public CompanyFunddetail get(String id) {
		return super.get(id);
	}
	
	public List<CompanyFunddetail> findList(CompanyFunddetail companyFunddetail) {
		return super.findList(companyFunddetail);
	}
	
	public Page<CompanyFunddetail> findPage(Page<CompanyFunddetail> page, CompanyFunddetail companyFunddetail) {
		return super.findPage(page, companyFunddetail);
	}
	
	@Transactional(readOnly = false)
	public CompanyFunddetail save(CompanyFunddetail companyFunddetail) {
		return super.save(companyFunddetail);
	}
	
	@Transactional(readOnly = false)
	public void delete(CompanyFunddetail companyFunddetail) {
		super.delete(companyFunddetail);
	}
	
	@Transactional(readOnly = false)
	public BigDecimal genFundDetail(CompanyAccount account,User user,BigDecimal operateCash,
			BusinessEvent businessEvent) {
		
		//TODO: 使用合适的设计模式处理 如策略模式 可以灵活切换不同的 积分策略
		CompanyFunddetail fundDetail = new CompanyFunddetail();
		fundDetail.setUser(user);
//		fundDetail.setSiteId(siteId);
		fundDetail.setCompany(account.getCompany());
		fundDetail.setCreateDate(new Date());
		fundDetail.setFundTimestamp(TimeUtils.getCurrentTimeMillis());
		
		fundDetail.setChangeType(businessEvent);
		fundDetail.setOperate(operateCash);
		fundDetail.setChangeDesc(businessEvent.getComment());
		
		BigDecimal resultBanlace  = account.getBalance();
		
		if(BusinessEvent.settle == businessEvent){
			
			fundDetail.setFundDirection(FundIO.IN);// IN OUT KEEP
			fundDetail.setTargetType(TargetType.Portal);
			fundDetail.setTarget(TargetType.Portal.getText());
			
			fundDetail.setFrozenAmount(account.getFrozenAmount());
			
			resultBanlace =  FundAbacusUtil.add(account.getBalance(),operateCash);//
			
			fundDetail.setBalance(resultBanlace);
			
		}else if(BusinessEvent.cashoutApply == businessEvent){//提现申请
			fundDetail.setFundDirection(FundIO.KEEP);// IN OUT KEEP
			fundDetail.setTargetType(TargetType.Portal);
			fundDetail.setTarget(TargetType.Portal.getText());
			
			fundDetail.setFrozenAmount(FundAbacusUtil.add(account.getFrozenAmount() ==null ?BigDecimal.ZERO:account.getFrozenAmount(),operateCash));
			
			resultBanlace =  FundAbacusUtil.subtract(account.getBalance(),operateCash);//减
			
			fundDetail.setBalance(resultBanlace);
		}else if(BusinessEvent.cashoutSuccess == businessEvent){//提现审核成功
			fundDetail.setFundDirection(FundIO.OUT);// IN OUT KEEP
			fundDetail.setTargetType(TargetType.Portal);
			fundDetail.setTarget(TargetType.Portal.getText());
			
			fundDetail.setFrozenAmount(FundAbacusUtil.subtract(account.getFrozenAmount() ==null ?BigDecimal.ZERO:account.getFrozenAmount(),operateCash));
			
			fundDetail.setBalance(resultBanlace);
		}else if(BusinessEvent.cashoutFail == businessEvent){//提现审核失败
			fundDetail.setFundDirection(FundIO.KEEP);// IN OUT KEEP
			fundDetail.setTargetType(TargetType.Portal);
			fundDetail.setTarget(TargetType.Portal.getText());
			
			fundDetail.setFrozenAmount(FundAbacusUtil.subtract(account.getFrozenAmount() ==null ?BigDecimal.ZERO:account.getFrozenAmount(),operateCash));
			
			resultBanlace =  FundAbacusUtil.add(account.getBalance(),operateCash);
			
			fundDetail.setBalance(resultBanlace);
		}else if(BusinessEvent.referreAward == businessEvent){//推荐奖励
//			fundDetail.setFundDirection(FundIO.IN);// IN OUT KEEP
//			fundDetail.setTargetType(TargetType.WebUser);
//			fundDetail.setTarget((tartTypeVal == null || tartTypeVal.equals(""))?TargetType.Portal:tartTypeVal);
//			fundDetail.setFrozenAmount(webUser.getFrozenAmount());
//			resultBanlace =  FundAbacusUtil.add(webUser.getBalance(),operateCash);
			
//			fundDetail.setBalance(resultBanlace);
		}
//		if(FundAbacusUtil.compareToZERO(operateCash)>0) // 控制要不要记录 操作资金为0时的记录
			super.save(fundDetail);
		
		return resultBanlace;
		
	}
}