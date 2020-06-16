package com.weixin.pay.server;

import org.springframework.stereotype.Repository;

@Repository
public interface ServerWxdiliweizhi {

     boolean coordinateToDistance(double latitude1, double longitude1, double latitude2, double longitude2);
}
