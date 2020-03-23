package com.agriculture.dao;

import com.agriculture.pojo.TemplatePlanAgricultural;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TemplatePlanAgriculturalMapper {
    /**
     * 添加农资信息
     * @param templatePlanAgriculturalList
     * @param id
     * @return
     */
    int addTemplatePlanAgricultural(@Param("list") List<TemplatePlanAgricultural> templatePlanAgriculturalList,@Param("planId") Integer id);
}