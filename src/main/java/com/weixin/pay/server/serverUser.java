package com.weixin.pay.server;

import com.alibaba.fastjson.JSONObject;
import com.weixin.pay.pojo.User;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface serverUser {
 /*   public User selectUser(User user);*/
     User selectOperid(User user);//查询账户
    User selectfangke(User user);//查询访客是否绑定
    User selectjs(User user);//查询角色
     List<User> selectyh(User user);//查询ipid所有用户
     int addUser(User user);//添加账户
     int deleteUser (User user);  //删除绑定信息
     JSONObject xinxiyz(String clientid,String iccic,String key,String name,String code,String appid,String orderid,String pass)throws Exception; //身份验证//账户挂失//账户解挂//交易结果查询
     int updateUser  (String appid,String opid,String name,String iccid,String pass,int status); //更新工号

    int updateA   (User user);//更新所有状态为0
    int updateB   (User user);//更新单个状态为1
    int updateUrl (User user);//修改照片路径
    int updateKind(User user);//修改等级


}
