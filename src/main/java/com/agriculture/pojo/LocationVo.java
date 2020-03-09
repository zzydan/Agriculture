package com.agriculture.pojo;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.util.Date;
@Data
@NoArgsConstructor//无参构造
@Accessors(chain = true)//链式写法
public class LocationVo implements Serializable {
    private Integer id;

    private String lng;

    private String lat;

}