package com.agriculture.dao;

import com.agriculture.pojo.SecUser;

public interface SecUserMapper {

    /**
     * 用户登录
     * @param userName
     * @return
     */
    SecUser findUserByName(String userName);
}