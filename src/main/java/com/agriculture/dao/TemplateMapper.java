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
}