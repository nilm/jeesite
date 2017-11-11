package com.thinkgem.jeesite.modules.accountant.dto;

import com.thinkgem.jeesite.modules.accountant.enums.AssetsCategory;

/**
 * @author Mars9527
 * @create 2017-11-10 上午9:27
 **/
public class BalanceSheetDto {

    private AssetsCategory assetsCategory;//资产负债表项目

    private String beginningBalance;//期初余额

    private String endingBalance;//期末余额

    public AssetsCategory getAssetsCategory() {
        return assetsCategory;
    }

    public void setAssetsCategory(AssetsCategory assetsCategory) {
        this.assetsCategory = assetsCategory;
    }

    public String getBeginningBalance() {
        return beginningBalance;
    }

    public void setBeginningBalance(String beginningBalance) {
        this.beginningBalance = beginningBalance;
    }

    public String getEndingBalance() {
        return endingBalance;
    }

    public void setEndingBalance(String endingBalance) {
        this.endingBalance = endingBalance;
    }

}