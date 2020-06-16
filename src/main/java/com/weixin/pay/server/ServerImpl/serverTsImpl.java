package com.weixin.pay.server.ServerImpl;

import com.alibaba.fastjson.JSONObject;
import com.weixin.pay.dao.UserDao;
import com.weixin.pay.pojo.User;
import com.weixin.pay.pojo.mpconfig;
import com.weixin.pay.server.serverMpconfig;
import com.weixin.pay.server.ServerTs;
import com.weixin.pay.utils.MD5Utils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
@Slf4j
@Service
public class serverTsImpl implements ServerTs {
    @Resource
    private UserDao UserDao;
    @Resource
    private serverMpconfig serverMpconfig;
    private SimpleDateFormat d = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
    private SimpleDateFormat s = new SimpleDateFormat("yyyyMMddHHmmss");//设置日期格式
    public List<User> selectTsop(String iccic,String appid){//查询operid
        User user=new User();
        user.setIccid(iccic);
        user.setAppid(appid);
        List<User> list= UserDao.selectTsop(user);
        return list;
    }
    public  String TsYz(JSONObject json){ //参数验证
        mpconfig mpconfig=serverMpconfig.selectconfig(json.getString("CustomerID"));
        String code="";
        StringBuffer stringBuffer=new StringBuffer();
        stringBuffer.append("001");
        stringBuffer.append(json.get("CustomerID"));
        stringBuffer.append(json.get("Kind"));//1
        stringBuffer.append(json.get("ICCID"));//11
        stringBuffer.append(json.get("ClockNo"));//202
        stringBuffer.append(json.get("AttendTime"));//20190325214836
        try {
            String b=MD5Utils.md5(stringBuffer.toString(),mpconfig.getMackey());
           log.info("本地mac==+"+b.toUpperCase()+"+JsonMac=="+json.getString("MAC")+"字符串="+stringBuffer+"key="+mpconfig.getMackey());
            if (b.toUpperCase().equals(json.getString("MAC"))){
            code="OK";
            }else {
                code="NO";
            }
        }catch (Exception e){
            log.error("Mac验证异常,异常原因 mas={}",e.getMessage(),e);
        }
        return code;
    }
    public Map Tsmb (JSONObject object,String name){ //模板消息

        StringBuffer stringBuffer=new StringBuffer();
         if (object.getIntValue("ClockNo")==0){

         }
        Map<String,String> m1 = new HashMap<String,String>();
        try {
            if (object.getIntValue("Kind")==1){//考勤

                if (object.getString("Area")!=null && object.getString("Area")!=""){
                    m1.put("lx",object.getString("Area"));//通知类型
                }else{
                    m1.put("lx",object.getString("Remark"));//通知类型
                }
                m1.put("name",name);//姓名
                m1.put("kqh",object.getString("ICCID"));// 考情号
                m1.put("date",d.format(s.parse(object.get("AttendTime").toString())));//时间
                m1.put("bt","终端["+object.getString("ClockNo")+"]");//结束语
                m1.put("code","1");//颜色选择

            }else if (object.getIntValue("Kind")==2){//门禁
                if (object.getIntValue("Flag")==1){
                    if (object.getString("Area")==null){
                        m1.put("lx",name+"离开");
                    }else{
                        m1.put("lx",name+"离开["+object.getString("Area")+"]");
                    }

                }else if (object.getIntValue("Flag")==2){
                    if (object.getString("Area")==null){
                        m1.put("lx",name+"进入");//进入
                    }else{
                        m1.put("lx",name+"进入["+object.getString("Area")+"]");//进入
                    }
                }
                m1.put("name",object.getString("Remark"));//门禁名称
                m1.put("kqh",object.getString("CardNo"));// 卡号
                m1.put("date",d.format(s.parse(object.get("AttendTime").toString())));//时间
                m1.put("bt","终端["+object.getString("ClockNo")+"]");//结束语
                m1.put("code","2");//颜色选择
            }else if (object.getIntValue("Kind")==3) {
                if (object.getIntValue("Flag") >= 0) {
                    if (object.getIntValue("Flag")==1){
                        m1.put("lx", "现金充值");//通知类型
                    }else if (object.getIntValue("Flag")==2){
                        m1.put("lx", "赠送充值");//通知类型
                    }else if (object.getIntValue("Flag")==3){
                        m1.put("lx", "终端充值");//通知类型
                    }else if (object.getIntValue("Flag")==4){
                        m1.put("lx", "一般补贴");//通知类型
                    }else if (object.getIntValue("Flag")==5){
                        m1.put("lx", "清零补偿");//通知类型
                    }else if (object.getIntValue("Flag")==6){
                        m1.put("lx", "微信充值");//通知类型
                    }else if (object.getIntValue("Flag")==7){
                        m1.put("lx", "支付宝充值");//通知类型
                    }else if (object.getIntValue("Flag")==8){
                        m1.put("lx", "银行转账");//通知类型
                    }else if (object.getIntValue("Flag")==9){
                        m1.put("lx", "其他充值");//通知类型
                    }else if (object.getIntValue("Flag")==10){
                        m1.put("lx", "开卡收押金");//通知类型
                    }else if (object.getIntValue("Flag")==11){
                        m1.put("lx", "补办收押金");//通知类型
                    }else if (object.getIntValue("Flag")==12){
                        m1.put("lx", "清零补现金");//通知类型
                    }else if (object.getIntValue("Flag")==13){
                        m1.put("lx", "冲正扣补贴");//通知类型
                    }else if (object.getIntValue("Flag")==14){
                        m1.put("lx", "冲正扣现金");//通知类型
                    }else if (object.getIntValue("Flag")==15){
                        m1.put("lx", "圈存到账");//通知类型
                    }else if (object.getIntValue("Flag")==20){
                        m1.put("lx", "现金转账");//通知类型
                    }else if (object.getIntValue("Flag")==21){
                        m1.put("lx", "补偿转账");//通知类型
                    }else if (object.getIntValue("Flag")==30){
                        m1.put("lx", "更正退现金");//通知类型
                    }else if (object.getIntValue("Flag")==31){
                        m1.put("lx", "更正退补贴");//通知类型
                    }else if (object.getIntValue("Flag")==32){
                        m1.put("lx", "消费现金返还");//通知类型
                    }else if (object.getIntValue("Flag")==33){
                        m1.put("lx", "消费补贴返还");//通知类型
                    }
                    m1.put("name", d.format(s.parse(object.get("AttendTime").toString())));//充值时间
                    m1.put("kqh",new BigDecimal(object.getIntValue("Amount")).divide(new BigDecimal(100),2,RoundingMode.HALF_UP).toString());// 充值金额
                    m1.put("date", new BigDecimal(object.getIntValue("Balance")).divide(new BigDecimal(100),2,RoundingMode.HALF_UP).toString());//账户余额
                    if (object.getIntValue("ClockNo")==0 && object.getString("Area")==null){
                        m1.put("bt","");//结束语
                    }else{
                    if (object.getIntValue("ClockNo")==0 && object.getString("Area")!=null){
                        m1.put("bt",object.getString("Area"));//结束语
                    }else if (object.getString("Area")==null && object.getIntValue("ClockNo")!=0){
                        m1.put("bt","终端["+object.getString("ClockNo")+"]");//结束语
                    }else{
                        m1.put("bt",object.getString("Area")+"-终端["+object.getString("ClockNo")+"]");//结束语
                    }
                    }
                    m1.put("code","3");//颜色选择
                } else if (object.getIntValue("Flag") < 0) {
                    if (object.getIntValue("Flag")==-1){
                        m1.put("lx", "消费现金");//通知类型
                    }else if (object.getIntValue("Flag")==-2){
                        m1.put("lx", "消费补偿");//通知类型
                    }else if (object.getIntValue("Flag")==-3){
                        m1.put("lx", "退现金");//通知类型
                    }else if (object.getIntValue("Flag")==-4){
                        m1.put("lx", "退补贴");//通知类型
                    }else if (object.getIntValue("Flag")==-5){
                        m1.put("lx", "清补贴");//通知类型
                    }else if (object.getIntValue("Flag")==6){
                        m1.put("lx", "订餐");//通知类型
                    }else if (object.getIntValue("Flag")==-7){
                        m1.put("lx", "记账");//通知类型
                    }else if (object.getIntValue("Flag")==-8){
                        m1.put("lx", "计次");//通知类型
                    }else if (object.getIntValue("Flag")==-10){
                        m1.put("lx", "退押金");//通知类型
                    }else if (object.getIntValue("Flag")==-20){
                        m1.put("lx", "现金转账");//通知类型
                    }else if (object.getIntValue("Flag")==-21){
                        m1.put("lx", "补偿转账");//通知类型
                    }else if (object.getIntValue("Flag")==-30){
                        m1.put("lx", "补录扣现金");//通知类型
                    }else if (object.getIntValue("Flag")==-31){
                        m1.put("lx", "补录扣补贴");//通知类型
                    }else if (object.getIntValue("Flag")==-32){
                        m1.put("lx", "充值纠错");//通知类型
                    }
                    m1.put("name", new BigDecimal(object.getIntValue("Amount")).divide(new BigDecimal(100),2,RoundingMode.HALF_UP).toString());//消费金额 保留2位小数
                    m1.put("kqh", d.format(s.parse(object.get("AttendTime").toString())));// 消费时间
                    if (object.getIntValue("ClockNo")==0 && object.getString("Area")==null){
                        m1.put("bt","");//结束语
                    }else{
                        if (object.getIntValue("ClockNo")==0 && object.getString("Area")!=null){
                            m1.put("bt",object.getString("Area"));//结束语
                        }else if (object.getIntValue("ClockNo")!=0 && (object.getString("Area")==null || object.getString("Area")=="")){
                            m1.put("bt","终端["+object.getString("ClockNo")+"]");//结束语
                        }else{
                            m1.put("bt",object.getString("Area")+"-终端["+object.getString("ClockNo")+"]");//结束语
                        }
                    }
                    m1.put("code","4");//颜色选择
                }
            }else if (object.getIntValue("Kind")==4){//消息上转
            m1.put("lx",object.getString("Title"));//通知类型
            m1.put("name","消息通知");//姓名
            m1.put("kqh",d.format(s.parse(object.get("NotifyTime").toString())));// 考情号
            m1.put("date",object.getString("Content"));//时间
            m1.put("bt",object.getString("Remark"));//结束语
            m1.put("code","1");//颜色选择
            }
        }catch (Exception e){
            log.error("模板消息异常,异常原因 mas={}",e.getMessage(),e);
        }
        return m1;
    }
    public Map Tsyh (String opid,String mbid,String zpdz){ //推送的用户
        Map<String,String> m = new HashMap<String,String>();
        m.put("FromUserName",opid);//opid
        m.put("template_id",mbid);//模板id、
        m.put("zpdz",zpdz);       //照片地址
        return m;
    }
    public  int Tspd(String appid){
        JSONObject json = new JSONObject();
        int i;
        mpconfig mpconfig = serverMpconfig.selectconfig(appid);
        json=JSONObject.parseObject(mpconfig.getParam());
        if (json.containsKey("invalidpush")){
          if (json.get("invalidpush").equals("1")){
              i=1;
          }else{
              i=0;
          }
        }else{
            i=0;
        }
      return i;
    }
    public  int Tspd2(JSONObject json){
        int i;
        if (json.containsKey("invalidpush")){
            if (json.get("invalidpush").toString().equals("1")){
                i=1;
                System.out.println();
            }else{
                i=0;
            }
        }else{
            i=0;
        }
        return i;
    }
}
