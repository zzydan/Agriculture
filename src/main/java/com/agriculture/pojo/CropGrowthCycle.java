package com.agriculture.pojo;

import java.io.Serializable;
import java.util.Date;

public class CropGrowthCycle implements Serializable {
    private Integer id;

    private Boolean disabled;

    private Date createtime;

    private String cropSpeciesId;

    private String cropVarietyId;

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

    public String getCropSpeciesId() {
        return cropSpeciesId;
    }

    public void setCropSpeciesId(String cropSpeciesId) {
        this.cropSpeciesId = cropSpeciesId == null ? null : cropSpeciesId.trim();
    }

    public String getCropVarietyId() {
        return cropVarietyId;
    }

    public void setCropVarietyId(String cropVarietyId) {
        this.cropVarietyId = cropVarietyId == null ? null : cropVarietyId.trim();
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
        sb.append(", cropSpeciesId=").append(cropSpeciesId);
        sb.append(", cropVarietyId=").append(cropVarietyId);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}