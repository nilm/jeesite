/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.accountant.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.accountant.entity.Book;
import com.thinkgem.jeesite.modules.accountant.service.BookService;

/**
 * 会计国标账本(科目)Controller
 * @author nideyuan
 * @version 2017-09-10
 */
@Controller
@RequestMapping(value = "${adminPath}/accountant/book")
public class BookController extends BaseController {

	@Autowired
	private BookService bookService;
	
	@ModelAttribute
	public Book get(@RequestParam(required=false) String id) {
		Book entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = bookService.get(id);
		}
		if (entity == null){
			entity = new Book();
		}
		return entity;
	}
	
	@RequiresPermissions("accountant:book:view")
	@RequestMapping(value = {"list", ""})
	public String list(Book book, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<Book> list = bookService.findList(book); 
		model.addAttribute("list", list);
		return "modules/accountant/bookList";
	}

	@RequiresPermissions("accountant:book:view")
	@RequestMapping(value = "form")
	public String form(Book book, Model model) {
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
		model.addAttribute("book", book);
		return "modules/accountant/bookForm";
	}

	@RequiresPermissions("accountant:book:edit")
	@RequestMapping(value = "save")
	public String save(Book book, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, book)){
			return form(book, model);
		}
		bookService.save(book);
		addMessage(redirectAttributes, "保存会计国标账本(科目)成功");
		return "redirect:"+Global.getAdminPath()+"/accountant/book/?repage";
	}
	
	@RequiresPermissions("accountant:book:edit")
	@RequestMapping(value = "delete")
	public String delete(Book book, RedirectAttributes redirectAttributes) {
		bookService.delete(book);
		addMessage(redirectAttributes, "删除会计国标账本(科目)成功");
		return "redirect:"+Global.getAdminPath()+"/accountant/book/?repage";
	}

	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String extId, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<Book> list = bookService.findList(new Book());
		for (int i=0; i<list.size(); i++){
			Book e = list.get(i);
			if (StringUtils.isBlank(extId) || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1)){
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
				map.put("pId", e.getParentId());
				map.put("name", e.getName());
				mapList.add(map);
			}
		}
		return mapList;
	}
	
}