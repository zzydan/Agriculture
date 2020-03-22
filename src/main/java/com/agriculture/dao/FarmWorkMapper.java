package com.agriculture.dao;

import com.agriculture.pojo.FarmWork;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface FarmWorkMapper {
    List<FarmWork> getAll(int id);
    FarmWork getxq(@Param("lotid")int lotid,@Param("id")int id);
    FarmWork getAll1();
    /**
     * 查询所有农事
     * @return
     */
    List<FarmWork> FindFarm();

    /**
     * 查询单个农事信息
     * @param id
     * @return
     */
    FarmWork FindFarmId(@Param("id")Integer id);

    /**
     * 添加农事
     * @param FarmWork
     * @return
     */
    int addFarm(FarmWork FarmWork);

    /**
     * 修改农事
     * @param FarmWork
     * @return
     */
    int UpdateFarm(FarmWork FarmWork);

    /**
     * 删除农事
     * @param id
     * @return
     */
    int deleteFarm(@Param("id")Integer id);
}