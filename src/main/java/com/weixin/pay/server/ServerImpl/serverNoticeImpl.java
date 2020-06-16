package com.weixin.pay.server.ServerImpl;

import com.weixin.pay.dao.OrdersDao;
import com.weixin.pay.pojo.notice;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import com.weixin.pay.dao.NoticeDao;
import  com.weixin.pay.server.serverNotice;
import javax.annotation.Resource;
import java.util.List;
@Slf4j
@Service
public class serverNoticeImpl implements serverNotice{
    @Resource
    private NoticeDao noticeDao;
   public List<notice> selectNotice (String appid,String iccid,String notifytime){ //查询消息
       notice notice1=new notice();
       notice1.setAppid(appid);
       notice1.setIccid(iccid);
       notice1.setNotifytime(notifytime);
       return noticeDao.selectNotice(notice1);
   }
   public int addNotice(notice notice){ //新增消息
       return noticeDao.addNotice(notice);
   }
}
