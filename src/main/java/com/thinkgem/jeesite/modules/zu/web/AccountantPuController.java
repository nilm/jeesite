/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zu.web;

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
import com.thinkgem.jeesite.modules.zu.entity.AccountantPu;
import com.thinkgem.jeesite.modules.zu.service.AccountantPuService;

/**
 * 族谱Controller
 * @author 倪得渊
 * @version 2017-10-06
 */
@Controller
@RequestMapping(value = "${adminPath}/zu/accountantPu")
public class AccountantPuController extends BaseController {

	@Autowired
	private AccountantPuService accountantPuService;
	
	@ModelAttribute
	public AccountantPu get(@RequestParam(required=false) String id) {
		AccountantPu entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = accountantPuService.get(id);
		}
		if (entity == null){
			entity = new AccountantPu();
		}
		return entity;
	}
	
	@RequiresPermissions("zu:accountantPu:view")
	@RequestMapping(value = {"list", ""})
	public String list(AccountantPu accountantPu, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<AccountantPu> list = accountantPuService.findList(accountantPu); 
		model.addAttribute("list", list);
		return "modules/zu/accountantPuList";
	}

	@RequiresPermissions("zu:accountantPu:view")
	@RequestMapping(value = "form")
	public String form(AccountantPu accountantPu, Model model) {
		if (accountantPu.getParent()!=null && StringUtils.isNotBlank(accountantPu.getParent().getId())){
			accountantPu.setParent(accountantPuService.get(accountantPu.getParent().getId()));
			// 获取排序号，最末节点排序号+30
			if (StringUtils.isBlank(accountantPu.getId())){
				AccountantPu accountantPuChild = new AccountantPu();
				accountantPuChild.setParent(new AccountantPu(accountantPu.getParent().getId()));
				List<AccountantPu> list = accountantPuService.findList(accountantPu); 
				if (list.size() > 0){
					accountantPu.setSort(list.get(list.size()-1).getSort());
					if (accountantPu.getSort() != null){
						accountantPu.setSort(accountantPu.getSort() + 30);
					}
				}
			}
		}
		if (accountantPu.getSort() == null){
			accountantPu.setSort(30);
		}
		model.addAttribute("accountantPu", accountantPu);
		return "modules/zu/accountantPuForm";
	}

	@RequiresPermissions("zu:accountantPu:edit")
	@RequestMapping(value = "save")
	public String save(AccountantPu accountantPu, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, accountantPu)){
			return form(accountantPu, model);
		}
		accountantPuService.save(accountantPu);
		addMessage(redirectAttributes, "保存族谱成功");
		return "redirect:"+Global.getAdminPath()+"/zu/accountantPu/?repage";
	}
	
	@RequiresPermissions("zu:accountantPu:edit")
	@RequestMapping(value = "delete")
	public String delete(AccountantPu accountantPu, RedirectAttributes redirectAttributes) {
		accountantPuService.delete(accountantPu);
		addMessage(redirectAttributes, "删除族谱成功");
		return "redirect:"+Global.getAdminPath()+"/zu/accountantPu/?repage";
	}

	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String extId, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<AccountantPu> list = accountantPuService.findList(new AccountantPu());
		for (int i=0; i<list.size(); i++){
			AccountantPu e = list.get(i);
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