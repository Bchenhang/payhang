package com.weixin.pay.pojo;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import java.math.BigDecimal;

@Entity
public class transaction {
    @Id
    @GeneratedValue
    private  int id;      //id
    private  String appid;       //版本号001
    private  String iccid;   //项目编号
    private  String type;
    private  String cardno;
    private  int clockno;
    private  String area;
    private  String attendtime;       //推送时间
    private  int flag;      //进出状态
    private  BigDecimal amount;
    private  BigDecimal balance;
    private  String remark;     //描述
    private  String uploadtime;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAppid() {
        return appid;
    }

    public void setAppid(String appid) {
        this.appid = appid;
    }

    public String getIccid() {
        return iccid;
    }

    public void setIccid(String iccid) {
        this.iccid = iccid;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getCardno() {
        return cardno;
    }

    public void setCardno(String cardno) {
        this.cardno = cardno;
    }

    public int getClockno() {
        return clockno;
    }

    public void setClockno(int clockno) {
        this.clockno = clockno;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getAttendtime() {
        return attendtime;
    }

    public void setAttendtime(String attendtime) {
        this.attendtime = attendtime;
    }

    public int getFlag() {
        return flag;
    }

    public void setFlag(int flag) {
        this.flag = flag;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public BigDecimal getBalance() {
        return balance;
    }

    public void setBalance(BigDecimal balance) {
        this.balance = balance;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getUploadtime() {
        return uploadtime;
    }

    public void setUploadtime(String uploadtime) {
        this.uploadtime = uploadtime;
    }
}
