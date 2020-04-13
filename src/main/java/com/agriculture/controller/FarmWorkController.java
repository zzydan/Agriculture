package com.agriculture.controller;

import com.agriculture.pojo.*;
import com.agriculture.service.FarmWorkService;
import com.agriculture.tools.JSONUtils;
import com.agriculture.tools.OssUtils;
import com.alibaba.fastjson.JSON;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import sun.misc.BASE64Decoder;
import sun.security.util.Length;

import javax.annotation.Resource;
import javax.sql.rowset.serial.SerialBlob;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.UUID;

/**
 * @program: agriculture
 * @description: 农事记录
 * @author: 高幸
 * @create: 2020-03-4 10:25
 **/
@Controller
@RequestMapping("FarmWork")
public class FarmWorkController {

    @Resource
    private FarmWorkService farmWorkService;

    @Resource
    private OssUtils ossUtils;

    @RequestMapping("getxq")
    @ResponseBody
    //农事详情
    public FarmWork getxq(int lotid, int id){
        System.out.println("lotid="+lotid);
        System.out.println("id="+id);
        FarmWork getxq = farmWorkService.getxq(lotid, id);
        System.out.println(getxq+"232323");

        return getxq;
    }

    @RequestMapping("getAll")
    @ResponseBody
    //根据分厂id获取农事
    public List<FarmWork> getAll(int id){
        List<FarmWork> list = farmWorkService.getAll(id);
        System.out.println(list+"根据返厂id获取农事");
        return list;
    }
    //测试方法
    @RequestMapping("getAll1")
    @ResponseBody
    public FarmWork getAll1(){
        FarmWork all1 = farmWorkService.getAll1();
        return all1;
    }
    //测试方法


    /**
     * 根据分场id查询农事详情
     * @param id
     * @return
     */
    @RequestMapping("getNongByFenChang")
    @ResponseBody
    public List<FarmWork> getNongByFenChang(int id){
        List<FarmWork> list = farmWorkService.getNongByFenChang(id);

        return list;
    }
    /**
     * 根据日期获取农事
     * @param date
     * @return
     */
    @RequestMapping("getWorkByDate")
    @ResponseBody
    public List<FarmWork> getWorkByDate(String date,Integer id){

        List<FarmWork> list = farmWorkService.getWorkByDate(date,id);

        return list;
    }
    /**
     * 查询农事列表
     * @param
     * @return
     */
    @RequestMapping("getNong")
    @ResponseBody
    public List<Work> getNong(){

        List<Work> list = farmWorkService.getNong();

        return list;
    }

    /**
     * 查询农资列表
     * @param
     * @return
     */
    @RequestMapping("getNongZi")
    @ResponseBody
    public List<Agricultural> getNongZi(){

        List<Agricultural> list = farmWorkService.getNongZi();

        return list;
    }

    /**
     * 添加临时农事
     * @param farmWork,zi,imgs
     * @return
     */
    @RequestMapping("addNong")
    @ResponseBody
    public boolean addNong(FarmWork farmWork,String zi,String[] imgs) throws Exception {
        //添加农事表以及农事农资表
        //boolean b= farmWorkService.addNong(farmWork,zi);


        for (int i = 0; i <imgs.length; i++) {
            System.out.println(imgs[i]);
            // 使用前端插件时可能有前有（"data:image/xxxx;base64,"）
            // 获取图片格式
            //String suffix = imgs[i].substring(11,imgs[i].indexOf(";"));
            // 使用插件传输产生的前缀
            String prefix = imgs[i].substring(0,imgs[i].indexOf(",") + 1);
            // 替换前缀为空
            imgs[i] = imgs[i].replace(prefix,"");
            // imgs[i] = imgs[i].substring(imageString.indexOf(",") + 1);
            InputStream binaryStream= decodeToImage(imgs[i]).getBinaryStream();
            String fileName=UUID.randomUUID().toString()+".png";
            //上传到oss
            String s = ossUtils.uploadFile2OSS(binaryStream, fileName);
            SecPic secPic = new SecPic();
            secPic.setPath("http://lzj-picservice.oss-cn-beijing.aliyuncs.com/userImg/"+fileName+"?x-oss-process=image/resize,w_1024");
            secPic.setObjId(farmWork.getId());
            secPic.setObjId(8);
            secPic.setObjType("work");
            //添加到数据库
            boolean b=farmWorkService.addPic(secPic);
        }

       // OssUtils.uploadFile2OSS(InputStream instream, String fileName)
        return true;
    }
    public static SerialBlob decodeToImage(String imageString) throws Exception {
        BASE64Decoder decoder = new BASE64Decoder();
        byte[] imageByte = decoder.decodeBuffer(imageString);
        return new SerialBlob(imageByte);
    }
    // 生成文件名加目录
    /*public String getFilename(String dir,suffix){
        // 使用uuid生成唯一文件名
        String uuid = UUID.randomUUID().toString();
        return dir+ "/" + uuid + "." +suffix;;
    }*/
}
