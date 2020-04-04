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

    /**
     * 查询作物品种列表 根据种类id
     * @param SpeciesId
     * @return
     */
    List<CropVariety> getVarietyListBySpeciesId(@Param("SpeciesId") Integer SpeciesId);
    /**
     * 查看作物品种
     * @return
     */
    List<CropVariety> findVariety();

    /**
     * 查询单个品种
     * @param id
     * @return
     */
    CropVariety findVarietyId(@Param("id")Integer id);
    /**
     * 删除品种
     * @param id
     * @return
     */
    int deleteVariety(@Param("id")Integer id);

    /**
     * 添加种类
     * @param cropVariety
     * @return
     */
    int InsertVariety(CropVariety cropVariety);

    /**
     * 修改种类
     * @param cropVariety
     * @return
     */
    int updataVariety(CropVariety cropVariety);

    /**
     * 获取分场内所有作物
     * @param fenChangId
     * @return
     */
    List<CropVariety> getSpeciesrByFenChang(Integer fenChangId);
}