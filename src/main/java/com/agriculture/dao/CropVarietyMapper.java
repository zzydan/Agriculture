package com.agriculture.dao;

import com.agriculture.pojo.CropVariety;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface CropVarietyMapper {

    /**
     * 查询作物品种列表
     * @param
     * @return
     */
    List<CropVariety> getVarietyList();
}