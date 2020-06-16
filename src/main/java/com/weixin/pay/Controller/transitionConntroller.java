package com.weixin.pay.Controller;
import com.alibaba.fastjson.JSONObject;
import com.weixin.pay.config.PayfwConfig;
import com.weixin.pay.pojo.TemplateData;
import com.weixin.pay.pojo.User;
import com.weixin.pay.pojo.WxTemplate;
import com.weixin.pay.pojo.mpconfig;
import com.weixin.pay.server.*;
import lombok.extern.slf4j.Slf4j;
import me.chanjar.weixin.common.bean.WxAccessToken;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.weixin.pay.pojo.sheet;
import com.weixin.pay.pojo.transaction;
import com.weixin.pay.pojo.control;
import org.springframework.web.servlet.ModelAndView;

import java.text.SimpleDateFormat;
import java.util.*;

@Slf4j
@Controller
public class transitionConntroller {
    @Resource
    private serverOrder selectOrders;
    @Resource
    private ServerTs serverTs;
    @Resource
    private  serverSheet serverSheet;
    @Resource
    private  serverControl serverControl;
    @Resource
    private  serverTransaction serverTransaction;
    @Resource
    private PayfwConfig payfwConfig;
    @Resource
    private serverMpconfig serverMpconfig;
    private SimpleDateFormat d = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
    private SimpleDateFormat g = new SimpleDateFormat("yyyyMMddHHmmss");//设置日期格式
        @ResponseBody
        @RequestMapping(value = "/YKT_ATTEND",method=RequestMethod.POST)
        public JSONObject index(@RequestBody  JSONObject json) {
            int codes=0;
            mpconfig mpconfig1=null;
            Calendar c = Calendar.getInstance();//可以对每个时间域单独修改
            WxAccessToken token=null;
            Date date=null;
            String zhaopianUrl="";
            String id="";//状态
            JSONObject jsonObject=new JSONObject();
            mpconfig mpconfig=serverMpconfig.selectconfig(json.getString("CustomerID"));
            if (mpconfig!=null){//判断是否存在项目编码
            String code=serverTs.TsYz(json);//验证MAC
                if (code.equals("OK")){
                    log.info("Mac成功---》"+code);
                    if (json.getIntValue("Kind")==1){//考勤
                        sheet sheet=serverSheet.selectpaicong(json);
                        if (sheet==null){
                            id="1";
                            codes=serverSheet.addSheet(json);
                            log.info("排重成功---》"+codes);
                        }
                    }else if (json.getIntValue("Kind")==2){//门禁
                        control control=serverControl.selectCpaicong(json);
                        if (control==null) {
                            id ="2";
                            codes = serverControl.addControl(json);
                            log.info("排重成功---》"+codes);
                        }
                    }else if (json.getIntValue("Kind")==3){//交易
                        if (json.getIntValue("Flag") < 0){
                            id="3";//消费
                        }else if (json.getIntValue("Flag") >= 0){
                            id="4"; //充值
                        }
                       transaction transaction=serverTransaction.Tpaicong(json);
                        if (transaction==null) {
                            codes = serverTransaction.addTransaction(json);
                            log.info("排重成功--->"+codes);
                        }
                    }
                    if (codes>0) {  //新增数据库
                        if (serverTs.Tspd2(json)==0){
                            log.info("--->推送开始"+json.get("ICCID"));
                        if (serverTs.Tspd(json.get("CustomerID").toString()) == 0) {//判断是否推送
                            try {
                                date = d.parse(d.format(g.parse(json.getString("AttendTime"))));//过滤日期小于当前8小时不推送
                            } catch (Exception e) {
                                log.error("推送日期异常,异常原因 mas={}", e.getMessage(), e);
                            }
                            c.setTime(new Date());
                            c.set(Calendar.HOUR_OF_DAY, c.get(Calendar.HOUR_OF_DAY) - 8);
                            if (date.after(c.getTime())) {
                                log.info("--->判断推送时间"+json.get("ICCID"));
                                List<User> list = serverTs.selectTsop(json.getString("ICCID"), json.getString("CustomerID"));
                                if (list.size() > 0) {
                                    log.info("--->获取token"+json.get("ICCID")+"appid/"+mpconfig.getAppid()+"/appsecret"+mpconfig.getSecret());
                                    if (mpconfig.getToken()==null){//第一次获取tolen
                                    token = selectOrders.getAccessToken(mpconfig.getAppid(), mpconfig.getSecret());
                                    log.info("--->第一次获取token"+token.getAccessToken());
                                    Date now = new Date();
                                    Date afterDate = new Date(now .getTime() + 6000000);
                                    log.info("--->获取token时间"+d.format(c.getTime()));
                                    int p=serverMpconfig.updateToken(mpconfig.getAppid(),token.getAccessToken(),d.format(afterDate));
                                        mpconfig1=serverMpconfig.selectconfig(json.getString("CustomerID"));
                                    log.info("--->第一次获取token到数据库"+p+"token="+token.getAccessToken());
                                    }else{
                                        try {
                                            Date date2 = new Date();
                                            Date date1=d.parse(mpconfig.getTokentime());
                                            if (date2.after(date1)==false){
                                                mpconfig1=serverMpconfig.selectconfig(json.getString("CustomerID"));
                                                log.info("--->token有效"+mpconfig1.getToken());
                                            }else{
                                                token = selectOrders.getAccessToken(mpconfig.getAppid(), mpconfig.getSecret());
                                                log.info("--->token失效从新获取"+token.getAccessToken());
                                                Date now = new Date();
                                                Date afterDate = new Date(now .getTime() + 6000000);
                                                int p=serverMpconfig.updateToken(mpconfig.getAppid(),token.getAccessToken(),d.format(afterDate));
                                                log.info("--->修改token得状态"+p);
                                                mpconfig1=serverMpconfig.selectconfig(json.getString("CustomerID"));
                                            }
                                        }catch (Exception e){
                                            log.error("推送token异常,异常原因 mas={}", e.getMessage(), e);
                                        }
                                    }
                                    String mbid = serverMpconfig.mbid(id, mpconfig, mpconfig1.getToken());//获取mbid
                                    if (json.getString("UrlImage") != "" && json.getString("UrlImage") != null) {
                                        zhaopianUrl = payfwConfig.getHdnotify() + "/Urlimg?UrlImage=" + json.getString("UrlImage");
                                    }
                                    for (int i = 0; i < list.size(); i++) {
                                        WxTemplate wxTemplate = selectOrders.buildTempMessage1(serverTs.Tsyh(list.get(i).getOperid(), mbid, zhaopianUrl));//模板信息  opid，模板id 照片地址
                                        Map<String, TemplateData> map = selectOrders.buildTempMessage2(serverTs.Tsmb(json, list.get(i).getName()));//模板信息
                                        wxTemplate.setData(map);
                                        int o = selectOrders.sendMessage(wxTemplate, mpconfig1.getToken());
                                        if (o == 0) {//推送是否成功
                                            //成功
                                            jsonObject.put("ResultCode", "0000");
                                            jsonObject.put("ResultMsg", "消息推送成功");
                                            log.info("信息推送成功---》" + jsonObject.toString());
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
                            } else {
                                jsonObject.put("ResultCode", "0000");
                                jsonObject.put("ResultMsg", "推送时间过期");
                                log.info("推送时间以过---》" + jsonObject.toString());
                            }
                        }else{
                            //数据不推送
                            jsonObject.put("ResultCode","0000");
                            jsonObject.put("ResultMsg","无推送要求");
                            log.info("无推送要求---》"+jsonObject.toString());
                        }
                    }else{
                            //数据不推送
                            jsonObject.put("ResultCode","0000");
                            jsonObject.put("ResultMsg","无推送服务");
                            log.info("数据不推送---》"+jsonObject.toString());
                    }
                    }else{
                        //数据库验证失败
                        jsonObject.put("ResultCode","0000");
                        jsonObject.put("ResultMsg","数据重复");
                        log.info("数据重复json---》"+jsonObject.toString());
                    }
             }else{
                    //Mac验证失败
                    jsonObject.put("ResultCode","0002");
                    jsonObject.put("ResultMsg","Mac验证失败");
                    log.info("Mac验证失败---》"+jsonObject.toString());
                }
            }else{
                 //Mac验证失败
                jsonObject.put("ResultCode","0003");
                jsonObject.put("ResultMsg","没有对应的项目编码");
                log.info("没有对应得项目编码---》"+jsonObject.toString());
            }
            return jsonObject;
        }

    @RequestMapping("/Urlimg")
    public ModelAndView Url(HttpServletRequest request, HttpServletResponse response, HttpSession session, @RequestParam(value = "UrlImage") String UrlImage){
        JSONObject json = new JSONObject();
        json.put("UrlImage",UrlImage+"?id="+new Random().nextInt(100000000));
        ModelAndView modelAndView = new ModelAndView();
        log.info("图片路径改变---》"+json.toString());
        modelAndView = new ModelAndView("zhaopianUrl");
        modelAndView.addObject("params", json);
        return modelAndView;
    }


}
