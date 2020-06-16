package com.weixin.pay.server.ServerImpl;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.github.binarywang.wxpay.bean.order.WxPayMpOrderResult;
import com.github.binarywang.wxpay.bean.request.BaseWxPayRequest;
import com.github.binarywang.wxpay.bean.request.WxPayUnifiedOrderRequest;
import com.github.binarywang.wxpay.bean.result.WxPayOrderQueryResult;
import com.github.binarywang.wxpay.config.WxPayConfig;
import com.github.binarywang.wxpay.exception.WxPayException;
import com.github.binarywang.wxpay.service.WxPayService;
import com.weixin.pay.config.PayfwConfig;
import com.weixin.pay.dao.OrdersDao;
import com.weixin.pay.dao.UserDao;
import com.weixin.pay.dao.MpconfigDao;
import com.weixin.pay.pojo.TemplateData;
import com.weixin.pay.pojo.User;
import com.weixin.pay.pojo.mpconfig;
import com.weixin.pay.pojo.WxTemplate;
import com.weixin.pay.pojo.orders;
import com.weixin.pay.utils.HttpClientUtils;
import com.weixin.pay.utils.HttpRequest;
import com.weixin.pay.utils.MD5Utils;
import lombok.extern.slf4j.Slf4j;
import me.chanjar.weixin.common.bean.WxAccessToken;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import  com.weixin.pay.server.serverOrder;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;

@Slf4j
@Service
public class serverOrderImpl implements serverOrder{
    @Resource
    private  OrdersDao ordersDao;
    @Resource
    private WxPayService wxPayService;
    @Resource
    private PayfwConfig payfwConfig;
    @Resource
    private UserDao userDao;
    @Resource
    private MpconfigDao mpconfigDao;
    //查订单
    private SimpleDateFormat d = new SimpleDateFormat("yyyy-MM-dd HH:mm");//设置日期格式
    private SimpleDateFormat s = new SimpleDateFormat("yyyyMMddHHmm");//设置日期格式
    private SimpleDateFormat a = new SimpleDateFormat("yyyyMMddHHmmss");//设置日期格式
    public orders selectOrders(orders orders){
        orders orders1  = ordersDao.selectOrders(orders.getOrderid());
        return orders1;
    }
    //删除数据库订单订单
    public  int deleteOrders (String orderid){
              int u=ordersDao.deleteOrders(orderid);
        return u;
    }
    //计算当前日期
    public  Date getDateBefore(int day){
        Calendar now =Calendar.getInstance();
        now.setTime(new Date());
        now.set(Calendar.DATE,now.get(Calendar.DATE)-day);
        return now.getTime();

    }
    //数据库添加订单
    public String addOrders(String operid,String price,String appid,String clientid,String iccid) {
       /* String uuid = UUID.randomUUID().toString().toUpperCase().replaceAll("-", "");//uuid订单号*/
        try {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        BigDecimal bigDecimal = new BigDecimal(price);
        BigDecimal bigDecimal1 = new BigDecimal("100");
        String orderid = getOrderIdByTime();//日期加随机数
        orders orders = new orders();
        orders.setOperid(operid);
        orders.setIccid(iccid);
        orders.setBoty("一卡通微信充值");
        orders.setOrderid(orderid);
        orders.setTrade_type("CNTY");
        orders.setPaytime(df.format(new Date()));
        orders.setState(0);
        orders.setStatus(0);
        orders.setTotal_fee(bigDecimal.multiply(bigDecimal1));
        orders.setAppid(appid);
        int i=ordersDao.addOrders(orders);//新增数据库
        if (i>0){
            String odid=orders.getOrderid();
            return odid;
        }
        }catch (Exception e){
            log.error("数据库添加订单异常,异常原因 mas={}",e.getMessage(),e);
        }
        return "";
    }
        //微信下单
    public WxPayMpOrderResult pay(String orderid){
        orders orders=ordersDao.selectOrders(orderid);
        WxPayMpOrderResult wxPayMpOrderResult = null;
        log.info("微信下单金额-----orderid》"+orderid);
        log.info("微信下单金额-----appid》"+orders.getAppid());
        mpconfig mpconfig=mpconfigDao.selectconfig(orders.getAppid());
        WxPayConfig wxPayConfig = new WxPayConfig();
        wxPayConfig.setAppId(mpconfig.getAppid());
        wxPayConfig.setMchId(mpconfig.getMchid());
        wxPayConfig.setMchKey(mpconfig.getMchkey());
        wxPayConfig.setNotifyUrl(payfwConfig.getNotify());
        wxPayService.setConfig(wxPayConfig);
            //下单
            WxPayUnifiedOrderRequest wxPayUnifiedOrderRequest = new WxPayUnifiedOrderRequest();
        try {
            wxPayUnifiedOrderRequest.setOpenid(orders.getOperid());//商户id
            wxPayUnifiedOrderRequest.setBody("一卡通微信充值["+orders.getIccid()+"]");                         //商品描述
            wxPayUnifiedOrderRequest.setOutTradeNo(orders.getOrderid()); //订单号
            BigDecimal num1 = new BigDecimal(orders.getTotal_fee().toString());
            log.info("数据库下单金额-----》"+num1.toString());
            wxPayUnifiedOrderRequest.setTotalFee(BaseWxPayRequest.yuanToFen(num1.divide(new BigDecimal("100"), 0, BigDecimal.ROUND_HALF_DOWN).toString()));  //金额
             log.info("微信下单金额-----》"+BaseWxPayRequest.yuanToFen(num1.divide(new BigDecimal("100"), 0, BigDecimal.ROUND_HALF_DOWN).toString()));
            wxPayUnifiedOrderRequest.setSpbillCreateIp(payfwConfig.getIp()); // 配置文件           //地址219.137.207.27
            wxPayUnifiedOrderRequest.setTradeType("JSAPI");
            //支付类型
             wxPayMpOrderResult = wxPayService.createOrder(wxPayUnifiedOrderRequest);//都再这里  开始就注入进去得
            log.info("================="+wxPayMpOrderResult.toString());
            } catch (WxPayException e) {
                log.error("微信下单异常,异常原因 mas={}",e.getMessage(),e);
            }
            return wxPayMpOrderResult;
        }
    //发送道具
    public JSONObject daojufasong(String orderid){
        SimpleDateFormat d = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        JSONObject object=null;
        log.info("道具发送数据库状态已修改orderid---》"+orderid);
        try {
        SimpleDateFormat s=new SimpleDateFormat("yyyyMMddHHmmss");
        orders orders= ordersDao.selectOrders(orderid);//查订单
        mpconfig mpconfig=mpconfigDao.selectkey(orders.getAppid());
        User user=new User();
        user.setAppid(orders.getAppid());
        user.setOperid(orders.getOperid());
        User user1=userDao.selectOperid(user);//查用户
        JSONObject json=new JSONObject();
        String data="";
            StringBuffer stringBuffer=new StringBuffer();
            stringBuffer.append("001");//下面还需要一个appid
            stringBuffer.append(orders.getAppid());//appid
            stringBuffer.append(payfwConfig.getClientid());//第三方渠道号
            stringBuffer.append(user1.getIccid());//工号
            stringBuffer.append(orders.getOrderid());//订单号
            stringBuffer.append(orders.getTotal_fee().stripTrailingZeros().toPlainString());//金额
            System.out.println(orders.getPayotime());
            Date date = d.parse(orders.getPayotime());//时间
            stringBuffer.append(s.format(date));//交易时间
            String b=MD5Utils.md5(stringBuffer.toString(),mpconfig.getMackey());
            json.put("VersionId","001");
            json.put("CustomerID",orders.getAppid());
            json.put("ClientID",payfwConfig.getClientid());
            json.put("ICCID",user1.getIccid());
            json.put("Name",user1.getName());
            json.put("OrderId",orders.getOrderid());
            json.put("Amount",orders.getTotal_fee().stripTrailingZeros().toPlainString());
            json.put("OrderDate",s.format(date));
            json.put("MAC",b);
            String p=json.toJSONString();
            data=HttpClientUtils.post(payfwConfig.getFwnotify()+"YKT_YHCZ.action",p);
            if (!data.equals("ON")){
            object= JSONObject.parseObject(data);
            if (object.getString("ResultCode").equals("0000") || object.getString("ResultCode").equals("0003")){
                orders orders1=new orders();
                orders1.setOrderid(orderid);
                int x= ordersDao.updatestate(orders1);
                log.info("道具发送成功");
                if (x>0){
                    log.info("数据库道具状态修改成功-----》"+x);
                   return object;
                }
            }else{
                return object;
            }
            }else{
                object.put("code","3333");
                log.info("服务器故障");
            }
        }catch (Exception e){
            log.error("道具发送异常,异常原因 mas={}",e.getMessage(),e);
        }
        return object;
    }
    //修改订单
    public String updateOrders(String orderid, String tradeNo, String totalFee){
        String cle="OK";
        JSONObject object=null;
        orders y=ordersDao.selectOrders(orderid);
        if (y!=null) {
            BigDecimal bigDecima1 = y.getTotal_fee();
            BigDecimal bigDecima2 = new BigDecimal(totalFee);
            BigDecimal bigDecima3 = new BigDecimal("100");
            BigDecimal bigDecima4 = bigDecima2.multiply(bigDecima3);
            //金额验证 修改状态
            SimpleDateFormat d = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
            orders o = new orders();
            o.setOrderid(y.getOrderid());
            o.setWxorderid(tradeNo);
            o.setPayotime(d.format(new Date()));
            int i = ordersDao.updateOrders(o);
            log.info("微信充值成功，下一步数据库金额验证》");
            if (bigDecima1.compareTo(bigDecima4) == 0) {
                log.info("微信到账，金额验证成功totaFee---》数据库金额：" + bigDecima1 + "--微信充值金额：" + bigDecima4);
                if (i > 0) {
                    object = daojufasong(orderid); //发送道具 修改状态
                    log.info("道具发送------》" + object.toString());
                }
            } else {
                cle = "ON";
                log.info("微信到账，金额验证失败totaFee---》数据库金额：" + bigDecima1 + "--微信充值金额：" + bigDecima4);
            }
        }else{
            cle = "ON";
            log.info("微信到账，订单号不存在orderid---》数据库单号：" + orderid);
        }
        return cle;
    }
    //查询当天订单显示
    public List<orders> selectPay (String operid,String appid,String iccid,String krq,String jrq){
        orders orders=new orders();
        orders.setOperid(operid);
        orders.setAppid(appid);
        orders.setIccid(iccid);
        orders.setPaytime(krq);
        orders.setPayotime(jrq); //orders.setPayotime(jrq);
        List<orders> orders1=ordersDao.selectPay(orders);//数据再这里
        return orders1;
    }
    //模板消息推送
    public WxAccessToken getAccessToken(String appId, String appSecret) {
        log.info("获取token  appid="+appId+"/appSecret="+appSecret);
        WxAccessToken token = new WxAccessToken();
        try {
        String Url = String.format("https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=%s&secret=%s",appId,appSecret);
        //此请求为https的get请求，返回的数据格式为{"access_token":"ACCESS_TOKEN","expires_in":7200}
        String result = HttpRequest.sendPost(Url,"");
        //使用FastJson将Json字符串解析成Json对象空气墙 数据就乱子啊这里
        JSONObject json= JSON.parseObject(result);
         log.info("token  数据"+json.toString());
        token.setAccessToken(json.getString("access_token"));
        token.setExpiresIn(json.getInteger("expires_in"));
        }catch (Exception e){
            log.error("推送获取token异常,异常原因 mas={}",e.getMessage(),e);
        }
        return token;
    }
    //获取模板id
    public JSONObject getAccessMoban(String moban, String tokey){
        JSONObject jsonObject=new JSONObject();
        jsonObject.put( "template_id_short",moban);
        String mobanid=jsonObject.toString();
        String Url = String.format("https://api.weixin.qq.com/cgi-bin/template/api_add_template?access_token="+tokey);
        String result=HttpClientUtils.post(Url,mobanid);
        JSONObject json= JSON.parseObject(result);
        return json;
    }
  //  {{first.DATA}}
  //  姓名：{{keyword1.DATA}}
  //  考勤号：{{keyword2.DATA}}
  //  时间：{{keyword3.DATA}}
   // {{remark.DATA}}
    //模板信息
    public  WxTemplate buildTempMessage1(Map<String, String> map) {
      //发送方帐号
      // 开发者微信号
      /*String toUserName = map.get("ToUserName");*/
      WxTemplate template = new WxTemplate();
      template.setUrl(map.get("zpdz"));
      template.setTouser(map.get("FromUserName"));//opid
      template.setTopcolor("#000000");
      template.setTemplate_id(map.get("template_id"));//模板Id
      return template;
  }
    //模板信息  门禁  充值 消费
    public   Map<String,TemplateData> buildTempMessage2(Map<String, String> map) {
      Map<String,TemplateData> m = new HashMap<String,TemplateData>();
        TemplateData first = new TemplateData();
      first.setColor("#000000");
      first.setValue(map.get("lx"));
      m.put("first", first);
        TemplateData keyword1 = new TemplateData();
      keyword1.setColor("#328392");
      keyword1.setValue(map.get("name"));
      m.put("keyword1", keyword1);
        TemplateData keyword2 = new TemplateData();
      keyword2.setColor("#328392");
      keyword2.setValue(map.get("kqh"));
      m.put("keyword2", keyword2);
        TemplateData keyword3 = new TemplateData();
      keyword3.setColor("#328392");
      keyword3.setValue(map.get("date"));
      m.put("keyword3", keyword3);
        TemplateData remark = new TemplateData();
      remark.setColor("#929232");
      remark.setValue(map.get("bt"));
      m.put("remark", remark);

      return m;

  }

    /**
     * 发送模板消息
     * @param t
     * @param accessToken
     * @return
     */
    public  int sendMessage(WxTemplate t,String accessToken) {
        int result = 0;
        // 拼装创建菜单的url
        String url = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=ACCESS_TOKEN".replace("ACCESS_TOKEN", accessToken);
        // 将菜单对象转换成json字符串
        String jsonMenu = JSONObject.toJSONString(t);
        // 调用接口创建菜单
        String response =HttpClientUtils.post(url,jsonMenu);
        JSONObject jsonObject = JSON.parseObject(response);
        //JSONObject jsonObject = httpRequest(url, "POST", jsonMenu);
        if (null != jsonObject) {
            if (0 != jsonObject.getIntValue("errcode")) {
                result = jsonObject.getIntValue("errcode");
                log.error("发送模板消息失败 errcode:{"
                        +jsonObject.getIntValue("errcode")+"} errmsg:{"+jsonObject.getString("errmsg")+"}");
            }
        }
        return result;
    }
    //日期加随机数订单号
    public  String getOrderIdByTime() {
            SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddHHmmss");
            String newDate=sdf.format(new Date());
            String result="";
            Random random=new Random();
               for(int i=0;i<3;i++){
                  result+=random.nextInt(10);
                  }
            return newDate+result;
}
    //微信订单查询
    public WxPayOrderQueryResult dingdan(orders orders) {
        mpconfig mpconfig=mpconfigDao.selectconfig(orders.getAppid());
        WxPayConfig wxPayConfig = new WxPayConfig();
        wxPayConfig.setAppId(mpconfig.getAppid());
        wxPayConfig.setMchId(mpconfig.getMchid());
        wxPayConfig.setMchKey(mpconfig.getMchkey());
        wxPayConfig.setNotifyUrl(payfwConfig.getNotify());
        wxPayService.setConfig(wxPayConfig);
        WxPayOrderQueryResult request = new WxPayOrderQueryResult();
        try {
            request=wxPayService.queryOrder(null,orders.getOrderid());
        } catch (WxPayException e) {
            log.error("微信下单异常,异常原因 mas={}", e.getMessage(), e);
        }
        System.out.println("返回的数据+11111111111111==="+request.toString());
        return request;
    }
}
