package com.weixin.pay.server;

import com.alibaba.fastjson.JSONObject;
import org.springframework.stereotype.Repository;

@Repository
public interface serverFangke {

    JSONObject fangke(JSONObject json,String code); //所有访客对接接口
}
