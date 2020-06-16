package com.weixin.pay.Controller;
import com.alibaba.fastjson.JSONObject;
import com.google.common.base.Supplier;
import com.weixin.pay.pojo.User;
import com.weixin.pay.server.ServerTs;
import com.weixin.pay.server.serverOrder;
import com.weixin.pay.server.serverUser;
import com.weixin.pay.utils.*;
import lombok.extern.slf4j.Slf4j;
import lombok.val;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.text.SimpleDateFormat;

@Slf4j
@Controller
public class QrcodeController {
    @Resource
    private ServerTs serverTs;
    @Resource
    private serverOrder serverOrder;
    /**
     * 生成二维码 并保存
     */
    @Resource
    private serverUser serverUser;
    private SimpleDateFormat d = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
    private SimpleDateFormat g = new SimpleDateFormat("yyyyMMddHHmmss");//设置日期格式
    @RequestMapping("/test1")
    @ResponseBody
    public String productcode() {
        String i="";
        return i;
    }
    /**
     * 生成二维码 不保存
     */
    @RequestMapping("/reCode")
    @ResponseBody
    public JSONObject reCode(HttpServletRequest request, HttpServletResponse response,HttpSession session){
        JSONObject json = new JSONObject();
        if (session.getAttribute("operid") != null && session.getAttribute("operid") != ""&&session.getAttribute("appid")!=null&&session.getAttribute("appid")!="") {
            try {
            String operid = session.getAttribute("operid").toString();
            String appid = session.getAttribute("appid").toString();
            String key = session.getAttribute("key").toString();
            String clientid = session.getAttribute("clientid").toString();
            User usera = new User();
            usera.setOperid(operid);
            usera.setAppid(appid);
            User user = serverUser.selectOperid(usera);
                json = serverUser.xinxiyz(clientid, user.getIccid(), key, user.getName(), "101", appid, null,user.getPassword());
                if (json.getString("ResultCode").equals("0000") && json.getString("code").equals("OK")){
                String i = RecodeUtil.creatRrCode(json.getString("Qrcode"), 290, 290);
                json.put("img", i);
                json.put("name", user.getName());
                    json.put("code","OK");
                }else{
                    json.put("code","NO");
                }
            } catch (Exception e) {
                log.error("二维码生成异常,异常原因 mas={}",e.getMessage(),e);
            }
        }
        return json;
    }
    @RequestMapping("/erm")
    public String reCode1(HttpServletRequest request, HttpServletResponse response, HttpSession session){
        return "qrcode";
    }
    @RequestMapping("/a1")
    public String vue(HttpServletRequest request, HttpServletResponse response, HttpSession session){
        return "fangkeBD";
    }
    @RequestMapping("/a2")
    public String b(HttpServletRequest request, HttpServletResponse response, HttpSession session){
        return "fangkeSQ";
    }
    @RequestMapping("/a3")
    public String c(HttpServletRequest request, HttpServletResponse response, HttpSession session){

        return "pay234";
    }
}
