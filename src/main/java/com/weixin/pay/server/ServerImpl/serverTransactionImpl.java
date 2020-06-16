package com.weixin.pay.server.ServerImpl;
import com.alibaba.fastjson.JSONObject;
import com.weixin.pay.dao.TransactionDao;
import com.weixin.pay.pojo.transaction;
import com.weixin.pay.server.serverTransaction;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Slf4j
@Service
public class serverTransactionImpl implements serverTransaction {
    @Resource
    private TransactionDao transactionDao;
    private SimpleDateFormat d = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
    private SimpleDateFormat s = new SimpleDateFormat("yyyyMMddHHmmss");//设置日期格式
    public List<transaction> selectTransaction(String  iccid, String appid, String attendtime, String attendtimes){    //查交易记录记录

        return  transactionDao.selectTransaction(iccid,appid,attendtime,attendtimes);
    }
    public   transaction Tpaicong(JSONObject orders){
            transaction sheet=new transaction();
            sheet.setAppid(orders.getString("CustomerID"));
            sheet.setFlag(orders.getIntValue("Flag"));
            sheet.setIccid(orders.getString("ICCID"));
        try {
            sheet.setAttendtime(d.format(s.parse(orders.get("AttendTime").toString())));
        }catch (Exception e){
            log.error("交易排重异常,异常原因 mas={}",e.getMessage(),e);
        }
        return  transactionDao.Tpaicong(sheet);
    }
    public int addTransaction(JSONObject object){        //增加交易记录
        System.out.println("新增成功得数据-----》"+object.toString());
        transaction sheet=new transaction();
        sheet.setAppid(object.getString("CustomerID"));
        try {
        sheet.setIccid(object.getString("ICCID"));
        if (object.getString("Type")!=null && object.getString("Type")!=""){
            sheet.setType(object.getString("Type"));
        }
        if (object.getString("CardNo")!=null && object.getString("CardNo")!=""){
            sheet.setCardno(object.getString("CardNo"));
        }
        sheet.setClockno(object.getIntValue("ClockNo"));
        if (object.getString("Area")!=null  && object.getString("Area")!=""){
            sheet.setArea(object.getString("Area"));
        }
        sheet.setAttendtime(d.format(s.parse(object.get("AttendTime").toString())));
        sheet.setFlag(object.getIntValue("Flag"));
        if (object.getString("Amount")!=null && object.getString("Amount")!=""){
            sheet.setAmount(new BigDecimal(object.getIntValue("Amount")).divide(new BigDecimal(100),2,RoundingMode.HALF_UP));
        }
        if (object.getString("Balance")!=null && object.getString("Balance")!=""){
            sheet.setBalance(new BigDecimal(object.getIntValue("Balance")).divide(new BigDecimal(100),2,RoundingMode.HALF_UP));
        }
       if (object.getString("Remark")!=null && object.getString("Remark")!=""){
            sheet.setRemark(object.getString("Remark"));
        }
            sheet.setUploadtime(d.format(new Date()));
        }catch (Exception e){
            log.error("交易新增异常,异常原因 mas={}",e.getMessage(),e);
        }

        return  transactionDao.addTransaction(sheet);
    }
}
