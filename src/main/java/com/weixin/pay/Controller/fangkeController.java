package com.weixin.pay.Controller;


import com.alibaba.fastjson.JSONObject;
import com.weixin.pay.pojo.User;
import com.weixin.pay.server.serverFangke;
import com.weixin.pay.server.serverOrder;
import com.weixin.pay.server.serverPicspace;
import com.weixin.pay.utils.HttpRequest;
import com.weixin.pay.utils.MD5Utils;
import lombok.extern.slf4j.Slf4j;
import lombok.val;
import org.apache.http.HttpResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.weixin.pay.server.serverUser;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@Controller
public class fangkeController {
    @Resource
    private serverFangke serverFangke;
    @Resource
    private serverUser serverUser;
    @Resource
    private serverOrder serverOrder;
    @Resource
    private  serverPicspace serverPicspace;
    //新增访客信息
    @ResponseBody
    @RequestMapping("/fangkeBD")
    public JSONObject fangkeBD(HttpSession session, HttpRequest request, HttpResponse response, @RequestParam(value = "sf") String sf,
                          @RequestParam(value = "xm") String xm, @RequestParam(value = "gz") String gz,@RequestParam(value = "xb") String xb,
                          @RequestParam(value = "cp") String cp, @RequestParam(value = "dh") String dh) {
       StringBuffer stringBuffer=new StringBuffer();
        JSONObject o=new JSONObject();
        System.out.println(xb);
        int sex=0;
         JSONObject jsonObject = new JSONObject();
        if (session.getAttribute("operid") != null && session.getAttribute("operid") != ""&&session.getAttribute("appid")!=null&&session.getAttribute("appid")!="") {
            String operid = session.getAttribute("operid").toString();
            String appid = session.getAttribute("appid").toString();
            String clientid=session.getAttribute("clientid").toString();
            String key=session.getAttribute("key").toString();
            User user1=new User();
            user1.setName(xm);
            user1.setIccid(sf);
            user1.setOperid(operid);
            user1.setAppid(appid);
            user1.setStatus(3);
            int i=serverUser.addUser(user1);
            System.out.println(i);
       /*    if (i>0){//新增访客
            try {
            stringBuffer.append("001");
            stringBuffer.append(appid);
            stringBuffer.append(clientid);
            stringBuffer.append(sf);
            String mac=MD5Utils.md5(stringBuffer.toString(),key);
            jsonObject.put("VersionId","001");
            jsonObject.put("CustomerID",appid);
            jsonObject.put("ClientID", clientid);
            jsonObject.put("ICCID", sf);
            jsonObject.put("Name", xm);
            if(xb.equals("男")){
               sex=1;
              }else{
               sex=2;
              }
            jsonObject.put("Sex",sex);
            jsonObject.put("PhoneNum", dh);
            jsonObject.put("Company", gz);
            jsonObject.put("PlateNum", cp);
            jsonObject.put("MAC",mac);
            o= serverFangke.fangke(jsonObject,"102");
            StringBuffer noke = new StringBuffer();
            log.info("访客信息----》" + jsonObject.toString());
            } catch (Exception e) {
                log.error("访客异常异常 msg={}", e.getMessage(), e);
            }
            }else{
                o.put("code","NO");
                log.error("访新增访客失败");
           }*/
    }
        return o;
    }
    //访客申请，
    @ResponseBody
    @RequestMapping("/fangkeSQ")
    public JSONObject fangkeSQ(HttpSession session, HttpRequest request, HttpResponse response, @RequestParam(value = "xm") String xm,
                               @RequestParam(value = "dh") String dh,@RequestParam(value = "rs") String rs,
                              @RequestParam(value = "rq") String rq, @RequestParam(value = "sy") String sy) {
        StringBuffer sb1=new StringBuffer();//访客资料
        StringBuffer sb=new StringBuffer();//访客申请
        JSONObject o1=new JSONObject();//访客资料
        JSONObject o=new JSONObject();//访客申请
        JSONObject jsonObject1 = new JSONObject();
       JSONObject jsonObject = new JSONObject();
        if (session.getAttribute("operid") != null && session.getAttribute("operid") != ""&&session.getAttribute("appid")!=null&&session.getAttribute("appid")!="") {
            String operid = session.getAttribute("operid").toString();
            String appid = session.getAttribute("appid").toString();
            String clientid=session.getAttribute("clientid").toString();
            String key=session.getAttribute("key").toString();
            User user1=new User();
            user1.setOperid(operid);
            user1.setAppid(appid);
            User user11 =serverUser.selectOperid(user1);//查询访客iccid

            try {  //查询访客资料
                    sb1.append("001"). append(appid).append(clientid).append(user11.getIccid());
                    String mac1=MD5Utils.md5(sb1.toString(),key);
                    jsonObject1.put("VersionId","001");
                    jsonObject1.put("CustomerID",appid);
                    jsonObject1.put("ClientID", clientid);
                    jsonObject1.put("ICCID", user11.getIccid());
                    jsonObject.put("Name", user11.getName());
                    jsonObject.put("MAC",mac1);
                    o1= serverFangke.fangke(jsonObject, "103");
                   //访客申请
                    String orderid=serverOrder.getOrderIdByTime();
                    sb.append("001"). append(appid).append(clientid). append(orderid).
                    append(user11.getIccid()) . append(user11.getName()) . append(xm). append(dh);//mac加密字符串
                    String mac=MD5Utils.md5(sb.toString(),key);
                    jsonObject.put("VersionId","001");
                    jsonObject.put("CustomerID",appid);
                    jsonObject.put("ClientID", clientid);
                    jsonObject.put("VisitID", orderid);
                    jsonObject.put("ICCID", o1.get("ICCID"));
                    jsonObject.put("Name", o1.get("Name"));
                    jsonObject.put("Sex", o1.get("Sex"));
                    jsonObject.put("PhoneNum", o1.get("PhoneNum"));
                jsonObject.put("Company",o1.get("Company"));
                if (o1.get("PlateNum")!=null){
                    jsonObject.put("PlateNum", o1.get("PlateNum"));
                }
                jsonObject.put("Cnt", rs);
                jsonObject.put("Receptionist", xm);
                jsonObject.put("ContractTel", dh);
                jsonObject.put("ExpectLeaveTime", rq);
                jsonObject.put("Remark", sy);
                jsonObject.put("MAC",mac);
                o= serverFangke.fangke(jsonObject, "102");
                } catch (Exception e) {
                    log.error("访客异常异常 msg={}", e.getMessage(), e);
                }
            }else{
                o.put("code","NO");
                log.error("访新增访客失败");
                log.error("1231231");
           }

        return o;
    }
    //访客修改身份证，姓名，工作单位，车牌，电话
    @ResponseBody
    @RequestMapping("/fangkeXG")
    public JSONObject fangkeXG(HttpSession session, HttpRequest request, HttpResponse response, @RequestParam(value = "sf") String sf,
                               @RequestParam(value = "xm") String xm, @RequestParam(value = "gz") String gz,
                               @RequestParam(value = "cp") String cp, @RequestParam(value = "dh") String dh) {
        JSONObject date = new JSONObject();
        try {
        date.put("ICCID",sf);
        date.put("Name",xm);
        date.put("Sex","0");
        date.put("Company",gz);
        date.put("PlateNum",cp);
        date.put("PhoneNum",dh);
        date.put("MAC","mac");
        date.put("code","0000");
            StringBuffer noke=new StringBuffer();
            log.info("访客信息----》"+date.toString());
        }catch (Exception e){
            log.error("访客异常异常 msg={}",e.getMessage(),e);
        }
        return date;
    }

  //修改跳转,保存跳转
    @RequestMapping("/fangkeTZ")
    public String fangkeTZ(HttpSession session, HttpRequest request, HttpResponse response,@RequestParam(value = "id") String id) {
        JSONObject date = new JSONObject();
         if(id.equals("1")){
             return "fangkeSQ";
         }else if (id.equals("2")){
             return "fangkeXG";
         }
        return "fangkeXG";
    }
   //访客绑定之后的跳转
    @RequestMapping("/SQ")
    public ModelAndView fangkelogin1(HttpSession session, HttpRequest request, HttpResponse response) {
        User user1=new User();
        if (session.getAttribute("operid") != null && session.getAttribute("operid") != ""&&session.getAttribute("appid")!=null&&session.getAttribute("appid")!="") {
            String operid = session.getAttribute("operid").toString();
            String appid = session.getAttribute("appid").toString();
            String clientid = session.getAttribute("clientid").toString();
            String key = session.getAttribute("key").toString();
            User user=new User();
            user.setAppid(appid);
            user.setOperid(operid);
            user1=serverUser.selectOperid(user);
        }
            ModelAndView modelAndView =new ModelAndView("fangkeSQ");
            modelAndView.addObject("params",user1.getIccid());

        return modelAndView;
    }
    //访客记录
    @RequestMapping("/fangkejl")
    public String fangkejl(HttpSession session, HttpServletRequest request, HttpResponse response) {
        System.out.println("fangke.姓名=");
        JSONObject jsonObject=new JSONObject();
        jsonObject.put("name","hang");
        jsonObject.put("pass","hang123");
        Map<String,String> map=new HashMap<>();
        map.put("appid","wx34563a3ac5e7146b");
        Map<String,JSONObject> stringObjectMap=new HashMap<>();
        stringObjectMap.put("code",jsonObject);
        System.out.print("");
    return "fangkejl";
    }

    //访客记录
    @RequestMapping("/fangketup")
    public String fangketup(HttpSession session, HttpServletRequest request, HttpResponse response) {

        return "fangketup";
    }
    //访客绑定图片
    @RequestMapping("/fangkeurl")
    public JSONObject fangurl(HttpServletRequest request, HttpServletResponse response, HttpSession session, @RequestParam(value = "imgStr") String imgStr) {
      JSONObject jsonObject =new JSONObject();
      JSONObject jsonObject1=new JSONObject();
      StringBuffer sb=new StringBuffer();//加密
        if(session.getAttribute("operid")!=null&&session.getAttribute("operid")!=""&&session.getAttribute("appid")!=null&&session.getAttribute("appid")!="") {//判断session是否为空
            String ak = session.getAttribute("ak").toString();
            String sk = session.getAttribute("sk").toString();
            String bucket = session.getAttribute("bucket").toString();
            String url = session.getAttribute("url").toString();
            String appid = session.getAttribute("appid").toString();
            String operid = session.getAttribute("operid").toString();
            String key = session.getAttribute("key").toString();
            String clientid = session.getAttribute("clientid").toString();
            //对字节数组字符串进行Base64解码并生成图片
            if (imgStr == null) {//图像数据为空
                jsonObject.put("id", "1");
                return jsonObject;
            }
            try {
                User user=new User();
                user.setAppid(appid);
                user.setOperid(operid);
                user=serverUser.selectOperid(user);
                sb.append("001").append(user.getAppid()).append(clientid).append(user.getIccid());
                String mac=MD5Utils.md5(sb.toString(),key);

                System.out.println(imgStr);
                StringBuffer stringBuffer=new StringBuffer(user.getAppid());//照片名称
                stringBuffer.append("/user/");
                stringBuffer.append(user.getIccid());
                String code=serverPicspace.deleteimage(ak,sk,bucket,stringBuffer.toString());//删除七牛云的图片
                System.out.println("111111=" + code+"路径="+stringBuffer.toString());
                String p = serverPicspace.put64image(imgStr,ak,sk,bucket,stringBuffer.toString());//上传图片到七牛云
                StringBuffer stringBuffer1=new StringBuffer(url);//照片路径
                stringBuffer1.append(stringBuffer);
                stringBuffer1.append("?id="+HttpRequest.getRandomString(5));
                jsonObject.put("VersionId","001");
                jsonObject.put("CustomerID",user.getAppid());
                jsonObject.put("ClientID",clientid);
                jsonObject.put("ICCID",user.getIccid());
                jsonObject.put("Name",user.getName());
                jsonObject.put("Kind","1");
                jsonObject.put("Url",stringBuffer1.toString());
                jsonObject.put("MAC",mac);
                jsonObject1= serverFangke.fangke(jsonObject,"101");//上传照片路径到服务器
                User user1=new User();
                user1.setOperid(user.getOperid());
                user1.setAppid(user.getAppid());
                user1.setIccid(user.getIccid());
                user1.setImgurl(stringBuffer1.toString());
                user1.setName(user.getName());
                //修改图片路径
                int i=serverUser.updateUrl(user1);
                if (i>0){
                    jsonObject.put("id", "0");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
     return jsonObject;
    }
}
