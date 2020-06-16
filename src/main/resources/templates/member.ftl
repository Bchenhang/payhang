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
                refreshCount()
            });

            function pushHistory() {
                window.addEventListener("popstate", function(e) {
                    alert("后退");
                    self.location.reload();
                }, false);
                var state = {
                    title : "#",
                    url : "http://hang.nat100.top/pay/wechat/in?id=3"
                };
                window.history.replaceState(state, "#", "http://hang.nat100.top/pay/wechat/in?id=3");
            };
            function refreshCount() {
                $.ajax({
                    url: "/pay/tishi",
                    type: "post",
                    data:{},
                    dataType: "json",
                    success: function (data) {
                        if (data.ResultCode=="0000") {

                        }else{
                            HuiFang.Funtishi(data.ResultMsg);
                        }
                    }
                })
            }
            function clickBind1() {
                var r=confirm("是否解除绑定!");
                if (r==true)
                {
                    $.ajax({
                        url: "/pay/de2",
                        type: "post",
                        data:{},
                        dataType: "json",
                        success: function (data) {
                            if (data.code=="NO"){
                                window.location.href =data.url+"/wechat/authorize?id=1&appid="+data.appid;
                            }else if(data.code=="OK"){
                                window.location.href =data.url+"/qiehuan";
                            }
                        }
                    })
                }
            }
            function clickBind2() {
                var r=confirm("是否切换!");
                if (r==true)
                {
                    var a=document.getElementById("url").value;//获取输入框元素
                    window.location.href =a+"/qiehuan";//http://hang.nat100.top  http://xiyunserver.com
                    /*$.ajax({
                        url: "/pay/de2",
                        type: "post",
                        data:{},
                        dataType: "json",
                        success: function (data) {

                            if (data.code=="OK"){
                                window.location.href =data.url+"/wechat/authorize?id=1&appid="+data.appid;
                            }
                            if（）
                        }
                    })*/
                }
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
    <header data-am-widget="header" class="am-header am-header-default jz">
        <div class="am-header-left am-header-nav">
        </div>
        <h1 class="am-header-title">
            <a href="#title-link" class="">个人中心</a>
        </h1>
    </header>
            <div class="wo">
            	<img src="images/个人中心.png" />
            	<p><a href="#title-link">${(params.name)!''} <i class="am-icon-angle-right"></i></a></p>
            </div>
            <ul class="member">
            	<li>
            		<a href="#title-link">
                        <span>余额</span>
						<p style="color: rgba(243, 124, 5, 0.83)">￥${(params.Balance1)!''}</p>
            		</a>
            	</li>
                <li>
                    <span>状态</span>
			         <#if params.ResultCode=="0000">
                        <p>账户正常</p>
					 </#if>
					 <#if params.ResultCode=="0201">
                        <p>账户异常</p>
					 </#if>
                </li>
            </ul>
            <ul class="nav">
            	<li>
            		<a href="/pay/img3" onclick="">
            			<img src="images/采集照片.png" />
            			<span>采集照片</span>
            			<i class="am-icon-angle-right"></i>
            		</a>
            	</li>
            	<li>
            		<a href="/pay/pay1?id=21">
            			<img src="images/修改密码.png" />
            			<span>修改密码</span>
            			<i class="am-icon-angle-right"></i>
            		</a>
            	</li>
            </ul>
            <ul class="nav">
                <li>
                    <a href="#" onclick="clickBind2();return false;">
                        <img src="images/切换账户.png" />
                        <span>切换账户</span>
                        <i class="am-icon-angle-right"></i>
                    </a>
                </li>
                <li>
                    <a href="#" onclick="clickBind1();return false;">
                        <img src="images/解除绑定.png" />
                        <span>解除绑定</span>
                        <i class="am-icon-angle-right"></i>
                    </a>
                </li>
            	<li>
            		<a href="/pay/pay1?id=19">
            			<img src="images/关于我们.png" />
            			<span>关于我们</span>
            			<i class="am-icon-angle-right"></i>
            		</a>
            	</li>
            </ul>
            <input type="hidden" id="url" value="${(params.url)!''}">
            <div style="height: 49px;"></div>
            <div data-am-widget="navbar" class="am-navbar  gm-foot am-no-layout" id="">
                <ul class="am-navbar-nav am-cf am-avg-sm-4">
                    <li>
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
                    <li class="curr">
                        <a href="#title-link" class="curr">
                            <span class="am-icon-user"></span>
                            <span class="am-navbar-label">个人中心</span>
                        </a>
                    </li>
                </ul>
		  </div>
	</body>
</html>
