package com.agriculture.pojo;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Data
@NoArgsConstructor//无参构造
@Accessors(chain = true)//链式写法
public class ParvialfieldVo implements Serializable {
    private Integer id;

    private String name;

    private String longitude;//分场经度

    private String latitude;//分场纬度

    private String technicianUser;//技术员id

    private String technicianUserName;//技术员name

    private List<LotVo> lotVoList;//分场包含的地块集合


}