package com.agriculture.service.impl;

import com.agriculture.dao.CropVarietyMapper;
import com.agriculture.dao.ParvialfieldMapper;
import com.agriculture.pojo.CropVariety;
import com.agriculture.pojo.Parvialfield;
import com.agriculture.service.ProductCenterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * @program: agriculture
 * @description: 产品溯源业务层
 * @author: 罗子鉴
 * @create: 2020-02-21 16:39
 **/
@Service
public class ProductCenterServiceImpl implements ProductCenterService {
    @Autowired
    private ParvialfieldMapper parvialfieldMapper;
    @Autowired
    private CropVarietyMapper cropVarietyMapper;

    /**
     * 获取用户下所有分场
     * @param id
     * @return
     */
    @Override
    public List<Parvialfield> getFenChangListByUser(Integer id) {


        List<Parvialfield> parvialfieldList1 =  parvialfieldMapper.getFenChangListByUser1(id);
        List<Parvialfield> parvialfieldList2 =   parvialfieldMapper.getFenChangListByUser2(id);

        Set<Parvialfield> set1 = new HashSet<Parvialfield>(parvialfieldList1);
        Set<Parvialfield> set2 = new HashSet<Parvialfield>(parvialfieldList2);

        set1.addAll(set2);

        List<Parvialfield> result = new ArrayList<Parvialfield>(set1);

        return result;
    }
    /**
     * 获取所有分场
     * @param
     * @return
     */
    @Override
    public List<Parvialfield> getFenChangList() {

        return parvialfieldMapper.getFenChangList();
    }

    /**
     * 获取分场内所有作物
     * @param fenChangId
     * @return
     */
    @Override
    public List<CropVariety> getSpeciesrByFenChang(Integer fenChangId) {

        return cropVarietyMapper.getSpeciesrByFenChang(fenChangId);
    }


}
