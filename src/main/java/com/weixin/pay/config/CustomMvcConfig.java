package com.weixin.pay.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * <p>
 *  前端页面跳转控制器
 * </p>
 *
 */
@Configuration
public class CustomMvcConfig implements WebMvcConfigurer {

    @Autowired
    private CommonIntercepter commonIntercepter;
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(commonIntercepter).addPathPatterns("/admin/**");
    }
    @Override
    public void addViewControllers(ViewControllerRegistry registry) {

        //访问登入页
        registry.addViewController("/shenke").setViewName("/shenke");
        registry.addViewController("/shenkel").setViewName("/shenkel");
        registry.addViewController("/shenkejd").setViewName("/shenkejd");
    }

}

