package com.agriculture.dao;

import com.agriculture.pojo.CropSpecies;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface CropSpeciesMapper {
    /**
     * 查询作物种类列表
     * @param
     * @return
     */
    List<CropSpecies> getSpeciesList();
}