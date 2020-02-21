package com.agriculture.controller;


import com.agriculture.service.SysCenterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 * @program: agriculture
 * @description: 系统管理
 * @author: 罗子鉴
 * @create: 2019-06-27 15:25
 **/
@Controller
@RequestMapping("/sysCenter")
public class SysCenterController {

    @Autowired
    private SysCenterService sysCenterServiceImpl;

}

