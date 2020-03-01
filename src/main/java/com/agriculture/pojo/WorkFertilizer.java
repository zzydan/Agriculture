package com.agriculture.pojo;

import java.io.Serializable;
import java.util.Date;

public class WorkFertilizer implements Serializable {
    private Integer id;

    private Boolean disabled;

    private Date createtime;

    private Integer farmWorkId;

    private Integer agriculturalId;

    private Double weight;

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

    public Integer getFarmWorkId() {
        return farmWorkId;
    }

    public void setFarmWorkId(Integer farmWorkId) {
        this.farmWorkId = farmWorkId;
    }

    public Integer getAgriculturalId() {
        return agriculturalId;
    }

    public void setAgriculturalId(Integer agriculturalId) {
        this.agriculturalId = agriculturalId;
    }

    public Double getWeight() {
        return weight;
    }

    public void setWeight(Double weight) {
        this.weight = weight;
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
        sb.append(", farmWorkId=").append(farmWorkId);
        sb.append(", agriculturalId=").append(agriculturalId);
        sb.append(", weight=").append(weight);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}