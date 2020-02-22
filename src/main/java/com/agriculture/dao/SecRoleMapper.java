package com.agriculture.dao;

import com.agriculture.pojo.SecRole;

import java.util.List;

public interface SecRoleMapper {
    /**
     * 查询所有角色
     * @return
     */
    List<SecRole> findRole();

}