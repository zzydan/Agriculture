package com.agriculture.service;

import com.agriculture.pojo.Agricultural;
import com.agriculture.pojo.FarmWork;
import com.agriculture.pojo.SecPic;
import com.agriculture.pojo.Work;

import java.util.List;

public interface FarmWorkService {
    List<FarmWork> getAll(int id);
    FarmWork getAll1();
    FarmWork getxq(int lotid, int id);

    /**
     * 根据分场id查询农事详情
     * @param id
     * @return
     */
    List<FarmWork> getNongByFenChang(int id);

    /**
     * 根据日期获取农事
     * @param date
     * @param id
     * @return
     */
    List<FarmWork> getWorkByDate(String date, Integer id);

    /**
     * 查询农事列表
     * @param
     * @return
     */
    List<Work> getNong();

    /**
     * 查询农资列表
     * @param
     * @return
     */
    List<Agricultural> getNongZi();

    /**
     * 添加临时农事
     * @param farmWork,zi
     * @return
     */
    boolean addNong(FarmWork farmWork, String zi);

    /**
     * 添加临时农事之图片添加
     * @param secPic
     * @return
     */
    boolean addPic(SecPic secPic);
}
