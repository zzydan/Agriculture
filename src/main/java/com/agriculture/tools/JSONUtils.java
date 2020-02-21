package com.agriculture.tools;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;

import java.util.List;

public class JSONUtils {

    /***
     * Object 转为  JSON
     * @param object
     * @return
     */
    public static String toJSONString(Object object) {
        if(null != object){
            //将javabean转化成json字符串
            String jsonStr = JSON.toJSONString(object);
            return jsonStr;
        }
        return "";
    }

    /***
     *
     * JSON 转 Object
     *
     * @param jsonStr
     *         [{"age":12,"createTime":null,"id":"","name":"wxw","registerTime":null,"sex":1}]
     * @return
     */
    @SuppressWarnings("unchecked")
    public static <T>T parseObject(String jsonStr, Class<T> objectClass){
        if(null != jsonStr){
            //将json字符串转化成对应的javabean
            T object = JSON.parseObject(jsonStr, objectClass);
            return object;
        }
        return null;
    }

    /***
     * JsonArray 转为 JSON
     * @param jsonArray
     * @return
     */
    public static String jsonArrayToJSONString(JSONArray jsonArray) {
        if(null != jsonArray){
            return jsonArray.toString();
        }
        return "";
    }

    /**
     * json 转 List<T>
     */
    public static  <T> List<T> jsonToList(String jsonString, Class<T> clazz) {
        @SuppressWarnings("unchecked")
        List<T> ts = (List<T>) JSONArray.parseArray(jsonString, clazz);
        return ts;
    }

}
