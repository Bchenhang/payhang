package com.weixin.pay.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix = "pay")
@Data
public class PayYmlConfig {
    private String mchId;
    private String mchKey;
    private String KeyPath;
    private String notify;
}
