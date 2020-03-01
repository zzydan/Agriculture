package com.agriculture.pojo;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.sql.Timestamp;
import java.util.Objects;

/**
 * @ClassName Lot
 * @Description TODO
 * @Author Chang
 * @Date 2020/2/28 23:07
 * @Version 1.0
 **/
@Data
@NoArgsConstructor//无参构造
@Accessors(chain = true)//链式写法
public class Lot {
    private int id;
    private Boolean disabled;
    private Timestamp createtime;
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
