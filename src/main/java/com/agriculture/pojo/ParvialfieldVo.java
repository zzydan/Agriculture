package com.agriculture.pojo;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.util.Date;
import java.util.List;


public class ParvialfieldVo implements Serializable {
    private Integer id;

    private String name;

    private String longitude;//分场经度

    private String latitude;//分场纬度

    private String technicianUser;//技术员id

    private String technicianUserName;//技术员name

    private List<LotVo> lotVoList;//分场包含的地块集合

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
        this.name = name;
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

    public String getTechnicianUser() {
        return technicianUser;
    }

    public void setTechnicianUser(String technicianUser) {
        this.technicianUser = technicianUser;
    }

    public String getTechnicianUserName() {
        return technicianUserName;
    }

    public void setTechnicianUserName(String technicianUserName) {
        this.technicianUserName = technicianUserName;
    }

    public List<LotVo> getLotVoList() {
        return lotVoList;
    }

    public void setLotVoList(List<LotVo> lotVoList) {
        this.lotVoList = lotVoList;
    }
}