package com.agriculture.service;

import com.agriculture.pojo.Enterprise;
import com.agriculture.pojo.OrderPageInfo;
import com.agriculture.pojo.SecRole;
import com.agriculture.pojo.SecUser;
import com.github.pagehelper.PageInfo;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * @program: agriculture
 * @description: 系统管理业务层
 * @author: 罗子鉴
 * @create: 2020-02-21 16:39
 **/
public interface SysCenterService {
    /**
     * 查询所有用户
     * @param pageInfo
     * @return
     */
    PageInfo<SecUser> findManager(OrderPageInfo pageInfo);

    /**
     * 查询所有权限
     * @return
     */
    List<SecRole> findRole();

    /**
     * 验证用户
     * @param userName
     * @return
     */
    int findUserName(String userName);

    /**
     * 添加用户
     * @param SecUser
     * @return
     */
    int addUser(SecUser SecUser);
    /**
     * 查询单个信息
     * @param id
     * @return
     */
    SecUser selectUserId(Integer id);
    /**
     * 删除用户
     * @param id
     * @return
     */
    int deleteUserId(Integer id);
    /**
     * 所有的企业
     * @return
     */
    List<Enterprise> findEnterprise();
    /**
     * 修改用户信息
     * @param SecUser
     * @return
     */
    int upUserId(SecUser SecUser);
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
     * 查询单个角色
     * @return
     */
    SecRole findRoleId(Integer id);
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
    int deleteRoleId(Integer id);

    /**
     * 企业管理的查询
     * @param pageInfo
     * @return
     */
    PageInfo<Enterprise> findEnterpriseByPage(OrderPageInfo pageInfo);

    /**
     * 企业管理的新增
     * @param enterprise
     * @param user1Pic
     * @param user2Pic
     * @param user3Pic
     * @return
     */
    int addEnterprise(Enterprise enterprise, MultipartFile user1Pic, MultipartFile user2Pic, MultipartFile user3Pic);

    /**
     * 企业管理的修改
     * @param enterprise
     * @return
     */
    int updateEnterprise(Enterprise enterprise);

    /**
     * 根据id查询企业所有数据
     * @param id
     * @return
     */
    Enterprise findEnterpriseById(Integer id);
}
