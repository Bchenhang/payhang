package com.weixin.pay.server;


import com.alibaba.fastjson.JSONObject;
import com.weixin.pay.pojo.transaction;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface serverTransaction {
    List<transaction> selectTransaction(String  iccid,String appid,String attendtime,String attendtimes);        //查消费记录记录
    transaction Tpaicong(JSONObject orders);        //排重
    int addTransaction(JSONObject orders);          //增加交易记录
}
