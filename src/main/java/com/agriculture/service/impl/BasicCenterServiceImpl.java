package com.agriculture.service.impl;

import com.agriculture.dao.BasicCenterMapper;
import com.agriculture.pojo.Location;
import com.agriculture.pojo.Parvialfield;
import com.agriculture.pojo.SecUser;
import com.agriculture.service.BasicCenterService;
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
    private BasicCenterMapper basicCenterMapper;

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
        location.setObjId(parvialfield.getId())
                .setObjType("zone");

        /* 添加地理位置表*/
        boolean b1=basicCenterMapper.addLocation(location);

        return b&b1;
    }

    /**
     * 查询分场列表
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
    public boolean updatePlace(Parvialfield parvialfield) {

        //地块修改基本信息
        boolean b=basicCenterMapper.updateParvialfield(parvialfield);

        /* 修改地块地理位置*/
        boolean b1=basicCenterMapper.updateLocation(parvialfield);
        return false;
    }


}
