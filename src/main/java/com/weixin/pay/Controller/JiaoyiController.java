package com.weixin.pay.Controller;
import com.alibaba.fastjson.JSONObject;
import com.weixin.pay.config.PayfwConfig;
import com.weixin.pay.pojo.User;
import com.weixin.pay.server.serverUser;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

import com.weixin.pay.server.serverOrder;
import com.weixin.pay.server.serverSheet;
import com.weixin.pay.server.serverControl;
import com.weixin.pay.server.serverTransaction;
import com.weixin.pay.pojo.sheet;
import com.weixin.pay.pojo.control;
import com.weixin.pay.pojo.transaction;
@Slf4j
@Controller
public class JiaoyiController {
    @Resource
    private serverOrder  serverOrder;
    @Resource
    private serverTransaction  serverTransaction;
    @Resource
    private serverControl  serverControl;
    @Resource
    private serverSheet  serverSheet;
    @Resource
    private serverUser serverUser;
    @Resource
    private PayfwConfig payfwConfig;
    //交易记录
    private SimpleDateFormat d = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
    @RequestMapping(value = "/jiaoyijilu")
    @ResponseBody
    public JSONObject a(HttpServletRequest request, HttpServletResponse response, HttpSession session
            ,@RequestParam(value = "sj",required=true,defaultValue="NO") String sj) {
        JSONObject jsonObject=new JSONObject();
        if(session.getAttribute("operid")!=null&&session.getAttribute("operid")!=""&&session.getAttribute("appid")!=null&&session.getAttribute("appid")!="") {
            List<transaction> list=null;
            transaction sheet = new transaction();
            try {
            String operid = session.getAttribute("operid").toString();
            String appid = session.getAttribute("appid").toString();
            User user = new User();
            user.setOperid(operid);
            user.setAppid(appid);
            User user1 = serverUser.selectOperid(user);
              String  krq=sj+" 00:59:59";
              String  jrq=sj+" 23:59:59";
            list = serverTransaction.selectTransaction(user1.getIccid(),appid, krq, jrq);
                for(int i = 0;i< list.size();i++) {
                    sheet = list.get(i);
                    Date date=d.parse(sheet.getAttendtime());
                    sheet.setAttendtime(d.format(date));
                    list.set(i,sheet);
                }
            }catch (Exception e){
                log.error("交易记录异常,异常原因 mas={}",e.getMessage(),e);
            }
            jsonObject.put("list",list);
            jsonObject.put("url",payfwConfig.getHdnotify());
        }
        log.info("交易记录数据 json={}",jsonObject.toString());
        return  jsonObject;
    }
    //考情记录
    @RequestMapping(value = "/kaoqingjilu")
    @ResponseBody
    public JSONObject kaoqingjilu(HttpServletRequest request, HttpServletResponse response,HttpSession session,@RequestParam(value = "sj",required=true,defaultValue="NO") String sj) {
        JSONObject j=new JSONObject();
        if(session.getAttribute("operid")!=null&&session.getAttribute("operid")!=""&&session.getAttribute("appid")!=null&&session.getAttribute("appid")!="") {
            List<sheet> list=null;
            String name="";
            sheet sheet = new sheet();
            try {
            String operid = session.getAttribute("operid").toString();
            String appid = session.getAttribute("appid").toString();
            String isshool=session.getAttribute("isshool").toString();
            User user = new User();
            user.setOperid(operid);
            user.setAppid(appid);
            User user1 = serverUser.selectOperid(user);
            String  krq=sj+" 00:59:59";
            String  jrq=sj+" 23:59:59";
            list = serverSheet.selectSheet(user1.getIccid(), appid, krq, jrq);
              for(int i = 0;i< list.size();i++) {
                    sheet = list.get(i);
                    if (sheet.getUrlimage()!=null){
                        sheet.setUrlimage(sheet.getUrlimage().concat("?id=" + new Random().nextInt(100000000)));
                    }
                    Date date=d.parse(sheet.getAttendtime());
                    sheet.setAttendtime(d.format(date));
                    list.set(i,sheet);
                }
                j.put("name", user1.getName());
                if (isshool.equals("1")){
                    name="学工号";
                }else{
                    name="工号";
                }
                j.put("isshool",name);
            }catch (Exception e){
                log.error("考情记录异常,异常原因 mas={}",e.getMessage(),e);
            }
            j.put("list", list);

        }
        return j;
    }
    //门禁记录
    @RequestMapping(value = "/menjinjilu")
    @ResponseBody
    public JSONObject menjinjilu(HttpServletRequest request, HttpServletResponse response,HttpSession session,@RequestParam(value = "sj",required=true,defaultValue="NO") String sj) {
        JSONObject j=new JSONObject();
        List<control> list=null;
        String name="";
        if(session.getAttribute("operid")!=null&&session.getAttribute("operid")!=""&&session.getAttribute("appid")!=null&&session.getAttribute("appid")!="") {
            control sheet=new control();
            String operid = session.getAttribute("operid").toString();
            String appid = session.getAttribute("appid").toString();
            String isshool=session.getAttribute("isshool").toString();
            User user = new User();
            user.setOperid(operid);
            user.setAppid(appid);
            User user1 = serverUser.selectOperid(user);
            String  krq=sj+" 00:59:59";
            String  jrq=sj+" 23:59:59";
            list =serverControl.selectControl(user1.getIccid(), appid, krq, jrq);
            try {
                for(int i = 0;i< list.size();i++) {
                    sheet = list.get(i);
                    if (sheet.getUrlimage()!=null) {
                        sheet.setUrlimage(sheet.getUrlimage().concat("?id=" + new Random().nextInt(100000000)));
                    }
                    Date date=d.parse(sheet.getAttendtime());
                    sheet.setAttendtime(d.format(date));
                    list.set(i,sheet);
                }
            }catch (Exception e){

                log.error("门禁记录异常,异常原因 mas={}",e.getMessage(),e);
            }
            j.put("list", list);
            j.put("name", user1.getName());
            if (isshool.equals("1")){
                name="学工号";
            }else{
                name="工号";
            }
            j.put("isshool",name);
            log.info("门禁记录");
        }
        log.info("门禁记录数据---》"+j.toString());
        return j;
    }
    @RequestMapping(value = "/c") //测试娃娃机
    public ModelAndView c(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView = new ModelAndView("cong");
        modelAndView.addObject("params", payfwConfig.getFwnotify());
        return modelAndView;
    }

    @RequestMapping(value = "/cs")
    public String cs(HttpServletRequest request, HttpServletResponse response,HttpSession session) {

        return "about";
    }
}
