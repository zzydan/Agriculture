package com.agriculture.dao;

import com.agriculture.pojo.FarmWork;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface FarmWorkMapper {
    List<FarmWork> getAll(int id);
    FarmWork getxq(@Param("lotid")int lotid,@Param("id")int id);
    FarmWork getAll1();
}