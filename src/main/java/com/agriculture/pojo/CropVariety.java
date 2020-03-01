package com.agriculture.pojo;

import java.io.Serializable;
import java.util.Date;

public class CropVariety implements Serializable {
    private Integer id;

    private Boolean disabled;

    private Date createtime;

    private String name;

    private Integer userId;

    private String species;

    private String zwswxld;

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

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getSpecies() {
        return species;
    }

    public void setSpecies(String species) {
        this.species = species == null ? null : species.trim();
    }

    public String getZwswxld() {
        return zwswxld;
    }

    public void setZwswxld(String zwswxld) {
        this.zwswxld = zwswxld == null ? null : zwswxld.trim();
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
        sb.append(", userId=").append(userId);
        sb.append(", species=").append(species);
        sb.append(", zwswxld=").append(zwswxld);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}