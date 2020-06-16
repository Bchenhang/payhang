package com.weixin.pay.dao;

import com.weixin.pay.pojo.User;
import com.weixin.pay.pojo.orders;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface UserDao {

  /*  User selectUser(String name,String password);        //查用户*/
    User selectOperid(User user);      //验证用户是否绑定
    User selectfangke(User user);      //查询访客是否绑定
    int addUser(User user);   //添加绑定信息
    int deleteUser (User user);  //删除绑定信息
    List<User> selectTsop(User user);//模板推送  查询opid
    int updateUser  (User user);//更新工号
    List<User> selectyh(User user);//查询所有opid得用户
    User selectjs(User user);      //查询单个用户
    int updateA  (User user);//更新所有状态为0
    int updateB  (User user);//更新单个状态为1
    int updateUrl(User user);//修改照片路径
    int updateKind(User user);//修改等级ind
}
