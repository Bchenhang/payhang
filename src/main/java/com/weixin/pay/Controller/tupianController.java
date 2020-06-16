package com.weixin.pay.Controller;

import com.alibaba.fastjson.JSONObject;
import com.weixin.pay.server.serverUser;
import com.weixin.pay.utils.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.weixin.pay.server.serverPicspace;
import javax.annotation.Resource;
import com.weixin.pay.pojo.User;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//接受base64的图片格式转码存本地
@Controller
public class tupianController {
    @Resource
    private  serverPicspace serverPicspace;
    @Resource
    private serverUser serverUser;
    @ResponseBody
    @RequestMapping("/img")
    //照片上转
    public JSONObject Url(HttpServletRequest request, HttpServletResponse response, HttpSession session,@RequestParam(value = "imgStr") String imgStr){
            System.out.println(imgStr);
            JSONObject jsonObject=new JSONObject();
            if(session.getAttribute("operid")!=null&&session.getAttribute("operid")!=""&&session.getAttribute("appid")!=null&&session.getAttribute("appid")!="") {//判断session是否为空
            String ak = session.getAttribute("ak").toString();
            String sk = session.getAttribute("sk").toString();
            String bucket = session.getAttribute("bucket").toString();
            String url = session.getAttribute("url").toString();
            String appid = session.getAttribute("appid").toString();
            String operid = session.getAttribute("operid").toString();
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
                System.out.println(imgStr);
                StringBuffer stringBuffer=new StringBuffer(user.getAppid());//照片名称
                stringBuffer.append("/user/");
                stringBuffer.append(user.getIccid());
                String code=serverPicspace.deleteimage(ak,sk,bucket,stringBuffer.toString());
                System.out.println("111111=" + code+"路径="+stringBuffer.toString());
                String p = serverPicspace.put64image(imgStr,ak,sk,bucket,stringBuffer.toString());
                StringBuffer stringBuffer1=new StringBuffer(url);//照片路径
                stringBuffer1.append(stringBuffer);
                stringBuffer1.append("?id="+HttpRequest.getRandomString(5));
                System.out.println(stringBuffer1.toString());
                User user1=new User();
                user1.setOperid(user.getOperid());
                user1.setAppid(user.getAppid());
                user1.setIccid(user.getIccid());
                user1.setImgurl(stringBuffer1.toString());
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
    @RequestMapping("/img1") //跳转上转图片
    public String Url1(HttpServletRequest request, HttpServletResponse response, HttpSession session){
        // 主板上转记录
        return "tupianshangchuan";
    }
    @RequestMapping("/img3") //跳转图片上传
    public ModelAndView Url3(HttpServletRequest request, HttpServletResponse response, HttpSession session){
        ModelAndView modelAndView =new ModelAndView("tupianshangchuan3");
        if(session.getAttribute("operid")!=null&&session.getAttribute("operid")!=""&&session.getAttribute("appid")!=null&&session.getAttribute("appid")!="") {//判断session是否为空
            String appid = session.getAttribute("appid").toString();
            String operid = session.getAttribute("operid").toString();
            User user=new User();
            user.setAppid(appid);
            user.setOperid(operid);
            user=serverUser.selectOperid(user);
            modelAndView.addObject("params",user.getImgurl());
        }
        // 主板上转记录
        return modelAndView;
    }
    @RequestMapping("/imgtc") //跳转图片上传
    public String imgtc(HttpServletRequest request, HttpServletResponse response, HttpSession session){
        if(session.getAttribute("operid")!=null&&session.getAttribute("operid")!=""&&session.getAttribute("appid")!=null&&session.getAttribute("appid")!="") {//判断session是否为空
        }
        // 主板上转记录
        return "redirect:/pay1?id=14";
    }
}
