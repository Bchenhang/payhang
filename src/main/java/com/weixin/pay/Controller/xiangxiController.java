package com.weixin.pay.Controller;
import com.alibaba.fastjson.JSONObject;
import com.weixin.pay.config.PayfwConfig;
import com.weixin.pay.pojo.*;
import com.weixin.pay.server.*;
import com.weixin.pay.utils.MD5Utils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;


@Slf4j
@Controller
public class xiangxiController {//消息上转
    @Resource
    private serverUser serverUser;
    @Resource
    private serverOrder selectOrders;
    @Resource
    private ServerTs serverTs;
    @Resource
    private com.weixin.pay.server.serverSheet serverSheet;
    @Resource
    private  serverControl serverControl;
    @Resource
    private  serverTransaction serverTransaction;
    @Resource
    private PayfwConfig payfwConfig;
    @Resource
    private  serverNotice serverNotice;
    @Resource
    private serverMpconfig serverMpconfig;
    private SimpleDateFormat d = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
    private SimpleDateFormat s = new SimpleDateFormat("yyyyMMddHHmmss");//设置日期格式
    @ResponseBody
    @RequestMapping(value = "/YKT_NOTIFY",method=RequestMethod.POST)
    public JSONObject index(@RequestBody JSONObject json) {
        json.put("Kind",4);
        mpconfig mpconfig=serverMpconfig.selectconfig(json.getString("CustomerID"));
        JSONObject jsonObject=new JSONObject();
        StringBuffer buffer = new StringBuffer();
        try {
        buffer.append("001");
        buffer.append(json.get("CustomerID"));
        buffer.append(json.get("ICCID"));
        buffer.append(json.get("NotifyTime"));
        String b=MD5Utils.md5(buffer.toString(),mpconfig.getMackey());
        System.out.println(b.toUpperCase());
        if (b.toUpperCase().equals(json.getString("MAC"))){
            notice notice=new notice();
            notice.setAppid(json.getString("CustomerID"));
            notice.setIccid(json.getString("ICCID"));
            notice.setTitle(json.getString("Title"));
            notice.setContent(json.getString("Content"));
            notice.setRemark(json.getString("Remark"));
            notice.setNotifytime(d.format(s.parse(json.getString("NotifyTime"))));
            int i=serverNotice.addNotice(notice);
            if (i>0){
             /*   List<User> list=serverTs.selectTsop(json.getString("ICCID"),json.getString("CustomerID"));
                if (list.size()>0) {
                    WxAccessToken token = selectOrders.getAccessToken(mpconfig.getAppid(), mpconfig.getSecret());
                    String mbid = serverMpconfig.mbid("5", mpconfig, token.getAccessToken());//获取mbid
                    for (int m = 0; m < list.size(); m++) {
                        WxTemplate wxTemplate = selectOrders.buildTempMessage1(serverTs.Tsyh(list.get(m).getOperid(), mbid, null));//模板信息  opid，模板id 照片地址
                        Map<String, TemplateData> map = selectOrders.buildTempMessage2(serverTs.Tsmb(json, list.get(m).getName()));//模板信息
                        wxTemplate.setData(map);
                        int o = selectOrders.sendMessage(wxTemplate, token.getAccessToken());
                        if (o == 0) {//推送是否成功
                            //成功
                            jsonObject.put("ResultCode", "0000");
                            jsonObject.put("ResultMsg", "消息推送成功");
                            log.info("信息推送成功---》" + jsonObject.toString());
                        } else {
                            //模板消息发送失败
                            jsonObject.put("ResultCode", "0000");
                            jsonObject.put("ResultMsg", "模板消息发送失败{微信白名单配置错误}");
                            log.info("信息推送失败---》" + jsonObject.toString());
                        }
                    }
                }else{
                    jsonObject.put("ResultCode","0000");
                    jsonObject.put("ResultMsg","用户不存在");
                    log.info("消息用户不存在----》");
                }*/
                jsonObject.put("ResultCode","0000");
                jsonObject.put("ResultMsg","数据添加成功");
                log.info("消息新增成功----》"+jsonObject.toString());
            }else {
                jsonObject.put("ResultCode", "0003");
                jsonObject.put("ResultMsg", "数据添加失败");
                log.info("消息新增成失败----》"+jsonObject.toString());
            }
         }else {
            jsonObject.put("ResultCode","0002");
            jsonObject.put("ResultMsg","MAC，验证失败");
            log.info("消息Mac验证失败----》"+jsonObject.toString());
        }
        }catch (Exception e){
            log.error("消息上传异常,异常原因 mas={}",e.getMessage(),e);
        }
        return jsonObject;
    }
    @RequestMapping(value = "/xx")
    @ResponseBody
    public JSONObject menjinjilu(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        JSONObject j=new JSONObject();
        notice notice=new notice();
        if(session.getAttribute("operid")!=null&&session.getAttribute("operid")!=""&&session.getAttribute("appid")!=null&&session.getAttribute("appid")!="") {//判断session是否为空
            String operid = session.getAttribute("operid").toString();
            String appid = session.getAttribute("appid").toString();
            Calendar calendar1 = Calendar.getInstance();
            try {
                User user=new User();
                user.setOperid(operid);
                user.setAppid(appid);
                User user1=serverUser.selectOperid(user);
                SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                calendar1.add(Calendar.DATE, -3);
                String three_days_ago = sdf1.format(calendar1.getTime());
                List<notice> list = serverNotice.selectNotice(user1.getAppid(), user1.getIccid(), three_days_ago);
                for (int i = 0; i < list.size(); i++) {
                    notice = list.get(i);
                    Date date = d.parse(notice.getNotifytime());
                    notice.setNotifytime(d.format(date));
                    list.set(i, notice);
                }
                j.put("list", list);
            } catch (Exception e) {
                log.error("消息记录异常,异常原因 mas={}", e.getMessage(), e);
            }
        }
        return j;
    }
}
