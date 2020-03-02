package com.agriculture.dao;

import com.agriculture.pojo.Agricultural;

import java.util.List;

import com.agriculture.pojo.OrderPageInfo;
import com.agriculture.pojo.SecUser;
import org.apache.ibatis.annotations.Param;

public interface AgriculturalMapper {
    /**
     * 模糊查询农资
     * @param pageInfo
     * @return
     */
    List<Agricultural> SelectAgric(@Param("info") OrderPageInfo pageInfo);

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
    int DeleteAgricId(@Param("id")Integer id);

    /**
     * 查询单个农资信息
     * @param id
     * @return
     */
    Agricultural SelectAgricId(@Param("id")Integer id);

    /**
     * 修改农资
     * @param Agricultural
     * @return
     */
    int UpdateAgricId(Agricultural Agricultural);

}