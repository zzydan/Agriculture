package com.agriculture.service.impl;

import com.agriculture.dao.EnterpriseMapper;
import com.agriculture.dao.SecRoleMapper;
import com.agriculture.dao.SecUserMapper;
import com.agriculture.pojo.Enterprise;
import com.agriculture.pojo.OrderPageInfo;
import com.agriculture.pojo.SecRole;
import com.agriculture.pojo.SecUser;
import com.agriculture.service.SysCenterService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @program: agriculture
 * @description: 系统管理业务层
 * @author: 罗子鉴
 * @create: 2020-02-21 16:39
 **/
@Service
public class SysCenterServiceImpl implements SysCenterService {
    @Autowired
    private SecRoleMapper secRoleMapper;
    @Autowired
    private SecUserMapper secUserMapper;
    @Autowired
    private  EnterpriseMapper enterpriseMapper;

    /**
     * 查询所有人员信息
     * @param pageInfo
     * @return
     */
    @Override
    public PageInfo<SecUser> findManager(OrderPageInfo pageInfo) {

        PageHelper.offsetPage(pageInfo.getOffset(),pageInfo.getLimit());

        List<SecUser> list = secUserMapper.findManager(pageInfo);

        PageInfo info = new PageInfo(list);

        return info;
    }

    /**
     * 查询所有角色信息
     * @return
     */
    @Override
    public List<SecRole> findRole() {

        List<SecRole> roles = secRoleMapper.findRole();

        return roles;
    }

    /**
     * 验证用户
     * @param userName
     * @return
     */
    @Override
    public int findUserName(String userName) {

        SecUser secUser= secUserMapper.findUserByName(userName);
        if(secUser!=null){
            return 1;
        }
        return 0;
    }

    /**
     * 添加用户
     * @param SecUser
     * @return
     */
    @Override
    public int addUser(SecUser SecUser) {
        return secUserMapper.addUser(SecUser);
    }

    /**
     * 查询单个用户信息回显
     * @param id
     * @return
     */
    @Override
    public SecUser selectUserId(Integer id) {
        return secUserMapper.selectUserId(id);
    }

    /**
     * 删除
     * @param id
     * @return
     */
    @Override
    public int deleteUserId(Integer id) {
        return secUserMapper.deleteUserId(id);
    }

    /**
     * 查询所有企业
     * @return
     */
    @Override
    public List<Enterprise> findEnterprise() {
        return enterpriseMapper.findEnterprise();
    }

    /**
     *
     * @param SecUser
     * @return
     */
    @Override
    public int upUserId(SecUser SecUser) {
        return secUserMapper.upUserId(SecUser);
    }

    /**
     *
     * @return
     */
    @Override
    public List<SecRole> findRoleEnter() {
        List<SecRole> list = secRoleMapper.findRoleEnter();
        return list;
    }

    /**
     *
     * @param SecRole
     * @return
     */
    @Override
    public int addRole(SecRole SecRole) {
        return secRoleMapper.addRole(SecRole);
    }

    /**
     *
     * @param id
     * @return
     */
    @Override
    public SecRole findRoleId(Integer id) {
        return secRoleMapper.findRoleId(id);
    }

    /**
     *
     * @param SecRole
     * @return
     */
    @Override
    public int upRoleId(SecRole SecRole) {
        return secRoleMapper.upRoleId(SecRole);
    }

    /**
     *
     * @param id
     * @return
     */
    @Override
    public int deleteRoleId(Integer id) {
        return secRoleMapper.deleteRoleId(id);
    }

    /**
     * 分页查询所有企业
     * @param pageInfo
     * @return
     */
    @Override
    public PageInfo<Enterprise> findEnterpriseByPage(OrderPageInfo pageInfo) {

        PageHelper.offsetPage(pageInfo.getOffset(),pageInfo.getLimit());

        List<Enterprise> list = enterpriseMapper.findEnterpriseByPage();

        PageInfo info = new PageInfo(list);

        return info;
    }

    /**
     * 新增企业
     * @param enterprise
     * @return
     */
    @Override
    public int addEnterprise(Enterprise enterprise) {

        int i = enterpriseMapper.addEnterprise(enterprise);

        return i;
    }

    /**
     * 修改企业
     * @param enterprise
     * @return
     */
    @Override
    public int updateEnterprise(Enterprise enterprise) {

        int i = enterpriseMapper.updateEnterprise(enterprise);

        return i;
    }

    /**
     * 根据id查询企业所有信息
     * @param id
     * @return
     */
    @Override
    public Enterprise findEnterpriseById(Integer id) {

        Enterprise enterprise = enterpriseMapper.findEnterpriseById(id);

        return enterprise;
    }
}
