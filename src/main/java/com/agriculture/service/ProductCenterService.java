package com.agriculture.service;

import com.agriculture.pojo.CropVariety;
import com.agriculture.pojo.Parvialfield;

import java.util.List;

/**
 * @program: agriculture
 * @description: 产品溯源业务层
 * @author: 罗子鉴
 * @create: 2020-02-21 16:39
 **/
public interface ProductCenterService {
    /**
     * 获取用户下所有分场
     * @param id
     * @return
     */
    List<Parvialfield> getFenChangListByUser(Integer id);
    /**
     * 获取所有分场
     * @param
     * @return
     */
    List<Parvialfield> getFenChangList();

    /**
     * 获取分场内所有作物
     * @param fenChangId
     * @return
     */
    List<CropVariety> getSpeciesrByFenChang(Integer fenChangId);
}
