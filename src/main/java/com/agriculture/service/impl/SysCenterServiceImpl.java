package com.agriculture.service.impl;

import com.agriculture.dao.EnterpriseMapper;
import com.agriculture.dao.SecPicMapper;
import com.agriculture.dao.SecRoleMapper;
import com.agriculture.dao.SecUserMapper;
import com.agriculture.pojo.*;
import com.agriculture.service.SysCenterService;
import com.agriculture.tools.OssUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * @program: agriculture
 * @description: 系统管理业务层
 * @author: 罗子鉴
 * @create: 2020-02-21 16:39
 **/
@Service
public class SysCenterServiceImpl implements SysCenterService {
    @Autowired
    private SecRoleMapper secRoleMapper;
    @Autowired
    private SecUserMapper secUserMapper;
    @Autowired
    private EnterpriseMapper enterpriseMapper;
    @Autowired
    private SecPicMapper secPicMapper;


    @Autowired
    private OssUtils ossUtils;

    /**
     * 查询所有人员信息
     *
     * @param pageInfo
     * @return
     */
    @Override
    public PageInfo<SecUser> findManager(OrderPageInfo pageInfo) {

        PageHelper.offsetPage(pageInfo.getOffset(), pageInfo.getLimit());

        List<SecUser> list = secUserMapper.findManager(pageInfo);

        PageInfo info = new PageInfo(list);

        return info;
    }

    /**
     * 查询所有角色信息
     *
     * @return
     */
    @Override
    public List<SecRole> findRole() {

        List<SecRole> roles = secRoleMapper.findRole();

        return roles;
    }

    /**
     * 验证用户
     *
     * @param userName
     * @return
     */
    @Override
    public int findUserName(String userName) {

        SecUser secUser = secUserMapper.findUserByName(userName);
        if (secUser != null) {
            return 1;
        }
        return 0;
    }

    /**
     * 添加用户
     *
     * @param SecUser
     * @return
     */
    @Override
    public int addUser(SecUser SecUser) {
        return secUserMapper.addUser(SecUser);
    }

    /**
     * 查询单个用户信息回显
     *
     * @param id
     * @return
     */
    @Override
    public SecUser selectUserId(Integer id) {
        return secUserMapper.selectUserId(id);
    }

    /**
     * 删除
     *
     * @param id
     * @return
     */
    @Override
    public int deleteUserId(Integer id) {
        return secUserMapper.deleteUserId(id);
    }

    /**
     * 查询所有企业
     *
     * @return
     */
    @Override
    public List<Enterprise> findEnterprise() {
        return enterpriseMapper.findEnterprise();
    }

    /**
     * @param SecUser
     * @return
     */
    @Override
    public int upUserId(SecUser SecUser) {
        return secUserMapper.upUserId(SecUser);
    }

    /**
     * @return
     */
    @Override
    public List<SecRole> findRoleEnter() {
        List<SecRole> list = secRoleMapper.findRoleEnter();
        return list;
    }

    /**
     * @param SecRole
     * @return
     */
    @Override
    public int addRole(SecRole SecRole) {
        return secRoleMapper.addRole(SecRole);
    }

    /**
     * @param id
     * @return
     */
    @Override
    public SecRole findRoleId(Integer id) {
        return secRoleMapper.findRoleId(id);
    }

    /**
     * @param SecRole
     * @return
     */
    @Override
    public int upRoleId(SecRole SecRole) {
        return secRoleMapper.upRoleId(SecRole);
    }

    /**
     * @param id
     * @return
     */
    @Override
    public int deleteRoleId(Integer id) {
        return secRoleMapper.deleteRoleId(id);
    }

    /**
     * 分页查询所有企业
     *
     * @param pageInfo
     * @return
     */
    @Override
    public PageInfo<Enterprise> findEnterpriseByPage(OrderPageInfo pageInfo) {

        PageHelper.offsetPage(pageInfo.getOffset(), pageInfo.getLimit());

        List<Enterprise> list = enterpriseMapper.findEnterpriseByPage();

        PageInfo info = new PageInfo(list);

        return info;
    }

    /**
     * 新增企业
     *
     * @param enterprise
     * @param user1Pic
     * @param user2Pic
     * @param user3Pic
     * @return
     */
    @Override
    public int addEnterprise(Enterprise enterprise, MultipartFile user1Pic, MultipartFile user2Pic, MultipartFile user3Pic) {

        if (user1Pic != null) {
            String filename = user1Pic.getOriginalFilename();
            if (!"".equals(filename.trim())) {
                //上传到OSS
                String uploadUrl = ossUtils.uploadImg2Oss(user1Pic);
                SecPic secPic = new SecPic();
                secPic.setName(filename);
                secPic.setInfo("mapperUser-1 heardpic");
                secPic.setPath(uploadUrl);

                int id = secPicMapper.addPiC(secPic);

                enterprise.setMapperUser1Pic(secPic.getId());
            }
        }
        if (user2Pic != null) {
            String filename2 = user2Pic.getOriginalFilename();
            if (!"".equals(filename2.trim())) {
                //上传到OSS
                String uploadUrl2 = ossUtils.uploadImg2Oss(user2Pic);
                SecPic secPic = new SecPic();
                secPic.setName(filename2);
                secPic.setInfo("mapperUser-2 heardpic");
                secPic.setPath(uploadUrl2);

                int id = secPicMapper.addPiC(secPic);

                enterprise.setMapperUser2Pic(secPic.getId());
            }
        }
        if (user3Pic != null) {
            String filename3 = user3Pic.getOriginalFilename();
            if (!"".equals(filename3.trim())) {
                //上传到OSS
                String uploadUrl3 = ossUtils.uploadImg2Oss(user3Pic);
                SecPic secPic = new SecPic();
                secPic.setName(filename3);
                secPic.setInfo("mapperUser-3 heardpic");
                secPic.setPath(uploadUrl3);

                int id = secPicMapper.addPiC(secPic);

                enterprise.setMapperUser3Pic(secPic.getId());
            }
        }

        int i = enterpriseMapper.addEnterprise(enterprise);

        return i;
    }

    /**
     * 修改企业
     *
     * @param enterprise
     * @return
     */
    @Override
    public int updateEnterprise(Enterprise enterprise) {

        int i = enterpriseMapper.updateEnterprise(enterprise);

        return i;
    }

    /**
     * 根据id查询企业所有信息
     *
     * @param id
     * @return
     */
    @Override
    public Enterprise findEnterpriseById(Integer id) {

        Enterprise enterprise = enterpriseMapper.findEnterpriseById(id);

        return enterprise;
    }
}
