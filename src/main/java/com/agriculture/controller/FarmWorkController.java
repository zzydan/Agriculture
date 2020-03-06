package com.agriculture.controller;

import com.agriculture.pojo.FarmWork;
import com.agriculture.service.FarmWorkService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/**
 * @program: agriculture
 * @description: 农事记录
 * @author: 高幸
 * @create: 2020-03-4 10:25
 **/
@Controller
@RequestMapping("FarmWork")
public class FarmWorkController {

    @Resource
    private FarmWorkService farmWorkService;
    @RequestMapping("getxq")
    @ResponseBody
    //农事详情
    public FarmWork getxq(int lotid, int id){
        System.out.println("lotid="+lotid);
        System.out.println("id="+id);
        FarmWork getxq = farmWorkService.getxq(lotid, id);
        System.out.println(getxq+"232323");

        return getxq;
    }

    @RequestMapping("getAll")
    @ResponseBody
    //根据分厂id获取农事
    public List<FarmWork> getAll(int id){
        List<FarmWork> list = farmWorkService.getAll(id);
        System.out.println(list+"根据返厂id获取农事");
        return list;
    }
    //测试方法
    @RequestMapping("getAll1")
    @ResponseBody
    public FarmWork getAll1(){
        FarmWork all1 = farmWorkService.getAll1();
        return all1;
    }
}
