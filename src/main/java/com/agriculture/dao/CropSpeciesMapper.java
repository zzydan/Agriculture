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
    /**
     * 查询作物种类
     * @return
     */
    List<CropSpecies> SelectCropAll();

    /**
     * 添加作物种类名称
     * @param CropSpecies
     * @return
     */
    int addcrop(@Param("CropSpecies")CropSpecies CropSpecies);

    /**
     * 查询单个种类
     * @param id
     * @return
     */
    CropSpecies SelectCropSpeciesId(@Param("id")Integer id);

    /**
     * 修改种类
     * @param CropSpecies
     * @return
     */
    int UpdateCropSpercies(CropSpecies CropSpecies);

    /**
     * 删除种类
     * @param id
     * @return
     */
    int DeleteCropSperciesId(@Param("id")Integer id);
}