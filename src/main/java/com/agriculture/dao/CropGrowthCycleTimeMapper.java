package com.agriculture.dao;

import com.agriculture.pojo.CropGrowthCycleTime;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface CropGrowthCycleTimeMapper {
    /**
     * 根据作物品种和种类查询作物周期
     * @param speciesId
     * @param varietyId
     * @return
     */
    List<CropGrowthCycleTime> getCropGrowthCycleTime(@Param("speciesId") Integer speciesId,@Param("varietyId")  Integer varietyId);
}