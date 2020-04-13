package com.agriculture.dao;


import com.agriculture.pojo.SecPic;

public interface SecPicMapper {

    /**
     * 将上传图片的位置存到数据库
     * @param secPic
     * @return
     */
    int addPiC(SecPic secPic);

    /**
     * 将上传图片的位置存到数据库
     * @param secPic
     * @return
     */
    boolean addPicture(SecPic secPic);
}