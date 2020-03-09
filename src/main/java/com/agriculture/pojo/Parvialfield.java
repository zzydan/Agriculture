package com.agriculture.pojo;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.util.Date;

@Data
@NoArgsConstructor//无参构造
@Accessors(chain = true)//链式写法
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

    private String longitude;//分场经度

    private String latitude;//分场纬度


}