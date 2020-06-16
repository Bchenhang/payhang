<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
		<script type="text/javascript" src="/pay/js/jquery.min.js" ></script>
		<script type="text/javascript" src="/pay/js/amazeui.min.js"></script>
		<link rel="stylesheet" href="/pay/css/amazeui.min.css" type="text/css" />
		<link rel="stylesheet" href="/pay/css/stylee.css" type="text/css" />
        <script type="text/javascript">
           /* $(function () {
                var system = {};
                var p = navigator.platform;
                var u = navigator.userAgent;
                system.win = p.indexOf("Win") == 0;
                system.mac = p.indexOf("Mac") == 0;
                system.x11 = (p == "X11") || (p.indexOf("Linux") == 0);
                if (system.win || system.mac || system.xll) {//如果是PC转
                    if (u.indexOf('Windows Phone') > -1) {  //win手机端

                    }
                    else {
                        window.location.href = "Expires.aspx?error=1";
                    }
                }
            })*/
           $(function(){
               clickBind();
           });
           function clickBind() {
               var js='';
               //获取值
               $.ajax({
                   url: "/pay/wechat/kongzhi",
                   type: "post",
                   data:{},
                   dataType: "json",
                   success: function (data) {
                       if (data.HomePic != "") {
                           js += ' <div class="banner"><img src="' + data.HomePic + '"/></div>\n' +
                                   '<ul class="menu" style="background-color: #f9f8f7">';
                       } else {
                           js += ' <div class="banner"><img src="/pay/images/主页.jpg"/></div>\n' +
                                   '<ul class="menu" style="background-color: #f9f8f7">';
                       }
                       if (data.module.substring(0, 1) == "1") {
                           js += '  <li>\n' +
                                   '\t            \t<div class="am-gallery-item">\n' +
                                   '\t\t\t\t\t\t<a href="/pay/pay1?id=1" class="">\n' +
                                   '\t\t\t\t\t\t\t<img src="/pay/images/充值.jpg">\n' +
                                   '\t\t\t\t\t\t\t<p>账户充值</p>\n' +
                                   '\t\t\t\t\t\t</a>\n' +
                                   '\t\t\t\t\t</div>\n' +
                                   '\t\t\t\t</li>';
                       }
                       if (data.module.substring(1, 2) == "1") {
                           js += '\t\t\t\t<li>\n' +
                                   '\t\t\t\t\t<div class="am-gallery-item">\n' +
                                   '\t\t\t\t\t\t<a href="/pay/pay1?id=2" class="">\n' +
                                   '\t\t\t\t\t\t\t<img src="/pay/images/交易记录.jpg">\n' +
                                   '\t\t\t\t\t\t\t<p>交易记录</p>\n' +
                                   '\t\t\t\t\t\t</a>\n' +
                                   '\t\t\t\t\t</div>\n' +
                                   '\t\t\t\t</li>';
                       }
                       if (data.module.substring(2, 3) == "1") {
                           js += '\t\t\t\t<li>\n' +
                                   '\t\t\t\t\t<div class="am-gallery-item">\n' +
                                   '\t\t\t\t\t\t<a href="/pay/pay1?id=3" class="">\n' +
                                   '\t\t\t\t\t\t\t<img src="/pay/images/挂失解挂.jpg">\n' +
                                   '\t\t\t\t\t\t\t<p>挂失解挂</p>\n' +
                                   '\t\t\t\t\t\t</a>\n' +
                                   '\t\t\t\t\t</div>\n' +
                                   '\t\t\t\t</li>';
                       }
                       if (data.module.substring(3, 4) == "1") {
                           js += '\t\t\t\t<li>\n' +
                                   '\t\t\t\t\t<div class="am-gallery-item">\n' +
                                   '\t\t\t\t\t\t<a href="/pay/pay1?id=4" class="demo_datetime" >\n' +
                                   '\t\t\t\t\t\t\t<img src="/pay/images/订餐.jpg">\n' +
                                   '\t\t\t\t\t\t\t<p>订餐</p>\n' +
                                   '\t\t\t\t\t\t</a>\n' +
                                   '\t\t\t\t\t</div>\n' +
                                   '\t\t\t\t</li>';
                       }
                       if (data.module.substring(4, 5) == "1") {
                           js += '                <li>\n' +
                                   '                    <div class="am-gallery-item">\n' +
                                   '                        <a href="/pay/pay1?id=20" class="">\n' +
                                   '                            <img src="/pay/images/手工签到.jpg">\n' +
                                   '                            <p>手工签到</p>\n' +
                                   '                        </a>\n' +
                                   '                    </div>\n' +
                                   '                </li>';
                       }
                       if (data.kind==0) {
                       if (data.module.substring(5, 6) == "1") {
                           js += '\t\t\t\t<li>\n' +
                                   '\t\t\t\t\t<div class="am-gallery-item">\n' +
                                   '\t\t\t\t\t\t<a href="/pay/pay1?id=9" class="">\n' +
                                   '\t\t\t\t\t\t\t<img src="/pay/images/请假.jpg">\n' +
                                   '\t\t\t\t\t\t\t<p>请假</p>\n' +
                                   '\t\t\t\t\t\t</a>\n' +
                                   '\t\t\t\t\t</div>\n' +
                                   '\t\t\t\t</li>';
                       }
                       }
                       if (data.kind==0) {
                           js += '\t\t\t\t<li>\n' +
                                   '\t\t\t\t\t<div class="am-gallery-item">\n' +
                                   '\t\t\t\t\t\t<a href="/pay/pay1?id=99" class="">\n' +
                                   '\t\t\t\t\t\t\t<img src="/pay/images/请假记录.png">\n' +
                                   '\t\t\t\t\t\t\t<p>请假记录</p>\n' +
                                   '\t\t\t\t\t\t</a>\n' +
                                   '\t\t\t\t\t</div>\n' +
                                   '\t\t\t\t</li>';
                       }else if (data.kind==1) {
                           js += '\t\t\t\t<li>\n' +
                                   '\t\t\t\t\t<div class="am-gallery-item">\n' +
                                   '\t\t\t\t\t\t<a href="/pay/pay1?id=99" class="">\n' +
                                   '\t\t\t\t\t\t\t<img src="/pay/images/请假审核.png">\n' +
                                   '\t\t\t\t\t\t\t<p>请假审核</p>\n' +
                                   '\t\t\t\t\t\t</a>\n' +
                                   '\t\t\t\t\t</div>\n' +
                                   '\t\t\t\t</li>';
                       }
                       if (data.module.substring(6, 7) == "1") {
                           js += '                <li>\n' +
                                   '                    <div class="am-gallery-item">\n' +
                                   '                        <a href="/pay/pay1?id=8" class="">\n' +
                                   '                            <img src="/pay/images/打卡明细.jpg">\n' +
                                   '                            <p>打卡明细</p>\n' +
                                   '                        </a>\n' +
                                   '                    </div>\n' +
                                   '                </li>';
                       }
                       if (data.module.substring(7, 8) == "1") {
                           js += '                <li>\n' +
                                   '                    <div class="am-gallery-item">\n' +
                                   '                        <a href="/pay/pay1?id=11" class="">\n' +
                                   '                            <img src="/pay/images/日报表.jpg">\n' +
                                   '                            <p>日报表</p>\n' +
                                   '                        </a>\n' +
                                   '                    </div>\n' +
                                   '                </li>';
                       }
                       if (data.module.substring(8, 9) == "1") {
                           js += '\t\t\t\t<li>\n' +
                                   '\t\t\t\t\t<div class="am-gallery-item">\n' +
                                   '\t\t\t\t\t\t<a href="/pay/pay1?id=7" class="">\n' +
                                   '\t\t\t\t\t\t\t<img src="/pay/images/通行足迹.jpg">\n' +
                                   '\t\t\t\t\t\t\t<p>通行足迹</p>\n' +
                                   '\t\t\t\t\t\t</a>\n' +
                                   '\t\t\t\t\t</div>\n' +
                                   '\t\t\t\t</li>';
                       }
                       if (data.module.substring(9, 10) == "1") {
                           js += '                <li>\n' +
                                   '                    <div class="am-gallery-item">\n' +
                                   '                        <a href="/pay/pay1?id=10" class="">\n' +
                                   '                            <img src="/pay/images/远程开门.jpg">\n' +
                                   '                            <p>远程开门</p>\n' +
                                   '                        </a>\n' +
                                   '                    </div>\n' +
                                   '                </li>';
                       }
                       if (data.module.substring(10, 11) == "1") {
                           js += '                <li>\n' +
                                   '                    <div class="am-gallery-item">\n' +
                                   '                        <a href="/pay/pay1?id=15" class="">\n' +
                                   '                            <img src="/pay/images/消息通知.jpg">\n' +
                                   '                            <p>消息通知</p>\n' +
                                   '                        </a>\n' +
                                   '                    </div>\n' +
                                   '                </li>';
                       }
                        if (data.kind==1) {
                       js += '\t\t\t\t<li>\n' +
                               '\t\t\t\t\t<div class="am-gallery-item">\n' +
                               '\t\t\t\t\t\t<a href="#title-link" class="">\n' +
                               '\t\t\t\t\t\t\t<img src="/pay/images/更多.jpg">\n' +
                               '\t\t\t\t\t\t\t<p>更多</p>\n' +
                               '\t\t\t\t\t\t</a>\n' +
                               '\t\t\t\t\t</div>\n' +
                               '\t\t\t\t</li>';
                        }
                           js += '            </ul>';
                           document.getElementById("div_id").innerHTML = js;
                   }
               })
           }
        </script>
	</head>
	<body>
		  <header data-am-widget="header" class="am-header am-header-default jz">
		      <h1 class="am-header-title">
		          <a href="#title-link" class="">常用功能</a>
		      </h1>
            </header>
             <div id="div_id" style="background-color: #f9f8f7">
			<#--内容-->
			 </div>
            <div style="height: 49px;"></div>
            <div data-am-widget="navbar" class="am-navbar  gm-foot am-no-layout" id="">
		      <ul class="am-navbar-nav am-cf am-avg-sm-4">
		          <li class="curr">
		            <a href="#title-link" class="curr">
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
          <script>

          </script>
	</body>
</html>
