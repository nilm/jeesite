/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.accountant.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
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

import com.alibaba.druid.support.json.JSONUtils;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.accountant.dao.BookDao;
import com.thinkgem.jeesite.modules.accountant.dto.BookDto;
import com.thinkgem.jeesite.modules.accountant.entity.Book;
import com.thinkgem.jeesite.modules.accountant.service.BookService;
import com.thinkgem.jeesite.modules.base.entity.WebUser;
import com.thinkgem.jeesite.modules.sys.entity.Menu;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

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
	public String delete(Book book, RedirectAttributes redirectAttributes,@RequestParam(required=false) String id) {
		if(id!=null && id!=""){
			book = bookService.get(id);
		}
		bookService.delete(book);
		addMessage(redirectAttributes, "删除会计国标账本(科目)成功");
		return "redirect:"+Global.getAdminPath()+"/accountant/book/listShow?repage";
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
				map.put("name", e.getCode()+" "+e.getName());
				mapList.add(map);
			}
		}
		return mapList;
	}
	
	@RequiresPermissions("accountant:book:import:view")
	@RequestMapping(value = "listView")
	public String listView(HttpServletRequest request, Model model) {
		List<Map<Object, Object>> mapList = Lists.newArrayList();
		Book form = new Book();
		Book b = new Book();
		b.setId("0");
		form.setParent(b);form.setCompanyId("");
		List<Book> nodes = bookService.findList(form);
		List<Map<String,Object>> tempDate=new ArrayList<Map<String,Object>>();
		for(Book node:nodes){
			Map<String,Object> obj=this.changeFunToMap(node);
			form.setParent(node);
			List<Book> bookList = bookService.findList(form);
			if(bookList!=null && bookList.size()>0){
				List<Map<String,Object>> chileList=new ArrayList<Map<String,Object>>();
				for (Book book : bookList) {
					Map<String,Object> childMap=this.changeFunToMap(book);
					chileList.add(childMap);
				}
				if(chileList.size()>0){
					obj.put("children",chileList);
				}
			}
			tempDate.add(obj);
		}
		List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
//		model.addAttribute("list", JSONUtils.toJSONString(tempDate));
		List<Book> books = bookService.findList(new Book());
		for (Book book : books) {
			Map<String,Object> obj=this.changeFunToMap2(book);
			list.add(obj);
		}
		model.addAttribute("list", JSONUtils.toJSONString(list));
		return "modules/accountant/book/bookListView";
	}
	public Map<String, Object> changeFunToMap(Book childNode) {
		Map<String,Object> obj=new HashMap<String, Object>();
		obj.put("name",childNode.getName());
		obj.put("id", childNode.getId());
		return obj;
	}
	public Map<String, Object> changeFunToMap2(Book childNode) {
		Map<String,Object> obj=new HashMap<String, Object>();
		obj.put("name",childNode.getName());
		obj.put("id", childNode.getId());
		if(childNode.getParent()!=null){
			obj.put("pId", childNode.getParent().getId());
			obj.put("open", true);
		}else{
			obj.put("pId", "0");
		}
		return obj;
	}
	
	@RequiresPermissions("accountant:book:import:edit")
	@RequestMapping(value = "add")
	@ResponseBody
	public String add(HttpServletRequest request, Model model) {
		String ids = request.getParameter("ids");
		String[] idsArray = ids.split(",");
		User user = UserUtils.getUser();
		for (String id : idsArray) {
			Book book = bookService.get(id);
			Book b = new Book();
			b.setAccountantCategory(book.getAccountantCategory());
			b.setAssetsCategory(book.getAssetsCategory());
			b.setAssistCode(book.getAssistCode());
			b.setCategory(book.getCategory());
			b.setCreateBy(user);
			b.setCode(book.getCode());
			b.setCompanyId(user.getCompany().getId());
			b.setCreateDate(new Date());
			b.setCurrentUser(user);
			b.setDelFlag(book.getDelFlag());
			b.setFinalStage(book.getFinalStage());
			b.setIsNewRecord(book.getIsNewRecord());
			b.setName(book.getName());
			b.setParent(book.getParent());
			b.setParentIds(book.getParentIds());
			b.setProfitsCategory(book.getProfitsCategory());
			b.setProperty(book.getProperty());
			b.setRemarks(book.getRemarks());
			b.setStatus(book.getStatus());
			b.setType(book.getType());
			b.setUser(user);
			bookService.save(b);
		}
		return "success";
	}
	
	@RequiresPermissions("accountant:book:my:view")
	@RequestMapping(value = "listShow")
	public String listShow(HttpServletRequest request, Model model) {
		List<Book> list = Lists.newArrayList();
		User user = UserUtils.getUser();
		Book form = new Book();
//		form.setCompanyId(user.getCompany().getId());
		List<Book> sourcelist = bookService.findList(form);
		sortList(list,sourcelist,"0",true);
		model.addAttribute("list", list);
		return "modules/accountant/book/bookListShow";
	}
	
	@RequiresPermissions("accountant:book:my:edit")
	@RequestMapping(value = "bookform")
	public String formBook(Book book, Model model) {
//		if (book.getParent()==null||book.getParent().getId()==null){
//			book.setParent(new Book("0"));
//		}
		book.setParent(bookService.get(book.getParent().getId()));
		// 获取排序号，最末节点排序号+30
		if (StringUtils.isBlank(book.getId())){
			List<Book> list = Lists.newArrayList();
			User user = UserUtils.getUser();
			Book form = new Book();
//			form.setCompanyId(user.getCompany().getId());
			List<Book> sourcelist = bookService.findList(form);
			sortList(list,sourcelist,book.getParentId(),false);
		}
		model.addAttribute("menu", book);
		return "modules/accountant/book/bookForm";
	}
	
	@RequiresPermissions("accountant:book:my:edit")
	@RequestMapping(value = "savechild")
	public String savechild(Book book, Model model, RedirectAttributes redirectAttributes) {
		if(!UserUtils.getUser().isAdmin()){
			addMessage(redirectAttributes, "越权操作，只有超级管理员才能添加或修改数据！");
			return "redirect:" + adminPath + "/sys/role/?repage";
		}
		if(book.getParent()==null){
			addMessage(redirectAttributes, "父账本不能为空");
		}
		bookService.saveChild(book);
		addMessage(redirectAttributes, "保存菜单'" + book.getName() + "'成功");
		return "redirect:" + adminPath + "/accountant/book/listShow";
	}
	
	/***
	 * 递归处理节点的关系（谁是谁的父节点、子节点）
	 * @param list
	 * @param sourcelist
	 * @param parentId
	 * @param cascade
	 */
	private void sortList(List<Book> list,List<Book> sourcelist,String parentId,Boolean cascade){
		for(int i=0;i<sourcelist.size();i++){
			Book book = sourcelist.get(i);
			if(book.getParent()!=null && book.getParent().getId().equals(parentId)){
				list.add(book);
				if(cascade){
					for(int j=0;j<sourcelist.size();j++){
						Book b = sourcelist.get(j);
						if(b.getParent()!=null && b.getParent().getId().equals(book.getId())){
							sortList(list,sourcelist,book.getId(),true);
							break;
						}
					}
				}
			}
		}
	}
}