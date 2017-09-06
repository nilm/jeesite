/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.company.service;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.money.FundAbacusUtil;
import com.thinkgem.jeesite.modules.company.dao.CompanyAccountDao;
import com.thinkgem.jeesite.modules.company.entity.CompanyAccount;
import com.thinkgem.jeesite.modules.company.enums.BusinessEvent;

/**
 * 商户账户Service
 * @author evan
 * @version 2015-11-13
 */
@Service
@Transactional(readOnly = true)
public class CompanyAccountService extends CrudService<CompanyAccountDao, CompanyAccount> {

	@Autowired
	private CompanyAccountDao accountDao;
	
	public CompanyAccount get(String id) {
		return super.get(id);
	}
	
	public List<CompanyAccount> findList(CompanyAccount companyAccount) {
		return super.findList(companyAccount);
	}
	
	public Page<CompanyAccount> findPage(Page<CompanyAccount> page, CompanyAccount companyAccount) {
		return super.findPage(page, companyAccount);
	}
	
	@Transactional(readOnly = false)
	public CompanyAccount save(CompanyAccount companyAccount) {
		return super.save(companyAccount);
	}
	
	@Transactional(readOnly = false)
	public void delete(CompanyAccount companyAccount) {
		super.delete(companyAccount);
	}
	// =====================业务方法=====================
	/**
	 * 根据商户id获取商户账户，没有则创建一个
	 * @param id
	 * @return
	 */
	public CompanyAccount getByCompanyId(String companyId){
		CompanyAccount  account = accountDao.getByCompanyId(companyId);
		if(account == null){
			account = new CompanyAccount();
			account.setCompanyId(companyId);
			account.setBalance(BigDecimal.ZERO);
			account.setFrozenAmount(BigDecimal.ZERO);
		}
		return account;
	}
	
	@Transactional(readOnly = false)
	public CompanyAccount updateAccount(CompanyAccount companyAccount,BigDecimal operateCash,BusinessEvent businessEvent) {
		if(businessEvent == BusinessEvent.settle){// 结算
			companyAccount.setBalance(FundAbacusUtil.add(companyAccount.getBalance(), operateCash));
			
		}else if (businessEvent == BusinessEvent.cashoutApply){//申请提现
			companyAccount.setBalance(FundAbacusUtil.subtract(companyAccount.getBalance(), operateCash));
			companyAccount.setFrozenAmount(FundAbacusUtil.add(companyAccount.getFrozenAmount(), operateCash));
		}else if(businessEvent == BusinessEvent.cashoutFail){//提现失败
			companyAccount.setBalance(FundAbacusUtil.add(companyAccount.getBalance(), operateCash));
			companyAccount.setFrozenAmount(FundAbacusUtil.subtract(companyAccount.getFrozenAmount(), operateCash));
		}else if(businessEvent == BusinessEvent.cashoutSuccess){//提现 成功
			companyAccount.setFrozenAmount(FundAbacusUtil.subtract(companyAccount.getFrozenAmount(), operateCash));
		}
		super.save(companyAccount);
		
		return companyAccount;
	}
	
}