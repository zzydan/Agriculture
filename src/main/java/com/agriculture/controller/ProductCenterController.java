package com.agriculture.controller;


import com.agriculture.service.ProductCenterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


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


}

