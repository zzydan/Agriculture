package com.agriculture.dao;

import com.agriculture.pojo.Lot;
import org.apache.ibatis.annotations.Param;

import java.util.List;

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
    /**
     * 查询所有地块详情
     * @param
     * @param fenChangId
     * @param diKuaiName
     * @return
     */
    List<Lot> getLotListAll(@Param("fenChangId") Integer fenChangId,@Param("diKuaiName") String diKuaiName);

    /**
     * 根据地块id修改地块详情
     * @param lot
     * @return
     */
    boolean updateLot(Lot lot);
}