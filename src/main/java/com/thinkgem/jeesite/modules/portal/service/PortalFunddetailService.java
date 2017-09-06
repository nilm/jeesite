/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.portal.service;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.money.FundAbacusUtil;
import com.thinkgem.jeesite.modules.company.enums.BusinessEvent;
import com.thinkgem.jeesite.modules.company.enums.FundIO;
import com.thinkgem.jeesite.modules.company.enums.TargetType;
import com.thinkgem.jeesite.modules.portal.dao.PortalFunddetailDao;
import com.thinkgem.jeesite.modules.portal.entity.PortalFunddetail;
import com.thinkgem.jeesite.modules.sys.entity.Office;

/**
 * 平台资金流动Service
 * @author evan
 * @version 2015-11-21
 */
@Service
@Transactional(readOnly = true)
public class PortalFunddetailService extends CrudService<PortalFunddetailDao, PortalFunddetail> {

	public PortalFunddetail get(String id) {
		return super.get(id);
	}
	
	public List<PortalFunddetail> findList(PortalFunddetail portalFunddetail) {
		return super.findList(portalFunddetail);
	}
	
	public Page<PortalFunddetail> findPage(Page<PortalFunddetail> page, PortalFunddetail portalFunddetail) {
		return super.findPage(page, portalFunddetail);
	}
	
	@Transactional(readOnly = false)
	public PortalFunddetail save(PortalFunddetail portalFunddetail) {
		return super.save(portalFunddetail);
	}
	
	@Transactional(readOnly = false)
	public void delete(PortalFunddetail portalFunddetail) {
		super.delete(portalFunddetail);
	}
	/**
	 * 生成平台资金记录
	 * @param portalFunddetail
	 * @return
	 */
	@Transactional(readOnly = false)
	public PortalFunddetail genPortalFunddetail(Office company,BigDecimal operateCash,
			String businessClassName,String businessId,	BusinessEvent businessEvent) {
		if(FundAbacusUtil.compareToZERO(operateCash) <= 0 ){
			return null;
		}
		PortalFunddetail portalFunddetail = new  PortalFunddetail();
		portalFunddetail.setChangeType(businessEvent);
		portalFunddetail.setOperate(operateCash);
		portalFunddetail.setDirection(FundIO.IN);
		portalFunddetail.setTarget(TargetType.Company);
		portalFunddetail.setTargetId(company.getId());
		portalFunddetail.setBusinessClass(businessClassName);
		portalFunddetail.setBusinessId(businessId);
		
		if(businessEvent == BusinessEvent.cashoutSuccess){//提现成功收取手续费
			portalFunddetail.setDescContent("商户提现手续费");
		}else if(businessEvent == BusinessEvent.settle){// 结算时收取手续费
			portalFunddetail.setDescContent("商户结算手续费");
		}
		
		return super.save(portalFunddetail);
	}
}