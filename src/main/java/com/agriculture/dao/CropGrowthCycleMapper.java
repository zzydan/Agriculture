package com.agriculture.dao;

import com.agriculture.pojo.CropGrowthCycle;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface CropGrowthCycleMapper {
    /**
     * 添加生育周期
     * @param CropGrowthCycle
     * @return
     */
    Boolean addCropGrowth(CropGrowthCycle CropGrowthCycle);

    /**
     * 删除生育种类
     * @param id
     * @return
     */
    int deleteCrop(@Param("id")Integer id);
}