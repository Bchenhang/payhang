package com.weixin.pay.server;

import com.alibaba.fastjson.JSONObject;
import com.weixin.pay.pojo.control;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface serverControl {
    List<control> selectControl(String iccid, String appid, String attendtime, String attendtimes);         //查门禁记录
    int addControl(JSONObject orders);          //增加门禁记录
    control selectCpaicong(JSONObject orders);  //排重
}
