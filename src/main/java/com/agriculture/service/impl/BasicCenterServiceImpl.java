package com.agriculture.service.impl;

import com.agriculture.dao.AgriculturalMapper;
import com.agriculture.dao.BasicCenterMapper;
import com.agriculture.dao.TemplateMapper;
import com.agriculture.dao.*;
import com.agriculture.pojo.*;
import com.agriculture.service.BasicCenterService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
    private BasicCenterMapper basicCenterMapper;
    @Autowired
    private AgriculturalMapper AgriculturalMapper;
    @Autowired
    private TemplateMapper templateMapper;

    /**
     * 添加地块
     * @param parvialfield
     * @param location
     * @return
     */
    @Transactional
    @Override
    public boolean addPlace(Parvialfield parvialfield, Location location) {

        /*添加地块表主键返回*/
        boolean b=basicCenterMapper.addParvialfield(parvialfield);
        location.setObjId(parvialfield.getId());
        location.setObjType("zone");

        /* 添加地理位置表*/
        boolean b1=basicCenterMapper.addLocation(location);

        return b&b1;
    }

    /**
     * 查询分场列表
     * @param
     * @return
     */
    @Override
    public List<Parvialfield> getFenChangList() {

        List<Parvialfield> parvialfields = basicCenterMapper.getFenChangList();

        return parvialfields;
    }


    /**
     * 查询角色id查询人员列表
     * @param roleId
     * @return
     */
    @Override
    public List<SecUser> getUserListByRole(Integer roleId) {

        List<SecUser> secUsers = basicCenterMapper.getUserListByRole(roleId);

        return secUsers;
    }

    /**
     * 根据分场id查询分场详情信息
     * @param id
     * @return
     */
    @Override
    public Parvialfield getFenChangById(Integer id) {

        Parvialfield parvialfield = basicCenterMapper.getFenChangById(id);

        return parvialfield;
    }

    /**
     * 修改地块信息
     * @param parvialfield
     * @return
     */
    @Override
    @Transactional
    public boolean updatePlace(Parvialfield parvialfield) {

        //地块修改基本信息
        boolean b=basicCenterMapper.updateParvialfield(parvialfield);

        /* 修改地块地理位置*/
        boolean b1=basicCenterMapper.updateLocation(parvialfield);
        return false;
    }
    /**
     * 查询作物种类列表
     * @param
     * @return
     */
    @Override
    public List<CropSpecies> getSpeciesList() {
        List<CropSpecies> cropSpecies = basicCenterMapper.getSpeciesList();
        return cropSpecies;
    }

    /**
     * 查询作物品种列表
     * @param
     * @return
     */
    @Override
    public List<CropVariety> getVarietyList() {
        List<CropVariety> cropVarieties = basicCenterMapper.getVarietyList();
        return cropVarieties;
    }
    /**
     * 添加地块
     * @param lot,overlay
     * @return
     */
    @Transactional
    @Override
    public boolean addLot(Lot lot, List<Location> locations) {

        //添加地块表
        boolean b = lotMapper.addLot(lot);

        //添加地理位置表
        for (int i = 0; i <locations.size() ; i++) {
            locations.get(i).setObjId(lot.getId())
                            .setObjType("lot");
        }
        boolean b1=locationMapper.addLocations(locations);

        return b&b1;
    }

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
}
