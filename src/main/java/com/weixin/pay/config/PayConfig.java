package com.weixin.pay.config;

import com.github.binarywang.wxpay.config.WxPayConfig;
import com.github.binarywang.wxpay.service.WxPayService;
import com.github.binarywang.wxpay.service.impl.WxPayServiceImpl;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

/**
 * 支付配置类
 */
@Component
public class PayConfig {

    @Resource
    private PayYmlConfig payYmlConfig;
    @Resource
    private WechatYmlConfig wechatYmlConfig;

    @Bean
    public WxPayService pay() {
        WxPayConfig wxPayConfig = new WxPayConfig();
        wxPayConfig.setAppId(wechatYmlConfig.getMpAppId());
        wxPayConfig.setMchId(payYmlConfig.getMchId());
        wxPayConfig.setMchKey(payYmlConfig.getMchKey());
        wxPayConfig.setNotifyUrl(payYmlConfig.getNotify());
        wxPayConfig.setKeyPath(payYmlConfig.getKeyPath());
        WxPayService wxPayService = new WxPayServiceImpl();
        wxPayService.setConfig(wxPayConfig);
        return wxPayService;
    }
}

