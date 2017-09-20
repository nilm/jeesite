/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.accountant.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.accountant.entity.SourceDoc;
import com.thinkgem.jeesite.modules.accountant.dao.SourceDocDao;
import com.thinkgem.jeesite.modules.accountant.entity.SourceDocAttachment;
import com.thinkgem.jeesite.modules.accountant.dao.SourceDocAttachmentDao;
import com.thinkgem.jeesite.modules.accountant.entity.SourceDocSubject;
import com.thinkgem.jeesite.modules.accountant.dao.SourceDocSubjectDao;

/**
 * 原始业务记录Service
 * @author 倪得渊
 * @version 2017-09-16
 */
@Service
@Transactional(readOnly = true)
public class SourceDocService extends CrudService<SourceDocDao, SourceDoc> {

	@Autowired
	private SourceDocAttachmentDao sourceDocAttachmentDao;
	@Autowired
	private SourceDocSubjectDao sourceDocSubjectDao;
	
	public SourceDoc get(String id) {
		SourceDoc sourceDoc = super.get(id);
//		sourceDoc.setSourceDocAttachmentList(sourceDocAttachmentDao.findList(new SourceDocAttachment(sourceDoc)));
		sourceDoc.setSourceDocSubjectList(sourceDocSubjectDao.findList(new SourceDocSubject(sourceDoc)));
		return sourceDoc;
	}
	
	public List<SourceDoc> findList(SourceDoc sourceDoc) {
		return super.findList(sourceDoc);
	}
	
	public Page<SourceDoc> findPage(Page<SourceDoc> page, SourceDoc sourceDoc) {
		return super.findPage(page, sourceDoc);
	}
	
	@Transactional(readOnly = false)
	public SourceDoc save(SourceDoc sourceDoc,String  filesPath) {

		sourceDoc = super.save(sourceDoc);

//		for (SourceDocAttachment sourceDocAttachment : sourceDoc.getSourceDocAttachmentList()){
//			if (sourceDocAttachment.getId() == null){
//				continue;
//			}
//			if (SourceDocAttachment.DEL_FLAG_NORMAL.equals(sourceDocAttachment.getDelFlag())){
//				if (StringUtils.isBlank(sourceDocAttachment.getId())){
//					sourceDocAttachment.setSourceDocId(sourceDoc);
//					sourceDocAttachment.preInsert();
//					sourceDocAttachmentDao.insert(sourceDocAttachment);
//				}else{
//					sourceDocAttachment.preUpdate();
//					sourceDocAttachmentDao.update(sourceDocAttachment);
//				}
//			}else{
//				sourceDocAttachmentDao.delete(sourceDocAttachment);
//			}
//		}

		for (SourceDocSubject sourceDocSubject : sourceDoc.getSourceDocSubjectList()){
			if (sourceDocSubject.getId() == null){
				continue;
			}
			if (SourceDocSubject.DEL_FLAG_NORMAL.equals(sourceDocSubject.getDelFlag())){
				if (StringUtils.isBlank(sourceDocSubject.getId())){
					sourceDocSubject.setSourceDoc(sourceDoc);
//					sourceDocSubject.setSubject();
					sourceDocSubject.preInsert();
					sourceDocSubjectDao.insert(sourceDocSubject);
				}else{
					sourceDocSubject.preUpdate();
					sourceDocSubjectDao.update(sourceDocSubject);
				}
			}else{
				sourceDocSubjectDao.delete(sourceDocSubject);
			}
		}
	return sourceDoc;
	}
	
	@Transactional(readOnly = false)
	public void delete(SourceDoc sourceDoc) {
		super.delete(sourceDoc);
		sourceDocAttachmentDao.delete(new SourceDocAttachment(sourceDoc));
		sourceDocSubjectDao.delete(new SourceDocSubject(sourceDoc));
	}
	
}