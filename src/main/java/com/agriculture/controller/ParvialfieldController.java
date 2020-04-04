package com.agriculture.controller;

import com.agriculture.pojo.Parvialfield;
import com.agriculture.service.ParvialfieldService;
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
@RequestMapping("Parvialfield")
public class ParvialfieldController {
    @Resource
    private ParvialfieldService parvialfieldService;
    //获取所有分厂
    @RequestMapping("getAll")
    @ResponseBody
    public List<Parvialfield> getAll(){
        List<Parvialfield> list = parvialfieldService.getAll();
        System.out.println(list+"444");
        return list;
    }
}
