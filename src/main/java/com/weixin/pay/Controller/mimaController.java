package com.weixin.pay.Controller;

import com.alibaba.fastjson.JSONObject;
import com.weixin.pay.config.PayfwConfig;
import com.weixin.pay.pojo.User;
import com.weixin.pay.utils.HttpClientUtils;
import com.weixin.pay.utils.HttpRequest;
import com.weixin.pay.utils.MD5Utils;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.HttpResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;

@Slf4j
@Controller
public class mimaController {
    @Resource
    private com.weixin.pay.server.serverUser serverUser;
    @Resource
    private PayfwConfig payfwConfig;
    private SimpleDateFormat d = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
    private SimpleDateFormat s = new SimpleDateFormat("yyyyMMddHHmmss");//设置日期格式
    @RequestMapping("/mima") //修改密码
    @ResponseBody
    public JSONObject mima(HttpSession session, HttpRequest request, HttpResponse response, @RequestParam(value = "password1") String password1, @RequestParam(value = "password2") String password2) {
        JSONObject json = new JSONObject();
        if(session.getAttribute("operid")!=null&&session.getAttribute("operid")!=""&&session.getAttribute("appid")!=null&&session.getAttribute("appid")!="") {
            StringBuffer stringBuffer = new StringBuffer();
            try {
                System.out.println(password1+"--"+password2);
                String operid = session.getAttribute("operid").toString();
                String appid = session.getAttribute("appid").toString();
                String key = session.getAttribute("key").toString();
                User user = new User();
                user.setOperid(operid);
                user.setAppid(appid);
                User user1 = serverUser.selectOperid(user);
                stringBuffer.append("001");//下面还需要一个appid
                stringBuffer.append(appid);
                stringBuffer.append(payfwConfig.getClientid());
                stringBuffer.append(user1.getIccid());
                stringBuffer.append(password1);
                stringBuffer.append(password2);
                System.out.println(stringBuffer+key);
                String b = MD5Utils.md5(stringBuffer.toString(), key);
                System.out.println(b);
                json.put("VersionId","001");
                json.put("CustomerID",appid);
                json.put("ClientID",payfwConfig.getClientid());
                json.put("ICCID",user1.getIccid());
                json.put("Name",user1.getName());
                json.put("Password",password1);
                json.put("NewPwd",password2);
                json.put("MAC", b);
                String p = json.toJSONString();
                String i=HttpClientUtils.post(payfwConfig.getFwnotify()+"YKT_UPDATEPWD.action",p);
                json=JSONObject.parseObject(i);
                json.put("appid",appid);
                json.put("url",payfwConfig.getHdnotify());
            }catch (Exception e){
                log.error("修改密码异常,异常原因 mas={}",e.getMessage(),e);
            }
        }

        System.out.println(json.toString());
        return json;
    }
}
