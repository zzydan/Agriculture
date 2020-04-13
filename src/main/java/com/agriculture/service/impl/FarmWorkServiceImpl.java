package com.agriculture.service.impl;

import com.agriculture.dao.AgriculturalMapper;
import com.agriculture.dao.FarmWorkMapper;
import com.agriculture.dao.SecPicMapper;
import com.agriculture.dao.WorkFertilizerMapper;
import com.agriculture.pojo.*;
import com.agriculture.service.FarmWorkService;
import com.agriculture.tools.JSONUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
public class FarmWorkServiceImpl implements FarmWorkService {
    @Resource
    private FarmWorkMapper farmWorkMapper;

    @Resource
    private AgriculturalMapper agriculturalMapper;


    @Resource
    private WorkFertilizerMapper workFertilizerMapper;

    @Resource
     private SecPicMapper secPicMapper;

    @Override
    public List<FarmWork> getAll(int id) {
        return farmWorkMapper.getAll(id);
    }

    @Override
    public FarmWork getAll1() {
        return farmWorkMapper.getAll1();
    }

    @Override
    public FarmWork getxq(int lotid, int id) {
        return farmWorkMapper.getxq(lotid, id);
    }

    /**
     * 根据分场id查询农事详情
     *
     * @param id
     * @return
     */
    @Override
    public List<FarmWork> getNongByFenChang(int id) {
        return farmWorkMapper.getNongByFenChang(id);
    }

    /**
     * 根据日期获取农事
     *
     * @param date
     * @param id
     * @return
     */
    @Override
    public List<FarmWork> getWorkByDate(String date, Integer id) {
        return farmWorkMapper.getWorkByDate(date, id);
    }

    /**
     * 查询农事列表
     *
     * @param
     * @return
     */
    @Override
    public List<Work> getNong() {
        return farmWorkMapper.getNong();
    }

    /**
     * 查询农资列表
     *
     * @param
     * @return
     */
    @Override
    public List<Agricultural> getNongZi() {
        return agriculturalMapper.getAgricList();
    }

    /**
     * 添加临时农事
     * @param farmWork,zi
     * @return
     */
    @Transactional
    @Override
    public boolean addNong(FarmWork farmWork, String zi) {
        boolean b=farmWorkMapper.addFarmWork(farmWork);
        boolean b1=false;
        if(b){
            Integer farmWorkId = farmWork.getId();
            List<WorkFertilizer> workFertilizers = JSONUtils.jsonToList(zi, WorkFertilizer.class);
            for (int i = 0; i <workFertilizers.size(); i++) {
                workFertilizers.get(i).setFarmWorkId(farmWorkId);
            }
            b1 =workFertilizerMapper.addZiList(workFertilizers);

        }


        return b1;
    }

    /**
     * 添加临时农事之图片添加
     * @param secPic
     * @return
     */
    @Override
    public boolean addPic(SecPic secPic) {
        boolean b = secPicMapper.addPicture(secPic);
        return false;
    }
}
