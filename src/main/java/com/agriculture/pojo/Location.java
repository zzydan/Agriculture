package com.agriculture.pojo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;
@Data
@NoArgsConstructor//无参构造
@Accessors(chain = true)//链式写法
public class Location implements Serializable {
    private Integer id;

    private Boolean disabled;

    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date createtime;

    private Integer objId;

    private String objType;

    private String longitude;

    private String latitude;


}