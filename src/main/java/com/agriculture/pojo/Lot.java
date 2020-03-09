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
@Data
@NoArgsConstructor//无参构造
@Accessors(chain = true)//链式写法
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

}
