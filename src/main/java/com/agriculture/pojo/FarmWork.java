package com.agriculture.pojo;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;

public class FarmWork implements Serializable {
    private String unitmeasurement;
    private String lotname;
    private String cropspeciesname;
    private String parvialfieldname;
    private double weight;
    private String agriculturalname;
    private Integer id;
    private int lotid;

    private Boolean disabled;

    private Date createtime;

    private String name;

    private Integer userId;

    private Integer lotId;

    private Integer workId;

    private Date finishTime;

    private String text;

    private String result;

    private String truename;
    private String workName;

    public String getWorkName() {
        return workName;
    }

    public void setWorkName(String workName) {
        this.workName = workName;
    }

    public String getTruename() {
        return truename;
    }

    public void setTruename(String truename) {
        this.truename = truename;
    }

    @Override
    public String toString() {
        return "FarmWork{" +
                "unitmeasurement='" + unitmeasurement + '\'' +
                ", lotname='" + lotname + '\'' +
                ", cropspeciesname='" + cropspeciesname + '\'' +
                ", parvialfieldname='" + parvialfieldname + '\'' +
                ", weight=" + weight +
                ", agriculturalname='" + agriculturalname + '\'' +
                ", id=" + id +
                ", lotid=" + lotid +
                ", disabled=" + disabled +
                ", createtime=" + createtime +
                ", name='" + name + '\'' +
                ", userId=" + userId +
                ", lotId=" + lotId +
                ", workId=" + workId +
                ", finishTime=" + finishTime +
                ", text='" + text + '\'' +
                ", result='" + result + '\'' +
                '}';
    }

    public String getUnitmeasurement() {
        return unitmeasurement;
    }

    public void setUnitmeasurement(String unitmeasurement) {
        this.unitmeasurement = unitmeasurement;
    }

    public String getLotname() {
        return lotname;
    }

    public void setLotname(String lotname) {
        this.lotname = lotname;
    }

    public String getCropspeciesname() {
        return cropspeciesname;
    }

    public void setCropspeciesname(String cropspeciesname) {
        this.cropspeciesname = cropspeciesname;
    }

    public String getParvialfieldname() {
        return parvialfieldname;
    }

    public void setParvialfieldname(String parvialfieldname) {
        this.parvialfieldname = parvialfieldname;
    }

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
    }

    public String getAgriculturalname() {
        return agriculturalname;
    }

    public void setAgriculturalname(String agriculturalname) {
        this.agriculturalname = agriculturalname;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public int getLotid() {
        return lotid;
    }

    public void setLotid(int lotid) {
        this.lotid = lotid;
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

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getLotId() {
        return lotId;
    }

    public void setLotId(Integer lotId) {
        this.lotId = lotId;
    }

    public Integer getWorkId() {
        return workId;
    }

    public void setWorkId(Integer workId) {
        this.workId = workId;
    }

    public Date getFinishTime() {
        return finishTime;
    }

    public void setFinishTime(Date finishTime) {
        this.finishTime = finishTime;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public FarmWork() {
    }

    public FarmWork(String unitmeasurement, String lotname, String cropspeciesname, String parvialfieldname, double weight, String agriculturalname, Integer id, int lotid, Boolean disabled, Date createtime, String name, Integer userId, Integer lotId, Integer workId, Date finishTime, String text, String result) {

        this.unitmeasurement = unitmeasurement;
        this.lotname = lotname;
        this.cropspeciesname = cropspeciesname;
        this.parvialfieldname = parvialfieldname;
        this.weight = weight;
        this.agriculturalname = agriculturalname;
        this.id = id;
        this.lotid = lotid;
        this.disabled = disabled;
        this.createtime = createtime;
        this.name = name;
        this.userId = userId;
        this.lotId = lotId;
        this.workId = workId;
        this.finishTime = finishTime;
        this.text = text;
        this.result = result;
    }
}