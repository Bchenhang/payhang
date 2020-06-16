package com.weixin.pay.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;
@Component
@ConfigurationProperties(prefix = "fw")
@Data
public class PayfwConfig {
    private String fwnotify;
    private String hdnotify;
    private String notify; //回调地址
    private String clientid;
    private String appid;
    private String mpAppSecret;
    private String mbKqid; //考情
    private String mbMjid; //门禁
    private String mbXfid; //消费
    private String mbCzid; //充值
    private String mbTzid; //信息
    private String mbShyy; //请假预约审核
    private String mbShgx; //请假审核更新
    private String ip; //充值服务器地址
}
