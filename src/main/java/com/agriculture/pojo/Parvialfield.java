package com.agriculture.pojo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

/**
 * @ClassName Parvialfield
 * @Description  分场管理表   TODO
 * @Author Chang
 * @Date 2020/2/21 15:38
 * @Version 1.0
 **/
/*链式写法：
Dept dept=new Dept();
dept.setDeptNo(11).setDname("开发部")*/
@Data
@NoArgsConstructor//无参构造
@Accessors(chain = true)//链式写法
public class Parvialfield implements Serializable {
    private Integer id;

    private Integer disabled;

    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date createtime;

    private String name;

    private String address;

    private Integer fieldlengthUser;//厂长id

    private Integer technicianUser;//技术员id

    private String fieldlengthUserName;//厂长

    private String technicianUserName;//技术员

    //private Location location;//关联地理位置表

    private String longitude;//经度

    private String latitude;//纬度
}
