package com.weixin.pay.dao;
import com.weixin.pay.pojo.orders;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface OrdersDao {
     orders selectOrders(String id);        //查订单
     int addOrders(orders orders);          //增加订单
     int updateOrders (orders orders);     //修改订单
     List<orders> selectPay (orders orders);   //查询后三条订单
     int deleteOrders (String orderid); //删除订单
     int updatestate (orders orders);
     int updatemoney (orders orders);//金额验证失败修改金额

}
