package com.weixin.pay.server;

import com.weixin.pay.pojo.picspace;
import org.springframework.stereotype.Repository;

@Repository
public interface serverPicspace {

    picspace selectPicspase(String bucket);//查询图片服务器参数
    String getUpToken(String ak,String sk,String bucketname);  //获取图片服务器的token
    String put64image(String file641,String ak,String sk,String bucketname,String key) throws Exception ;//上转图片到服务器
    String deleteimage(String ak,String sk,String bucketname,String key);//删除照片
}
