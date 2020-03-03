package com.agriculture.dao;

import com.agriculture.pojo.Location;

import java.util.List;

import com.agriculture.pojo.Parvialfield;
import org.apache.ibatis.annotations.Param;

public interface LocationMapper {

    /**
     * 添加地理位置表
     * @param location
     * @return
     */
    boolean addLocation(Location location);

    /**
     * 修改地块地理位置
     * @param parvialfield
     * @return
     */
    boolean updateLocation(Parvialfield parvialfield);

    /**
     * 添加地块地理位置批量
     * @param locations
     * @return
     */
    boolean addLocations(@Param("locations") List<Location> locations);
}