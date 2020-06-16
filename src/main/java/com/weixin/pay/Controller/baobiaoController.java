package com.weixin.pay.Controller;
import com.alibaba.fastjson.JSONObject;
import com.weixin.pay.config.PayfwConfig;
import com.weixin.pay.pojo.User;
import com.weixin.pay.utils.HttpClientUtils;
import com.weixin.pay.utils.HttpRequest;
import com.weixin.pay.utils.MD5Utils;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.HttpResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
@Slf4j
@Controller
public class baobiaoController {
    @Resource
    private com.weixin.pay.server.serverUser serverUser;
    @Resource
    private PayfwConfig payfwConfig;

    private SimpleDateFormat d = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
    private SimpleDateFormat s = new SimpleDateFormat("yyyyMMdd");//设置日期格式
    @RequestMapping("/baobiao") //考情查询
    @ResponseBody
    public JSONObject diancan(HttpSession session, HttpRequest request, HttpResponse response, @RequestParam(value = "rq") String rq) {
        JSONObject json = new JSONObject();
        StringBuffer stringBuffer = new StringBuffer();
        if(session.getAttribute("operid")!=null&&session.getAttribute("operid")!=""&&session.getAttribute("appid")!=null&&session.getAttribute("appid")!="") {
            try {
            String operid = session.getAttribute("operid").toString();
            String appid = session.getAttribute("appid").toString();
            String key = session.getAttribute("key").toString();
            User user = new User();
            user.setOperid(operid);
            user.setAppid(appid);
            User user1 = serverUser.selectOperid(user);
                stringBuffer.append("001");//下面还需要一个appid
                stringBuffer.append(appid);
                stringBuffer.append(payfwConfig.getClientid());
                stringBuffer.append(user1.getIccid());
                String b = MD5Utils.md5(stringBuffer.toString(), key);
                json.put("VersionId","001");
                json.put("CustomerID",appid);
                json.put("ClientID",payfwConfig.getClientid());
                json.put("ICCID",user1.getIccid());
                json.put("Name",user1.getName());
                json.put("AttendDate",s.format(d.parse(rq)));
                json.put("MAC", b);
                String p = json.toJSONString();
                System.out.println(p);
                String i=HttpClientUtils.post(payfwConfig.getFwnotify()+"YKT_QUERY_ATTRPT.action",p);
                json=JSONObject.parseObject(i);
            }catch (Exception e){
                log.error("考勤查询发生异常 msg={}",e.getMessage(),e);
            }
        }
        return json;
    }
}
