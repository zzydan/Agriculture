package com.agriculture.controller;


import com.agriculture.pojo.CropVariety;
import com.agriculture.pojo.Parvialfield;
import com.agriculture.pojo.SecUser;
import com.agriculture.service.ProductCenterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;


/**
 * @program: agriculture
 * @description: 气象环境控制层
 * @author: 罗子鉴
 * @create: 2019-06-27 15:25
 **/
@Controller
@RequestMapping("/productCenter")
public class ProductCenterController {

    @Autowired
    private ProductCenterService productCenterServiceImpl;


    /**
     * 获取用户下所有分场
     * @param session
     * @return
     */
    @RequestMapping("getFenChangListByUser")
    @ResponseBody
    public List<Parvialfield> getFenChangListByUser(HttpSession session){
        //根据键删除session中的值
        SecUser user = (SecUser)session.getAttribute("USER_SESSION");
        List<Parvialfield> list = null;
        if(user.getId()!=1){
            list = productCenterServiceImpl.getFenChangListByUser(user.getId());
        }else {
            list = productCenterServiceImpl.getFenChangList();
        }

        return list;
    }

    /**
     * 获取分场内所有作物
     * @param fenChangId
     * @return
     */
    @RequestMapping("getSpeciesrByFenChang")
    @ResponseBody
    public List<CropVariety> getSpeciesrByFenChang(Integer fenChangId){

        return productCenterServiceImpl.getSpeciesrByFenChang(fenChangId);
    }
}

