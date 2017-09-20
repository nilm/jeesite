package com.thinkgem.jeesite.modules.accountant.dto;

/**
 * Created by 倪得渊 on 2017/9/16.
 */
public class BizBookTemplateDto {
     private String bizId;		// 业务 父类
    private String subjectId;		// 账本
    private String subjectName;		// 账本
    private String direction;		// 方向
    private String lrDirection;		// 方向
    private String fixed;		// 定选否
    private String selectType;		// 单选 多选
    private String groupTag;		// 组别辨识-- 同一业务不同组标识不一样
    private String category;		// 账本类型
    private String status;		// 当前状态

    public String getBizId() {
        return bizId;
    }

    public void setBizId(String bizId) {
        this.bizId = bizId;
    }

    public String getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(String subjectId) {
        this.subjectId = subjectId;
    }

    public String getDirection() {
        return direction;
    }

    public void setDirection(String direction) {
        this.direction = direction;
    }

    public String getFixed() {
        return fixed;
    }

    public void setFixed(String fixed) {
        this.fixed = fixed;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    public String getLrDirection() {
        return lrDirection;
    }

    public void setLrDirection(String lrDirection) {
        this.lrDirection = lrDirection;
    }

    public String getSelectType() {
        return selectType;
    }

    public void setSelectType(String selectType) {
        this.selectType = selectType;
    }

    public String getGroupTag() {
        return groupTag;
    }

    public void setGroupTag(String groupTag) {
        this.groupTag = groupTag;
    }
}
