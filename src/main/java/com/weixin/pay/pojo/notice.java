package com.weixin.pay.pojo;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class notice {
    @Id
    @GeneratedValue
    private  int id;
    private  String appid;
    private  String iccid;
    private  String title;      //标题
    private  String content;    //内容
    private  String remark;     //落款
    private  String notifytime; //时间
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
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }
    public String getRemark() {
        return remark;
    }
    public void setRemark(String remark) {
        this.remark = remark;
    }
    public String getNotifytime() {
        return notifytime;
    }
    public void setNotifytime(String notifytime) {
        this.notifytime = notifytime;
    }
}
