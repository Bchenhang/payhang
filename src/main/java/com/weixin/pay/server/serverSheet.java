package com.weixin.pay.server;
import com.weixin.pay.pojo.sheet;
import org.springframework.stereotype.Repository;
import com.alibaba.fastjson.JSONObject;

import java.util.List;

@Repository
public interface serverSheet {
    List<sheet> selectSheet(String iccid, String appid, String attendtime, String attendtimes);          //查考情记录
    sheet selectpaicong(JSONObject orders);   //排重
    int addSheet(JSONObject orders);          //增加考情记录
}
