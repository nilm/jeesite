/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.account.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.enums.AuditStatus;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.TimeUtils;
import com.thinkgem.jeesite.modules.account.dao.CashoutDao;
import com.thinkgem.jeesite.modules.account.entity.Cashout;
import com.thinkgem.jeesite.modules.account.enums.UserEvent;
import com.thinkgem.jeesite.modules.base.entity.WebUser;
import com.thinkgem.jeesite.modules.base.service.WebUserService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 用户提现申请Service
 * @author evan
 * @version 2015-04-06
 */
@Service
@Transactional(readOnly = true)
public class CashoutService extends CrudService<CashoutDao, Cashout> {

	@Autowired
	private FundDetailService fundDetailService;
	
	@Autowired
	private WebUserService webUserService;
	
	public Cashout get(String id) {
		return super.get(id);
	}
	
	public List<Cashout> findList(Cashout cashout) {
		return super.findList(cashout);
	}
	
	public Page<Cashout> findPage(Page<Cashout> page, Cashout cashout) {
		return super.findPage(page, cashout);
	}
	
	@Transactional(readOnly = false)
	public Cashout save(Cashout cashout) {
		return super.save(cashout);
	}
	
	@Transactional(readOnly = false)
	public void delete(Cashout cashout) {
		super.delete(cashout);
	}
	
	
	/**
	 * 前台提现申请
	 * @param cashout
	 */
	@Transactional(readOnly = false)
	public void saveCashoutApply(WebUser webUser,Cashout cashout) {
		
		//处理资金记录
		
		//提现冻结资金
		fundDetailService.genFundDetail(cashout.getId(), 
				cashout.getCompanyId(), webUser, cashout.getApplyAmount(), UserEvent.cashoutApply,"");
		
		super.save(cashout);
		
		//最后汇总数据
		webUserService.updateWebUserAccount(webUser, null, cashout.getApplyAmount(), UserEvent.cashoutApply);
		
	}
	/**
	 * 后台提现审核
	 * @param cashout
	 */
	@Transactional(readOnly = false)
	public void doCashoutApplyAudit(Cashout cashout,String action) {
	
		//处理资金记录
		WebUser webUser = cashout.getWebUser();
		webUser =  webUserService.get(webUser);
		cashout.setAuditDate(TimeUtils.getCurrentTimestamp());
		cashout.setUser(UserUtils.getUser());
		UserEvent userEvent =  null;
		// 修改状态为审核通过
		if(action.equals(AuditStatus.success.toString()) && cashout.getStatus().equals(AuditStatus.doing.toString())){
			cashout.setStatus(action);
			userEvent = UserEvent.cashoutSuccess;
		}
		
		// 修改状态为审核失败
		// 修改状态为审核通过
		if(action.equals(AuditStatus.fail.toString())){
			cashout.setStatus(action);
			userEvent = UserEvent.cashoutFail;
		}
		
		
		
		//提现冻结资金
		fundDetailService.genFundDetail(cashout.getId(), 
				cashout.getCompanyId(), webUser, cashout.getApplyAmount(), userEvent,"");
		
		super.save(cashout);
		
		//最后汇总数据
		webUserService.updateWebUserAccount(webUser, null, cashout.getApplyAmount(), userEvent);
		
	}

	
}