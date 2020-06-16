package com.weixin.pay.Controller;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.github.binarywang.wxpay.bean.notify.WxPayNotifyResponse;
import com.github.binarywang.wxpay.bean.notify.WxPayOrderNotifyResult;
import com.github.binarywang.wxpay.bean.order.WxPayMpOrderResult;
import com.github.binarywang.wxpay.bean.result.BaseWxPayResult;
import com.github.binarywang.wxpay.config.WxPayConfig;
import com.github.binarywang.wxpay.service.WxPayService;
import com.weixin.pay.config.PayfwConfig;
import com.weixin.pay.pojo.User;
import com.weixin.pay.server.serverPicspace;
import com.weixin.pay.server.serverOrder;
import com.weixin.pay.pojo.mpconfig;
import com.weixin.pay.server.serverMpconfig;
import com.weixin.pay.dao.OrdersDao;
import com.weixin.pay.pojo.orders;
import com.weixin.pay.pojo.picspace;
import com.weixin.pay.server.serverUser;
import lombok.extern.slf4j.Slf4j;
import me.chanjar.weixin.common.api.WxConsts;
import me.chanjar.weixin.mp.api.WxMpInMemoryConfigStorage;
import me.chanjar.weixin.mp.api.WxMpService;
import me.chanjar.weixin.mp.bean.result.WxMpOAuth2AccessToken;
import me.chanjar.weixin.mp.bean.result.WxMpUser;
import org.apache.commons.io.IOUtils;
import org.springframework.boot.web.embedded.undertow.UndertowWebServer;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * Project Name: com.weixin.pay.controller
 * File Name: IndexController
 * Date: 2018-11-30 21:49
 * Copyright (c) 2018, 3141621744@qq.com All Rights Reserved.
 *
 * @author Tobin
 */
@Slf4j
@Controller
@RequestMapping("/wechat")
public class IndexController {
    @Resource
    private serverUser serverUser;
    @Resource
    private OrdersDao ordersDao;
    @Resource
    private WxMpService wxMpService;
    @Resource
    private WxPayService wxPayService;
    @Resource
    private serverOrder selectOrders;
    @Resource
    private serverMpconfig serverMpconfig;
    @Resource
    private PayfwConfig payfwConfig;
    @Resource
    private serverPicspace serverPicspace;
    //结果通知
    @ResponseBody
    @RequestMapping(value = "/order")
    public String parseOrderNotifyResult(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception {
        try {
            String xmlResult = IOUtils.toString(request.getInputStream(), request.getCharacterEncoding());
            log.info("回调数据xmlResult---》"+xmlResult);
            WxPayOrderNotifyResult result = wxPayService.parseOrderNotifyResult(xmlResult);
            // 结果正确
            String orderId = result.getOutTradeNo();//自己的订单
            String tradeNo = result.getTransactionId();//微信订单
            String totalFee = BaseWxPayResult.fenToYuan(result.getTotalFee());//金额
            //自己处理订单的业务逻辑，需要判断订单是否已经支付过，否则可能会重复调用
            log.info("微信回调结果orderId---》"+orderId);
            log.info("微信回调结果tradeNo---》"+tradeNo);
            log.info("微信回调结果totalFee---》"+totalFee);
            String code=selectOrders.updateOrders(orderId,tradeNo,totalFee);
            if (code.equals("OK")){
                log.info("微信充值到账流程完成---》"+code);
                return WxPayNotifyResponse.success("OK!");
            }
        } catch (Exception e) {
            log.error("微信回调结果异常,异常原因{}",e.getMessage(),e);
            return WxPayNotifyResponse.fail(e.getMessage());
        }
        return WxPayNotifyResponse.success("OK!");
    }
    //获取code
    @GetMapping("/authorize")
    public String authorize(HttpServletResponse req, HttpServletRequest request, HttpSession session, @RequestParam("id") String id,@RequestParam("appid") String appid) {
                 mpconfig mpconfig=serverMpconfig.selectconfig(appid);
                 String redirect = "";
                try {
                //mp
                WxMpInMemoryConfigStorage wxMpInMemoryConfigStorage = new WxMpInMemoryConfigStorage();
                wxMpInMemoryConfigStorage.setAppId(mpconfig.getAppid());
                wxMpInMemoryConfigStorage.setSecret(mpconfig.getSecret());
                wxMpService.setWxMpConfigStorage(wxMpInMemoryConfigStorage);
                //pay
                    WxPayConfig wxPayConfig = new WxPayConfig();
                    wxPayConfig.setAppId(mpconfig.getAppid());
                    wxPayConfig.setMchId(mpconfig.getMchid());
                    wxPayConfig.setMchKey(mpconfig.getMchkey());
                    wxPayConfig.setNotifyUrl(payfwConfig.getNotify());
                    wxPayService.setConfig(wxPayConfig);
                /*session.setAttribte*/
                session.setAttribute("appid", mpconfig.getAppid());
                session.setAttribute("key", mpconfig.getMackey());
                session.setAttribute("clientid", payfwConfig.getClientid());
                JSONObject jsonObject=JSON.parseObject(mpconfig.getParam());
                if (jsonObject.get("picspace")!=null){
                picspace picspace= serverPicspace.selectPicspase(jsonObject.get("picspace").toString());//图片参数
                    session.setAttribute("ak", picspace.getAccesskey());
                    session.setAttribute("sk", picspace.getSecretkey());
                    session.setAttribute("bucket", picspace.getBucket());
                    session.setAttribute("url", picspace.getUrl());
                }

                if (jsonObject.get("isshool")==null){
                    jsonObject.put("isshool","2");
                }
                session.setAttribute("isshool",jsonObject.get("isshool"));
                // 设置回调地址
                String url = payfwConfig.getHdnotify() + "/wechat/userInfo?id=" + id;
                // 发起微信认证地址
                 redirect = wxMpService.oauth2buildAuthorizationUrl(url, WxConsts.OAuth2Scope.SNSAPI_USERINFO, null);
                } catch (Exception e) {
                    log.error("获取code异常,异常原因 mas={}",e.getMessage(),e);
                }
                return "redirect:" + redirect;
    }
     //获取opid
    /**
     * 回调地址
     *
     * @param code
     * @param
     * @return
     */
    @RequestMapping("/userInfo")
    public String userInfo(
            @RequestParam("code") String code, HttpServletResponse response, HttpServletRequest request, HttpSession session,@RequestParam("id") String id) {
        WxMpOAuth2AccessToken wxMpOAuth2AccessToken =  new WxMpOAuth2AccessToken();
        WxMpUser wxMpUser = new WxMpUser();
        try {
            wxMpOAuth2AccessToken = wxMpService.oauth2getAccessToken(code);
            wxMpUser = wxMpService.oauth2getUserInfo(wxMpOAuth2AccessToken, "zh_CN");
        } catch (Exception e) {
            log.error("获取opid异常,异常原因 mas={}",e.getMessage(),e);
        }
        session.setAttribute("operid",wxMpUser.getOpenId());//存session值
        return  "redirect:/wechat/in?id="+id;
    }
    //登入 ，绑定，个人中心/我的云卡
    @RequestMapping(value = "/in")
    public String index(HttpServletResponse response, HttpServletRequest request, HttpSession session,@RequestParam("id") String id) {
        if(session.getAttribute("operid")!=null&&session.getAttribute("operid")!=""&&session.getAttribute("appid")!=null&&session.getAttribute("appid")!=""){//判断session是否为空
        String operid=session.getAttribute("operid").toString();
        String appid=session.getAttribute("appid").toString();
        String clientid=session.getAttribute("clientid").toString();
        String key=session.getAttribute("key").toString();
        String isshool=session.getAttribute("isshool").toString();
        JSONObject o=null;
        User user=new User();
        user.setOperid(operid);
        user.setAppid(appid);
        user.setStatus(3);
        User user3=serverUser.selectfangke(user);
        if (user3==null) {
        User user1=serverUser.selectOperid(user);
        if (user1!=null){
        try {
          o=serverUser.xinxiyz(clientid,user1.getIccid(),key,user1.getName(),"101",appid,null,user1.getPassword());
        }catch (Exception e){
            log.error("登入验证异常,异常原因 mas={}",e.getMessage(),e);
        }
        if (o.getString("code")!="ON"){
        if (o.getString("ResultCode").equals("0000") || o.getString("ResultCode").equals("0201")){
            //修改等级
             user.setIccid(user1.getIccid());
             user.setKind(0);
             serverUser.updateKind(user);
        if (user1!=null&&id.equals("1")){
            return "redirect:/pay1?id=12";
        }else if(user1!=null&&id.equals("2")){
            return "redirect:/pay1?id=17";
        }else if(user1!=null&&id.equals("3")){
            return "redirect:/pay1?id=14";
        }else if (user1==null){
            return "redirect:/wechat/login1?isshool="+isshool;
        }
        }
            return "redirect:/wechat/login1?isshool="+isshool;
        }
            return "redirect:/wechat/login1?isshool="+isshool;
        }
            return "redirect:/wechat/login1?isshool="+isshool;
        }
            return "redirect:/SQ";
        }
        return "redirect:/wechat/authorize?id=1";

    }
    //登入判断用户是学校还是公司
    @RequestMapping(value = "/login1")
    public ModelAndView login1(HttpServletResponse response, HttpServletRequest request, HttpSession session,@RequestParam("isshool") String isshool) {
        String name="";
       if (isshool.equals("1")){
           name="请输入学工号";
       }else{
           name="请输入工号";
       }
        ModelAndView modelAndView =new ModelAndView("login");
        modelAndView.addObject("params",name);

        return modelAndView;
    }
    //下单接口
    @RequestMapping(value = "/create")
    @ResponseBody
    public JSONObject createOrder(
         HttpServletRequest request, HttpServletResponse response,HttpSession session,@RequestParam("price") String price) {
        JSONObject json = new JSONObject();
        if(session.getAttribute("operid")!=null&&session.getAttribute("operid")!=""&&session.getAttribute("appid")!=null&&session.getAttribute("appid")!="") {
            try {
            String operid = session.getAttribute("operid").toString();
            String appid = session.getAttribute("appid").toString();
            User user = new User();
            user.setOperid(operid);
            user.setAppid(appid);
            user.setIccid(appid);

            User user1 = serverUser.selectOperid(user);
            //下单
            json.put("orderid", selectOrders.addOrders(operid, price.trim(), appid, payfwConfig.getClientid(), user1.getIccid()));
            json.put("url", payfwConfig.getHdnotify());
            }catch (Exception e){
              log.error("下单异常,异常原因 mas={}",e.getMessage(),e);
            }
        }
        log.info("下单数据-->"+json.toString());
        return json;
    }
    //H5唤起支付
    @RequestMapping(value = "/pay")
    @ResponseBody
    public ModelAndView pay(
        HttpServletRequest request, HttpServletResponse response,@RequestParam("orderid") String orderid){
        orders orders=new orders();
        orders.setOrderid(orderid);
        orders orders1=selectOrders.selectOrders(orders);
        if (orders1==null){
            ModelAndView modelAndView =new ModelAndView("order2");
            return  modelAndView;
        }
        if (orders1.getStatus()==0){
        JSONObject json=new JSONObject();
        //下单
        WxPayMpOrderResult wxPayMpOrderResult = selectOrders.pay(orderid);
        json.put("appId",wxPayMpOrderResult.getAppId());
        json.put("timeStamp",wxPayMpOrderResult.getTimeStamp());
        json.put("nonceStr",wxPayMpOrderResult.getNonceStr());
        json.put("packageValue",wxPayMpOrderResult.getPackageValue());
        json.put("signType",wxPayMpOrderResult.getSignType());
        json.put("paySign",wxPayMpOrderResult.getPaySign());
        json.put("url",payfwConfig.getHdnotify());
        json.put("orderid",orderid);
            String timeStamp = String.valueOf((System.currentTimeMillis() / 1000));
            log.info("下单数据----------------->"+json.toString()+"====+"+timeStamp);
        //唤起支付
        ModelAndView modelAndView =new ModelAndView("payH5");
        modelAndView.addObject("params",json);
        return modelAndView;
        }else if (orders1.getStatus()==1){
            ModelAndView modelAndView =new ModelAndView("order2");
        return modelAndView;
        }
        return null;
    }
    //主页面控制
    @RequestMapping(value = "/kongzhi")
    @ResponseBody
    public JSONObject kongzhi(HttpServletRequest request, HttpServletResponse response,HttpSession session){
        JSONObject json = new JSONObject();
        if(session.getAttribute("operid")!=null&&session.getAttribute("operid")!=""&&session.getAttribute("appid")!=null&&session.getAttribute("appid")!="") {
                String appid = session.getAttribute("appid").toString();
                String operid = session.getAttribute("operid").toString();
                mpconfig mpconfig = serverMpconfig.selectconfig(appid);
                 User user=new User();
                   user.setOperid(operid);
                   user.setAppid(appid);
                User user1= serverUser.selectOperid(user);
                json=JSONObject.parseObject(mpconfig.getParam());
                json.put("kind",user1.getKind());
            }
            System.out.println(json);
            return json;
    }
}
