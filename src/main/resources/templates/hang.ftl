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

            })
            function cla(time) {
              alert("1="+time)

            }
        </script>
	</head>
	<body>
		  <header data-am-widget="header" class="am-header am-header-default jz">
		      <div class="am-header-left am-header-nav">
		         <a href="javascript:history.back()" class="">
					<i class="am-icon-chevron-left"></i>
				</a>
		      </div>
		      <h1 class="am-header-title">
		          <a href="#title-link" class="">交易记录</a>
		      </h1>
           </header>
          <div class="hang" style="width:350px;height:50px;">
              <div><a>开始时间：</a><input type="date" style=" width:100px;height:20px; border:1px solid #378888">
          </div>
            <ul class="order">
            		<#list params as  index>
                        <li>
                            <h2><i></i><span id="hang">日期：${index.TradeTime}</span><b>余额：${index.Balance?number/100}</b></h2>
                            <p><img src="images/add.png"/><span>交易金额：${index.Amount?number/100}</span></p>
                            <p style="border-bottom: 1px solid #ddd;">
                                <img src="images/time.png"/>
                                <span style="border-bottom: 0;">交易类型：<#if index.Kind=="C">消费</#if>
								<#if index.Kind=="R">充值</#if>
								<#if index.Kind=="T">微信第三方充值</#if>
								<#if index.Kind=="B">退款</#if>
								<#if index.Kind=="G">更正</#if></span>
                            </p>
                        </li>
					</#list>
				</#if>
            </ul>
            <div style="height: 49px;"></div>
            <div data-am-widget="navbar" class="am-navbar  gm-foot am-no-layout" id="">
		      <ul class="am-navbar-nav am-cf am-avg-sm-4">
		          <li>
		            <a href="dc.ftl" >
		                <span class="am-icon-home"></span>
		                <span class="am-navbar-label">常用功能</span>
		            </a>
		          </li>
		          <li class="curr">
		            <a href="order.html" >
		                <span class="am-icon-th-large"></span>
		                <span class="am-navbar-label">我的云卡</span>
		            </a>
		          </li>
		          <li>
		            <a href="member.html" class="">
		                <span class="am-icon-user"></span>
		                <span class="am-navbar-label">个人中心</span>
		            </a>
		          </li>
		          
		      </ul>
		  </div>
	</body>
</html>
