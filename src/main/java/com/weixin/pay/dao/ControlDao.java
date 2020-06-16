package com.weixin.pay.dao;

import com.weixin.pay.pojo.control;
import com.weixin.pay.pojo.sheet;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface ControlDao {
    List<control> selectControl(@Param(value="iccid") String  iccid, @Param(value = "appid") String appid, @Param(value = "attendtime") String attendtime, @Param(value = "attendtimes") String attendtimes); //查门禁记录
    control selectCpaicong(control contro);  //排重
    int addControl(control orders);          //增加门禁记录
}
