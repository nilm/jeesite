package com.thinkgem.jeesite.modules.accountant.enums;

import org.apache.ibatis.annotations.Case;

import java.util.ArrayList;
import java.util.List;

/**
 * 资产负债表项目
 * @author Mars9527
 * @create 2017-11-09 上午10:42
 **/
public enum AssetsCategory {

    money_funds("货币资金"),
    trade_finance_funds("交易性金融资产"),
    notes_receivables("应收票据"),
    receivable("应收账款"),
    prepayment("预付款项"),
    interest_receivables("应收利息"),
    dividends_receivables("应收股利"),
    other_receivables("其他应收款"),
    inventory("库存商品"),
    non_current_assets_within_one_year("一年内到期的非流动资产"),
    other_current("其他流动资产"),
    available_for_sale_financial_assets("可供出售金融资产"),
    held_to_maturity_investment("持有至到期投资"),
    long_term_receivables("长期应收款"),
    long_term_equity_investment("长期股权投资"),
    investment_property("投资性房地产"),
    fixed_assets("固定资产"),
    construction_in_process("在建工程"),
    construction_material("工程物资"),
    fixed_assets_pending_for_disposal("固定资产清理"),
    bearer_biological_assets("生产性生物资产"),
    oil_and_gas_assets("油气资产"),
    intangible_assets("无形资产"),
    development_costs("开发支出"),
    goodwill("商誉"),
    long_term_prepaid_expenses("长期待摊费用"),
    deferred_tax_assets("递延所得税资产"),
    other_non_current_assets("其他非流动资产"),
    current_liabilities("流动负债"),
    short_term_borrowings("短期借款"),
    trade_finance_borrowings("交易性金融负债"),
    notes_payable("应付票据"),
    payable("应付账款"),
    advance_receivables("预收款项"),
    employee_benefits_payable("应付职工薪酬"),
    taxes_payable("应交税费"),
    interest_payable("应付利息"),
    dividends_payable("应付股利"),
    other_payables("其他应收款"),
    non_current_liabilities_within_one_year("一年内到期的非流动负债"),
    other_current_liabilities("其他流动负债"),
    long_term_borrowings("长期借款"),
    debentures_payable("应付债券"),
    long_term_payable("长期应付款"),
    payables_for_specific_projects("专项应付款"),
    provisions("预计负债"),
    deferred_tax_liabilities("递延所得税负债"),
    other_non_current_liabilities("其他非流动负债"),
    paid_in_capital("实收资本"),
    capital_surplus("资本公积"),
    surplus_reserve("盈余公积"),
    undistributed_profits("未分配利润"),

    //以下为资产负债表大项
    currentAssets("流动资产"),
    nonCurrentAssets("非流动资产"),
    currentLiabilities("流动负债"),
    nonCurrentLiabilities("非流动流动负债"),
    ownershipInteres("所有者权益");

    private String text;
    private String val;

    AssetsCategory(String text) {
        this.text = text;
    }

    public String getText() {
        return text;
    }
    public String getVal() {
        return toString();
    }


    public void setText(String text) {
        this.text = text;
    }

    private static  List<AssetsCategory> list=new ArrayList<AssetsCategory>();



    /**
     * 根据大项获取明细项集合
     * @return
     */
    public static List<AssetsCategory> getAssetsCategoryListByParent(AssetsCategory ac){
        list.clear();
        if(AssetsCategory.currentAssets==ac) return getCurrentAssets();
        if(AssetsCategory.nonCurrentAssets==ac) return getNonCurrentAssets();
        if(AssetsCategory.currentLiabilities==ac) return getCurrentLiabilities();
        if(AssetsCategory.nonCurrentLiabilities==ac) return getNonCurrentLiabilities();
        if(AssetsCategory.ownershipInteres==ac) return getOwnershipInteres();
        return null;
    }
    /**
     * 获取流动资产项目集合
     * @return
     */
    public static List<AssetsCategory> getCurrentAssets(){
        list.add(money_funds);
        list.add(trade_finance_funds);
        list.add(notes_receivables);
        list.add(receivable);
        list.add(prepayment);
        list.add(interest_receivables);
        list.add(dividends_receivables);
        list.add(other_receivables);
        list.add(inventory);
        list.add(non_current_assets_within_one_year);
        list.add(other_current);
        return list;
    }

    /**
     * 获取非流动资产项目集合
     * @return
     */
    public static List<AssetsCategory> getNonCurrentAssets(){
        list.add(available_for_sale_financial_assets);
        list.add(held_to_maturity_investment);
        list.add(long_term_receivables);
        list.add(long_term_equity_investment);
        list.add(investment_property);
        list.add(fixed_assets);
        list.add(construction_in_process);
        list.add(construction_material);
        list.add(fixed_assets_pending_for_disposal);
        list.add(bearer_biological_assets);
        list.add(oil_and_gas_assets);
        list.add(intangible_assets);
        list.add(development_costs);
        list.add(goodwill);
        list.add(long_term_prepaid_expenses);
        list.add(deferred_tax_assets);
        list.add(other_non_current_assets);
        return list;
    }

    /**
     * 获取流动负债项目集合
     * @return
     */
    public static List<AssetsCategory> getCurrentLiabilities(){
        list.add(short_term_borrowings);
        list.add(trade_finance_borrowings);
        list.add(notes_payable);
        list.add(payable);
        list.add(advance_receivables);
        list.add(employee_benefits_payable);
        list.add(taxes_payable);
        list.add(interest_payable);
        list.add(dividends_payable);
        list.add(other_payables);
        list.add(non_current_liabilities_within_one_year);
        list.add(other_current_liabilities);
        return list;
    }
    /**
     * 获取非流动负债项目集合
     * @return
     */
    public static List<AssetsCategory> getNonCurrentLiabilities(){
        list.add(long_term_borrowings);
        list.add(debentures_payable);
        list.add(long_term_payable);
        list.add(payables_for_specific_projects);
        list.add(provisions);
        list.add(deferred_tax_liabilities);
        list.add(other_non_current_liabilities);
        return list;
    }
    /**
     * 获取所有者权益项目集合
     * @return
     */
    public static List<AssetsCategory> getOwnershipInteres(){
        list.add(paid_in_capital);
        list.add(capital_surplus);
        list.add(surplus_reserve);
        list.add(undistributed_profits);
        return list;
    }
    /**
     * 获取所有者权益项目集合
     * @return
     */
    public static List<AssetsCategory> getALLlist(){
        list = AssetsCategory.getCurrentAssets();
        list = AssetsCategory.getNonCurrentAssets();
        list = AssetsCategory.getCurrentLiabilities();
        list = AssetsCategory.getNonCurrentLiabilities();
        list = AssetsCategory.getOwnershipInteres();
        return list;
    }


    public static void main(String[] args) {
        List<AssetsCategory> list;

//        list = AssetsCategory.getCurrentAssets();
//        list = AssetsCategory.getNonCurrentAssets();
//        list = AssetsCategory.getCurrentLiabilities();
//        list = AssetsCategory.getNonCurrentLiabilities();
        list = AssetsCategory.getOwnershipInteres();
        for (AssetsCategory currentAsset : list) {
            System.out.println(currentAsset.getText());
        }

    }

}
