package com.agriculture.pojo;

import java.util.Date;

public class Enterprise {
    private Integer id;

    private Boolean disabled;

    private Integer createuser;

    private String createuserName;

    private Date createtime;

    private String name;

    private String address;

    private Integer userNumber;

    private String intro;

    private Double longitude;

    private Double latitude;

    private String filiale;

    private String filialeCenter;

    private String mapperUser1;

    private Integer mapperUser1Pic;

    private String mapperUser1PicPath;

    private String mapperUser2;

    private Integer mapperUser2Pic;

    private String mapperUser2PicPath;

    private String mapperUser3;

    private Integer mapperUser3Pic;

    private String mapperUser3PicPath;

    public String getMapperUser1PicPath() {
        return mapperUser1PicPath;
    }

    public void setMapperUser1PicPath(String mapperUser1PicPath) {
        this.mapperUser1PicPath = mapperUser1PicPath;
    }

    public String getMapperUser2PicPath() {
        return mapperUser2PicPath;
    }

    public void setMapperUser2PicPath(String mapperUser2PicPath) {
        this.mapperUser2PicPath = mapperUser2PicPath;
    }

    public String getMapperUser3PicPath() {
        return mapperUser3PicPath;
    }

    public void setMapperUser3PicPath(String mapperUser3PicPath) {
        this.mapperUser3PicPath = mapperUser3PicPath;
    }

    public Integer getCreateuser() {
        return createuser;
    }

    public void setCreateuser(Integer createuser) {
        this.createuser = createuser;
    }

    public String getCreateuserName() {
        return createuserName;
    }

    public void setCreateuserName(String createuserName) {
        this.createuserName = createuserName;
    }

    public Integer getUserNumber() {
        return userNumber;
    }

    public void setUserNumber(Integer userNumber) {
        this.userNumber = userNumber;
    }


    public String getFilialeCenter() {
        return filialeCenter;
    }

    public void setFilialeCenter(String filialeCenter) {
        this.filialeCenter = filialeCenter;
    }

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

    public String getIntro() {
        return intro;
    }

    public void setIntro(String intro) {
        this.intro = intro == null ? null : intro.trim();
    }

    public Double getLongitude() {
        return longitude;
    }

    public void setLongitude(Double longitude) {
        this.longitude = longitude;
    }

    public Double getLatitude() {
        return latitude;
    }

    public void setLatitude(Double latitude) {
        this.latitude = latitude;
    }

    public String getFiliale() {
        return filiale;
    }

    public void setFiliale(String filiale) {
        this.filiale = filiale == null ? null : filiale.trim();
    }

    public String getMapperUser1() {
        return mapperUser1;
    }

    public void setMapperUser1(String mapperUser1) {
        this.mapperUser1 = mapperUser1 == null ? null : mapperUser1.trim();
    }

    public Integer getMapperUser1Pic() {
        return mapperUser1Pic;
    }

    public void setMapperUser1Pic(Integer mapperUser1Pic) {
        this.mapperUser1Pic = mapperUser1Pic;
    }

    public String getMapperUser2() {
        return mapperUser2;
    }

    public void setMapperUser2(String mapperUser2) {
        this.mapperUser2 = mapperUser2 == null ? null : mapperUser2.trim();
    }

    public Integer getMapperUser2Pic() {
        return mapperUser2Pic;
    }

    public void setMapperUser2Pic(Integer mapperUser2Pic) {
        this.mapperUser2Pic = mapperUser2Pic;
    }

    public String getMapperUser3() {
        return mapperUser3;
    }

    public void setMapperUser3(String mapperUser3) {
        this.mapperUser3 = mapperUser3 == null ? null : mapperUser3.trim();
    }

    public Integer getMapperUser3Pic() {
        return mapperUser3Pic;
    }

    public void setMapperUser3Pic(Integer mapperUser3Pic) {
        this.mapperUser3Pic = mapperUser3Pic;
    }
}