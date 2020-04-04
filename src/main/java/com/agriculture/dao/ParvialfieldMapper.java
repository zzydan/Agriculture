package com.agriculture.dao;

import com.agriculture.pojo.Parvialfield;

import java.util.List;

import com.agriculture.pojo.ParvialfieldVo;

public interface ParvialfieldMapper {
    List<Parvialfield> getAll();
    /**
     * 添加地块表主键返回
     * @param parvialfield
     * @return
     */
    boolean addParvialfield(Parvialfield parvialfield);


    /**
     * 查询分场列表
     * @param
     * @return
     */
    List<Parvialfield> getFenChangList();

    /**
     * 根据分场id查询分场详情信息
     * @param id
     * @return
     */
    Parvialfield getFenChangById(Integer id);


    /**
     * 分场修改基本信息
     * @param parvialfield
     * @return
     */
    boolean updateParvialfield(Parvialfield parvialfield);

    /**
     * 查询分场列表vo,一个分场对多个地块，一个地块有对应多个经纬度
     * @param
     * @return
     */
    List<ParvialfieldVo> getFenChangListVo();

    /**
     * 删除分场
     * @param id
     * @return
     */
    boolean deleteFenChangById(Integer id);

    /**
     * 获取分场负责人的列表
     * @param id
     * @return
     */
    List<Parvialfield> getFenChangListByUser1(Integer id);
    /**
     * 获取分场技术员的列表
     * @param id
     * @return
     */
    List<Parvialfield> getFenChangListByUser2(Integer id);
}