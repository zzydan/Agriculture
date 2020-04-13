package com.agriculture.dao;

import com.agriculture.pojo.FarmWork;

import java.util.List;

import com.agriculture.pojo.Work;
import org.apache.ibatis.annotations.Param;

public interface FarmWorkMapper {
    List<FarmWork> getAll(int id);
    FarmWork getxq(@Param("lotid")int lotid,@Param("id")int id);
    FarmWork getAll1();

    /**
     * 根据分场id查询农事详情
     * @param id
     * @return
     */
    List<FarmWork> getNongByFenChang(int id);


    /**
     * 根据日期获取农事
     * @param date
     * @return
     */
    List<FarmWork> getWorkByDate(@Param("date") String date,@Param("id") Integer id);

    /**
     * 查询农事列表
     * @param
     * @return
     */
    List<Work> getNong();

    /**
     * 添加临时农事
     * @param farmWork
     * @return
     */
    boolean addFarmWork(FarmWork farmWork);
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