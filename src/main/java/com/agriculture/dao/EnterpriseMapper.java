package com.agriculture.dao;


import com.agriculture.pojo.Enterprise;

import java.util.List;

public interface EnterpriseMapper {
    /**
     * 所有的企业
     * @return
     */
    List<Enterprise> findEnterprise();
}