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
            refreshCount();
        })
          $(document).ready(function(){
                  //循环执行，每隔30秒钟执行一次 1000
              window.setInterval(refreshCount, 60000);
              refreshCount();
                  //去掉定时器的方法
              });
        function refreshCount() {
            $.ajax({
                url: "/pay/reCode",
                type: "post",
                data:{},
                dataType: "json",
                success: function (data) {
                    if (data.code=="OK") {
                        $("#mg").attr("src","data:image/png;base64,"+data.img);
                        document.getElementById("name").innerText = data.name;
                        document.getElementById("kh").innerText = data.CardNo;
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
    <div class="am-header-left am-header-nav">
    </div>
    <h1 class="am-header-title">
        <a href="#title-link" class="" style="color: #333333">我的云卡</a>
    </h1>
</header>
<div class="banner" align="center"><h2>姓名：<span id="name"></span> 卡号：<span id="kh"></span></h2></div>
<h1 class="am-header-title" align="center">
    <img id="mg" src="">
</h1>
<div class="banner" align="center"><h1>扫码刷卡</h1></div>
<div class="banner" align="center"><h3 style="color: #e61c16">1、扫码时请对准摄像头，距离0-10CM</h3></div>
<div class="banner" align="center"><h3 style="color: #e61c16">2、二维码自动刷新，连续使用请刷新二维码</h3></div>

<div class="reg2" align="center">
    <input type="button" value="刷新" class="money-btn"  onclick="refreshCount()">
</div>
<div style="height: 49px;"></div>
<div data-am-widget="navbar" class="am-navbar  gm-foot am-no-layout" id="">
    <ul class="am-navbar-nav am-cf am-avg-sm-4">
        <li>
            <a href="/pay/pay1?id=12" class="">
                <span class="am-icon-home"></span>
                <span class="am-navbar-label">常用功能</span>
            </a>
        </li>
        <li class="curr">
            <a href="#title-link" class="curr">
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
