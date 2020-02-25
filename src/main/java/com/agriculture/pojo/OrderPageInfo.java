package com.agriculture.pojo;

import java.io.Serializable;

/**
 * @program: zhny
 * @description: bootstrapTable分页信息
 * @author: 罗子鉴
 * @create: 2019-03-27 09:50
 **/
public class OrderPageInfo implements Serializable {
    //当前页面数据条数
    private Integer limit;
    //页面数据的的行数
    private Integer offset;
    //排序的字段
    private String sort;
    //排序的规则  desc和asc
    private String order;

    private Integer disabled;

    private String startTime;

    private String endTime;
    //角色分页
    private String username;
    private String roleId;


    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public Integer getDisabled() {
        return disabled;
    }

    public void setDisabled(Integer disabled) {
        this.disabled = disabled;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getRoleId() {
        return roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }



    public Integer getLimit() {
        return limit;
    }

    public void setLimit(Integer limit) {
        this.limit = limit;
    }

    public Integer getOffset() {
        return offset;
    }

    public void setOffset(Integer offset) {
        this.offset = offset;
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public String getOrder() {
        return order;
    }

    public void setOrder(String order) {
        this.order = order;
    }

    @Override
    public String toString() {
        return "LogsPageInfo{" +
                "limit=" + limit +
                ", offset=" + offset +
                ", sort='" + sort + '\'' +
                ", order='" + order + '\'' +
                '}';
    }
}

