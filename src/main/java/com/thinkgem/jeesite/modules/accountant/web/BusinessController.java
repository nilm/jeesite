/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.accountant.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.accountant.entity.BizBookTemplate;
import com.thinkgem.jeesite.modules.accountant.entity.Book;
import com.thinkgem.jeesite.modules.accountant.service.BookService;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import groovy.text.markup.TemplateConfiguration;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.accountant.entity.Business;
import com.thinkgem.jeesite.modules.accountant.service.BusinessService;

import java.util.Iterator;
import java.util.List;

/**
 * 发生的业务Controller
 * @author 倪得渊
 * @version 2017-09-10
 */
@Controller
@RequestMapping(value = "${adminPath}/accountant/business")
public class BusinessController extends BaseController {

	@Autowired
	private BusinessService businessService;

	@Autowired
	private BookService bookService;

	@ModelAttribute
	public Business get(@RequestParam(required=false) String id) {
		Business entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = businessService.get(id);
		}
		if (entity == null){
			entity = new Business();
		}
		return entity;
	}
	
	@RequiresPermissions("accountant:business:view")
	@RequestMapping(value = {"list", ""})
	public String list(Business business, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Business> page = businessService.findPage(new Page<Business>(request, response), business); 
		model.addAttribute("page", page);
		return "modules/accountant/businessList";
	}

	@RequiresPermissions("accountant:business:view")
	@RequestMapping(value = "form")
	public String form(Business business,Book book, Model model) {
		List<BizBookTemplate> bizBookTemplateList = business.getBizBookTemplateList();
		for (BizBookTemplate bizBookTemplate : bizBookTemplateList) {
			String lr = bizBookTemplate.getBook().getCategory();
			String bookDisplayName =bizBookTemplate.getBookName()+"（"+ DictUtils.getDictLabel(lr,"accountant_left_right","")+"）";
			bizBookTemplate.setBookName(bookDisplayName);
		}
		business.setBizBookTemplateList(bizBookTemplateList);
		model.addAttribute("business", business);
		if (book.getParent()!=null && StringUtils.isNotBlank(book.getParent().getId())){
			book.setParent(bookService.get(book.getParent().getId()));
			// 获取排序号，最末节点排序号+30
			if (StringUtils.isBlank(book.getId())){
				Book bookChild = new Book();
				bookChild.setParent(new Book(book.getParent().getId()));
				List<Book> list = bookService.findList(book);
				if (list.size() > 0){
					book.setSort(list.get(list.size()-1).getSort());
					if (book.getSort() != null){
						book.setSort(book.getSort() + 30);
					}
				}
			}
		}
		if (book.getSort() == null){
			book.setSort(30);
		}

		model.addAttribute("books",book);
		return "modules/accountant/businessForm";
	}

	@RequiresPermissions("accountant:business:edit")
	@RequestMapping(value = "save")
	public String save(Business business, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, business)){
			return form(business,null, model);
		}
//		List<BizBookTemplate> bizBookTemplateList = business.getBizBookTemplateList();
//		for (BizBookTemplate bizBookTemplate : bizBookTemplateList) {
//			String category = bizBookTemplate.getCategory();
//			if("1".equals(bizBookTemplate.getDirection())){
//				bizBookTemplate.setDirection(category);
//			}else if("-1".equals(bizBookTemplate.getDirection())){
//				if("right".equals(category)) bizBookTemplate.setDirection("left");
//				else if ("left".equals(category)) bizBookTemplate.setDirection("right");
//			}
//		}
		businessService.save(business);
		addMessage(redirectAttributes, "保存会计业务成功");
		return "redirect:"+Global.getAdminPath()+"/accountant/business/?repage";
	}
	
	@RequiresPermissions("accountant:business:edit")
	@RequestMapping(value = "delete")
	public String delete(Business business, RedirectAttributes redirectAttributes) {
		businessService.delete(business);
		addMessage(redirectAttributes, "删除会计业务成功");
		return "redirect:"+Global.getAdminPath()+"/accountant/business/?repage";
	}

}