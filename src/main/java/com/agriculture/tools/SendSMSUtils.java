package com.agriculture.tools;

import com.cloopen.rest.sdk.CCPRestSmsSDK;

import java.util.HashMap;

public class SendSMSUtils {
   public static boolean sendMSM(String phone,String code){
	   HashMap<String, Object> result = null;

	   //初始化SDK
	   CCPRestSmsSDK restAPI = new CCPRestSmsSDK();
	   // 初始化服务器地址和端口
  
	   restAPI.init("app.cloopen.com", "8883");//https://app.cloopen.com:8883
	   //设置业务信息   
	// 初始化主账号名称和主账号令牌，
	   restAPI.setAccount("8aaf07086772ac61016790b287a31b7d", "1789b0a8bf61459cbc922bd490ad5b10");//
	   restAPI.setAppId("8aaf07086772ac61016790b287f11b83");
	   //请使用管理控制台中已创建应用的APPID。则13800000000手机号收到的短信内容是：【云通讯】您使用的是云通讯短信模板，您的验证码是6532，请于5分钟内
	   result = restAPI.sendTemplateSMS(phone,"1" ,new String[]{code,"500"});
	   //获取发送结果
	   if("000000".equals(result.get("statusCode"))){//根据状态码判断是否发送成功	   
		   System.out.println("发送成功");
		   return true;
	   }else{
		   System.out.println(" 错误信息: "+result.get("statusMsg"));
		   return false;
	   }
   }

}
