package com.agriculture.pojo;

import java.io.Serializable;
import java.util.Date;

public class SecPic implements Serializable {
    private Integer id;

    private String name;

    private String info;

    private String path;

    private Float size;

    private Boolean disabled;

    private Date createtime;

    private String  objType;

    private Integer objId;


    private static final long serialVersionUID = 1L;

    public String getObjType() {
        return objType;
    }

    public void setObjType(String objType) {
        this.objType = objType;
    }

    public Integer getObjId() {
        return objId;
    }

    public void setObjId(Integer objId) {
        this.objId = objId;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info == null ? null : info.trim();
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path == null ? null : path.trim();
    }

    public Float getSize() {
        return size;
    }

    public void setSize(Float size) {
        this.size = size;
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

    @Override
    public String toString() {
        return "SecPic{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", info='" + info + '\'' +
                ", path='" + path + '\'' +
                ", size=" + size +
                ", disabled=" + disabled +
                ", createtime=" + createtime +
                ", objType='" + objType + '\'' +
                ", objId='" + objId + '\'' +
                '}';
    }
}