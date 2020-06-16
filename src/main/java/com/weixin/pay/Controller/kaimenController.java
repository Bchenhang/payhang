package com.weixin.pay.Controller;

import com.alibaba.fastjson.JSONArray;
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
public class kaimenController {//门点查询
    @Resource
    private com.weixin.pay.server.serverUser serverUser;
    @Resource
    private PayfwConfig payfwConfig;

    private SimpleDateFormat d = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
    private SimpleDateFormat s = new SimpleDateFormat("yyyyMMdd");//设置日期格式
    @RequestMapping("/mendian") //门点查询
    @ResponseBody
    public JSONObject mendian(HttpSession session, HttpRequest request, HttpResponse response) {
        JSONObject json = new JSONObject();
        StringBuffer stringBuffer = new StringBuffer();
        if(session.getAttribute("operid")!=null&&session.getAttribute("operid")!=""&&session.getAttribute("appid")!=null&&session.getAttribute("appid")!="") {
            String operid = session.getAttribute("operid").toString();
            String appid = session.getAttribute("appid").toString();
            String key = session.getAttribute("key").toString();
            User user = new User();
            user.setOperid(operid);
            user.setAppid(appid);
            User user1 = serverUser.selectOperid(user);
            try {
                stringBuffer.append("001");//下面还需要一个appid
                stringBuffer.append(appid);
                stringBuffer.append(payfwConfig.getClientid());
                stringBuffer.append(user1.getIccid());
                String b = MD5Utils.md5(stringBuffer.toString(), key);
                json.put("VersionId","001");
                json.put("CustomerID",appid);
                json.put("ClientID",payfwConfig.getClientid());
                json.put("ICCID",user1.getIccid());
                json.put("Name",user1.getName());
                json.put("MAC", b);
                String p = json.toJSONString();
                System.out.println(p);
                String i=HttpClientUtils.post(payfwConfig.getFwnotify()+"YKT_QUERY_DOOR.action",p);
                json=JSONObject.parseObject(i);
                JSONArray jsonArray = JSONArray.parseArray(json.getString("Door"));
                System.out.println(""+jsonArray);
            }catch (Exception e){
                log.error("门点查询记录异常,异常原因 mas={}",e.getMessage(),e);
            }
        }
        return json;
    }

    @RequestMapping("/kai") //远程开门
    @ResponseBody
    public JSONObject kai(HttpSession session, HttpRequest request, HttpResponse response, @RequestParam(value = "zd") String zd, @RequestParam(value = "zm") String zm) {
        JSONObject json = new JSONObject();
        StringBuffer stringBuffer = new StringBuffer();
        if(session.getAttribute("operid")!=null&&session.getAttribute("operid")!=""&&session.getAttribute("appid")!=null&&session.getAttribute("appid")!="") {
            String operid = session.getAttribute("operid").toString();
            String appid = session.getAttribute("appid").toString();
            String key = session.getAttribute("key").toString();
            User user = new User();
            user.setOperid(operid);
            user.setAppid(appid);
            try {
                User user1 = serverUser.selectOperid(user);
                stringBuffer.append("001");//下面还需要一个appid
                stringBuffer.append(appid);
                stringBuffer.append(payfwConfig.getClientid());
                stringBuffer.append(user1.getIccid());
                stringBuffer.append(zd);
                stringBuffer.append(zm);
                String b = MD5Utils.md5(stringBuffer.toString(), key);
                json.put("VersionId","001");
                json.put("CustomerID",appid);
                json.put("ClientID",payfwConfig.getClientid());
                json.put("ICCID",user1.getIccid());
                json.put("Name",user1.getName());
                json.put("ClockNo",zd);
                json.put("SubNo",zm);
                json.put("MAC", b);
                String p = json.toJSONString();
                System.out.println(p);
                String i=HttpClientUtils.post(payfwConfig.getFwnotify()+"YKT_OPENDOOR.action",p);
                json=JSONObject.parseObject(i);
            }catch (Exception e){
                log.error("远程开门异常,异常原因 mas={}",e.getMessage(),e);
            }
        }
        return json;
    }
}
