package com.weixin.pay.server.ServerImpl;

import com.weixin.pay.utils.HttpRequest;
import lombok.extern.slf4j.Slf4j;
import me.chanjar.weixin.common.util.http.HttpResponseProxy;
import org.springframework.stereotype.Service;
import com.weixin.pay.server.ServerWxdiliweizhi;
@Slf4j
@Service
public class serverWxdiliweizhiImpl implements ServerWxdiliweizhi {
    //计算点与点之间得距离
    public  boolean coordinateToDistance(double latitude1, double longitude1, double latitude2, double longitude2)
    {
        double a = latitude1 * Math.PI / 180.0 - latitude2 * Math.PI / 180.0;
        double b = longitude1 * Math.PI / 180.0 - longitude2 * Math.PI / 180.0;
        double s = 2 * Math.asin(Math.sqrt(Math.pow(Math.sin(a / 2), 2)
                + Math.cos(latitude1 * Math.PI / 180.0)
                * Math.cos(latitude2 * Math.PI / 180.0)
                * Math.pow(Math.sin(b / 2), 2)));
        s = s * 6378.137 * 1000;
        s= s * 3.2425926/2;
        s = Math.round(s);
        System.out.println("两点之间得距离="+s);
        if (s > 50) {
            return true;
        }
        return false;
    }
}
