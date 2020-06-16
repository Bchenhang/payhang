<!DOCTYPE html>
<html>
  <script>
function onBridgeReady(){
WeixinJSBridge.invoke(
    'getBrandWCPayRequest', {
    "appId":'${params.appId}',                  //公众号名称，由商户传入
    "timeStamp":'${params.timeStamp}',            //时间戳，自1970年以来的秒数
    "nonceStr":'${params.nonceStr}',             //随机串
    "package":'${params.packageValue}',
    "signType":"MD5",                             //微信签名方式
    "paySign":'${params.paySign}'                //微信签名
 },
  function(res){
      if(res.err_msg == "get_brand_wcpay_request:ok" ){
         alert("充值成功");
        window.location.href='${params.url}'+"/pay1?id=1&orderid="+'${params.orderid}'
  }else{
        //返回跳转到订单详情页面
          alert("充值失败")
        window.location.href='${params.url}'+"/pay1?id=1";
    }
  });
}
   if (typeof WeixinJSBridge == "undefined"){
         if( document.addEventListener ){
            document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
            }else if (document.attachEvent){
               document.attachEvent('WeixinJSBridgeReady', onBridgeReady);
               document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
            }
}else{
onBridgeReady();
}
  </script>
</html>