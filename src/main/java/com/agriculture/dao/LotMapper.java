package com.agriculture.dao;

import com.agriculture.pojo.Lot;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface LotMapper {
    /**
     * 添加地块
     * @param lot
     * @return
     */
    boolean addLot(Lot lot);
}