package com.agriculture.pojo;

import java.io.Serializable;
import java.util.Date;

public class Parvialfield implements Serializable {
    private Integer id;

    private Boolean disabled;

    private Date createtime;

    private String name;

    private String address;

    private Integer fieldlengthUser;

    private Integer technicianUser;

    private String fieldlengthUserName;//厂长

    private String technicianUserName;//技术员

    private String longitude;//经度

    private String latitude;//纬度

    public String getFieldlengthUserName() {
        return fieldlengthUserName;
    }

    public void setFieldlengthUserName(String fieldlengthUserName) {
        this.fieldlengthUserName = fieldlengthUserName;
    }

    public String getTechnicianUserName() {
        return technicianUserName;
    }

    public void setTechnicianUserName(String technicianUserName) {
        this.technicianUserName = technicianUserName;
    }

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public Integer getFieldlengthUser() {
        return fieldlengthUser;
    }

    public void setFieldlengthUser(Integer fieldlengthUser) {
        this.fieldlengthUser = fieldlengthUser;
    }

    public Integer getTechnicianUser() {
        return technicianUser;
    }

    public void setTechnicianUser(Integer technicianUser) {
        this.technicianUser = technicianUser;
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
        sb.append(", address=").append(address);
        sb.append(", fieldlengthUser=").append(fieldlengthUser);
        sb.append(", technicianUser=").append(technicianUser);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}