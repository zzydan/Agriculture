package com.agriculture.pojo;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.util.Date;


/**
 * @ClassName CropVariety
 * @Description TODO
 * @Author Chang
 * @Date 2020/2/28 23:07
 * @Version 1.0
 **/
@Data
@NoArgsConstructor//无参构造
@Accessors(chain = true)//链式写法
public class CropVariety implements Serializable {
    private int id;
    private Boolean disabled;
    private Date createtime;
    private String name;
    private Integer userId;
    private String species;
    private String zwswxld;

    private String name1;

    private String truename;

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
        this.species = species;
    }

    public String getZwswxld() {
        return zwswxld;
    }

    public void setZwswxld(String zwswxld) {
        this.zwswxld = zwswxld;
    }

    public String getName1() {
        return name1;
    }

    public void setName1(String name1) {
        this.name1 = name1;
    }

    public String getTruename() {
        return truename;
    }

    public void setTruename(String truename) {
        this.truename = truename;
    }
}
