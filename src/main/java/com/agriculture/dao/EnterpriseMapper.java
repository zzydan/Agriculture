package com.agriculture.dao;


import com.agriculture.pojo.Enterprise;
import com.agriculture.pojo.OrderPageInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface EnterpriseMapper {
    /**
     * 所有的企业
     * @return
     */
    List<Enterprise> findEnterprise();

    /**
     * 分页查询企业管理
     * @return
     */
    List<Enterprise> findEnterpriseByPage();

    /**
     * 新增企业
     * @param enterprise
     * @return
     */
    int addEnterprise(@Param("enterprise") Enterprise enterprise);

    /**
     * 修改企业
     * @param enterprise
     * @return
     */
    int updateEnterprise(@Param("enterprise") Enterprise enterprise);

    /**
     * 根据id查询企业所有信息
     * @param id
     * @return
     */
    Enterprise findEnterpriseById(Integer id);
}