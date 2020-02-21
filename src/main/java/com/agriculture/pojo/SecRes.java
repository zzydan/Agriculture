package com.agriculture.pojo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class SecRes implements Serializable {
    private Integer id;

    private String icon;

    private String info;

    private String resname;

    private String type;

    private Integer parentId;

    private Boolean disabled;

    private Date createtime;

    private static final long serialVersionUID = 1L;

    private List<SecRes> resList;

    public List<SecRes> getResList() {
        return resList;
    }

    public void setResList(List<SecRes> resList) {
        this.resList = resList;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon == null ? null : icon.trim();
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info == null ? null : info.trim();
    }

    public String getResname() {
        return resname;
    }

    public void setResname(String resname) {
        this.resname = resname == null ? null : resname.trim();
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type == null ? null : type.trim();
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
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
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", icon=").append(icon);
        sb.append(", info=").append(info);
        sb.append(", resname=").append(resname);
        sb.append(", type=").append(type);
        sb.append(", parentId=").append(parentId);
        sb.append(", disabled=").append(disabled);
        sb.append(", createtime=").append(createtime);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }


}