package com.weixin.pay.pojo;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import java.math.BigDecimal;

@Entity
public class mpconfig {
    @Id
    @GeneratedValue
    private  String appid;
    private  String appname;
    private  String secret;
    private  String mchid;
    private  String mchkey;     //微信key
    private  String mackey;    //平台加密钥
    private  String tempid1;  //考勤
    private  String tempid2;   //门禁
    private  String tempid3;  //消费
    private  String tempid4;  //充值
    private  String tempid5;  //消息上转
    private  String tempid6;
    private  String tempid7;
    private  String tempid8;
    private  String tempid9;
    private  String tempid10;
    private  String param;
    private  String token;
    private  String tokentime;

    public String getAppid() {
        return appid;
    }

    public void setAppid(String appid) {
        this.appid = appid;
    }

    public String getAppname() {
        return appname;
    }

    public void setAppname(String appname) {
        this.appname = appname;
    }

    public String getSecret() {
        return secret;
    }

    public void setSecret(String secret) {
        this.secret = secret;
    }

    public String getMchid() {
        return mchid;
    }

    public void setMchid(String mchid) {
        this.mchid = mchid;
    }

    public String getMchkey() {
        return mchkey;
    }

    public void setMchkey(String mchkey) {
        this.mchkey = mchkey;
    }

    public String getMackey() {
        return mackey;
    }

    public void setMackey(String mackey) {
        this.mackey = mackey;
    }

    public String getTempid1() {
        return tempid1;
    }

    public void setTempid1(String tempid1) {
        this.tempid1 = tempid1;
    }

    public String getTempid2() {
        return tempid2;
    }

    public void setTempid2(String tempid2) {
        this.tempid2 = tempid2;
    }

    public String getTempid3() {
        return tempid3;
    }

    public void setTempid3(String tempid3) {
        this.tempid3 = tempid3;
    }

    public String getTempid4() {
        return tempid4;
    }

    public void setTempid4(String tempid4) {
        this.tempid4 = tempid4;
    }

    public String getTempid5() {
        return tempid5;
    }

    public void setTempid5(String tempid5) {
        this.tempid5 = tempid5;
    }

    public String getTempid6() {
        return tempid6;
    }

    public void setTempid6(String tempid6) {
        this.tempid6 = tempid6;
    }

    public String getTempid7() {
        return tempid7;
    }

    public void setTempid7(String tempid7) {
        this.tempid7 = tempid7;
    }

    public String getTempid8() {
        return tempid8;
    }

    public void setTempid8(String tempid8) {
        this.tempid8 = tempid8;
    }

    public String getTempid9() {
        return tempid9;
    }

    public void setTempid9(String tempid9) {
        this.tempid9 = tempid9;
    }

    public String getTempid10() {
        return tempid10;
    }

    public void setTempid10(String tempid10) {
        this.tempid10 = tempid10;
    }

    public String getParam() {
        return param;
    }

    public void setParam(String param) {
        this.param = param;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getTokentime() {
        return tokentime;
    }

    public void setTokentime(String tokentime) {
        this.tokentime = tokentime;
    }
}
