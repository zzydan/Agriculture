package com.agriculture.pojo;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.util.Date;
import java.util.List;


/**
 * @ClassName Lot 地块表
 * @Description TODO
 * @Author Chang
 * @Date 2020/2/28 23:07
 * @Version 1.0
 **/
public class Lot implements Serializable {
    private int id;
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

    public int getId() {
        return id;
    }

    public void setId(int id) {
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
        this.name = name;
    }

    public String getSsfc() {
        return ssfc;
    }

    public void setSsfc(String ssfc) {
        this.ssfc = ssfc;
    }

    public String getTrzd() {
        return trzd;
    }

    public void setTrzd(String trzd) {
        this.trzd = trzd;
    }

    public String getDkzz() {
        return dkzz;
    }

    public void setDkzz(String dkzz) {
        this.dkzz = dkzz;
    }

    public String getZwzl() {
        return zwzl;
    }

    public void setZwzl(String zwzl) {
        this.zwzl = zwzl;
    }

    public String getZwpz() {
        return zwpz;
    }

    public void setZwpz(String zwpz) {
        this.zwpz = zwpz;
    }

    public String getDkjsy() {
        return dkjsy;
    }

    public void setDkjsy(String dkjsy) {
        this.dkjsy = dkjsy;
    }

    public String getLdfx() {
        return ldfx;
    }

    public void setLdfx(String ldfx) {
        this.ldfx = ldfx;
    }

    public String getDkmj() {
        return dkmj;
    }

    public void setDkmj(String dkmj) {
        this.dkmj = dkmj;
    }

    public String getDkzc() {
        return dkzc;
    }

    public void setDkzc(String dkzc) {
        this.dkzc = dkzc;
    }
}
