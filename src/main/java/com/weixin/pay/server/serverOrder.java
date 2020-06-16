package com.weixin.pay.server;
import com.alibaba.fastjson.JSONObject;
import com.github.binarywang.wxpay.bean.order.WxPayMpOrderResult;
import com.github.binarywang.wxpay.bean.result.WxPayOrderQueryResult;
import com.weixin.pay.pojo.TemplateData;
import com.weixin.pay.pojo.WxTemplate;
import com.weixin.pay.pojo.orders;
import me.chanjar.weixin.common.bean.WxAccessToken;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Repository
public interface serverOrder {
    //查
    public orders selectOrders(orders orders); //查订单

    public WxPayMpOrderResult pay(String oderid); //查配置

    public String updateOrders(String orderid, String tradeNo, String totalFee);//修改订单 发送道具

    public WxAccessToken getAccessToken(String appId, String appSecret);//获取toke

    public JSONObject getAccessMoban(String moban, String tokey);         //获取模板id

    public WxTemplate buildTempMessage1(Map<String, String> map);//放入opid

    public Map<String, TemplateData> buildTempMessage2(Map<String, String> map);//模板信息

    public int sendMessage(WxTemplate t, String accessToken);//发送模板信息

    public String addOrders(String operid, String price,String appid,String clientid,String iccid);//添加订单

    public List<orders> selectPay (String operid,String appid,String iccid,String krq,String jrq);//查询订单

    public  int deleteOrders (String orderid); //删除订单

    public Date getDateBefore(int day);//拿几天前的日期

    public JSONObject daojufasong(String orderid);//发送道具

    public WxPayOrderQueryResult dingdan(orders orders);//查询微信订单

    public  String getOrderIdByTime();//生产订单号 访客单号






}