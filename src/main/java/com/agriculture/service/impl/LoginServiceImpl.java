package com.agriculture.service.impl;


import com.agriculture.dao.SecResMapper;
import com.agriculture.dao.SecUserMapper;
import com.agriculture.pojo.SecRes;
import com.agriculture.pojo.SecUser;
import com.agriculture.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;


/**
 * @program: bcys
 * @description: 用户登录实现层
 * @author: 罗子鉴
 * @create: 2019-03-21 14:44
 **/
@Service
public class LoginServiceImpl implements LoginService {
    @Autowired
    private SecUserMapper secUserMapper;
    @Autowired
    private SecResMapper secResMapper;

    /**
     * 登录
     * @param userName
     * @return
     */
    @Override
    public SecUser findUserByName(String userName) {

        return secUserMapper.findUserByName(userName);
    }

    /**
     * 加载权限
     * @param roleId
     * @return
     */
    @Override
    public List<SecRes> loading_res(Integer roleId) {

        List<SecRes> list = secResMapper.loading_res(roleId);

        List<SecRes> resList= new ArrayList<SecRes>();

        for (SecRes res:list) {
            if(res.getParentId()==0){
                List<SecRes> resChildList= new ArrayList<SecRes>();
                for (int i = 0; i < list.size(); i++) {
                    if(list.get(i).getParentId()==res.getId()){
                        resChildList.add(list.get(i));
                    }
                }
                res.setResList(resChildList);
                resList.add(res);
            }
        }
        return resList;
    }
}

