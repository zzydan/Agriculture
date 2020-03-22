package com.agriculture.pojo;

import java.io.Serializable;
import java.util.Date;

public class CropGrowthCycleTime implements Serializable {
    private Integer id;

    private Boolean disabled;

    private Date createtime;

    private String cropGrowthCycleId;

    private String sysqmc;

    private Date startTime;

    private Date endTime;

    private Integer picId;

    private String truename;

    private String name;

    private String csname;

    private static final long serialVersionUID = 1L;

    public String getTruename() {
        return truename;
    }

    public void setTruename(String truename) {
        this.truename = truename;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCsname() {
        return csname;
    }

    public void setCsname(String csname) {
        this.csname = csname;
    }

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

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

    public String getCropGrowthCycleId() {
        return cropGrowthCycleId;
    }

    public void setCropGrowthCycleId(String cropGrowthCycleId) {
        this.cropGrowthCycleId = cropGrowthCycleId == null ? null : cropGrowthCycleId.trim();
    }

    public String getSysqmc() {
        return sysqmc;
    }

    public void setSysqmc(String sysqmc) {
        this.sysqmc = sysqmc == null ? null : sysqmc.trim();
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Integer getPicId() {
        return picId;
    }

    public void setPicId(Integer picId) {
        this.picId = picId;
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
        sb.append(", cropGrowthCycleId=").append(cropGrowthCycleId);
        sb.append(", sysqmc=").append(sysqmc);
        sb.append(", startTime=").append(startTime);
        sb.append(", endTime=").append(endTime);
        sb.append(", picId=").append(picId);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}