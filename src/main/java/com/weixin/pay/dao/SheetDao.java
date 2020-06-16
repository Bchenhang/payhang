package com.weixin.pay.dao;

import com.weixin.pay.pojo.sheet;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface SheetDao {
    List<sheet> selectSheet(@Param(value="iccid") String  iccid,@Param(value = "appid") String appid,@Param(value = "attendtime") String attendtime,@Param(value = "attendtimes") String attendtimes);        //查考情记录
    sheet selectpaicong(sheet orders);   //排重
    int addSheet(sheet orders);          //增加考情记录
}
