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
import com.thinkgem.jeesite.common.utils.money.FundAbacusUtil;
import com.thinkgem.jeesite.modules.company.entity.CompanyAccount;
import com.thinkgem.jeesite.modules.company.entity.CompanySettleLog;
import com.thinkgem.jeesite.modules.company.enums.BusinessEvent;
import com.thinkgem.jeesite.modules.company.enums.FundIO;
import com.thinkgem.jeesite.modules.company.config.BusinessConfig;
import com.thinkgem.jeesite.modules.company.dao.CompanySettleLogDao;
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * 商户结算单Service
 * @author evan
 * @version 2015-11-14
 */
@Service
@Transactional(readOnly = true)
public class CompanySettleLogService extends CrudService<CompanySettleLogDao, CompanySettleLog> {

	public CompanySettleLog get(String id) {
		return super.get(id);
	}
	
	public List<CompanySettleLog> findList(CompanySettleLog companySettleLog) {
		return super.findList(companySettleLog);
	}
	
	public Page<CompanySettleLog> findPage(Page<CompanySettleLog> page, CompanySettleLog companySettleLog) {
		companySettleLog.getSqlMap().put("dsf", dataScopeFilter(companySettleLog.getCurrentUser(), "o2", "u14"));
		return super.findPage(page, companySettleLog);
	}
	
	@Transactional(readOnly = false)
	public CompanySettleLog save(CompanySettleLog companySettleLog) {
		return super.save(companySettleLog);
	}
	
	@Transactional(readOnly = false)
	public void delete(CompanySettleLog companySettleLog) {
		super.delete(companySettleLog);
	}
	
	/**
	 * 生成结算单 
	 * 时间时点 包括 订单的定时结算 |提现的 [申请|失败|成功]
	 * @param account
	 * @param user
	 * @param operateCash
	 * @param businessEvent
	 * @return
	 */
/*	@Transactional(readOnly = false)
	public CompanySettleLog genSettleLog(CompanyAccount account,User user,BigDecimal operateCash,
			BusinessEvent businessEvent) {
		
		
		CompanySettleLog settleLog = new CompanySettleLog();
		
		settleLog.setCompany(account.getCompany());
		settleLog.setCreateDate(new Date());
		
		if(businessEvent == BusinessEvent.settle){
//		settleLog.setNeedAudit(DictUtils.getDictValue("是", "yes_no", "no"));
//		settleLog.setAuditStatus(DictUtils.getDictValue("审核中", "base_audit_status", "audit"));
		settleLog.setSettleType(FundIO.IN);
//		账务计算
			settleLog.setPoundage(BusinessConfig.POUNDAGE);
			settleLog.setSettleMoney(FundAbacusUtil.subtract(settleLog.getPayNetMoney(), BusinessConfig.POUNDAGE));
			
		}
		
		return super.save(settleLog);
	}*/
	
}