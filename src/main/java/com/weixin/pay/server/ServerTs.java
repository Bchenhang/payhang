package com.weixin.pay.server;
import com.alibaba.fastjson.JSONObject;
import com.weixin.pay.pojo.User;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface ServerTs {
    public List<User> selectTsop(String iccid,String appid);//查询operid
    public  String TsYz(JSONObject object);     //参数验证
    public  Map Tsyh(String opid,String mbid,String zpdz);     //opid
    public Map Tsmb (JSONObject object,String name);  //模板消息
    public  int Tspd(String appid);//推送判断
    public  int Tspd2(JSONObject json);//推送判断


}
