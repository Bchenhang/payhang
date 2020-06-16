package com.weixin.pay.Controller;

import com.alibaba.fastjson.JSONObject;
import com.weixin.pay.config.PayfwConfig;
import com.weixin.pay.pojo.*;
import com.weixin.pay.server.serverUser;
import com.weixin.pay.utils.HttpClientUtils;
import com.weixin.pay.utils.HttpRequest;
import com.weixin.pay.utils.MD5Utils;
import lombok.extern.slf4j.Slf4j;
import me.chanjar.weixin.common.bean.WxAccessToken;
import org.apache.http.HttpResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.weixin.pay.server.*;
@Slf4j
@Controller
public class qingjiaController {
    @Resource
    private serverUser serverUser;
    @Resource
    private PayfwConfig payfwConfig;
    @Resource
    private serverMpconfig serverMpconfig;
    @Resource
    private serverOrder selectOrders;
    @Resource
    private ServerTs serverTs;

    private SimpleDateFormat d = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
    private SimpleDateFormat s = new SimpleDateFormat("yyyyMMddHHmmss");//设置日期格式

    @RequestMapping("/qingjia") //请假申请
    @ResponseBody
    public JSONObject diancan(HttpSession session, HttpRequest request, HttpResponse response, @RequestParam(value = "lx") String lx
            , @RequestParam(value = "krq") String krq, @RequestParam(value = "jrq") String jrq, @RequestParam(value = "sy") String sy) {
        JSONObject json = new JSONObject();
        String Skrq = krq + ":00";
        String Sjrq = jrq + ":00";
        Date now = new Date();
        Date afterDate = new Date(now .getTime() + 6000000);
        log.info("--->获取token时间"+d.format(afterDate));
        if (session.getAttribute("operid") != null && session.getAttribute("operid") != "" && session.getAttribute("appid") != null && session.getAttribute("appid") != "") {
            StringBuffer stringBuffer = new StringBuffer();
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
                stringBuffer.append(s.format(d.parse(Skrq)));
                stringBuffer.append(s.format(d.parse(Sjrq)));
                String b = MD5Utils.md5(stringBuffer.toString(), key);
                json.put("VersionId", "001");
                json.put("CustomerID", appid);
                json.put("ClientID", payfwConfig.getClientid());
                json.put("ICCID", user1.getIccid());
                json.put("Name", user1.getName());
                json.put("BeginTime", s.format(d.parse(Skrq)));
                json.put("EndTime", s.format(d.parse(Sjrq)));
                json.put("Kind", lx);
                json.put("Remark", sy);
                json.put("MAC", b);
                String p = json.toJSONString();
                System.out.println(p);
                String i = HttpClientUtils.post(payfwConfig.getFwnotify() + "YKT_LEAVE.action", p);
                json = JSONObject.parseObject(i);
            } catch (Exception e) {
                log.error("请假记录异常,异常原因 mas={}", e.getMessage(), e);
            }
        }
        return json;
    }
    //请假推送接口
    @ResponseBody
    @RequestMapping(value = "/YKT_ATTENDd",method=RequestMethod.POST)
    public JSONObject index(@RequestBody JSONObject json) {
        JSONObject jsonObject=new JSONObject();
        mpconfig mpconfig1=null;
        String zhaopianUrl="";
        String id="";
        Calendar c = Calendar.getInstance();//可以对每个时间域单独修改
        mpconfig mpconfig=serverMpconfig.selectconfig(json.getString("CustomerID"));//根据appid查询项目编码是否存在
        if (mpconfig!=null){//判断是否存在项目编码
            //kind=1学生预约审核通知《推送给老师》6
            //kind=2审核状态更新通知 《推送给学生》7
            List<User> list = serverTs.selectTsop(json.getString("ICCID"), json.getString("CustomerID"));//获取需要推送的用户
            if (list.size() > 0) {
                if (json.get("Kind")=="1"){
                    id="6";
                }else if (json.get("Kind")=="2"){
                    id="7";
                }
            String mbid=serverMpconfig.Token(mpconfig,json,id);//获取模板id
            if (json.getString("UrlImage") != "" && json.getString("UrlImage") != null) {
                zhaopianUrl = payfwConfig.getHdnotify() + "/Urlimg?UrlImage=" + json.getString("UrlImage");
            }
            for (int i = 0; i < list.size(); i++) {
                WxTemplate wxTemplate = selectOrders.buildTempMessage1(serverTs.Tsyh(list.get(i).getOperid(), mbid, zhaopianUrl));//模板信息  opid，模板id 照片地址
                Map<String, TemplateData> map = selectOrders.buildTempMessage2(serverTs.Tsmb(json, list.get(i).getName()));//模板信息
                wxTemplate.setData(map);
               mpconfig1=serverMpconfig.selectconfig(json.getString("CustomerID"));//根据appid查询token
                int o = selectOrders.sendMessage(wxTemplate, mpconfig1.getToken());
                if (o == 0) {//推送是否成功
                    //成功
                    jsonObject.put("ResultCode", "0000");
                    jsonObject.put("ResultMsg", "消息推送成功");
                    log.info("推送成功---》" + jsonObject.toString());
                }else {
                    //模板消息发送失败
                    jsonObject.put("ResultCode", "0000");
                    jsonObject.put("ResultMsg", "模板消息发送失败{微信白名单配置错误}");
                    log.info("信息推送失败---》" + jsonObject.toString());
                }
            }
            } else {
                //数据库验证失败
                jsonObject.put("ResultCode", "0000");
                jsonObject.put("ResultMsg", "用户不存在，发送失败");
                log.info("数据库验证失败，用户不存在---》" + jsonObject.toString());
            }
        }else{
            //Mac验证失败
            jsonObject.put("ResultCode","0003");
            jsonObject.put("ResultMsg","没有对应的项目编码");
            log.info("没有对应得项目编码---》"+jsonObject.toString());
        }
        return jsonObject;
    }

}