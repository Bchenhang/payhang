package com.weixin.pay.Controller;
import com.alibaba.fastjson.JSONObject;
import com.github.binarywang.wxpay.bean.result.WxPayOrderQueryResult;
import com.weixin.pay.config.PayfwConfig;
import com.weixin.pay.pojo.User;
import com.weixin.pay.pojo.mpconfig;
import com.weixin.pay.pojo.orders;
import com.weixin.pay.server.serverOrder;
import com.weixin.pay.server.serverUser;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Slf4j
@Controller
public class yemianConntroller {
    @Resource
    private serverUser serverUser;
    @Resource
    private serverOrder  serverOrder;
    @Resource
    private PayfwConfig payfwConfig;
    @Resource
    private com.weixin.pay.server.serverMpconfig serverMpconfig;
    private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
    private Date dt = new Date();
    private SimpleDateFormat d = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
    private SimpleDateFormat s = new SimpleDateFormat("yyyyMMddHHmmss");//设置日期格式
    //验证是否绑定过
    @RequestMapping("/yz")
    @ResponseBody
    public JSONObject login(HttpServletRequest request, HttpServletResponse response, @RequestParam("operid") String operid) {
        JSONObject json=new JSONObject();
           User user=new User();
           user.setOperid(operid);
           User user1=serverUser.selectOperid(user);
          if (user1!=null){
              json.put("operid",user.getOperid());
              json.put("code","OK");
              return json;
            }
        json.put("code","NO");
        return json;
}
    //第一次绑定验证
    @RequestMapping("/wan")
    @ResponseBody
    public JSONObject loginL(HttpServletRequest request, HttpServletResponse response, HttpSession session,@RequestParam("name") String name, @RequestParam("iccid") String iccid, @RequestParam("pass") String pass) {
        JSONObject o=new JSONObject();
        StringBuffer stringBuffer=new StringBuffer();
        if (session.getAttribute("operid") != null && session.getAttribute("operid") != ""&&session.getAttribute("appid")!=null&&session.getAttribute("appid")!="") {
            String operid = session.getAttribute("operid").toString();
            String appid = session.getAttribute("appid").toString();
            String key = session.getAttribute("key").toString();
            String clientid = session.getAttribute("clientid").toString();
            User user = new User();
            user.setOperid(operid);
            user.setAppid(appid);
            User user1 = serverUser.selectOperid(user);
            System.out.println(iccid + name+pass);
            if (user1 == null) {
                try {
                    o = serverUser.xinxiyz(clientid,iccid, key, name, "101", appid, null,pass);
                    if (o.get("code").equals("OK")) {
                        if (o.get("ResultCode").equals("0000") || o.get("ResultCode").equals("0201")) {
                            User u = new User();
                            u.setName(name);
                            u.setIccid(iccid);
                            u.setOperid(operid);
                            u.setAppid(appid);
                            u.setPassword(pass);
                            u.setStatus(1);
                            user.setKind(1);//验证取等级
                            serverUser.updateKind(user);
                            serverUser.addUser(u);
                            o.put("url",payfwConfig.getHdnotify());
                            o.put("code", "CN");
                        }
                    }else if (o.get("code").equals("ON")){
                        o.put("code", "FW");
                    }
                } catch (Exception e) {
                    log.error("账户绑定异常,异常原因 mas={}",e.getMessage(),e);
                }
                //数据库有用户记录  但是密码或者等级有误进行更正
            } else {
                try {
                    o = serverUser.xinxiyz(clientid, iccid, key, name, "101", appid, null,pass);
                    if (o.getString("ResultCode").equals("0000") || o.getString("ResultCode").equals("0201")){
                        User u = new User();
                        u.setName(name);
                        u.setIccid(iccid);
                        u.setOperid(operid);
                        u.setAppid(appid);
                        user.setKind(1);//验证取等级
                        serverUser.updateKind(user);
                        serverUser.updateUser(appid,operid,name,iccid,pass,1);
                    }
                o.put("url",payfwConfig.getHdnotify());
                o.put("code", "CN");
                } catch (Exception e) {
                    log.error("账户绑定异常,异常原因 mas={}",e.getMessage(),e);
                }
            }
        }
        log.info("第一次绑定---->"+o.toString());
        return  o;
    }
    //第一次绑定验证加切换
    @RequestMapping("/wan1")
    @ResponseBody
    public JSONObject loginL1(HttpServletRequest request, HttpServletResponse response, HttpSession session,@RequestParam("name") String name, @RequestParam("iccid") String iccid, @RequestParam("pass") String pass) {
        JSONObject o=new JSONObject();
        StringBuffer stringBuffer=new StringBuffer();
        if (session.getAttribute("operid") != null && session.getAttribute("operid") != ""&&session.getAttribute("appid")!=null&&session.getAttribute("appid")!="") {
            String operid = session.getAttribute("operid").toString();
            String appid = session.getAttribute("appid").toString();
            String key = session.getAttribute("key").toString();
            String clientid = session.getAttribute("clientid").toString();
            User user = new User();
            user.setOperid(operid);
            user.setAppid(appid);
            user.setIccid(iccid);
            User user1 = serverUser.selectjs(user);
            System.out.println(iccid + name+pass);
            if (user1 == null) {
                try {
                    o = serverUser.xinxiyz(clientid,iccid, key, name, "101", appid, null,pass);
                    if (o.get("code").equals("OK")) {
                        if (o.get("ResultCode").equals("0000") || o.get("ResultCode").equals("0201")) {
                            User u = new User();
                            u.setName(name);
                            u.setIccid(iccid);
                            u.setOperid(operid);
                            u.setAppid(appid);
                            u.setPassword(pass);
                            u.setStatus(1);
                            serverUser.updateA(u);
                            serverUser.addUser(u);
                            o.put("url",payfwConfig.getHdnotify());
                            o.put("code", "OK");
                        }
                    }else if (o.get("code").equals("ON")){
                        o.put("code", "FW");
                    }
                } catch (Exception e) {
                    log.error("账户绑定异常,异常原因 mas={}",e.getMessage(),e);
                }
            } else {
                try {
                    o = serverUser.xinxiyz(clientid, iccid, key, name, "101", appid, null,pass);
                    if (o.getString("ResultCode").equals("0000") || o.getString("ResultCode").equals("0201")){
                        User u = new User();
                        u.setName(name);
                        u.setIccid(iccid);
                        u.setOperid(operid);
                        u.setAppid(appid);
                        u.setPassword(pass);
                        u.setStatus(1);
                        serverUser.updateA(u);
                        serverUser.updateB(u);
                    }
                    o.put("url",payfwConfig.getHdnotify());
                    o.put("code", "CN");
                } catch (Exception e) {
                    log.error("账户绑定异常,异常原因 mas={}",e.getMessage(),e);
                }
            }
        }
        log.info("第一次绑定---->"+o.toString());
        return  o;
    }
    //1跳转都充值页面 2跳转到个人信息页面
    @RequestMapping("/pay1")
    public ModelAndView pay(HttpServletRequest request, HttpServletResponse response,HttpSession session,@RequestParam("id") String id,@RequestParam(required=false) String orderid) {
        ModelAndView modelAndView = new ModelAndView();
        String name="";
                JSONObject json = new JSONObject();
                User user=new User();
                if (session.getAttribute("operid") != null && session.getAttribute("operid") != ""&&session.getAttribute("appid")!=null&&session.getAttribute("appid")!="") {//判断session是否为空
                    String operid=session.getAttribute("operid").toString();//
                    String appid = session.getAttribute("appid").toString();//项目编号
                    String clientid = session.getAttribute("clientid").toString();//第三方渠道编码
                    String key = session.getAttribute("key").toString();//key
                    String isshool=session.getAttribute("isshool").toString();
                    if (id.equals("1")) {//充值页
                        if (orderid!=null){
                            orders orders=new orders();
                            orders orders1=new orders();
                            orders.setOrderid(orderid);
                            orders1=serverOrder.selectOrders(orders);
                            if (orders1.getStatus()==0){//为0 开始查
                                WxPayOrderQueryResult reque = new WxPayOrderQueryResult();
                                reque=serverOrder.dingdan(orders1);
                                log.info("微信查询订单结果 mas="+reque.getTradeState());
                                if (reque.getTradeState().equals("SUCCESS")){
                                    BigDecimal bigDecima1 = orders1.getTotal_fee();
                                    BigDecimal bigDecima3 = new BigDecimal("100");
                                    BigDecimal result5 = bigDecima1.divide(bigDecima3,2,BigDecimal.ROUND_HALF_UP);
                                    String code=serverOrder.updateOrders(orderid,"001",result5.toString());
                                    log.info("1支付成功，回调异常,手动修改 mas="+code);
                                }
                            }
                        }
                        User usera=new User();
                        usera.setOperid(operid);
                        usera.setAppid(appid);
                        user=serverUser.selectOperid(usera);
                        try {
                            json= serverUser.xinxiyz(clientid,user.getIccid(),key,user.getName(),"101",appid,null,user.getPassword());
                            json.put("url",payfwConfig.getHdnotify());
                            JSONObject json4 = new JSONObject();
                            mpconfig mpconfig = serverMpconfig.selectconfig(appid);
                            json4=JSONObject.parseObject(mpconfig.getParam());
                            json.put("chargeval1",json4.get("chargeval1").toString());
                            json.put("chargeval2",json4.get("chargeval2").toString());
                            json.put("chargeval3",json4.get("chargeval3").toString());
                            json.put("chargeval4",json4.get("chargeval4").toString());
                            json.put("chargeval5",json4.get("chargeval5").toString());
                            json.put("chargeval6",json4.get("chargeval6").toString());
                        }catch (Exception e){
                            log.error("充值异常,异常原因 mas={}",e.getMessage(),e);
                        }
            modelAndView = new ModelAndView("pay234");
            modelAndView.addObject("params", json);
        } else if (id.equals("2")) {                                        //交易记录
            modelAndView = new ModelAndView("jiaoyijilu2");
            modelAndView.addObject("params", json);
        } else if (id.equals("3")) {                                        //自助挂失
            User usera=new User();
            usera.setOperid(operid);
            usera.setAppid(appid);
            user=serverUser.selectOperid(usera);
            try {

                json= serverUser.xinxiyz(clientid,user.getIccid(),key,user.getName(),"101",appid,null,user.getPassword());
                json.put("name",user.getName());
                json.put("pass",user.getIccid());
                if (isshool.equals("1")){
                    name="学工号";
                }else{
                    name="工号";
                }
                json.put("isshool",name);
                }catch (Exception e){
                log.error("挂失异常,异常原因 mas={}",e.getMessage(),e);
                }
            modelAndView = new ModelAndView("gs");
            modelAndView.addObject("params", json);
        } else if (id.equals("4")) {                                                         //订餐
            JSONObject js=new JSONObject();
            js.put("rq",sdf.format(dt)) ;
            modelAndView = new ModelAndView("diancan");
            modelAndView.addObject("params",js);
        } else if (id.equals("5")) {

            modelAndView = new ModelAndView("near");
            modelAndView.addObject("params", json);
        } else if (id.equals("6")) {                                         //交易

            modelAndView = new ModelAndView("near");
            modelAndView.addObject("params", json);
        } else if (id.equals("7")) {                                          //门禁

            modelAndView = new ModelAndView("menjinjilu2");
            modelAndView.addObject("params", json);
        } else if (id.equals("8")) {                                          //考勤

            modelAndView = new ModelAndView("kaoqingjilu2");
            modelAndView.addObject("params", json);
        } else if (id.equals("9")) {                                         //请假
            modelAndView = new ModelAndView("qingjia");
            modelAndView.addObject("params", json);
        } else if (id.equals("99")) {                                         //请假记录《》请假审核
            modelAndView = new ModelAndView("shenke");
            modelAndView.addObject("params", json);
        }else if (id.equals("10")) {                                         //远程开门
            modelAndView = new ModelAndView("kaimen");
            modelAndView.addObject("params", json);
        } else if (id.equals("11")) {                                         //日报表
            modelAndView = new ModelAndView("baobiao");
            modelAndView.addObject("params", json);
        } else if (id.equals("12")) {                                         //首页
            modelAndView = new ModelAndView("index");//页面切换moban
            modelAndView.addObject("params", json);
        } else if (id.equals("13")) {                                         //订单

            modelAndView.setViewName("order2");
            modelAndView.addObject("params", json);
        } else if (id.equals("14")) {                                         //个人中心
            StringBuffer stringBuffer=new StringBuffer();
            JSONObject o= new JSONObject();
            user.setOperid(operid);
            user.setAppid(appid);
            User user1=serverUser.selectOperid(user);
            try {
                o= serverUser.xinxiyz(clientid,user1.getIccid(),key,user1.getName(),"101",appid,null,user1.getPassword());
                if (o.getString("code").equals("OK") && o.getString("ResultCode").equals("0000")){
                    double balance= Double.parseDouble(o.get("Balance").toString())/100;
                    o.put("Balance1",balance);
                    o.put("name",user1.getName());
                    o.put("code","OK");
                }else{
                    o.put("code","ON");
                }
                o.put("url",payfwConfig.getHdnotify());
            }catch (Exception e){
                log.error("个人中心异常,异常原因 mas={}",e.getMessage(),e);
            }
            modelAndView = new ModelAndView("member");
            modelAndView.addObject("params",o);
        } else if (id.equals("15")) {                                           //消息上转
            modelAndView = new ModelAndView("xiaoxi");
            modelAndView.addObject("params", json);
        } else if (id.equals("16")) {                                           //继续圈存
            modelAndView = new ModelAndView("member");
            modelAndView.addObject("params", json);
        }else if (id.equals("17")) {                                            //我的云卡
            modelAndView = new ModelAndView("qrcode");
            modelAndView.addObject("params", json);
        }else if (id.equals("18")) {                                            //接触绑定
            modelAndView = new ModelAndView("jclogin");
            modelAndView.addObject("params", json);
        }else if (id.equals("19")) {                                            //接触绑定
            modelAndView = new ModelAndView("about");
            modelAndView.addObject("params", json);
        }else if (id.equals("20")) {                                            //手工签到
            modelAndView = new ModelAndView("qiandao");
            modelAndView.addObject("params", json);
         }else if (id.equals("21")) {                                            //修改密码
                        modelAndView = new ModelAndView("mima");
                        modelAndView.addObject("params", json);
                    }

    }else{
            modelAndView = new ModelAndView("redirect:/wechat/authorize");
            modelAndView.addObject("params", json);
        }
       return modelAndView;
    }
    //取消订单
    @RequestMapping("/del")
    public String deleorderid(HttpServletRequest request, HttpServletResponse response, @RequestParam("orderid") String orderid) {//删除订单
        JSONObject json=new JSONObject();
        log.info("取消订单"+orderid);
        serverOrder.deleteOrders(orderid);
        return "redirect:/pay1?id=13";
    }
    //删除绑定的用户
    @RequestMapping("/de2")
    @ResponseBody
    public JSONObject deleUser(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
        JSONObject json = new JSONObject();
        if(session.getAttribute("operid")!=null&&session.getAttribute("operid")!=""&&session.getAttribute("appid")!=null&&session.getAttribute("appid")!="") {//判断session是否为空
            String appid = session.getAttribute("appid").toString();
            String operid = session.getAttribute("operid").toString();
            User user = new User();
            user.setOperid(operid);
            user.setAppid(appid);
            int u = serverUser.deleteUser(serverUser.selectOperid(user));//删除第一个用户
            if (u > 0) {
                User user1=serverUser.selectOperid(user); //继续查询第一个用户
                if (user1!=null){
                    int i=serverUser.updateB(user1); //修改查询到得用户状态
                       if (i>0){
                           json.put("url",payfwConfig.getHdnotify());
                           json.put("appid",appid);
                           json.put("code","OK");
                       }
                }else{

                    json.put("url",payfwConfig.getHdnotify());
                    json.put("appid",appid);
                    json.put("code","NO");
                }
            }
        }
        return json;
    }
/*    //查询显示订单
    @RequestMapping("/xiao")
    public ModelAndView xiao(HttpServletRequest request, HttpServletResponse response) {
        JSONObject json=new JSONObject();
        ModelAndView modelAndView=new ModelAndView();
        List<orders>list =serverOrder.selectPay("oTsqN0XEkT4bA1RklyVmC2IDgbfA","");//可以了
        json.put("list",list);
        modelAndView.setViewName("order");
        modelAndView.addObject("params",json);
        return  modelAndView;
    }*/
    //挂失解挂
    @RequestMapping("/guashi")
    @ResponseBody
    public JSONObject guajie(HttpServletRequest request,HttpSession session, HttpServletResponse response,@RequestParam("code") String code) {
        JSONObject json=new JSONObject();
        if(session.getAttribute("operid")!=null&&session.getAttribute("operid")!=""&&session.getAttribute("appid")!=null&&session.getAttribute("appid")!="") {//判断session是否为空
            String operid = session.getAttribute("operid").toString();
            String appid = session.getAttribute("appid").toString();
            String clientid = session.getAttribute("clientid").toString();
            String key = session.getAttribute("key").toString();
            try {
                User usera = new User();
                usera.setOperid(operid);
                usera.setAppid(appid);
                User user = serverUser.selectOperid(usera);
                JSONObject o = serverUser.xinxiyz(clientid, user.getIccid(), key, user.getName(), code, appid, null,user.getPassword());
                if (o.get("ResultCode").equals("0000")) {
                    json.put("url", payfwConfig.getHdnotify());
                    json.put("code", "OK");
                    return json;
                }
            } catch (Exception e) {
                log.error("挂失解挂异常,异常原因 mas={}",e.getMessage(),e);
            }
        }
        json.put("url",payfwConfig.getHdnotify());
        json.put("code","NO");
        return json;
    }
    //继续圈存
    @RequestMapping("/qc")
    @ResponseBody
    public JSONObject qc(HttpServletRequest request, HttpServletResponse response,@RequestParam("orderid") String orderid) {
        JSONObject json=new JSONObject();
        json=serverOrder.daojufasong(orderid);
        json.put("url",payfwConfig.getHdnotify());
        log.info("圈存成功json----》"+json.toString());
       return  json;
    }

    @RequestMapping("/dingdan")  //订单记录
    @ResponseBody
    public JSONObject dingdan(HttpServletRequest request, HttpServletResponse response,HttpSession session,@RequestParam(value = "sj",required=true,defaultValue="NO") String sj) {
        JSONObject json=new JSONObject();
        User user=new User();
        orders orders=new orders();
        String operid = session.getAttribute("operid").toString();
        String appid = session.getAttribute("appid").toString();
        String clientid = session.getAttribute("clientid").toString();
        String key = session.getAttribute("key").toString();
        String  krq=sj+" 00:00:00";
        String  jrq=sj+" 23:59:59";
        User user2=new User();
        user2.setOperid(operid);
        user2.setAppid(appid);
        User user3=serverUser.selectOperid(user2);
        List<orders> list = serverOrder.selectPay(user3.getOperid(),user3.getAppid(),user3.getIccid(),krq,jrq);
        for (int i=0;i<list.size();i++) {
            if (list.get(i).getOrderid() != null) {
                try {
                    user.setOperid(operid);
                    user.setAppid(appid);
                    User user1=serverUser.selectOperid(user);
                    JSONObject o= serverUser.xinxiyz(clientid,user1.getIccid(),key,user1.getName(),"104",appid,list.get(i).getOrderid(),null);
                    list.get(i).setWxorderid(o.get("ResultCode").toString());
                    orders = list.get(i);
                    Date date=d.parse(orders.getPaytime());
                    orders.setPaytime(d.format(date));
                    list.set(i,orders);
                }catch (Exception e){
                    log.error("订单记录异常,异常原因 mas={}",e.getMessage(),e);
                }
            }
        }
        json.put("list", list);
        json.put("url",payfwConfig.getHdnotify());
        return  json;
    }

    @RequestMapping("/tishi")
    @ResponseBody
    public JSONObject tishi(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
        JSONObject json=new JSONObject();
        if(session.getAttribute("operid")!=null&&session.getAttribute("operid")!=""&&session.getAttribute("appid")!=null&&session.getAttribute("appid")!="") {//判断session是否为空
            String operid = session.getAttribute("operid").toString();
            String appid = session.getAttribute("appid").toString();
            String clientid = session.getAttribute("clientid").toString();
            String key = session.getAttribute("key").toString();
            User usera = new User();
                usera.setOperid(operid);
                usera.setAppid(appid);
                User user = serverUser.selectOperid(usera);
            if (user!=null){
                try {
                    json = serverUser.xinxiyz(clientid, user.getIccid(), key, user.getName(), "101", appid, null,user.getPassword());
                    if (json.getString("code")=="ON"){
                        json.put("url",payfwConfig.getHdnotify());
                        return json;
                    }
                    return json;
            } catch (Exception e) {
                    log.error("提示功能异常,异常原因 mas={}",e.getMessage(),e);
            }
           }else{
                json.put("code", "3333");
                json.put("url",payfwConfig.getHdnotify());
            }
        }
        json.put("url",payfwConfig.getHdnotify());
        return  json;
    }
    @RequestMapping("/zhifuZT")  //订单状态查询
    @ResponseBody
    public JSONObject zhifuZT(HttpServletRequest request, HttpServletResponse response,HttpSession session,@RequestParam(required=false) String orderid) {
        JSONObject json=new JSONObject();
        json.put("url",payfwConfig.getHdnotify());
        if (orderid!=null){
            orders orders=new orders();
            orders orders1=new orders();
            orders.setOrderid(orderid);
            orders1=serverOrder.selectOrders(orders);
            if (orders1.getStatus()==0){//为0 开始查
                WxPayOrderQueryResult reque = new WxPayOrderQueryResult();
                reque=serverOrder.dingdan(orders1);
                log.info("微信查询订单结果 mas="+reque.getTradeState());
                if (reque.getTradeState().equals("SUCCESS")){
                    BigDecimal bigDecima1 = orders1.getTotal_fee();
                    BigDecimal bigDecima3 = new BigDecimal("100");
                    BigDecimal result5 = bigDecima1.divide(bigDecima3,2,BigDecimal.ROUND_HALF_UP);
                    String code=serverOrder.updateOrders(orderid,"001",result5.toString());
                    log.info("支付成功，回调异常,手动修改订单 mas="+code);
                    json.put("code",code);
                }else {
                    json.put("code","ON");
                }
            }
        }
       return json;
    }
    @RequestMapping("/sx")  //订单状态查询
    @ResponseBody
    public JSONObject dingdanshixiao(HttpServletRequest request, HttpServletResponse response,HttpSession session,@RequestParam(required=false) String orderid) {
        JSONObject json=new JSONObject();
        json.put("url",payfwConfig.getHdnotify());
        orders orders=new orders();
        orders orders1=new orders();
        orders.setOrderid(orderid);
        json.put("orderid",orderid);
        orders1=serverOrder.selectOrders(orders);
        Date date = new Date();
        try {
            Date date1=d.parse(orders1.getPaytime());
            Date afterDate = new Date(date1 .getTime() + 300000);
           if (afterDate.after(date)==false){
               json.put("code",2);//订单未失效
           }else if (afterDate.after(date)==true){
               json.put("code",1);//订单失效
           }
        }catch (Exception e){
            e.printStackTrace();
        }
        return json;
    }
}
