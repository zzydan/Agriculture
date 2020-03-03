package com.agriculture.dao;

import com.agriculture.pojo.SecRole;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SecRoleMapper {
    /**
     * 查询所有角色
     * @return
     */
    List<SecRole> findRole();
    /**
     * 查询单个角色
     * @return
     */
    SecRole findRoleId(@Param("id")Integer id);
    /**
     * 查询所有角色信息和企业
     * @return
     */
    List<SecRole> findRoleEnter();

    /**
     * 添加角色
     * @param SecRole
     * @return
     */
    int addRole(SecRole SecRole);

    /**
     * 修改角色
     * @param SecRole
     * @return
     */
    int upRoleId(SecRole SecRole);

    /**
     * 删除
     * @param id
     * @return
     */
    int deleteRoleId(@Param("id")Integer id);



}