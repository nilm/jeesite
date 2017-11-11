/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.accountant.web;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.accountant.dto.BalanceSheetDto;
import com.thinkgem.jeesite.modules.accountant.dto.BookDto;
import com.thinkgem.jeesite.modules.accountant.entity.Book;
import com.thinkgem.jeesite.modules.accountant.entity.BookRecordDetail;
import com.thinkgem.jeesite.modules.accountant.enums.AssetsCategory;
import com.thinkgem.jeesite.modules.accountant.service.BalanceSheetService;
import com.thinkgem.jeesite.modules.accountant.service.BookService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 使用的账本目录列表Controller
 * @author nideyuan
 * @version 2017-09-10
 */
@Controller
@RequestMapping(value = "${adminPath}/accountant/bookusetotal")
public class BookUseTotalController extends BaseController {

	@Autowired
	private BookService bookService;
	@Autowired
	private BalanceSheetService balanceSheetService;

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



	@RequiresPermissions("accountant:bookusetotal:view")
	@RequestMapping(value = {"list", ""})
	public String list(Book book, HttpServletRequest request, HttpServletResponse response, Model model) {
		//TODO: 增加按company查询
//		 book.setCompanyId(UserUtils.getUser().getCompany().getId());

		book.setCategory("left");
		book.setAccountantCategory("assets");

		List<BookDto> assets_category = bookService.findByCategoryList(book);
		model.addAttribute("assets_category", assets_category);

		book.setCategory("left");
		book.setAccountantCategory("expenses");

		List<BookDto> expenses_category = bookService.findByCategoryList(book);
		model.addAttribute("expenses_category", expenses_category);

		book.setCategory("right");
		book.setAccountantCategory("owners_equity");

		List<BookDto> owners_equity_category = bookService.findByCategoryList(book);
		model.addAttribute("owners_equity_category", owners_equity_category);

		book.setCategory("right");
		book.setAccountantCategory("liabilities");

		List<BookDto> liabilities_category = bookService.findByCategoryList(book);
		model.addAttribute("liabilities_category", liabilities_category);

		book.setCategory("right");
		book.setAccountantCategory("income");

		List<BookDto> income_category = bookService.findByCategoryList(book);
		model.addAttribute("income_category", income_category);

		BookRecordDetail left_sum_bookRecordDetail= bookService.getCategorySumAmount("left");

		model.addAttribute("left_sum_bookRecordDetail", left_sum_bookRecordDetail);
		BookRecordDetail right_sum_bookRecordDetail = bookService.getCategorySumAmount("right");
		model.addAttribute("right_sum_bookRecordDetail", right_sum_bookRecordDetail);


		return "modules/accountant/bookUseTotalList";
	}

	/**
	 * 查看明细账
	 * @param book
	 * @param model
	 * @return
	 */
	@RequiresPermissions("accountant:bookusetotal:view")
	@RequestMapping(value = "view")
	public String form(Book book, HttpServletRequest request, HttpServletResponse response,  Model model) {

		book = bookService.get(book.getId());
		model.addAttribute("book", book);
		Page<BookRecordDetail> bookRecordDetailPage = bookService.findBookRecordDetailPage(new Page<BookRecordDetail>(request, response),book);
		model.addAttribute("page", bookRecordDetailPage);
		return "modules/accountant/bookUseViewList";
	}

	/**
	 * 资产负债表
	 * @param book
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("accountant:bookusetotal:view")
	@RequestMapping(value = "getBalanceSheet")
	public String getBalanceSheet(Book book, HttpServletRequest request, HttpServletResponse response, Model model) {

		//TODO: 增加按company查询
		//		 book.setCompanyId(UserUtils.getUser().getCompany().getId());

		List<BalanceSheetDto> currentAssets=balanceSheetService.findByAssetsCategoryList(AssetsCategory.currentAssets);
		model.addAttribute("currentAssets", currentAssets);

		List<BalanceSheetDto> nonCurrentAssets=balanceSheetService.findByAssetsCategoryList(AssetsCategory.nonCurrentAssets);
		model.addAttribute("nonCurrentAssets", nonCurrentAssets);

		List<BalanceSheetDto> currentLiabilities=balanceSheetService.findByAssetsCategoryList(AssetsCategory.currentLiabilities);
		model.addAttribute("currentLiabilities", currentLiabilities);

		List<BalanceSheetDto> nonCurrentLiabilities=balanceSheetService.findByAssetsCategoryList(AssetsCategory.nonCurrentLiabilities);
		model.addAttribute("nonCurrentLiabilities", nonCurrentLiabilities);

		List<BalanceSheetDto> ownershipInteres=balanceSheetService.findByAssetsCategoryList(AssetsCategory.ownershipInteres);
		model.addAttribute("ownershipInteres", ownershipInteres);
		return "modules/accountant/bookUseBalanceSheet";
	}

}