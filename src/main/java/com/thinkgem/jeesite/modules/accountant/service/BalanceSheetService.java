package com.thinkgem.jeesite.modules.accountant.service;

import com.thinkgem.jeesite.common.utils.money.FundAbacusUtil;
import com.thinkgem.jeesite.modules.accountant.dto.BalanceSheetDto;
import com.thinkgem.jeesite.modules.accountant.dto.BookDto;
import com.thinkgem.jeesite.modules.accountant.entity.Book;
import com.thinkgem.jeesite.modules.accountant.enums.AssetsCategory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

/**
 * 资产负债表相关计算逻辑
 * @author Mars9527
 * @create 2017-11-08 下午3:20
 **/
@Service
@Transactional(readOnly = true)
public class BalanceSheetService {
    @Autowired
    private BookService bookService;


    /**
     * 根据大项获取资产负债表明细项集合
     * @param ac
     * @return
     */

    public List<BalanceSheetDto> findByAssetsCategoryList(AssetsCategory ac) {

        List<AssetsCategory> assetsCategoryList = AssetsCategory.getAssetsCategoryListByParent(ac);
        List<BalanceSheetDto> dtos=new ArrayList<BalanceSheetDto>();
        if(assetsCategoryList!=null){
            for (AssetsCategory assetsCategory : assetsCategoryList) {
                BalanceSheetDto dto=new BalanceSheetDto();
                Book find = new Book();
                find.setAssetsCategory(assetsCategory.name());
                List<BookDto> bookDtos = bookService.findBookDtoByCategoryList(find);
                BigDecimal beginningBalance=new BigDecimal(0);
                BigDecimal endingBalance=new BigDecimal(0);
                if(bookDtos!=null && bookDtos.size()>0){
                    for (BookDto bookDto : bookDtos) {
                        beginningBalance= FundAbacusUtil.add(beginningBalance,bookDto.getBeginningAmount());
                        endingBalance=FundAbacusUtil.add(endingBalance,bookDto.getSumAmount());
                    }
                }
                dto.setAssetsCategory(assetsCategory);
                dto.setBeginningBalance(beginningBalance+"");
                dto.setEndingBalance(endingBalance+"");
                dtos.add(dto);
            }
        }
        return dtos;
    }
}