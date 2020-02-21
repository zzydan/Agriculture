package com.agriculture.controller;


import com.agriculture.service.ZnnjCenterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 * @program: agriculture
 * @description: 智能农机控制层
 * @author: 罗子鉴
 * @create: 2019-06-27 15:25
 **/
@Controller
@RequestMapping("/znnjCenter")
public class ZnnjCenterController {

    @Autowired
    private ZnnjCenterService znnjCenterServiceImpl;

}

