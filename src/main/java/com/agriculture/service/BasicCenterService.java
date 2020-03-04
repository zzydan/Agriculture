package com.agriculture.service;

import com.agriculture.pojo.*;
import com.github.pagehelper.PageInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @program: agriculture
 * @description: 基本管理业务层
 * @author: 常高杰
 * @create: 2020-02-21 16:39
 **/
public interface BasicCenterService {


    /**
     * 添加地块
     * @param parvialfield
     * @param location
     * @return
     */
    boolean addPlace(Parvialfield parvialfield, Location location);


    /**
     * 查询分场列表
     * @param
     * @return
     */
    List<Parvialfield> getFenChangList();

    /**
     * 查询角色id查询人员列表
     * @param roleId
     * @return
     */
    List<SecUser> getUserListByRole(Integer roleId);

    /**
     * 根据分场id查询分场详情信息
     * @param id
     * @return
     */
    Parvialfield getFenChangById(Integer id);

    /**
     * 修改地块信息
     * @param parvialfield
     * @return
     */
    boolean updatePlace(Parvialfield parvialfield);
    /**
     * 查询作物种类列表
     * @param
     * @return
     */
    List<CropSpecies> getSpeciesList();
    /**
     * 查询作物品种列表
     * @param
     * @return
     */
    List<CropVariety> getVarietyList();
    /**
     * 模糊查询农资
     * @param pageInfo
     * @return
     */
    PageInfo<Agricultural> SelectAgric(OrderPageInfo pageInfo);
    /**
     * 添加农资
     * @param Agricultural
     * @return
     */
    int AddAgric(Agricultural Agricultural);
    /**
     * 删除农资
     * @param id
     * @return
     */
    int DeleteAgricId(Integer id);

    /**
     * 查询单个农资信息
     * @param id
     * @return
     */
    Agricultural SelectAgricId(Integer id);
    /**
     * 修改农资
     * @param Agricultural
     * @return
     */
    int UpdateAgricId(Agricultural Agricultural);

    /**
     * 查询所有模板
     * @param pageInfo
     * @return
     */
    PageInfo<Template> findTemplate(OrderPageInfo pageInfo);

    /**
     * 添加地块
     * @param lot,overlay
     * @return
     */
    boolean addLot(Lot lot, List<Location> locations);

    /**
     * 查询分场列表vo,一个分场对多个地块，一个地块有对应多个经纬度
     * @param
     * @return
     */
    List<ParvialfieldVo> getFenChangListVo();

    /**
     * 根据地块id查询地块详情
     * @param lotId
     * @return
     */
    Lot getLotById(Integer lotId);

    /**
     * 根据分场id查询所有地块详情
     * @param fenChangId
     * @return
     */
    List<Lot> getLotByFenChangId(Integer fenChangId);
}
