package com.weixin.pay.dao;
import com.weixin.pay.pojo.mpconfig;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MpconfigDao {

    mpconfig selectconfig(String appid);        //查配置
    mpconfig selectkey(String appid);  //查Key
    int updatMpconfig1(mpconfig mpconfig);//新增模板id
    int updatMpconfig2(mpconfig mpconfig);//新增模板id
    int updatMpconfig3(mpconfig mpconfig);//新增模板id
    int updatMpconfig4(mpconfig mpconfig);//新增模板id
    int updatMpconfig5(mpconfig mpconfig);//新增模板id
    int updatMpconfig6(mpconfig mpconfig);//新增模板id 预约 请假
    int updatMpconfig7(mpconfig mpconfig);//新增模板id 更新 请假
    int updateToken(mpconfig mpconfig);//新增token
}
