package com.weixin.pay.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * 获取yml的微信配置信息
 */
@Component
@Data
@ConfigurationProperties(prefix = "wechat")
public class WechatYmlConfig {
    private  String mpAppId;
    private  String mpAppSecret;
}
