package com.agriculture.controller;


import com.agriculture.pojo.*;
import com.agriculture.service.BasicCenterService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;


/**
 * @program: agriculture
 * @description: 基本管理控制层
 * @author: 常高杰
 * @create: 2019-06-27 15:25
 **/
@Controller
@RequestMapping("/basicCenter")
public class BasicCenterController {

    @Autowired
    private BasicCenterService basicCenterService;

    /**
     * 添加地块
     * @param parvialfield
     * @return
     */
    @RequestMapping("addPlace")
    @ResponseBody
    public boolean addPlace(Parvialfield parvialfield){

        Location location = new Location();
        location.setLatitude(parvialfield.getLatitude());
        location.setLongitude(parvialfield.getLongitude());
        boolean b = basicCenterService.addPlace(parvialfield,location);

        return b;
    }

    /**
     * 修改地块信息
     * @param parvialfield
     * @return
     */
    @RequestMapping("updatePlace")
    @ResponseBody
    public boolean updatePlace(Parvialfield parvialfield){

        boolean b = basicCenterService.updatePlace(parvialfield);

        return b;
    }

    /**
     * 查询分场列表
     * @return
     */
    @RequestMapping("getFenChangList")
    @ResponseBody
    public List<Parvialfield> getFenChangList(){

        List<Parvialfield> parvialfields = basicCenterService.getFenChangList();

        return parvialfields;
    }

    /**
     * 查询角色id查询人员列表
     * @param roleId
     * @return
     */
    @RequestMapping("getUserListByRole")
    @ResponseBody
    public List<SecUser> getUserListByRole(Integer roleId){

        List<SecUser> secUsers = basicCenterService.getUserListByRole(roleId);

        return secUsers;
    }
    /**
     * 根据分场id查询分场详情信息
     * @param id
     * @return
     */
    @RequestMapping("getFenChangById")
    @ResponseBody
    public Parvialfield getFenChangById(Integer id){

        Parvialfield parvialfield = basicCenterService.getFenChangById(id);

        return parvialfield;
    }
    /**
     * 查询作物种类列表
     * @param
     * @return
     */
    @RequestMapping("getSpeciesList")
    @ResponseBody
    public List<CropSpecies> getSpeciesList(){

        List<CropSpecies> cropSpecies = basicCenterService.getSpeciesList();

        return cropSpecies;
    }
    /**
     * 查询作物品种列表
     * @param
     * @return
     */
    @RequestMapping("getVarietyList")
    @ResponseBody
    public List<CropVariety> getVarietyList(){

        List<CropVariety> cropVarieties = basicCenterService.getVarietyList();

        return cropVarieties;
    }

    /**
     * 查询所有农资
     * @param pageInfo
     * @return
     */
    @RequestMapping("SelectAgric")
    @ResponseBody
    public PageInfo<Agricultural> SelectAgric(OrderPageInfo pageInfo) {

        PageInfo<Agricultural> user = basicCenterService.SelectAgric(pageInfo);

        return user;
    }

    /**
     * 添加农资信息
     * @param Agricultural
     * @return
     */
    @RequestMapping("AddAgric")
    @ResponseBody
    public int AddAgric(Agricultural Agricultural){
        return basicCenterService.AddAgric(Agricultural);
    }
    /**
     * 删除农资
     * @param id
     * @return
     */
    @RequestMapping("DeleteAgricId/{id}")
    @ResponseBody
    public int DeleteAgricId(@PathVariable("id")Integer id){
        return basicCenterService.DeleteAgricId(id);
    }
    /**
     * 查询单个角色
     * @return
     */
    @RequestMapping("SelectAgricId/{id}")
    @ResponseBody
    public Agricultural SelectAgricId(@PathVariable("id")Integer id){
        Agricultural list=basicCenterService.SelectAgricId(id);
        return list;
    }
    @RequestMapping("Agricultural")
    @ResponseBody
    public int UpdateAgricId(Agricultural Agricultural){
        return basicCenterService.UpdateAgricId(Agricultural);
    }






}

