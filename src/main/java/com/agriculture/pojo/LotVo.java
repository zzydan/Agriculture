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

public class LotVo implements Serializable {
    private int lId;

    private String lName;

    private List<LocationVo> locationVoList;

    public void setlId(int lId) {
        this.lId = lId;
    }

    public void setlName(String lName) {
        this.lName = lName;
    }

    public void setLocationVoList(List<LocationVo> locationVoList) {
        this.locationVoList = locationVoList;
    }
}
