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

}
