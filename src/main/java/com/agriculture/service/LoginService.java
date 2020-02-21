package com.agriculture.service;

import com.agriculture.pojo.SecRes;
import com.agriculture.pojo.SecUser;

import java.util.List;

/**
 * @program: bcys
 * @description: 用户登录业务层
 * @author: 罗子鉴
 * @create: 2019-03-21 14:43
 **/
public interface LoginService {

    /**
     * 用户登录
     * @param username
     * @return
     */
    SecUser findUserByName(String username);

    /**
     * 加载权限
     * @param roleId
     * @return
     */
    List<SecRes> loading_res(Integer roleId);
}
