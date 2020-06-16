package com.weixin.pay.server.ServerImpl;
import com.alibaba.fastjson.JSONObject;
import com.weixin.pay.config.PayfwConfig;
import com.weixin.pay.pojo.User;
import  com.weixin.pay.server.serverUser;
import com.weixin.pay.dao.UserDao;
import com.weixin.pay.utils.HttpClientUtils;
import com.weixin.pay.utils.MD5Utils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Slf4j
@Service
public class serverUserImpl implements  serverUser {
    @Resource
    private PayfwConfig payfwConfig;

    @Resource
    private UserDao UserDao;

   /* public User selectUser(User user){
        User orders  = UserDao.selectUser(user.getNaem(),user.getPassword());
        return orders;
    }*/
    public User selectOperid(User user){
        User orders1  = UserDao.selectOperid(user);
        return orders1;
    }
   public User selectfangke(User user){
       User orders2  = UserDao.selectfangke(user);
        return orders2;
    }//查询访客是否绑定
    public int updateUser  (String appid,String opid,String name,String iccid,String pass,int status){
        User userk=new User();
        userk.setAppid(appid);
        userk.setOperid(opid);
        userk.setName(name);
        userk.setIccid(iccid);
        userk.setPassword(pass);
        userk.setStatus(status);
        return UserDao.updateUser(userk);
    }
    public  int addUser(User user){
       int i= UserDao.addUser(user);
        return i;
    }
    public int deleteUser (User user){//删除绑定信息
       int i= UserDao.deleteUser(user);
        return i;
    }
    //身份验证//账户挂失//账户解挂//交易结果查询
    public JSONObject xinxiyz(String clientid,String iccic,String key,String name,String code,String appid,String orderid,String pass)throws Exception{
        JSONObject json=new JSONObject();
        String i="";
        StringBuffer stringBuffer=new StringBuffer();
        JSONObject o=new JSONObject();
        stringBuffer.append("001");
        stringBuffer.append(appid);
        stringBuffer.append(clientid);
        stringBuffer.append(iccic);
        if (orderid!=null){
         stringBuffer.append(orderid);
        }
        String b=MD5Utils.md5(stringBuffer.toString(),key);
        json.put("VersionId","001");
        json.put("CustomerID",appid);
        if (code.equals("101")){
        json.put("Password",pass);
        }
        json.put("ClientID",clientid);
        json.put("ICCID",iccic);
        json.put("Name",name);
        if (orderid!=null){
            json.put("OrderId",orderid);
        }
        json.put("MAC",b);
        String p=json.toJSONString();
        if (code.equals("101")){//身份验证
            i=HttpClientUtils.post(payfwConfig.getFwnotify()+"YKT_YHXXYZ.action",p);
        }else if  (code.equals("102")){//挂失
            i=HttpClientUtils.post(payfwConfig.getFwnotify()+"YKT_SUSPEND.action",p);
        }else if (code.equals("103")){//解挂
            i=HttpClientUtils.post(payfwConfig.getFwnotify()+"YKT_RESUME.action",p);
        }else if (code.equals("104")){//交易结果查询
            i=HttpClientUtils.post(payfwConfig.getFwnotify()+"YKT_QUERY_CZ.action",p);
        }
        if (i.equals("ON")){
            o.put("code","ON");
        }else{
            o= JSONObject.parseObject(i);
            o.put("code","OK");
        }
        return  o;
    }
    public List<User> selectyh(User user){//查询operid所有用户
        List<User> list= UserDao.selectyh(user);
        return list;
    }
    public  User selectjs(User user){//查询角色
        User user1=UserDao.selectjs(user);
        return user1;
    }
    public int updateA  (User user){//更新所有状态为0
        int i=UserDao.updateA(user);
        return i;
    }
    public int updateB  (User user){//更新单个状态为1
        int i=UserDao.updateB(user);
        return i;
    }
    public int updateUrl(User user){//修改照片路径
        int i=UserDao.updateUrl(user);
        return i;
    }
    public int updateKind(User user){//修改等级ind
        int i=UserDao.updateKind(user);
        return i;
    }
}
