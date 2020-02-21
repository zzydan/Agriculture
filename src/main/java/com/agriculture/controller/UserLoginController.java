package com.agriculture.controller;


import com.agriculture.pojo.SecRes;
import com.agriculture.pojo.SecUser;
import com.agriculture.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @program: agriculture
 * @description: 用户登录控制
 * @author: 罗子鉴
 * @create: 2019-03-21 14:39
 **/

@RequestMapping("user")
@Controller
public class UserLoginController {
    @Autowired
    private LoginService loginServiceImpl;

    /**
     * 用户登录
     * @param userName
     * @param password
     * @param session
     * @return
     */
    @RequestMapping("login")
    @ResponseBody
    public Map<String,String> UserLogin(String userName, String password, HttpSession session){

        Map<String,String> map = new HashMap<String,String>();

        SecUser user = loginServiceImpl.findUserByName(userName);

        if(user==null){
            map.put("message","账号或密码错误，如果问题请联系系统管理员");
            return map;
        }
        if(!user.getPassword().equals(password)){
            map.put("message","账号或密码错误，如果问题请联系系统管理员");
            return map;
        }

        session.setAttribute("USER_SESSION",user);

        map.put("flag","true");

        return map;
    }


    /**
     * 用户注销登录
     * @param session
     * @return
     */
    @RequestMapping("/logout")
    public String  logout(HttpSession session){
        //根据键删除session中的值
        session.removeAttribute("USER_SESSION");

        session.invalidate();

        return "redirect:/jsps/login.jsp";

    }

    /**
     * 权限加载
     * @param session
     * @return
     */
    @RequestMapping("/loading_res")
    @ResponseBody
    public List<SecRes> loading_res(HttpSession session){
        SecUser user = (SecUser)session.getAttribute("USER_SESSION");
        List<SecRes> list = loginServiceImpl.loading_res(user.getRoleId());
        return list;
    }
}

