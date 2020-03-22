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
    /**
     * 查询所有生育时期
     * @return
     */
    List<CropGrowthCycleTime> FindCropGrowthCycleTime();

    /**
     * 添加生育周期时间表
     * @param id
     * @param zwswxld_up
     * @param starttime
     * @param endtime
     * @return
     */
    Boolean AddCroptime(@Param("id") Integer id, @Param("zwswxld_up") String zwswxld_up,@Param("starttime") String starttime,@Param("endtime") String endtime);

    /**
     * 查询单个生育周期信息
     * @param id
     * @return
     */
    List<CropGrowthCycleTime> SelectCropTimeId(@Param("id")Integer id);
}