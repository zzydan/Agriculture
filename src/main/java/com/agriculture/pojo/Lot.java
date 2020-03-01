package com.agriculture.pojo;

import java.io.Serializable;
import java.util.Date;

public class Lot implements Serializable {
    private Integer id;

    private Boolean disabled;

    private Date createtime;

    private String name;

    private String ssfc;

    private String trzd;

    private String dkzz;

    private String zwzl;

    private String zwpz;

    private String dkjsy;

    private String ldfx;

    private String dkmj;

    private String dkzc;

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

    public String getSsfc() {
        return ssfc;
    }

    public void setSsfc(String ssfc) {
        this.ssfc = ssfc == null ? null : ssfc.trim();
    }

    public String getTrzd() {
        return trzd;
    }

    public void setTrzd(String trzd) {
        this.trzd = trzd == null ? null : trzd.trim();
    }

    public String getDkzz() {
        return dkzz;
    }

    public void setDkzz(String dkzz) {
        this.dkzz = dkzz == null ? null : dkzz.trim();
    }

    public String getZwzl() {
        return zwzl;
    }

    public void setZwzl(String zwzl) {
        this.zwzl = zwzl == null ? null : zwzl.trim();
    }

    public String getZwpz() {
        return zwpz;
    }

    public void setZwpz(String zwpz) {
        this.zwpz = zwpz == null ? null : zwpz.trim();
    }

    public String getDkjsy() {
        return dkjsy;
    }

    public void setDkjsy(String dkjsy) {
        this.dkjsy = dkjsy == null ? null : dkjsy.trim();
    }

    public String getLdfx() {
        return ldfx;
    }

    public void setLdfx(String ldfx) {
        this.ldfx = ldfx == null ? null : ldfx.trim();
    }

    public String getDkmj() {
        return dkmj;
    }

    public void setDkmj(String dkmj) {
        this.dkmj = dkmj == null ? null : dkmj.trim();
    }

    public String getDkzc() {
        return dkzc;
    }

    public void setDkzc(String dkzc) {
        this.dkzc = dkzc == null ? null : dkzc.trim();
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
        sb.append(", ssfc=").append(ssfc);
        sb.append(", trzd=").append(trzd);
        sb.append(", dkzz=").append(dkzz);
        sb.append(", zwzl=").append(zwzl);
        sb.append(", zwpz=").append(zwpz);
        sb.append(", dkjsy=").append(dkjsy);
        sb.append(", ldfx=").append(ldfx);
        sb.append(", dkmj=").append(dkmj);
        sb.append(", dkzc=").append(dkzc);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}