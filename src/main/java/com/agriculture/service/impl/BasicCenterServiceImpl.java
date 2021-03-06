package com.agriculture.service.impl;

import com.agriculture.dao.AgriculturalMapper;
import com.agriculture.dao.TemplateMapper;
import com.agriculture.dao.*;
import com.agriculture.pojo.*;
import com.agriculture.service.BasicCenterService;
import com.agriculture.tools.OssUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.util.List;

/**
 * @program: agriculture
 * @description: 基本管理业务层
 * @author: 常高杰
 * @create: 2020-02-21 16:39
 **/
@Service
public class BasicCenterServiceImpl implements BasicCenterService {

    @Resource
    private CropVarietyMapper cropVarietyMapper;
    @Resource
    private CropSpeciesMapper cropSpeciesMapper;
    @Resource
    private LocationMapper locationMapper;
    @Resource
    private ParvialfieldMapper parvialfieldMapper;
    @Resource
    private SecUserMapper secUserMapper;
    @Resource
    private LotMapper lotMapper;
    @Resource
    private AgriculturalMapper AgriculturalMapper;
    @Resource
    private TemplateMapper templateMapper;
    @Autowired
    private TemplatePlanMapper templatePlanMapper;
    @Autowired
    private TemplatePlanAgriculturalMapper templatePlanAgriculturalMapper;

    @Autowired
    private CropGrowthCycleTimeMapper cropGrowthCycleTimeMapper;
    @Autowired
    private WorkMapper workMapper;
    @Autowired
    private SecPicMapper secPicMapper;
    @Autowired
    private AgriculturalMapper agriculturalMapper;
    @Autowired
    private FarmWorkMapper farmWorkMapper;
    @Autowired
    private CropGrowthCycleMapper CropGrowthCycleMapper;
    @Autowired
    private OssUtils ossUtils;





    /**
     * 添加分场
     * @param parvialfield
     * @param location
     * @return
     */
    @Transactional
    @Override
    public boolean addPlace(Parvialfield parvialfield, Location location) {

        /*添加地块表主键返回*/
        boolean b=parvialfieldMapper.addParvialfield(parvialfield);
        location.setObjId(parvialfield.getId());
        location.setObjType("zone");

        /* 添加地理位置表*/
        boolean b1=locationMapper.addLocation(location);

        return b&b1;
    }

    /**
     * 查询分场列表
     * @param
     * @return
     */
    @Override
    public List<Parvialfield> getFenChangList() {

        List<Parvialfield> parvialfields = parvialfieldMapper.getFenChangList();

        return parvialfields;
    }


    /**
     * 查询角色id查询人员列表
     * @param roleId
     * @return
     */
    @Override
    public List<SecUser> getUserListByRole(Integer roleId) {

        List<SecUser> secUsers = secUserMapper.getUserListByRole(roleId);

        return secUsers;
    }

    /**
     * 根据分场id查询分场详情信息
     * @param id
     * @return
     */
    @Override
    public Parvialfield getFenChangById(Integer id) {

        Parvialfield parvialfield = parvialfieldMapper.getFenChangById(id);

        return parvialfield;
    }

    /**
     * 修改分场信息
     * @param parvialfield
     * @return
     */
    @Override
    @Transactional
    public boolean updatePlace(Parvialfield parvialfield) {

        //分场修改基本信息
        boolean b=parvialfieldMapper.updateParvialfield(parvialfield);

        /* 修改分场地理位置*/
        boolean b1=locationMapper.updateLocation(parvialfield);
        return false;
    }

    /**
     * 删除分场
     * @param id
     * @return
     */
    @Transactional
    @Override
    public boolean deleteFenChangById(Integer id) {
        //删除分场表
        boolean b=parvialfieldMapper.deleteFenChangById(id);
        //删除地块表
        boolean b1=lotMapper.deleteLotByParvialfiledId(id);
        return b&&b1;
    }

  /*  *//**
     * 添加地块
     * @param lot,overlay
     * @return
     *//*
    @Transactional
    @Override
    public boolean addLot(Lot lot, List<Location> locations) {

        //添加地块表
        boolean b = lotMapper.addLot(lot);

        //添加地理位置表
        for (int i = 0; i <locations.size() ; i++) {
            locations.get(i).setObjId(lot.getId());
            locations.get(i).setObjType("lot");
        }
        boolean b1=locationMapper.addLocations(locations);

        return b&b1;
    }*/

    /**
     * 查询分场列表vo,一个分场对多个地块，一个地块有对应多个经纬度
     * @param
     * @return
     */
    @Override
    public List<ParvialfieldVo> getFenChangListVo() {

        List<ParvialfieldVo> parvialfields = parvialfieldMapper.getFenChangListVo();
        return parvialfields;
    }

    /**
     * 根据地块id查询地块详情
     * @param lotId
     * @return
     */
    @Override
    public Lot getLotById(Integer lotId) {
        Lot lot = lotMapper.getLotById(lotId);
        return lot;
    }
    /**
     * 根据分场id查询所有地块详情
     * @param fenChangId
     * @return
     */
    @Override
    public List<Lot> getLotByFenChangId(Integer fenChangId) {
        List<Lot> lots = lotMapper.getLotByFenChangId(fenChangId);
        return lots;
    }
    /**
     * 查询所有地块详情
     * @param
     * @param fenChangId
     * @param diKuaiName
     * @return
     */
    @Override
    public List<Lot> getLotListAll(Integer fenChangId, String diKuaiName) {
        List<Lot> lots = lotMapper.getLotListAll(fenChangId,diKuaiName);
        return lots;
    }

    /**
     * 根据地块id修改地块详情
     * @param lot
     * @return
     */
    @Override
    public boolean updateLot(Lot lot) {

        boolean b = lotMapper.updateLot(lot);

        return b;
    }

    /**
     * 查询所有农资
     * @param pageInfo
     * @return
     */
    @Override
    public PageInfo<Agricultural> SelectAgric(OrderPageInfo pageInfo) {
        PageHelper.offsetPage(pageInfo.getOffset(), pageInfo.getLimit());

        List<Agricultural> list = AgriculturalMapper.SelectAgric(pageInfo);

        PageInfo info = new PageInfo(list);

        return info;
    }

    /**
     * 添加农资信息
     * @param Agricultural
     * @return
     */
    @Override
    public int AddAgric(Agricultural Agricultural) {
        return AgriculturalMapper.AddAgric(Agricultural);
    }

    /**
     * 删除农资
     * @param id
     * @return
     */
    @Override
    public int DeleteAgricId(Integer id) {
        return AgriculturalMapper.DeleteAgricId(id);
    }

    /**
     * 查询单个
     * @param id
     * @return
     */
    @Override
    public Agricultural SelectAgricId(Integer id) {
        return AgriculturalMapper.SelectAgricId(id);
    }

    /**
     * 修改农资
     * @param Agricultural
     * @return
     */
    @Override
    public int UpdateAgricId(Agricultural Agricultural) {
        return AgriculturalMapper.UpdateAgricId(Agricultural);
    }


    /**
     * 查询作物种类列表
     * @param
     * @return
     */
    @Override
    public List<CropSpecies> getSpeciesList() {
        List<CropSpecies> cropSpecies = cropSpeciesMapper.getSpeciesList();
        return cropSpecies;
    }

    /**
     * 查询作物品种列表
     * @param
     * @return
     */
    @Override
    public List<CropVariety> getVarietyList() {
        List<CropVariety> cropVarieties = cropVarietyMapper.getVarietyList();
        return cropVarieties;
    }

    /**
     * 查询作物品种列表 根据种类id
     * @param SpeciesId
     * @return
     */
    @Override
    public List<CropVariety> getVarietyListBySpeciesId(Integer SpeciesId) {
        List<CropVariety> cropVarieties = cropVarietyMapper.getVarietyListBySpeciesId(SpeciesId);
        return cropVarieties;
    }

    /**
     * 根据作物种类查询作物周期
     * @param speciesId
     * @param varietyId
     * @return
     */
    @Override
    public List<CropGrowthCycleTime> getCropGrowthCycleList(Integer speciesId, Integer varietyId) {

        List<CropGrowthCycleTime> cropGrowthCycleTimes = cropGrowthCycleTimeMapper.getCropGrowthCycleTime(speciesId,varietyId);

        return cropGrowthCycleTimes;
    }

    /**
     * 查询所有农事
     * @return
     */
    @Override
    public List<Work> getWorkList() {

        List<Work> workList = workMapper.getWorkList();

        return workList;
    }

    /**
     * 查询所有农资
     * @return
     */
    @Override
    public List<Agricultural> getAgricList() {

        List<Agricultural> agricList = agriculturalMapper.getAgricList();

        return agricList;
    }

    @Override
    public List<CropSpecies> SelectCropAll() {
        List<CropSpecies> list=cropSpeciesMapper.SelectCropAll();
        return list;
    }

    /**
     * 查询所有模板
     * @param pageInfo
     * @return
     */
    @Override
    public PageInfo<Template> findTemplate(OrderPageInfo pageInfo) {

        PageHelper.offsetPage(pageInfo.getOffset(),pageInfo.getLimit());

        List<Template> list = templateMapper.findTemplate(pageInfo);

        PageInfo info = new PageInfo(list);

        return info;
    }

    /**
     * 查询单个模板详情
     * @param templateId
     * @return
     */
    @Override
    public Template findTemplateById(Integer templateId) {

        return templateMapper.findTemplateById(templateId);
    }

    /**
     * 添加模板
     * @param template
     * @return
     */
    @Override
    public int addTemplate(Template template) {
        //添加模板基础信息
        int i = templateMapper.addTemplate(template);
        if(i>0){
            //循环添加模板农事信息
            for (TemplatePlan templatePlan:template.getTemplatePlanList()) {
                int result = templatePlanMapper.addTemplatePlan(templatePlan,template.getId());
                //循环添加农资信息
                if(result>0){
                    templatePlanAgriculturalMapper.addTemplatePlanAgricultural(templatePlan.getTemplatePlanAgriculturalList(),templatePlan.getId());
                }
            }
        }
        return i;
    }

    /**
     * 修改模板
     * @param template
     * @return
     */
    @Override
    public int updateTemplate(Template template) {

        //修改模板基础信息
        int i = templateMapper.updateTemplate(template);
        int delTemplatePlan = templatePlanMapper.delTemplatePlanByTemplateId(template.getId());
        //循环添加模板农事信息
        for (TemplatePlan templatePlan:template.getTemplatePlanList()) {
            int result = templatePlanMapper.addTemplatePlan(templatePlan,template.getId());
            //循环添加农资信息
            if(result>0){
                templatePlanAgriculturalMapper.addTemplatePlanAgricultural(templatePlan.getTemplatePlanAgriculturalList(),templatePlan.getId());
            }
        }

        return i;
    }

    /**
     * 删除模板
     * @param templateId
     * @return
     */
    @Override
    public int deleteTemplate(Integer templateId) {

        return templateMapper.deleteTemplate(templateId);
    }
    /**
     * 添加作物种类
     * @param CropSpecies
     * @param user1Pic
     * @return
     */
    @Override
    public int addcrop(CropSpecies CropSpecies, MultipartFile user1Pic) {
        if (user1Pic != null) {
            String filename = user1Pic.getOriginalFilename();
            if (!"".equals(filename.trim())) {
                //上传到OSS
                String uploadUrl = ossUtils.uploadImg2Oss(user1Pic);
                SecPic secPic = new SecPic();
                secPic.setName(filename);
                secPic.setInfo("PicId-1 pic");
                secPic.setPath(uploadUrl);

                int id = secPicMapper.addPiC(secPic);

                CropSpecies.setPicId(secPic.getId());
            }
        }
        int i=cropSpeciesMapper.addcrop(CropSpecies);
        return i;
    }

    /**
     * 查询所有品种
     * @return
     */
    @Override
    public List<CropVariety> findVariety() {
        List<CropVariety> list= cropVarietyMapper.findVariety();
        return list;
    }

    @Override
    public CropVariety findVarietyId(Integer id) {
        return cropVarietyMapper.findVarietyId(id);
    }

    /**
     * 删除品种
     * @param id
     * @return
     */
    @Override
    public int deleteVariety(Integer id) {
        return cropVarietyMapper.deleteVariety(id);
    }

    /**
     * 添加品种
     * @param cropVariety
     * @return
     */
    @Override
    public int InsertVariety(CropVariety cropVariety) {
        return cropVarietyMapper.InsertVariety(cropVariety);
    }

    /**
     * 修改品种
     * @param cropVariety
     * @return
     */
    @Override
    public int updataVariety(CropVariety cropVariety) {
        return cropVarietyMapper.updataVariety(cropVariety);
    }

    /**
     * 查询所有农事
     * @return
     */
    @Override
    public List<FarmWork> FindFarm() {
        List<FarmWork> list=farmWorkMapper.FindFarm();
        return list;
    }

    /**
     * 查询单个农事
     * @param id
     * @return
     */
    @Override
    public FarmWork FindFarmId(Integer id) {
        return farmWorkMapper.FindFarmId(id);
    }

    /**
     * 添加农事
     * @param FarmWork
     * @return
     */
    @Override
    public int addFarm(FarmWork FarmWork) {
        return farmWorkMapper.addFarm(FarmWork);
    }

    /**
     * 修改农事
     * @param FarmWork
     * @return
     */
    @Override
    public int UpdateFarm(FarmWork FarmWork) {
        return farmWorkMapper.UpdateFarm(FarmWork);
    }

    /**
     * 删除农事
     * @param id
     * @return
     */
    @Override
    public int deleteFarm(Integer id) {
        return farmWorkMapper.deleteFarm(id);
    }

    @Override
    public List<CropGrowthCycleTime> FindCropGrowthCycleTime() {
        List<CropGrowthCycleTime> list=cropGrowthCycleTimeMapper.FindCropGrowthCycleTime();
        return list;
    }


    /**
     * 查询所有的生育时期
     * @return
     */
    @Override
    public Boolean addCropGrowth(CropGrowthCycle CropGrowthCycle,String[] zwswxld_up, String[] starttime, String[] endtime) {
        boolean b=CropGrowthCycleMapper.addCropGrowth(CropGrowthCycle);
        if(b=true){
            for (int i = 0; i < zwswxld_up.length; i++) {
                cropGrowthCycleTimeMapper.AddCroptime(CropGrowthCycle.getId(), zwswxld_up[i], starttime[i],endtime[i]);
                System.out.println(CropGrowthCycle.getId());
            }
        }
        return b;
    }
    /**
     * 查询单个生育周期信息
     * @param id
     * @return
     */
    @Override
    public List<CropGrowthCycleTime> SelectCropTimeId(Integer id) {
        return cropGrowthCycleTimeMapper.SelectCropTimeId(id);
    }

    /**
     * 删除生育种类
     * @param id
     * @return
     */
    @Override
    public int deleteCrop(Integer id) {
        return CropGrowthCycleMapper.deleteCrop(id);
    }
    /**
     * 查询单个种类
     * @param id
     * @return
     */
    @Override
    public CropSpecies SelectCropSpeciesId(Integer id) {
        return cropSpeciesMapper.SelectCropSpeciesId(id);
    }
    /**
     * 修改种类
     * @param CropSpecies
     * @return
     */
    @Override
    public int UpdateCropSpercies(CropSpecies CropSpecies) {
        return cropSpeciesMapper.UpdateCropSpercies(CropSpecies);
    }
    /**
     * 删除种类
     * @param id
     * @return
     */
    @Override
    public int DeleteCropSperciesId(Integer id) {
        return cropSpeciesMapper.DeleteCropSperciesId(id);
    }


}
