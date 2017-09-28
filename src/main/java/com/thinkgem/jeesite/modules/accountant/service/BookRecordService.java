/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.accountant.service;

import java.math.BigDecimal;
import java.util.List;

import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.money.FundAbacusUtil;
import com.thinkgem.jeesite.modules.accountant.dao.*;
import com.thinkgem.jeesite.modules.accountant.entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sun.tools.classfile.Annotation.element_value;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;

/**
 * 账本记录Service
 * @author 倪得渊
 * @version 2017-09-24
 */
@Service
@Transactional(readOnly = true)
public class BookRecordService extends CrudService<BookRecordDao, BookRecord> {

	@Autowired
	private BookDao bookDao;
	@Autowired
	private AttachmentDao attachmentDao;
	@Autowired
	private BookRecordDetailDao bookRecordDetailDao;

	@Autowired
	private BizBookTemplateDao bizBookTemplateDao;

	public BookRecord get(String id) {
		BookRecord bookRecord = super.get(id);
		bookRecord.setAttachmentList(attachmentDao.findList(new Attachment(bookRecord)));
		bookRecord.setBookRecordDetailList(bookRecordDetailDao.findList(new BookRecordDetail(bookRecord)));
		return bookRecord;
	}
	
	public List<BookRecord> findList(BookRecord bookRecord) {
		return super.findList(bookRecord);
	}
	
	public Page<BookRecord> findPage(Page<BookRecord> page, BookRecord bookRecord) {
		return super.findPage(page, bookRecord);
	}
	
	@Transactional(readOnly = false)
	public BookRecord save(BookRecord bookRecord,String filesPath) {
		super.save(bookRecord);
		String[] filesPathArray = filesPath.split("\\|");
		if(filesPathArray != null && filesPathArray.length > 0){
			for (String filePath :filesPathArray){

				if(StringUtils.isBlank(filePath.trim()) || "|".equals(filePath.trim())){
					continue;
				}
				Attachment attachment = new Attachment(bookRecord);
				attachment.setCreateDate(bookRecord.getCreateDate());
				attachment.setFilesPath(filePath);
				attachment.setDelFlag(Attachment.DEL_FLAG_NORMAL);
				if(filePath.contains("."))
				attachment.setType(filePath.substring(filePath.lastIndexOf("."),filePath.length()));
				attachment.preInsert();
				attachmentDao.insert(attachment);
			}
		}
//		for (Attachment attachment : bookRecord.getAttachmentList()){
//			if (attachment.getId() == null){
//				continue;
//			}
//			if (Attachment.DEL_FLAG_NORMAL.equals(attachment.getDelFlag())){
//				if (StringUtils.isBlank(attachment.getId())){
//					attachment.setBookId(bookRecord);
//					attachment.preInsert();
//					attachmentDao.insert(attachment);
//				}else{
//					attachment.preUpdate();
//					attachmentDao.update(attachment);
//				}
//			}else{
//				attachmentDao.delete(attachment);
//			}
//		}
		for (BookRecordDetail bookRecordDetail : bookRecord.getBookRecordDetailList()){
			if (bookRecordDetail.getId() == null || ""==bookRecordDetail.getId()){
				continue;
			}
			if (BookRecordDetail.DEL_FLAG_NORMAL.equals(bookRecordDetail.getDelFlag())){
				if (StringUtils.isBlank(bookRecordDetail.getId())){
					bookRecordDetail.preInsert();
					bookRecordDetail.setCreateDate(bookRecord.getCreateDate());
					bookRecordDetail.setRecord(bookRecord);
					String amount = bookRecordDetail.getAmount();
					try {
						if(amount.contains(",")){
							String[] amounts = amount.split(",");
							if(amounts.length==0) {
								continue;
							}else if(amounts.length==1) {
								amount=amounts[0];
							}else {
								BigDecimal rightAmount=new BigDecimal(amounts[1]);
								amount=rightAmount+"";
							}
						}
					} catch (NullPointerException e) {
						continue;
					} 
					bookRecordDetail.setAmount(amount);
					
					handleBalance(bookRecordDetail);
//TODO: 规则检验  有左必有右 左右必相等
					bookRecordDetailDao.insert(bookRecordDetail);
				}else{
					// 不做更新处理  只能冲销处理
//					bookRecordDetail.preUpdate();
//					bookRecordDetailDao.update(bookRecordDetail);
				}
			}else{
				bookRecordDetailDao.delete(bookRecordDetail);
			}
		}
	return bookRecord;
	}

	private void handleBalance(BookRecordDetail bookRecordDetail) {
		// 获取业务模板
		String bizId = bookRecordDetail.getRecord().getBizId();
		String bookId = bookRecordDetail.getBookId();
		bookRecordDetail.setBook(bookDao.get(bookId));
		// 根据业务 与 账本 查询 业务模板
		BizBookTemplate bizBookTemplate4search = new BizBookTemplate();
		bizBookTemplate4search.setBiz(new Business(bizId));
		bizBookTemplate4search.setBook(new Book(bookId));

		BizBookTemplate bizBookTemplate = bizBookTemplateDao.findByBizAndBook(bizBookTemplate4search);
		String direction = bizBookTemplate.getDirection();

		// 获取本账本最后一笔记录
		List<BookRecordDetail> bookRecordDetails = bookRecordDetailDao.getLastDetailByBook(bookRecordDetail.getBook());
		BookRecordDetail lastbookRecordDetail = (bookRecordDetails!= null && bookRecordDetails.size()>0) ? bookRecordDetails.get(0):null;
		BigDecimal initAmont = BigDecimal.ZERO;
		if (lastbookRecordDetail != null ){
			String lastBalance = lastbookRecordDetail.getBalance();
			initAmont = new BigDecimal(lastBalance);
		}else{
			logger.warn("本账本未进行期初设置");
			//TODO: 正常情况需要爆出异常， 即需要先设置期初值
		}

		doPlusOrMinus(bookRecordDetail, initAmont, bookRecordDetail.getAmount(),direction);

		bookRecordDetail.setRecordTimestamp(DateUtils.getCurrentTimeMillis());
	}

	/**
	 * 设置账本的具体值
	 * @param bookRecordDetail
	 * @param initAmont
	 * @param currentAmount
	 * @param direction
	 */
	private void doPlusOrMinus(BookRecordDetail bookRecordDetail,BigDecimal initAmont,String currentAmount,String direction){
		BigDecimal finalBalance = BigDecimal.ZERO;
		//本账本在本业务的增减方向 1 增 -1减  对应字典 accountant_biz_plus_minus
		if("1".equals(direction)){
			finalBalance = FundAbacusUtil.add(initAmont,bookRecordDetail.getAmount());
			bookRecordDetail.setDirection("1");
		}else {
			finalBalance = FundAbacusUtil.subtract(initAmont,bookRecordDetail.getAmount());
			bookRecordDetail.setDirection("-1");
		}
		bookRecordDetail.setBalance(finalBalance.toString());
	}

	@Transactional(readOnly = false)
	public void delete(BookRecord bookRecord) {
		super.delete(bookRecord);
		attachmentDao.delete(new Attachment(bookRecord));
		bookRecordDetailDao.delete(new BookRecordDetail(bookRecord));
	}
	
}