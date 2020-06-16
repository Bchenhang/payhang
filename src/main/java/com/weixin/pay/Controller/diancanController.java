package com.weixin.pay.Controller;

import com.alibaba.fastjson.JSONObject;
import com.weixin.pay.config.PayfwConfig;
import com.weixin.pay.pojo.User;
import com.weixin.pay.server.serverUser;
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

import com.weixin.pay.utils.HttpClientUtils;

import java.text.SimpleDateFormat;
import java.util.Date;
@Slf4j
@Controller
public class diancanController {
        /**
         * 生成二维码 并保存
         */
        @Resource
        private serverUser serverUser;
        @Resource
        private PayfwConfig payfwConfig;
         //点餐
         private SimpleDateFormat d = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
         private SimpleDateFormat s = new SimpleDateFormat("yyyyMMdd");//设置日期格式
         private Date dt = new Date();
        @RequestMapping("/diancan")
        @ResponseBody
        public JSONObject diancan(HttpSession session, HttpRequest request, HttpResponse response, @RequestParam(value = "zao") String zao, @RequestParam(value = "zhong") String zhong, @RequestParam(value = "wan") String wan
                , @RequestParam(value = "ye") String ye, @RequestParam(value = "rq") String rq) {
            JSONObject date = new JSONObject();
            if(session.getAttribute("operid")!=null&&session.getAttribute("operid")!=""&&session.getAttribute("appid")!=null&&session.getAttribute("appid")!="") {
                try {
                JSONObject json = new JSONObject();
                String i = null;
                StringBuffer stringBuffer = new StringBuffer();
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
                System.out.println("日期="+s.format(d.parse(rq)));
                stringBuffer.append(s.format(d.parse(rq)));
                    String b = MD5Utils.md5(stringBuffer.toString(), key);
                    json.put("VersionId","001");
                    json.put("CustomerID",appid);
                    json.put("ClientID",payfwConfig.getClientid());
                    json.put("ICCID",user1.getIccid());
                    json.put("Name",user1.getName());
                    json.put("Date",s.format(d.parse(rq)));
                    json.put("Breakfast",zao);
                    json.put("Lunch",zhong);
                    json.put("Supper",wan);
                    json.put("Midnight",ye);
                    json.put("MAC", b);
                    String p = json.toJSONString();
                    i=HttpClientUtils.post(payfwConfig.getFwnotify()+"YKT_ORDER.action",p);
                    date =JSONObject.parseObject(i);
                    log.info("点餐返回数据----》"+date.toString());
                }catch (Exception e){
                    log.error("点餐发生异常 msg={}",e.getMessage(),e);
                }
            }
            return date;
        }
    @RequestMapping("/dianselect")
    @ResponseBody
    public JSONObject diancan(HttpSession session, HttpRequest request, HttpResponse response,@RequestParam(value = "rq") String rq) {
        JSONObject json = new JSONObject();
        JSONObject js = new JSONObject();
        if(session.getAttribute("operid")!=null&&session.getAttribute("operid")!=""&&session.getAttribute("appid")!=null&&session.getAttribute("appid")!="") {
            StringBuffer stringBuffer = new StringBuffer();
            try {
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
                stringBuffer.append(s.format(d.parse(rq)));
                String b = MD5Utils.md5(stringBuffer.toString(), key);
                json.put("VersionId","001");
                json.put("CustomerID",appid);
                json.put("ClientID",payfwConfig.getClientid());
                json.put("ICCID",user1.getIccid());
                json.put("Name",user1.getName());
                json.put("Date",s.format(d.parse(rq)));
                json.put("MAC", b);
                String p = json.toJSONString();
                String i=HttpClientUtils.post(payfwConfig.getFwnotify()+"YKT_QUERY_DC.action",p);
                js=JSONObject.parseObject(i);
                js.put("rq",rq);
            }catch (Exception e){
                log.error("点餐状态发生异常 msg={}",e.getMessage(),e);
            }
        }
        return js;
    }
}
