package com.agriculture.controller;


import com.agriculture.service.BasicCenterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 * @program: agriculture
 * @description: 基本管理控制层
 * @author: 罗子鉴
 * @create: 2019-06-27 15:25
 **/
@Controller
@RequestMapping("/basicCenter")
public class BasicCenterController {

    @Autowired
    private BasicCenterService basicCenterServiceImpl;


}

