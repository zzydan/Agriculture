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