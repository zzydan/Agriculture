package com.agriculture.dao;


import com.agriculture.pojo.Location;
import com.agriculture.pojo.Parvialfield;
import com.agriculture.pojo.SecUser;

import java.util.List;


public interface BasicCenterMapper {

    /**
     * 添加地块表主键返回
     * @param parvialfield
     * @return
     */
    boolean addParvialfield(Parvialfield parvialfield);

    /* */

    /**
     * 添加地理位置表
     * @param location
     * @return
     */
    boolean addLocation(Location location);

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
     * 地块修改基本信息
     * @param parvialfield
     * @return
     */
    boolean updateParvialfield(Parvialfield parvialfield);

    /**
     * 修改地块地理位置
     * @param parvialfield
     * @return
     */
    boolean updateLocation(Parvialfield parvialfield);
}