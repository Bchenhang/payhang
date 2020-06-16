package com.weixin.pay.dao;


import com.weixin.pay.pojo.picspace;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface PicspaceDao {
    picspace selectPicspase(@Param(value="bucket") String  bucket);//查询图片服务器参数
}
