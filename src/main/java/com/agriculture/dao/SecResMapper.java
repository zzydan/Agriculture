package com.agriculture.dao;

import com.agriculture.pojo.SecRes;

import java.util.List;

public interface SecResMapper {
    /**
     * 权限
     * @param roleId
     * @return
     */
    List<SecRes> loading_res(Integer roleId);

    /**
     * 查询权限表
     * @return
     */
    List<SecRes> findRes();
}