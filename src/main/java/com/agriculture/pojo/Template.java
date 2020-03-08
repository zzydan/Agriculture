package com.agriculture.pojo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class Template implements Serializable {
    private Integer id;

    private Boolean disabled;

    private Date createtime;

    private String name;

    private Integer category;

    private Integer categoryName;

    private Integer variety;

    private Integer varietyName;

    private List<TemplatePlan> templatePlanList;

    public List<TemplatePlan> getTemplatePlanList() {
        return templatePlanList;
    }

    public void setTemplatePlanList(List<TemplatePlan> templatePlanList) {
        this.templatePlanList = templatePlanList;
    }

    public Integer getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(Integer categoryName) {
        this.categoryName = categoryName;
    }

    public Integer getVarietyName() {
        return varietyName;
    }

    public void setVarietyName(Integer varietyName) {
        this.varietyName = varietyName;
    }

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Boolean getDisabled() {
        return disabled;
    }

    public void setDisabled(Boolean disabled) {
        this.disabled = disabled;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public Integer getCategory() {
        return category;
    }

    public void setCategory(Integer category) {
        this.category = category;
    }

    public Integer getVariety() {
        return variety;
    }

    public void setVariety(Integer variety) {
        this.variety = variety;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", disabled=").append(disabled);
        sb.append(", createtime=").append(createtime);
        sb.append(", name=").append(name);
        sb.append(", category=").append(category);
        sb.append(", variety=").append(variety);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}