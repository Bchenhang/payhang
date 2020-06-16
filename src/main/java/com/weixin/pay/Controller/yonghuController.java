package com.weixin.pay.Controller;

import com.alibaba.fastjson.JSONObject;
import com.weixin.pay.pojo.User;
import com.weixin.pay.server.serverUser;
import org.apache.http.HttpRequest;
import org.apache.http.HttpResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class yonghuController {

    @Resource
    private serverUser serverUser;
    @RequestMapping("qiehuan")
    public String yonghu(HttpSession session, HttpResponse response, HttpRequest request){//跳转切换用户
        System.out.println("123");
        return "login3";
    }
    //查询所有用户 循环显示
    @ResponseBody
    @RequestMapping("shuju")
    public JSONObject shuju(HttpSession session, HttpResponse response, HttpRequest request){
        JSONObject jsonObject=new JSONObject();

        if (session.getAttribute("operid") != null && session.getAttribute("operid") != ""&&session.getAttribute("appid")!=null&&session.getAttribute("appid")!="") {
            String operid = session.getAttribute("operid").toString();
            String appid = session.getAttribute("appid").toString();
            String isshool=session.getAttribute("isshool").toString();
            User user = new User();
            String name="";
            user.setOperid(operid);
            user.setAppid(appid);
            List<User> user1 = serverUser.selectyh(user);
            if (isshool.equals("1")){
                name="请输入学工号";
            }else{
                name="请输入工号";
            }
            System.out.println("1232321"+name);
            jsonObject.put("list",user1);
            jsonObject.put("params",name);
        }
        return jsonObject;
    }
    //查询用户密码
    @ResponseBody
    @RequestMapping("js")
    public JSONObject js(HttpSession session, HttpResponse response, HttpRequest request,@RequestParam("iccid") String iccid){
        JSONObject jsonObject=new JSONObject();
        if (session.getAttribute("operid") != null && session.getAttribute("operid") != ""&&session.getAttribute("appid")!=null&&session.getAttribute("appid")!="") {
            String operid = session.getAttribute("operid").toString();
            String appid = session.getAttribute("appid").toString();
            System.out.println(operid+"=="+appid+"=="+iccid);
            User user = new User();
            user.setOperid(operid);
            user.setAppid(appid);
            user.setIccid(iccid);
            User user1 = serverUser.selectjs(user);
            jsonObject.put("iccid",user1.getIccid());
            jsonObject.put("name",user1.getName());
            jsonObject.put("password",user1.getPassword());
        }
        return jsonObject;
    }
    @ResponseBody
    @RequestMapping("g")
    public  JSONObject strin(HttpSession session, HttpResponse response, HttpRequest request){
   JSONObject j=new JSONObject();
   j.put("with","45");
   j.get("with");
   j.put("code","OK");
      /*
        body {
            background-color: black;
            font-family: Georgia;
            font-size: 30px;
        }h1 {
            font-size: 60px;
            color: blue;
            text-align: center;
        }h2 {
            font-size: 45px;
            color: green;
            padding-left: 10px;
            jjidojg
        }*/
      System.out.println("123");
    return j;
    }

}
