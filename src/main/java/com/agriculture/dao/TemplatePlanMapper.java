package com.agriculture.dao;

import com.agriculture.pojo.TemplatePlan;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TemplatePlanMapper {
    /**
     * 添加模板计划
     * @param templatePlan
     * @param templateId
     * @return
     */
    int addTemplatePlan(@Param("templatePlan") TemplatePlan templatePlan,@Param("templateId") Integer templateId);

    /**
     * 根据模板id删除信息
     * @param templateId
     * @return
     */
    int delTemplatePlanByTemplateId(@Param("templateId") Integer templateId);
}