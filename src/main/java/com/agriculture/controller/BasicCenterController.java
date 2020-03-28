package com.agriculture.controller;


import com.agriculture.pojo.*;
import com.agriculture.service.BasicCenterService;
import com.agriculture.tools.JSONUtils;
import com.alibaba.fastjson.JSONArray;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

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
     * 添加分场
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
     * 修改分场信息
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
     * 删除分场
     * @param id
     * @return
     */
    @RequestMapping("deleteFenChangById")
    @ResponseBody
    public boolean deleteFenChangById(Integer id){

        boolean b = basicCenterService.deleteFenChangById(id);

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
     * 查询分场列表vo
     * @return
     */
    @RequestMapping("getFenChangListVo")
    @ResponseBody
    public List<ParvialfieldVo> getFenChangListVo(){

        List<ParvialfieldVo> parvialfields = basicCenterService.getFenChangListVo();

        return parvialfields;
    }

    /**
     * 根据地块id查询地块详情
     * @param lotId
     * @return
     */
    @RequestMapping("getLotById")
    @ResponseBody
    public Lot getLotById(Integer lotId){

        Lot lot = basicCenterService.getLotById(lotId);

        return lot;
    }
    /**
     * 根据地块id修改地块详情
     * @param lot
     * @return
     */
    @RequestMapping("updateLot")
    @ResponseBody
    public boolean updateLot(Lot lot){

      boolean b = basicCenterService.updateLot(lot);

        return b;
    }
    /**
     * 根据分场id查询所有地块详情
     * @param fenChangId
     * @return
     */
    @RequestMapping("getLotByFenChangId")
    @ResponseBody
    public List<Lot> getLotByFenChangId(Integer fenChangId){

        List<Lot> lots = basicCenterService.getLotByFenChangId(fenChangId);

        return lots;
    }
    /**
     * 查询所有地块详情
     * @param fenChangId,diKuaiName
     * @return
     */
    @RequestMapping("getLotListAll")
    @ResponseBody
    public List<Lot> getLotListAll(Integer fenChangId,String diKuaiName){

        List<Lot> lots = basicCenterService.getLotListAll(fenChangId,diKuaiName);

        return lots;
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


   /* *//**
     * 添加地块
     * @param lot,overlay
     * @return
     *//*
    @RequestMapping("addLot")
    @ResponseBody
    public boolean addLot(Lot lot,String overlay){

        //把js对象数组转化为对象集合
        List<Location> locations = (List<Location>)JSONArray.parseArray(overlay, Location.class);
        boolean b = basicCenterService.addLot(lot,locations);

        return b;
    }*/

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
     * 查询单个农资
     * @return
     */
    @RequestMapping("SelectAgricId/{id}")
    @ResponseBody
    public Agricultural SelectAgricId(@PathVariable("id")Integer id){
        Agricultural list=basicCenterService.SelectAgricId(id);
        return list;
    }

    /**
     *
     * @param Agricultural
     * @return
     */
    @RequestMapping("Agricultural")
    @ResponseBody
    public int UpdateAgricId(Agricultural Agricultural){
        return basicCenterService.UpdateAgricId(Agricultural);
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
     * 查询作物品种列表 根据种类id
     * @param
     * @return
     */
    @RequestMapping("getVarietyListBySpeciesId")
    @ResponseBody
    public List<CropVariety> getVarietyListBySpeciesId(Integer SpeciesId){

        List<CropVariety> cropVarieties = basicCenterService.getVarietyListBySpeciesId(SpeciesId);

        return cropVarieties;
    }

    /**
     * 根据种类id 查询作物生育周期
     * @param
     * @return
     */
    @RequestMapping("getCropGrowthCycleList")
    @ResponseBody
    public List<CropGrowthCycleTime> getCropGrowthCycleList(Integer speciesId,Integer varietyId){

        List<CropGrowthCycleTime> cropGrowthCycleTimes = basicCenterService.getCropGrowthCycleList(speciesId,varietyId);

        return cropGrowthCycleTimes;
    }

    /**
     * 查询所有农事
     * @return
     */
    @RequestMapping("getWorkList")
    @ResponseBody
    public List<Work> getWorkList() {

        List<Work> works = basicCenterService.getWorkList();

        return works;
    }


    /**
     * 查询所有农资
     * @return
     */
    @RequestMapping("getAgricList")
    @ResponseBody
    public List<Agricultural> getAgricList() {

        List<Agricultural> agriculturals = basicCenterService.getAgricList();

        return agriculturals;
    }

    /**
     * 查询所有模板
     * @param pageInfo
     * @return
     */
    @RequestMapping("findTemplate")
    @ResponseBody
    public PageInfo<Template> findTemplate(OrderPageInfo pageInfo) {
        PageInfo<Template> template = basicCenterService.findTemplate(pageInfo);
        return template;
    }

    /**
     * 查询单个模板详情
     * @param templateId
     * @return
     */
    @RequestMapping("findTemplateById")
    @ResponseBody
    public Template findTemplateById(Integer templateId) {

        Template template = basicCenterService.findTemplateById(templateId);

        return template;
    }

    /**
     * 添加模板
     * @param template
     * @return
     */
    @RequestMapping("addTemplate")
    @ResponseBody
    public int addTemplate(Template template,String templatePlanData) {

        //还原数据
        List<TemplatePlan> templatePlans = new JSONUtils().jsonToList(templatePlanData, TemplatePlan.class);
        template.setTemplatePlanList(templatePlans);

        //添加模板
        int i = basicCenterService.addTemplate(template);

        return i;
    }

    /**
     * 修改模板
     * @param template
     * @return
     */
    @RequestMapping("updateTemplate")
    @ResponseBody
    public int updateTemplate(Template template,String templatePlanData) {

        //还原数据
        List<TemplatePlan> templatePlans = new JSONUtils().jsonToList(templatePlanData, TemplatePlan.class);
        template.setTemplatePlanList(templatePlans);

        //添加模板
        int i = basicCenterService.updateTemplate(template);

        return i;
    }

    /**
     * 删除模板
     * @param templateId
     * @return
     */
    @RequestMapping("deleteTemplate")
    @ResponseBody
    public int deleteTemplate(Integer templateId) {

        int i = basicCenterService.deleteTemplate(templateId);

        return i;
    }

    /**
     * 查询作物种类
     * @return
     */
    @RequestMapping("SelectCropAll")
    @ResponseBody
    public List<CropSpecies> SelectCropAll(){
        List<CropSpecies> list=basicCenterService.SelectCropAll();
        return list;
    }

    /**
     * 添加种类
     * @param CropSpecies
     * @param User1Pic
     * @return
     */
    @RequestMapping("addcrop")
    @ResponseBody
    public boolean addcrop(CropSpecies CropSpecies, MultipartFile User1Pic){
        System.out.println(User1Pic);
        int i=basicCenterService.addcrop(CropSpecies,User1Pic);
        return i>0;
    }
    /**
     * 查询作物品种
     * @return
     */
    @RequestMapping("findVariety")
    @ResponseBody
    public List<CropVariety> findVariety(){
        List<CropVariety> list=basicCenterService.findVariety();
        return list;
    }
    /**
     * 查询品种回显
     * @param id
     * @return
     */
    @RequestMapping("findVarietyId/{id}")
    @ResponseBody
    public  CropVariety findVarietyId(@PathVariable("id")Integer id){
        CropVariety list=basicCenterService.findVarietyId(id);
        return list;
    }
    /**
     * 删除品种
     * @param id
     * @return
     */
    @RequestMapping("deleteVariety/{id}")
    @ResponseBody
    public int deleteVariety(@PathVariable("id")Integer id){
        return basicCenterService.deleteVariety(id);
    }

    /**
     * 添加品种
     * @param cropVariety
     * @return
     */
    @RequestMapping("InsertVariety")
    @ResponseBody
    public int InsertVariety(CropVariety cropVariety){
        return basicCenterService.InsertVariety(cropVariety);
    }

    /**
     * 修改品种
     * @param cropVariety
     * @return
     */
    @RequestMapping("updataVariety")
    @ResponseBody
    public int updataVariety(CropVariety cropVariety){
        return basicCenterService.updataVariety(cropVariety);
    }

    /**
     * 查询所有农事
     * @return
     */
    @RequestMapping("FindFarm")
    @ResponseBody
    public List<FarmWork> FindFarm() {
        List<FarmWork> list=basicCenterService.FindFarm();
        return list;
    }

    /**
     * 查询单个农事信息
     * @param id
     * @return
     */
    @RequestMapping("FindFarmId/{id}")
    @ResponseBody
    public FarmWork FindFarmId(@PathVariable("id")Integer id) {
        return basicCenterService.FindFarmId(id);
    }
    /**
     * 添加农事
     * @param FarmWork
     * @return
     */
    @RequestMapping("addFarm")
    @ResponseBody
    public int addFarm(FarmWork FarmWork) {
        return basicCenterService.addFarm(FarmWork);
    }
    /**
     * 修改农事
     * @param FarmWork
     * @return
     */
    @RequestMapping("UpdateFarm")
    @ResponseBody
    public int UpdateFarm(FarmWork FarmWork) {
        return basicCenterService.UpdateFarm(FarmWork);
    }

    /**
     * 删除农事
     * @param id
     * @return
     */
    @RequestMapping("deleteFarm/{id}")
    @ResponseBody
    public int deleteFarm(@PathVariable("id")Integer id) {
        return basicCenterService.deleteFarm(id);
    }
    /**
     * 查询所有的生育时期
     * @return
     */
    @RequestMapping("FindCropGrowthCycleTime")
    @ResponseBody
    public List<CropGrowthCycleTime> FindCropGrowthCycleTime() {
        List<CropGrowthCycleTime> list=basicCenterService.FindCropGrowthCycleTime();
        return list;
    }
    /**
     * 添加生育周期时期
     * @param CropGrowthCycle
     * @param zwswxld_up
     * @param starttime
     * @param endtime
     * @return
     */
    @RequestMapping("/addCropGrowth")
    @ResponseBody
    public boolean addCropGrowth(CropGrowthCycle CropGrowthCycle, @RequestParam("zwswxld_up[]") String[] zwswxld_up, @RequestParam("starttime[]") String[] starttime,@RequestParam("endtime[]") String[] endtime){
        System.out.println("添加生育周期");
        Boolean bo=basicCenterService.addCropGrowth(CropGrowthCycle, zwswxld_up,starttime ,endtime);
        return bo;
    }
    /**
     * 查询单个生育周期信息
     * @param id
     * @return
     */
    @RequestMapping("/SelectCropTimeId/{id}")
    @ResponseBody
    public List<CropGrowthCycleTime> SelectCropTimeId(@PathVariable("id")Integer id) {
        return basicCenterService.SelectCropTimeId(id);
    }
    /**
     * 删除生育种类
     * @param id
     * @return
     */
    @RequestMapping("/deleteCrop/{id}")
    @ResponseBody
    public int deleteCrop(@PathVariable("id")Integer id) {
        return basicCenterService.deleteCrop(id);
    }
    /**
     * 查询单个种类
     * @param id
     * @return
     */
    @RequestMapping("/SelectCropSpeciesId/{id}")
    @ResponseBody
    public CropSpecies SelectCropSpeciesId(@PathVariable("id")Integer id) {
        return basicCenterService.SelectCropSpeciesId(id);
    }
    /**
     * 修改种类
     * @param CropSpecies
     * @return
     */
    @RequestMapping("UpdateCropSpercies")
    @ResponseBody
    public int UpdateCropSpercies(CropSpecies CropSpecies) {
        return basicCenterService.UpdateCropSpercies(CropSpecies);
    }
    /**
     * 删除种类
     * @param id
     * @return
     */
    @RequestMapping("/DeleteCropSperciesId/{id}")
    @ResponseBody
    public int DeleteCropSperciesId(@PathVariable("id")Integer id) {
        return basicCenterService.DeleteCropSperciesId(id);
    }
}

