package com.weixin.pay.server.ServerImpl;
import com.alibaba.fastjson.JSONObject;
import com.weixin.pay.pojo.control;
import com.weixin.pay.server.serverControl;
import com.weixin.pay.dao.ControlDao;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Slf4j
@Service
public class serverControlImpl implements  serverControl  {
    @Resource
    private ControlDao controlDao;
    private SimpleDateFormat d = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
    private SimpleDateFormat s = new SimpleDateFormat("yyyyMMddHHmmss");//设置日期格式
    public List<control> selectControl(String iccid, String appid, String attendtime, String attendtimes){
        return controlDao.selectControl(iccid,appid,attendtime,attendtimes);
    }       //查门禁记录
    public control selectCpaicong(JSONObject orders){//排重
        control control=new control();
        try {
            control.setAppid(orders.getString("CustomerID"));
            control.setIccid(orders.getString("ICCID"));
            control.setAttendtime(d.format(s.parse(orders.get("AttendTime").toString())));
            control.setFlag(orders.getIntValue("Flag"));
        }catch (Exception e){
            log.error("门禁排重异常,异常原因 mas={}",e.getMessage(),e);
        }

        return  controlDao.selectCpaicong(control);
    }
    public  int addControl(JSONObject object){
        control control=new control();
        control.setAppid(object.getString("CustomerID"));
        control.setIccid(object.getString("ICCID"));
        try {
        if (object.getString("Type")!=null && object.getString("Type")!=""){
            control.setType(object.getString("Type"));
        }
        if (object.getString("CardNo")!=null && object.getString("CardNo")!=""){
            control.setCardno(object.getString("CardNo"));
        }
        control.setClockno(object.getIntValue("ClockNo"));
        if (object.getString("Area")!=null && object.getString("Area")!=""){
            control.setArea(object.getString("Area"));
        }
        control.setAttendtime(d.format(s.parse(object.get("AttendTime").toString())));
        control.setFlag(object.getIntValue("Flag"));
        if (object.getString("UrlImage")!=null && object.getString("UrlImage")!=""){
            control.setUrlimage(object.getString("UrlImage"));
        } if (object.getString("Remark")!=null && object.getString("Remark")!=""){
            control.setRemark(object.getString("Remark"));
        }
           control.setUploadtime(d.format(new Date()));
        }catch (Exception e){
            log.error("新增门禁异常,异常原因 mas={}",e.getMessage(),e);
        }

        return  controlDao.addControl(control);
    }          //增加门禁记录
}
