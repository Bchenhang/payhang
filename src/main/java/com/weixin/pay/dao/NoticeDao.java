package com.weixin.pay.dao;
import com.weixin.pay.pojo.notice;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
@Mapper
public interface NoticeDao {
        List<notice> selectNotice (notice notice); //查询消息
        int addNotice(notice notice);    //新增消息
}
