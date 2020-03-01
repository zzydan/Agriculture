package com.agriculture.pojo;

import java.io.Serializable;
import java.util.Date;

public class TemplatePlan implements Serializable {
    private Integer id;

    private Boolean disabled;

    private Date createtime;

    private String title;

    private String sysq;

    private String ns;

    private String templateId;

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

    public String getSysq() {
        return sysq;
    }

    public void setSysq(String sysq) {
        this.sysq = sysq == null ? null : sysq.trim();
    }

    public String getNs() {
        return ns;
    }

    public void setNs(String ns) {
        this.ns = ns == null ? null : ns.trim();
    }

    public String getTemplateId() {
        return templateId;
    }

    public void setTemplateId(String templateId) {
        this.templateId = templateId == null ? null : templateId.trim();
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