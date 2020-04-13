package com.agriculture.dao;

import com.agriculture.pojo.WorkFertilizer;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface WorkFertilizerMapper {

    /**
     * 添加临时农事之农资添加
     * @param workFertilizers
     * @return
     */
    public boolean addZiList(@Param("workFertilizers") List<WorkFertilizer> workFertilizers);
}