package com.thinkgem.jeesite.modules.accountant.web;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.accountant.entity.*;
import com.thinkgem.jeesite.modules.accountant.enums.BookRecordType;
import com.thinkgem.jeesite.modules.accountant.service.BizBookTemplateService;
import com.thinkgem.jeesite.modules.accountant.service.BookRecordService;
import com.thinkgem.jeesite.modules.accountant.service.BookService;
import com.thinkgem.jeesite.modules.accountant.service.BusinessService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

/**
 * 科目期初
 * @author Mars9527
 * @date 2017年10月11日
 */
@Controller
@RequestMapping(value = "${adminPath}/accountant/opening")
public class AccountOpeningController extends BaseController {
	@Autowired
	private BookRecordService bookRecordService;
	@Autowired
	private BusinessService businessService;
	@Autowired
	private BizBookTemplateService bizBookTemplateService;
	@Autowired
	private BookService bookervice;

	@ModelAttribute
	public BookRecord get(@RequestParam(required=false) String id) {
		BookRecord entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = bookRecordService.get(id);
		}
		if (entity == null){
			entity = new BookRecord();
		}
		return entity;
	}
	/**
	 * 预览
	 * @param bookRecord
	 * @param model
	 * @return
	 * @author Mars9527
	 * @date 2017年10月11日
	 */
	@RequiresPermissions("accountant:bookRecord:view")
	@RequestMapping(value = {"list", ""})
	public String view(BookRecord bookRecord, Model model) {
		model.addAttribute("bookRecord", bookRecord);

		return "modules/accountant/accountOpeningList";
	}
	/**
	 * 跳到新增或者编辑页面
	 * @param bookRecord
	 * @param model
	 * @return
	 * @author Mars9527
	 * @date 2017年10月11日
	 */
	@RequiresPermissions("accountant:bookRecord:edit")
	@RequestMapping(value = {"form"})
	public String form(BookRecord bookRecord, Model model) {

		if(bookRecord.getId()==null || "".equals(bookRecord.getId())){
			BookRecord search = new BookRecord();
			search.setBookRecordType(BookRecordType.CREATE_OPENING);
			List<BookRecord> list = bookRecordService.findList(search);
			if(list!=null && list.size()>0){
				bookRecord = bookRecordService.get(list.get(0).getId());
			}
//            bookRecord=list.get(0);
//			bookRecord= bookRecordService.get(search);
		}
		Business business = new Business();
		business.setDelFlag("0");
		business.setName("账本期初");
		List<Business> businesses = businessService.findList(business);
		Business biz = businesses.get(0);
		if(bookRecord.getRecordDate()==null) bookRecord.setRecordDate(new Date());
		model.addAttribute("businesses",businesses);
		model.addAttribute("bookRecord", bookRecord);
		return "modules/accountant/accountOpeningForm";
	}
	@RequiresPermissions("accountant:bookRecord:edit")
	@RequestMapping(value = "save")
	public String save(BookRecord bookRecord, HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {

		bookRecord.setUser(UserUtils.getUser());
		bookRecord.setCompany(UserUtils.getUser().getCompany());
		bookRecord.setStatus("user_record");
		bookRecord.setBookRecordType(BookRecordType.CREATE_OPENING);
		String filesPath = request.getParameter("filesPath");

		if (!beanValidator(model, bookRecord)){
			return form(bookRecord, model);
		}
		bookRecordService.save(bookRecord,filesPath);
		addMessage(redirectAttributes, "保存账本记录成功");
		return "redirect:"+ Global.getAdminPath()+"/accountant/opening/";
	}
}
