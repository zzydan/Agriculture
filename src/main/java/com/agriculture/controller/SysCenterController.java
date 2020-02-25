package com.agriculture.controller;


import com.agriculture.pojo.Enterprise;
import com.agriculture.pojo.OrderPageInfo;
import com.agriculture.pojo.SecRole;
import com.agriculture.pojo.SecUser;
import com.agriculture.service.SysCenterService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;


/**
 * @program: agriculture
 * @description: 系统管理
 * @author: 罗子鉴
 * @create: 2019-06-27 15:25
 **/
@Controller
@RequestMapping("/sysCenter")
public class SysCenterController<pu> {

    @Autowired
    private SysCenterService sysCenterServiceImpl;

    /**
     *  显示管理员信息并返回到前台
     * @param pageInfo
     * @return  PageInfo<SecUser>
     */
    @RequestMapping("findManager")
    @ResponseBody
    public PageInfo<SecUser> findManager(OrderPageInfo pageInfo) {

        PageInfo<SecUser> user = sysCenterServiceImpl.findManager(pageInfo);

        return user;
    }

    /**
     * 查询所有角色
     * @return
     */
    @RequestMapping("findRole")
    @ResponseBody
    public List<SecRole> findRole(){

        List<SecRole> roles = sysCenterServiceImpl.findRole();

        return roles;
    }
    /**
     * 验证用户唯一性
     * @param userName
     * @return
     */
    @RequestMapping("findUserName")
    @ResponseBody
    public int findUserName(String userName){

        int i=  sysCenterServiceImpl.findUserName(userName);

        return i;
    }

    /**
     * 添加用户
     * @param SecUser
     * @return
     */
    @RequestMapping("addUser")
    @ResponseBody
    public int addUser(SecUser SecUser){
        return sysCenterServiceImpl.addUser(SecUser);
    }

    /**
     * 查询用户回显
     * @param id
     * @return
     */
    @RequestMapping("selectUserId/{id}")
    @ResponseBody
    public  SecUser selectUserId(@PathVariable("id")Integer id){
        SecUser list=sysCenterServiceImpl.selectUserId(id);
        return list;
    }

    /**
     * 删除用户
     * @param id
     * @return
     */
    @RequestMapping("deleteUserId/{id}")
    @ResponseBody
    public int deleteUserId(@PathVariable("id")Integer id){
        return sysCenterServiceImpl.deleteUserId(id);
    }

    /**
     * 查询所有企业
     * @return
     */
    @RequestMapping("findEnterprise")
    @ResponseBody
    public List<Enterprise> findEnterprise(){
        List<Enterprise> list=sysCenterServiceImpl.findEnterprise();
        return list;
    }

    /**
     * 修改用户
     * @param SecUser
     * @return
     */
    @RequestMapping("upUserId")
    @ResponseBody
    public int upUserId(SecUser SecUser){
        return sysCenterServiceImpl.upUserId(SecUser);
    }

    /**
     * 查询角色模块信息
     * @return
     */
    @RequestMapping("findRoleEnter")
    @ResponseBody
    public List<SecRole> findRoleEnter(){
        List<SecRole> list=sysCenterServiceImpl.findRoleEnter();
        return list;
    }

    /**
     * 添加角色
     * @param SecRole
     * @return
     */
    @RequestMapping("addRole")
    @ResponseBody
    public int addRole(SecRole SecRole){
        return sysCenterServiceImpl.addRole(SecRole);
    }
    /**
     * 查询单个角色
     * @return
     */
    @RequestMapping("findRoleId/{id}")
    @ResponseBody
    public SecRole findRoleId(@PathVariable("id")Integer id){
        SecRole list=sysCenterServiceImpl.findRoleId(id);
        return list;
    }

    /**
     * 修改角色
     * @param SecRole
     * @return
     */
    @RequestMapping("upRoleId")
    @ResponseBody
    public int upRoleId(SecRole SecRole){
        return sysCenterServiceImpl.upRoleId(SecRole);
    }
    /**
     * 删除角色
     * @param id
     * @return
     */
    @RequestMapping("deleteRoleId/{id}")
    @ResponseBody
    public int deleteRoleId(@PathVariable("id")Integer id){
        return sysCenterServiceImpl.deleteRoleId(id);
    }


    /**
     * 企业管理的查询
     * @param pageInfo
     * @return
     */
    @RequestMapping("/findEnterpriseByPage")
    @ResponseBody
    public PageInfo<Enterprise> findEnterpriseByPage(OrderPageInfo pageInfo){

        PageInfo<Enterprise> enterpriseList = sysCenterServiceImpl.findEnterpriseByPage(pageInfo);

        return enterpriseList;
    }

    /**
     * 企业管理的新增
     * @param enterprise
     * @return
     */
    @RequestMapping("/addEnterprise")
    @ResponseBody
    public boolean addEnterprise(Enterprise enterprise){

        int i =  sysCenterServiceImpl.addEnterprise(enterprise);

        return i>0;

    }

    /**
     * 根据id 查询所有数据
     * @param id
     * @return
     */
    @RequestMapping("/findEnterpriseById/{id}")
    @ResponseBody
    public Enterprise findEnterpriseById(@PathVariable("id")Integer id){

        Enterprise enterprise = sysCenterServiceImpl.findEnterpriseById(id);

        return enterprise;
    }

    /**
     * 企业管理的修改
     * @param enterprise
     * @return
     */
    @RequestMapping("/updateEnterprise")
    @ResponseBody
    public boolean updateEnterprise(Enterprise enterprise){

        int i =  sysCenterServiceImpl.updateEnterprise(enterprise);

        return i>0;
    }
}

