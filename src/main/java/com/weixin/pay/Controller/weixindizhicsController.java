package com.weixin.pay.Controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.weixin.pay.pojo.Userdetails;
import com.weixin.pay.utils.GetLocationMsg;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import  com.weixin.pay.pojo.Gps;
import  com.weixin.pay.utils.positionUtil;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
@Slf4j
@Controller
public class weixindizhicsController {
    @ResponseBody
    @RequestMapping(value = "/details", method = RequestMethod.POST)
    public String details(Map<String, Object> model, HttpSession session, HttpServletResponse response, HttpServletRequest request) {
        String latitude =  request.getParameter("latitude");
        String longitude = request.getParameter("longitude");
        System.out.println("1-->"+latitude);
        System.out.println("1-->"+longitude);
        if (latitude!=null & longitude!=null) {
            double lat = Double.valueOf(latitude).doubleValue();
            double lon = Double.valueOf(longitude).doubleValue();
            // 微信是GPS需要转化地图
            Gps gps = new Gps(lat, lon);
            Gps gcj = positionUtil.gps84_To_Gcj02(gps.getWgLat(), gps.getWgLon());
            String jsonStr = GetLocationMsg.GetLocationMs(gcj.getWgLat(), gcj.getWgLon());
             System.out.println(jsonStr);
            // 因为嵌套太多先解析
            JSONObject jsonObj = JSONArray.parseObject(jsonStr);
            JSONArray jsonArray = (JSONArray) jsonObj.get("results");
            List list = new ArrayList();// 用list保存全部数据
            for (int i = 0; i < jsonArray.size(); i++) {
                Userdetails user = (Userdetails) JSONObject.toJavaObject(jsonArray.getJSONObject(i), Userdetails.class);
                // System.out.println(user.toString());
                list.add(user.getFormatted_address());
            }
            String json = JSON.toJSONString(list); // list转json
            System.out.println(json);
            // 页面上
            return json;
        }else {
            return null;
        }

    }
}
