package com.agriculture.dao;

import com.agriculture.pojo.OrderPageInfo;
import com.agriculture.pojo.SecUser;
import com.github.pagehelper.PageInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SecUserMapper {

    /**
     * 用户登录
     * @param userName
     * @return
     */
    SecUser findUserByName(String userName);
    /**
     * 模糊查询所有用户
     * @param pageInfo
     * @return
     */
    List<SecUser> findManager(@Param("info") OrderPageInfo pageInfo);

    /**
     *  添加用户
     * @param SecUser
     * @return
     */
    int addUser(SecUser SecUser);

    /**
     * 查询单个信息
     * @param id
     * @return
     */
    SecUser selectUserId(@Param("id") Integer id);

    /**
     * 删除用户
     * @param id
     * @return
     */
    int deleteUserId(@Param("id")Integer id);

    /**
     * 修改用户信息
     * @param SecUser
     * @return
     */
    int upUserId(SecUser SecUser);


    /**
     * 查询角色id查询人员列表
     * @param roleId
     * @return
     */
    List<SecUser> getUserListByRole(Integer roleId);

    /**
     * 查询手机号查询用户信息
     * @param tel
     * @return
     */
    SecUser login(String tel);
}