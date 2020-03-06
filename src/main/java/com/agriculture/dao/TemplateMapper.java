package com.agriculture.dao;

import com.agriculture.pojo.OrderPageInfo;
import com.agriculture.pojo.Template;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TemplateMapper {
    /**
     * 查询所有模板
     * @param pageInfo
     * @return
     */
    List<Template> findTemplate(@Param("info") OrderPageInfo pageInfo);

    /**
     * 查询单个模板详情
     * @param templateId
     * @return
     */
    Template findTemplateById(Integer templateId);

    /**
     * 删除模板
     * @param templateId
     * @return
     */
    int deleteTemplate(Integer templateId);
}