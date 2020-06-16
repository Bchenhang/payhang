package com.weixin.pay.pojo;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import java.math.BigDecimal;

@Entity
public class orders {
    @Id
    @GeneratedValue
    private  String orderid;      //系统订单
    private  String operid;       //用户唯一标识
    private  String iccid;
    private  String trade_type;   //金额类型
    private  BigDecimal total_fee;    //金额
    private  String boty;         //商品，描述
    private  String paytime;       //下单时间
    private  Integer status;      //支付状态
    private  Integer state;       //商品到账状态
    private  String wxorderid;     //微信订单号
    private  String payotime;      //付款时间
    private  String appid;     //用户标识
    private  int code;     //用户标识删除订单1正常0删除

    public String getOrderid() {
        return orderid;
    }

    public void setOrderid(String orderid) {
        this.orderid = orderid;
    }

    public String getOperid() {
        return operid;
    }

    public void setOperid(String operid) {
        this.operid = operid;
    }

    public String getIccid() {
        return iccid;
    }

    public void setIccid(String iccid) {
        this.iccid = iccid;
    }

    public String getTrade_type() {
        return trade_type;
    }

    public void setTrade_type(String trade_type) {
        this.trade_type = trade_type;
    }

    public BigDecimal getTotal_fee() {
        return total_fee;
    }

    public void setTotal_fee(BigDecimal total_fee) {
        this.total_fee = total_fee;
    }

    public String getBoty() {
        return boty;
    }

    public void setBoty(String boty) {
        this.boty = boty;
    }

    public String getPaytime() {
        return paytime;
    }

    public void setPaytime(String paytime) {
        this.paytime = paytime;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public String getWxorderid() {
        return wxorderid;
    }

    public void setWxorderid(String wxorderid) {
        this.wxorderid = wxorderid;
    }

    public String getPayotime() {
        return payotime;
    }

    public void setPayotime(String payotime) {
        this.payotime = payotime;
    }

    public String getAppid() {
        return appid;
    }

    public void setAppid(String appid) {
        this.appid = appid;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }
}
