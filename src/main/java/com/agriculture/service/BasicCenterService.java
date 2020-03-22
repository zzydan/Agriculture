package com.agriculture.service;

import com.agriculture.pojo.*;
import com.github.pagehelper.PageInfo;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * @program: agriculture
 * @description: 基本管理业务层
 * @author: 常高杰
 * @create: 2020-02-21 16:39
 **/
public interface BasicCenterService {


    /**
     * 添加地块
     * @param parvialfield
     * @param location
     * @return
     */
    boolean addPlace(Parvialfield parvialfield, Location location);


    /**
     * 查询分场列表
     * @param
     * @return
     */
    List<Parvialfield> getFenChangList();

    /**
     * 查询角色id查询人员列表
     * @param roleId
     * @return
     */
    List<SecUser> getUserListByRole(Integer roleId);

    /**
     * 根据分场id查询分场详情信息
     * @param id
     * @return
     */
    Parvialfield getFenChangById(Integer id);

    /**
     * 修改地块信息
     * @param parvialfield
     * @return
     */
    boolean updatePlace(Parvialfield parvialfield);
    /**
     * 查询作物种类列表
     * @param
     * @return
     */
    List<CropSpecies> getSpeciesList();
    /**
     * 查询作物品种列表
     * @param
     * @return
     */
    List<CropVariety> getVarietyList();

    /**
     * 查询作物品种列表 根据种类id
     * @param SpeciesId
     * @return
     */
    List<CropVariety> getVarietyListBySpeciesId(Integer SpeciesId);
    /**
     * 模糊查询农资
     * @param pageInfo
     * @return
     */
    PageInfo<Agricultural> SelectAgric(OrderPageInfo pageInfo);
    /**
     * 添加农资
     * @param Agricultural
     * @return
     */
    int AddAgric(Agricultural Agricultural);
    /**
     * 删除农资
     * @param id
     * @return
     */
    int DeleteAgricId(Integer id);

    /**
     * 查询单个农资信息
     * @param id
     * @return
     */
    Agricultural SelectAgricId(Integer id);
    /**
     * 修改农资
     * @param Agricultural
     * @return
     */
    int UpdateAgricId(Agricultural Agricultural);

    /**
     * 查询所有模板
     * @param pageInfo
     * @return
     */
    PageInfo<Template> findTemplate(OrderPageInfo pageInfo);

    /**
     * 查询单个模板详情
     * @param templateId
     * @return
     */
    Template findTemplateById(Integer templateId);
/*
    *//**
     * 添加地块
     * @param lot,overlay
     * @return
     *//*
    boolean addLot(Lot lot, List<Location> locations);*/

    /**
     * 查询分场列表vo,一个分场对多个地块，一个地块有对应多个经纬度
     * @param
     * @return
     */
    List<ParvialfieldVo> getFenChangListVo();

    /**
     * 根据地块id查询地块详情
     * @param lotId
     * @return
     */
    Lot getLotById(Integer lotId);

    /**
     * 根据分场id查询所有地块详情
     * @param fenChangId
     * @return
     */
    List<Lot> getLotByFenChangId(Integer fenChangId);

    /**
     * 查询所有地块详情
     * @param
     * @param fenChangId
     * @param diKuaiName
     * @return
     */
    List<Lot> getLotListAll(Integer fenChangId, String diKuaiName);

    /**
     * 根据地块id修改地块详情
     * @param lot
     * @return
     */
    boolean updateLot(Lot lot);


    /**
     * 根据种类id 查询作物生育周期
     * @param speciesId
     * @param varietyId
     * @return
     */
    List<CropGrowthCycleTime> getCropGrowthCycleList(Integer speciesId, Integer varietyId);

    /**
     * 删除模板
     * @param templateId
     * @return
     */
    int deleteTemplate(Integer templateId);

    /**
     * 添加模板
     * @param template
     * @return
     */
    int addTemplate(Template template);


    /**
     * 删除分场
     * @param id
     * @return
     */
    boolean deleteFenChangById(Integer id);

    /**
     * 查询所有农事
     * @return
     */
    List<Work> getWorkList();

    /**
     * 查询所有农资
     * @return
     */
    List<Agricultural> getAgricList();
    /**
     * 查询作物品种
     * @return
     */
    List<CropSpecies> SelectCropAll();



    /**
     * 添加作物种类名称
     * @param CropSpecies
     * @return
     */
    int addcrop(CropSpecies CropSpecies, MultipartFile user1Pic);
    /**
     * 查看作物品种
     * @return
     */
    List<CropVariety> findVariety();
    /**
     * 查询单个品种
     * @param id
     * @return
     */
    CropVariety findVarietyId(Integer id);
    /**
     * 删除品种
     * @param id
     * @return
     */
    int deleteVariety(Integer id);
    /**
     * 添加种类
     * @param cropVariety
     * @return
     */
    int InsertVariety(CropVariety cropVariety);
    /**
     * 修改种类
     * @param cropVariety
     * @return
     */
    int updataVariety(CropVariety cropVariety);
    /**
     * 查询所有农事
     * @return
     */
    List<FarmWork> FindFarm();

    /**
     * 查询单个农事信息
     * @param id
     * @return
     */
    FarmWork FindFarmId(@Param("id")Integer id);
    /**
     * 添加农事
     * @param FarmWork
     * @return
     */
    int addFarm(FarmWork FarmWork);
    /**
     * 修改农事
     * @param FarmWork
     * @return
     */
    int UpdateFarm(FarmWork FarmWork);

    /**
     * 删除农事
     * @param id
     * @return
     */
    int deleteFarm(Integer id);
    /**
     * 查询所有生育时期
     * @return
     */
    List<CropGrowthCycleTime> FindCropGrowthCycleTime();
    /**
     * 添加生育周期
     * @param CropGrowthCycle
     * @return
     */
    Boolean addCropGrowth(CropGrowthCycle CropGrowthCycle,String[] zwswxld_up,String[] starttime,String[] endtime);
    /**
     * 查询单个生育周期信息
     * @param id
     * @return
     */
    List<CropGrowthCycleTime> SelectCropTimeId(@Param("id")Integer id);
    /**
     * 删除生育种类
     * @param id
     * @return
     */
    int deleteCrop(Integer id);
    /**
     * 查询单个种类
     * @param id
     * @return
     */
    CropSpecies SelectCropSpeciesId(@Param("id")Integer id);
    /**
     * 修改种类
     * @param CropSpecies
     * @return
     */
    int UpdateCropSpercies(CropSpecies CropSpecies);
    /**
     * 删除种类
     * @param id
     * @return
     */
    int DeleteCropSperciesId(Integer id);
}
