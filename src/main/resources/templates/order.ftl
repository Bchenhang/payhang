<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
        <title></title>
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
		<script type="text/javascript" src="js/jquery.min.js" ></script>
		<script type="text/javascript" src="js/amazeui.min.js"></script>
		<link rel="stylesheet" href="css/amazeui.min.css" type="text/css" />
		<link rel="stylesheet" href="css/stylee.css" type="text/css" />
        <script type="text/javascript">
            $(function () {
                click();
            });
            function click() {
                var js='';
                    $.ajax({
                        url: "/pay/dingdan",
                        type: "post",
                        data:{},
                        dataType: "json",
                        success: function (data) {
                            if (data.list!= "") {
                                for (var o in data.list) {
                                    js += '<li>\n';

                                    if (data.list[o].status==0 && data.list[o].state==0 && data.list[o].wxorderid=="0004"){
                                        js+= ' <h2><i></i><span>'+data.list[o].boty+'</span><b>待支付</b></h2>';
                                    }else if (data.list[o].status==1 && data.list[o].state==0){
                                        js+= ' <h2><i></i><span>'+data.list[o].boty+'</span><b>圈存失败</b></h2>';
                                    }else if (data.list[o].status==1 && data.list[o].state==1 && data.list[o].wxorderid=="0000"){
                                        js+= ' <h2><i></i><span>'+data.list[o].boty+'</span><b>支付成功</b></h2>';
                                    }else if (data.list[o].status==1 && data.list[o].state==1 && data.list[o].wxorderid=="8888"){
                                        js+= ' <h2><i></i><span>'+data.list[o].boty+'</span><b>交易成功</b></h2>';
                                    }
                                    js+= ' <p><img src="images/订单小图片.png"/><span>单号&nbsp;:&nbsp;'+data.list[o].orderid+'</span></p>\n' +
                                            ' <p style="border-bottom: 1px solid #ddd;">\n' +
                                            ' <img src="images/时间小图片.png"/>\n' +
                                            ' <span style="border-bottom: 0;">时间&nbsp;:&nbsp;'+data.list[o].paytime+'</span>\n' +
                                            ' </p>\n' +
                                            ' <h3>\n' +
                                            ' <span>￥'+data.list[o].total_fee/100+'</span>';
                                          if (data.list[o].status==0 && data.list[o].state==0 && data.list[o].wxorderid=="0004") {
                                            js+= ' <a href="/pay/wechat/pay?orderid='+data.list[o].orderid+'" class="current" onclick="if(confirm(\'是否支付?\')==false)return false;">立即支付</a>\n' +
                                                 ' <a href="/pay/del?orderid='+data.list[o].orderid+'"  onclick="if(confirm(\'是否取消?\')==false)return false;">取消订单</a>\n' +
                                                 ' <a href="" style="background-color: #c7254e; size: A4; display: none"></a>';
                                              }
                                            if (data.list[o].status==1 && data.list[o].state==0) {
                                                js+=' <a href="#" onclick="clickBind2(\''+data.list[o].orderid+'\')" class="current" >继续圈存</a>';
                                            }else if (data.list[o].status==1 && data.list[o].state==1 && data.list[o].wxorderid=="0000"){
                                                js+= ' <a href="#title-link" >待领取</a>';
                                            }else if (data.list[o].status==1 && data.list[o].state==1 && data.list[o].wxorderid=="8888"){
                                                js+= ' <a href="#title-link" >订单已完成</a>';
                                            }
                                           js+= ' </h3>\n' +
                                            '</li>';
                                }
                                document.getElementById("div_id").innerHTML = js;
                                HuiFang.Funtishi("操作成功");
                            }else{
                                var h='<div align="center">\n' +
                                        '<p style="width: 120px; height: 30px; padding-top: 80px"><h1>当期没有记录</h1></p>\n' +
                                        '</div>';
                                document.getElementById("div_id").innerHTML = h;
                                HuiFang.Funtishi("无记录");
                            }
                        }
                    })
            }
            function clickBind2(orderid) {
                alert(orderid)
                    //获取值
                    $.ajax({
                        url: "/pay/qc",
                        type: "post",
                        data:{
                            orderid: orderid
                        },
                        dataType: "json",
                        success: function (data) {
                            if (data.code=="3333"){
                                HuiFang.Funtishi("服务器故障！");
                            }else if (data.ResultCode=="0000" || data.ResultCode=="0003"){
                                HuiFang.Funtishi("圈存成功！");
                                window.location.href =data.url+"/pay1?id=13";
                            }else{
                                HuiFang.Funtishi(data.ResultMsg);
                            }
                        }
                    })
            }
            var HuiFang = {

                m_tishi: null,//全局变量 判断是否存在div,
                //提示div 等待2秒自动关闭
                Funtishi: function (content, url) {
                    if (HuiFang.m_tishi == null) {
                        HuiFang.m_tishi = '<div class="xiaoxikuang none" id="app_tishi" style="z-index:9999;left: 15%;width:70%;position: fixed;background:none;bottom:10%;"> <p class="app_tishi" style="background: none repeat scroll 0 0 #000; border-radius: 30px;color: #fff; margin: 0 auto;padding: 1.5em;text-align: center;width: 70%;opacity: 0.8; font-family:Microsoft YaHei;letter-spacing: 1px;font-size: 1.5em;"></p></div>';
                        $(document.body).append(HuiFang.m_tishi);
                    }
                    $("#app_tishi").show();
                    $(".app_tishi").html(content);
                    if (url) {
                        window.setTimeout("location.href='" + url + "'", 1500);
                    } else {
                        setTimeout('$("#app_tishi").fadeOut()', 1500);
                    }
                },
            }

        </script>
	</head>
	<body>
		  <header data-am-widget="header" class="am-header am-header-default jz" style="background-color: #f2f2f2">
		      <h1 class="am-header-title">
		          <a href="#title-link" class="" style="color: #333333">订单记录</a>
		      </h1>
           </header>
            <ul class="order" id="div_id">
				<#--数据-->
            </ul>
            <div style="height: 49px;"></div>
           <div data-am-widget="navbar" class="am-navbar  gm-foot am-no-layout" id="">
               <ul class="am-navbar-nav am-cf am-avg-sm-4">
                   <li class="">
                       <a href="/pay/pay1?id=12" class="">
                           <span class="am-icon-home"></span>
                           <span class="am-navbar-label">常用功能</span>
                       </a>
                   </li>
                   <li>
                       <a href="/pay/pay1?id=17" class="">
                           <span class="am-icon-th-large"></span>
                           <span class="am-navbar-label">我的云卡</span>
                       </a>
                   </li>
                   <li>
                       <a href="/pay/pay1?id=14" class="">
                           <span class="am-icon-user"></span>
                           <span class="am-navbar-label">个人中心</span>
                       </a>
                   </li>

               </ul>
		  </div>
	</body>
</html>
