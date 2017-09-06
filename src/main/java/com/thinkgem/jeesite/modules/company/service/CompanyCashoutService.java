/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.company.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.company.dao.CompanyCashoutDao;
import com.thinkgem.jeesite.modules.company.entity.CompanyAccount;
import com.thinkgem.jeesite.modules.company.entity.CompanyCashout;
import com.thinkgem.jeesite.modules.company.enums.BusinessEvent;
import com.thinkgem.jeesite.modules.portal.service.PortalFunddetailService;
import com.thinkgem.jeesite.modules.sys.dao.OfficeDao;

/**
 * 商户提现记录Service
 * @author evan
 * @version 2015-11-13
 */
@Service
@Transactional(readOnly = true)
public class CompanyCashoutService extends CrudService<CompanyCashoutDao, CompanyCashout> {

	@Autowired
	private CompanyFunddetailService fundDetailService;
	
	@Autowired
	private PortalFunddetailService portalFunddetailService;
	
	@Autowired
	private CompanySettleLogService settleLogService;
	
	@Autowired
	private CompanyAccountService accountService;
	
	@Autowired
	private OfficeDao companyDao;
	
	public CompanyCashout get(String id) {
		return super.get(id);
	}
	
	public List<CompanyCashout> findList(CompanyCashout companyCashout) {
		return super.findList(companyCashout);
	}
	
	public Page<CompanyCashout> findPage(Page<CompanyCashout> page, CompanyCashout companyCashout) {
		companyCashout.getSqlMap().put("dsf", dataScopeFilter(companyCashout.getCurrentUser(), "o3", "u4"));
		return super.findPage(page, companyCashout);
	}
	
	@Transactional(readOnly = false)
	public CompanyCashout save(CompanyCashout companyCashout) {
		return super.save(companyCashout);
	}
	
	@Transactional(readOnly = false)
	public void delete(CompanyCashout companyCashout) {
		super.delete(companyCashout);
	}

	/**
	 * 提现审核操作
	 * @param companyCashout
	 * @return
	 */
	@Transactional(readOnly = false)
	public CompanyCashout audit(CompanyCashout companyCashout) {
		
		if (companyCashout.getStatus().equals("success")){//审核成功 
		// 成功 扣款
			
			//处理商户账户
			CompanyAccount account = accountService.getByCompanyId(companyCashout.getCompany().getId());
			account.setCompany(companyCashout.getCompany());
			//处理商户资金明细
			fundDetailService.genFundDetail(account, companyCashout.getCurrentUser(), companyCashout.getApplyAmount(), BusinessEvent.cashoutSuccess);
			
			//处理平台资金明细
			portalFunddetailService.genPortalFunddetail(companyCashout.getCompany(), companyCashout.getCashoutFee(), CompanyCashout.class.getName(), companyCashout.getId(), BusinessEvent.settle);
			
			accountService.updateAccount(account, companyCashout.getApplyAmount(), BusinessEvent.cashoutSuccess);
		}else if (companyCashout.getStatus().equals("fail")){// 审核失败
		//失败 退款
			CompanyAccount account = accountService.getByCompanyId(companyCashout.getCompany().getId());
			account.setCompany(companyCashout.getCompany());
			//处理商户资金明细
			fundDetailService.genFundDetail(account, companyCashout.getCurrentUser(), companyCashout.getApplyAmount(), BusinessEvent.cashoutFail);
			
			accountService.updateAccount(account, companyCashout.getApplyAmount(), BusinessEvent.cashoutFail);
			
		}else if(companyCashout.getStatus().equals("doing")){// 标记为处理中 -- 不做任何处理
			
		}
		
		return super.save(companyCashout);
	}
}