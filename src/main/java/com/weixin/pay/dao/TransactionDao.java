package com.weixin.pay.dao;

import com.weixin.pay.pojo.transaction;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface TransactionDao {
    List<transaction> selectTransaction(@Param(value="iccid") String  iccid, @Param(value = "appid") String appid, @Param(value = "attendtime") String attendtime, @Param(value = "attendtimes") String attendtimes);        //查消费记录记录
    transaction Tpaicong(transaction orders);                           //排重

    int addTransaction(transaction orders);          //增加消费记录
}
