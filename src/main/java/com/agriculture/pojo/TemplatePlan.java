package com.agriculture.pojo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class TemplatePlan implements Serializable {
    private Integer id;

    private Boolean disabled;

    private Date createtime;

    private String title;

    private Integer sysq;

    private Integer ns;

    private Integer templateId;

    private List<TemplatePlanAgricultural> templatePlanAgriculturalList;

    public List<TemplatePlanAgricultural> getTemplatePlanAgriculturalList() {
        return templatePlanAgriculturalList;
    }

    public void setTemplatePlanAgriculturalList(List<TemplatePlanAgricultural> templatePlanAgriculturalList) {
        this.templatePlanAgriculturalList = templatePlanAgriculturalList;
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

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public Integer getSysq() {
        return sysq;
    }

    public void setSysq(Integer sysq) {
        this.sysq = sysq ;
    }

    public Integer getNs() {
        return ns;
    }

    public void setNs(Integer ns) {
        this.ns = ns;
    }

    public Integer getTemplateId() {
        return templateId;
    }

    public void setTemplateId(Integer templateId) {
        this.templateId = templateId;
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
        sb.append(", title=").append(title);
        sb.append(", sysq=").append(sysq);
        sb.append(", ns=").append(ns);
        sb.append(", templateId=").append(templateId);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}