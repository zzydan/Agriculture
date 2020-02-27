package com.agriculture.service;

import com.agriculture.pojo.Location;
import com.agriculture.pojo.Parvialfield;
import com.agriculture.pojo.SecUser;

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
}
