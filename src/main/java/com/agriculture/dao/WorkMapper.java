package com.agriculture.dao;

import com.agriculture.pojo.Work;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface WorkMapper {
    /**
     * 查询所有农事列表
     * @return
     */
    List<Work> getWorkList();
}