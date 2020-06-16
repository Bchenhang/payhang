package com.weixin.pay.server;

import com.alibaba.fastjson.JSONObject;
import com.weixin.pay.pojo.mpconfig;
import org.springframework.stereotype.Repository;

@Repository
public interface serverMpconfig {
     mpconfig selectconfig(String appid);        //查配置
     String mbid (String id,mpconfig mpconfig,String token);  //获取模板id
     int updateToken(String appid,String token,String tokentime);//修改token

     String Token(mpconfig mpconfig,JSONObject json,String id);//整合上面两个方法直接返回返回mbid
}
