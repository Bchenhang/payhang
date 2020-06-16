package com.weixin.pay.server;

import com.weixin.pay.pojo.notice;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface serverNotice {
    List<notice> selectNotice (String appid ,String iccid ,String notifytime); //查询消息
    int addNotice(notice notice);    //新增消息
}
