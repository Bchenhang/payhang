package com.weixin.pay.server.ServerImpl;
import com.alibaba.fastjson.JSONObject;
import com.weixin.pay.config.PayfwConfig;
import com.weixin.pay.pojo.mpconfig;
import com.weixin.pay.dao.MpconfigDao;
import  com.weixin.pay.server.serverMpconfig;
import com.weixin.pay.server.serverOrder;
import lombok.extern.slf4j.Slf4j;
import me.chanjar.weixin.common.bean.WxAccessToken;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

@Slf4j
@Service
public class serverMpconfigImpl implements serverMpconfig {

    @Resource
    private  MpconfigDao mpconfigDao;
    @Resource
    private serverOrder selectOrders;
    @Resource
    private PayfwConfig payfwConfig;
    private SimpleDateFormat d = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
    private SimpleDateFormat s = new SimpleDateFormat("yyyyMMddHHmmss");//设置日期格式
    public mpconfig selectconfig(String appid){//查配置信息
        return mpconfigDao.selectconfig(appid);
    }        //查配置
    //获取模板id
    public String mbid (String id,mpconfig mpconfig,String token){
        String mbid="";
        try {
        mpconfig mpconfig1=new mpconfig();
        mpconfig1.setAppid(mpconfig.getAppid());
        JSONObject mb=null;
        if (id.equals("1")){
          if (mpconfig.getTempid1()==null || mpconfig.getTempid1().equals("")){
              mb=selectOrders.getAccessMoban(payfwConfig.getMbKqid(),token);
              mpconfig1.setTempid1(mb.getString("template_id"));
              int o=mpconfigDao.updatMpconfig1(mpconfig1);
              mbid=mb.getString("template_id");
          }else{

              mbid= mpconfig.getTempid1();
            }
        }else if(id.equals("2")){
            if (mpconfig.getTempid2()==null || mpconfig.getTempid2().equals("")){
                mb=selectOrders.getAccessMoban(payfwConfig.getMbMjid(),token);
                mpconfig1.setTempid2(mb.getString("template_id"));
                int o=mpconfigDao.updatMpconfig2(mpconfig1);
                mbid=mb.getString("template_id");
            }else{
                mbid= mpconfig.getTempid2();
            }
        }else if(id.equals("3")){
            if (mpconfig.getTempid3()==null || mpconfig.getTempid3().equals("")){
                mb=selectOrders.getAccessMoban(payfwConfig.getMbXfid(),token);
                mpconfig1.setTempid3(mb.getString("template_id"));
                int o=mpconfigDao.updatMpconfig3(mpconfig1);
                mbid=mb.getString("template_id");
                System.out.println("1"+mbid);
            }else{

                mbid= mpconfig.getTempid3();
                System.out.println("2"+mbid);
            }
        }else if(id.equals("4")){
            if (mpconfig.getTempid4()==null || mpconfig.getTempid4().equals("")){
                mb=selectOrders.getAccessMoban(payfwConfig.getMbCzid(),token);
                mpconfig1.setTempid4(mb.getString("template_id"));
                int o=mpconfigDao.updatMpconfig4(mpconfig1);
                mbid=mb.getString("template_id");
            }else{
                mbid= mpconfig.getTempid4();
            }
        }else  if(id.equals("5")){
            if (mpconfig.getTempid5()==null || mpconfig.getTempid5().equals("")){
                mb=selectOrders.getAccessMoban(payfwConfig.getMbTzid(),token);
                mpconfig1.setTempid5(mb.getString("template_id"));
                int o=mpconfigDao.updatMpconfig5(mpconfig1);
                mbid=mb.getString("template_id");
            }else{
                mbid= mpconfig.getTempid5();
            }
        }else  if(id.equals("6")){
            if (mpconfig.getTempid6()==null || mpconfig.getTempid6().equals("")){
                mb=selectOrders.getAccessMoban(payfwConfig.getMbShyy(),token);
                mpconfig1.setTempid6(mb.getString("template_id"));
                int o=mpconfigDao.updatMpconfig6(mpconfig1);
                mbid=mb.getString("template_id");
            }else{
                mbid= mpconfig.getTempid5();
            }
        }else  if(id.equals("7")){
            if (mpconfig.getTempid7()==null || mpconfig.getTempid7().equals("")){
                mb=selectOrders.getAccessMoban(payfwConfig.getMbShgx(),token);
                mpconfig1.setTempid7(mb.getString("template_id"));
                int o=mpconfigDao.updatMpconfig7(mpconfig1);
                mbid=mb.getString("template_id");
            }else{
                mbid= mpconfig.getTempid5();
            }
        }
        }catch (Exception e){
         log.error("获取模板id异常,异常原因 mas={}",e.getMessage(),e);
        }
       return mbid;
   }
    //修改token
   public int updateToken(String appid,String token,String tokentime){
        mpconfig mpconfig=new mpconfig();
        mpconfig.setAppid(appid);
        mpconfig.setToken(token);
        mpconfig.setTokentime(tokentime);
        int i=mpconfigDao.updateToken(mpconfig);
        return i;
   }

    //返回正确的tocken
    public String Token(mpconfig mpconfig,JSONObject json,String id){
        String mbid="";
        WxAccessToken token=null;
        mpconfig mpconfig1=null;
        Calendar c = Calendar.getInstance();//可以对每个时间域单独修改
        log.info("--->获取token"+json.get("ICCID")+"appid/"+mpconfig.getAppid()+"/appsecret"+mpconfig.getSecret());
        if (mpconfig.getToken()==null){//第一次获取tolen
            token = selectOrders.getAccessToken(mpconfig.getAppid(), mpconfig.getSecret());
            log.info("--->第一次获取token"+token.getAccessToken());
            Date now = new Date();
            Date afterDate = new Date(now .getTime() + 6000000);
            log.info("--->获取token时间"+d.format(c.getTime()));
            int p=updateToken(mpconfig.getAppid(),token.getAccessToken(),d.format(afterDate));
            //=serverMpconfig.selectconfig(json.getString("CustomerID"));
            log.info("--->第一次获取token到数据库"+p+"token="+token.getAccessToken());
        }else{
            try {
                Date date2 = new Date();
                Date date1=d.parse(mpconfig.getTokentime());
                if (date2.after(date1)==false){
                    //mpconfig1=serverMpconfig.selectconfig(json.getString("CustomerID"));
                    //log.info("--->token有效"+mpconfig1.getToken());
                }else{
                    token = selectOrders.getAccessToken(mpconfig.getAppid(), mpconfig.getSecret());
                    log.info("--->token失效从新获取"+token.getAccessToken());
                    Date now = new Date();
                    Date afterDate = new Date(now .getTime() + 6000000);
                    int p=updateToken(mpconfig.getAppid(),token.getAccessToken(),d.format(afterDate));
                    log.info("--->修改token得状态"+p);
                    //mpconfig1=serverMpconfig.selectconfig(json.getString("CustomerID"));
                }
                mpconfig1=selectconfig(json.getString("CustomerID"));
            }catch (Exception e){
                log.error("推送token异常,异常原因 mas={}", e.getMessage(), e);
            }
        }
        return mbid(id, mpconfig1, mpconfig1.getToken());//获取mbid;
    }

}
