package com.weixin.pay.server.ServerImpl;

import com.alibaba.fastjson.JSONObject;
import com.weixin.pay.dao.SheetDao;
import com.weixin.pay.pojo.sheet;
import com.weixin.pay.server.serverSheet;
import lombok.extern.slf4j.Slf4j;
import lombok.val;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Slf4j
@Service
public class serverSheetImpl implements  serverSheet {
    @Resource
    private SheetDao sheetDao;
    private SimpleDateFormat d = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
    private SimpleDateFormat s = new SimpleDateFormat("yyyyMMddHHmmss");//设置日期格式
    public List<sheet> selectSheet(String iccid, String appid, String attendtime, String attendtimes){              //查考情记录

        return  sheetDao.selectSheet(iccid,appid,attendtime,attendtimes);

    }
    public  sheet selectpaicong(JSONObject orders){        //排重

          sheet sheet=new sheet();
          try {
              sheet.setAppid(orders.getString("CustomerID"));
              sheet.setIccid(orders.getString("ICCID"));
              sheet.setAttendtime(d.format(s.parse(orders.get("AttendTime").toString())));
          }catch (Exception e){
              log.error("考勤排重异常,异常原因 mas={}",e.getMessage(),e);
          }
        return  sheetDao.selectpaicong(sheet);
    }
        public int addSheet(JSONObject object){    //新增考情记录
            sheet sheet=new sheet();
            try {
                sheet.setAppid(object.getString("CustomerID"));
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
                if (object.getString("UrlImage")!=null  && object.getString("UrlImage")!=""){
                    sheet.setUrlimage(object.getString("UrlImage"));
                } if (object.getString("Remark")!=null  && object.getString("Remark")!=""){
                    sheet.setRemark(object.getString("Remark"));
                }
                sheet.setUploadtime(d.format(new Date()));
            }catch (Exception e){
                log.error("考勤新增异常,异常原因 mas={}",e.getMessage(),e);
            }
        return  sheetDao.addSheet(sheet);
    }
}
