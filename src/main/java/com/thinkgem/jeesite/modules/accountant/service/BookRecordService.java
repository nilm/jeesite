/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.accountant.service;

import java.math.BigDecimal;
import java.util.List;

import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.money.Bead;
import com.thinkgem.jeesite.common.utils.money.FundAbacusUtil;
import com.thinkgem.jeesite.modules.accountant.dao.*;
import com.thinkgem.jeesite.modules.accountant.entity.*;
import com.thinkgem.jeesite.modules.accountant.enums.BookRecordType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;

import static com.thinkgem.jeesite.common.utils.money.FundAbacusUtil.*;

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
	private BusinessDao businessDao;
	@Autowired
	private AttachmentDao attachmentDao;
	@Autowired
	private BookRecordDetailDao bookRecordDetailDao;

	@Autowired
	private BizBookTemplateDao bizBookTemplateDao;

	public BookRecord get(BookRecord rec) {
		BookRecord bookRecord = super.get(rec);
		if(bookRecord!=null && bookRecord.getId()!=null) {
			bookRecord.setAttachmentList(attachmentDao.findList(new Attachment(bookRecord)));
			bookRecord.setBookRecordDetailList(bookRecordDetailDao.findList(new BookRecordDetail(bookRecord)));
		}
		return bookRecord;
	}
	public BookRecord get(String id) {
		BookRecord bookRecord = super.get(id);
		if(bookRecord!=null) {
			bookRecord.setAttachmentList(attachmentDao.findList(new Attachment(bookRecord)));
			List<BookRecordDetail> list = bookRecordDetailDao.findList(new BookRecordDetail(bookRecord));
			bookRecord.setBookRecordDetailList(list);
		}
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
//		处理摘要 没填在使用业务名称 digest
		String bizId = bookRecord.getBizId();
		Business biz = null;
		if(StringUtils.isBlank(bizId) == false){
			biz = businessDao.get(bizId);
		}
		String digest = "".equals(bookRecord.getDigest())?biz.getName():bookRecord.getDigest();
		bookRecord.setDigest(digest);

		super.save(bookRecord);
		if(filesPath!=null){
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
					bookRecordDetail.setBookRecordType(bookRecord.getBookRecordType());

					String bookId = bookRecordDetail.getBookId();
					bookRecordDetail.setBook(bookDao.get(bookId));

					String amount = bookRecordDetail.getAmount();
					String direc="";//此为凭证的左右方向
					try {
						if(amount.contains(",")){
							String[] amounts = amount.split(",");
							if(amounts.length==0) {
								continue;
							}else if(amounts.length==1) {
								amount=amounts[0];
								direc="left";
							}else {
								BigDecimal leftAmount= "".equals(amounts[0]) ? new BigDecimal(0) : new BigDecimal(amounts[0]);
								BigDecimal rightAmount= "".equals(amounts[1]) ? new BigDecimal(0) : new BigDecimal(amounts[1]);
								if(leftAmount.compareTo(BigDecimal.ZERO)==0 && rightAmount.compareTo(BigDecimal.ZERO)==0){
									//左右金额都为0
								}else if (leftAmount.compareTo(BigDecimal.ZERO)!=0 && rightAmount.compareTo(BigDecimal.ZERO)==0){
									//左金额不为0
									amount=leftAmount+"";
									direc="left";
								}else if (leftAmount.compareTo(BigDecimal.ZERO)==0 && rightAmount.compareTo(BigDecimal.ZERO)!=0){
									//右金额不为0
									amount=rightAmount+"";
									direc="right";
								}
							}
						}else {
							// 获取业务模板
//							 bizId = bookRecordDetail.getRecord().getBizId();
							// 根据业务 与 账本 查询 业务模板
							BizBookTemplate bizBookTemplate4search = new BizBookTemplate();
							bizBookTemplate4search.setBiz(new Business(bizId));
							bizBookTemplate4search.setBook(new Book(bookId));
							BizBookTemplate bizBookTemplate = bizBookTemplateDao.findByBizAndBook(bizBookTemplate4search);
							direc=bizBookTemplate.getDirection();

						}
						bookRecordDetail.setDirection(direc);
						bookRecordDetail.setAmount(amount);
					} catch (NullPointerException e) {
						continue;
					} 

					handleBalance(bookRecordDetail);
//					switch (bookRecord.getBookRecordType()) {
//						case CREATE_OPENING:{
//							bookRecordDetail.setBalance(amount.toString());
//							break;
//						}
//					}
					bookRecordDetail.setRecordTimestamp(DateUtils.getCurrentTimeMillis());
					bookRecordDetail.setRecordDate(bookRecord.getRecordDate());
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


		// 获取本账本最后一笔记录
		List<BookRecordDetail> bookRecordDetails = bookRecordDetailDao.getLastDetailByBook(bookRecordDetail);
		BookRecordDetail lastbookRecordDetail = (bookRecordDetails!= null && bookRecordDetails.size()>0) ? bookRecordDetails.get(0):null;
		BigDecimal initAmont = BigDecimal.ZERO;
		if (lastbookRecordDetail != null ){
			String lastBalance = lastbookRecordDetail.getBalance();
			initAmont = new BigDecimal(lastBalance);
		}else{
			logger.warn("本账本未进行期初设置");
			//TODO: 正常情况需要爆出异常， 即需要先设置期初值
		}
		doPlusOrMinus_v2(bookRecordDetail, initAmont);
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
			finalBalance = add(initAmont,bookRecordDetail.getAmount());
			bookRecordDetail.setDirection("1");
		}else {
			finalBalance = subtract(initAmont,bookRecordDetail.getAmount());
			bookRecordDetail.setDirection("-1");
		}
		bookRecordDetail.setBalance(finalBalance.toString());
	}

	/**
	 *
	 * @param bookRecordDetail
	 * @param initAmont
	 */
	private void doPlusOrMinus_v2(BookRecordDetail bookRecordDetail,BigDecimal initAmont){
		BigDecimal finalBalance = BigDecimal.ZERO;
		//栏位方向与账本方向一致为增，不一致为减
		if(bookRecordDetail.getDirection().equalsIgnoreCase(bookRecordDetail.getBook().getCategory())){
			finalBalance = add(initAmont,bookRecordDetail.getAmount());
		}else {
			finalBalance = subtract(initAmont,bookRecordDetail.getAmount());
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