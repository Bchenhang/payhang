package com.weixin.pay.server.ServerImpl;

import com.alibaba.fastjson.JSONObject;
import com.weixin.pay.config.PayfwConfig;
import com.weixin.pay.server.serverFangke;
import com.weixin.pay.utils.HttpClientUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Slf4j
@Service
public class serverFangkeimpl implements serverFangke {
    @Resource
    private PayfwConfig payfwConfig;
    public JSONObject fangke(JSONObject json, String code){//所有访客对接接口
        JSONObject jsonObject=new JSONObject();
        String i="";
        String p=json.toJSONString();
        if (code.equals("101")){//修改用户或访客的照片
            i=HttpClientUtils.post(payfwConfig.getFwnotify()+"YKT_UPDATEPICTURE.action",p);
        }else if  (code.equals("102")){//更新访客资料
            i=HttpClientUtils.post(payfwConfig.getFwnotify()+"YKT_UPDATEVISITOR.action",p);
        }else if (code.equals("103")){//根据访客身份证查询访客其他资料
            i=HttpClientUtils.post(payfwConfig.getFwnotify()+"YKT_QRYVISITOR.action",p);
        }else if (code.equals("104")){//访客来访申请
            i=HttpClientUtils.post(payfwConfig.getFwnotify()+"YKT_VISITORREGISTER.action",p);
        }else if (code.equals("105")){//用于审核来访申请
            i=HttpClientUtils.post(payfwConfig.getFwnotify()+"YKT_CHCEKVISITOR.action",p);
        }
        if (i.equals("ON")){
            jsonObject.put("code","ON");
        }else{
            jsonObject= JSONObject.parseObject(i);
            jsonObject.put("code","OK");
        }
        return jsonObject;
    }
}
