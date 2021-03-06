package com.agriculture.pojo;

import java.io.Serializable;
import java.util.Date;

public class TemplatePlanAgricultural implements Serializable {
    private Integer id;

    private Boolean disabled;

    private Date createtime;

    private String trxfl;

    private String nzmc;

    private String yl;

    private String danwei;

    private Integer planId;

    public String getDanwei() {
        return danwei;
    }

    public void setDanwei(String danwei) {
        this.danwei = danwei;
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

    public String getTrxfl() {
        return trxfl;
    }

    public void setTrxfl(String trxfl) {
        this.trxfl = trxfl == null ? null : trxfl.trim();
    }

    public String getNzmc() {
        return nzmc;
    }

    public void setNzmc(String nzmc) {
        this.nzmc = nzmc == null ? null : nzmc.trim();
    }

    public String getYl() {
        return yl;
    }

    public void setYl(String yl) {
        this.yl = yl == null ? null : yl.trim();
    }

    public Integer getPlanId() {
        return planId;
    }

    public void setPlanId(Integer planId) {
        this.planId = planId;
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
        sb.append(", trxfl=").append(trxfl);
        sb.append(", nzmc=").append(nzmc);
        sb.append(", yl=").append(yl);
        sb.append(", planId=").append(planId);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}