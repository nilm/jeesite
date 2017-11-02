package com.thinkgem.jeesite.modules.accountant.enums;


public enum BookRecordType {

    CREATE_OPENING("建账期初"), DAILY("日常"), CLOSING("期末"),REPORT("报表");

    private String text;

    BookRecordType(String text) {
        this.text = text;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }
}
