package com.agriculture.pojo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

/**
 * @ClassName Location
 * @Description 地理位置表 TODO
 * @Author Chang
 * @Date 2020/2/21 23:21
 * @Version 1.0
 **/
@Data
@NoArgsConstructor//无参构造
@Accessors(chain = true)//链式写法
public class Location implements Serializable {
    private Integer id;

    private String disabled;

    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date createtime;

    private Integer objId;

    private String objType;

    private String longitude;

    private String latitude;

}
