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
        function clickBind2() {
            var r=confirm("是否挂失账户!");
            if (r==true)
            {
                //获取值
                $.ajax({
                    url: "/pay/guashi",
                    type: "post",
                    data:{
                        code: "102"
                    },
                    dataType: "json",
                    success: function (data) {
                        if (data.code=="OK"){
                            window.location.href =data.url+"/pay1?id=3";
                        }
                    }
                })
            }
        }
        function clickBind3() {
            var r=confirm("是否解除挂失!");
            if (r==true)
            {
                //获取值
                $.ajax({
                    url: "/pay/guashi",
                    type: "post",
                    data:{
                        code: "103"
                    },
                    dataType: "json",
                    success: function (data) {
                        if (data.code=="OK"){
                            window.location.href =data.url+"/pay1?id=3";
                        }
                    }
                })
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
<header data-am-widget="header" class="am-header am-header-default jz" style="background-color: #f2f2f2">

    <h1 class="am-header-title">
        <a href="#title-link" class="" style="color: #333333">挂失/解挂</a>
    </h1>
</header>
<ul class="near">
    <li>
        <div class="pic"><img src="images/pic.png"/></div>
        <div class="text">
            <h2><i></i><span>${(params.name)!''}</span></h2>
            <p>${(params.isshool)!''}：<span>${(params.pass)!''}</span></p>
             <#if params.ResultCode=="0201">
             <p>状态：账户已挂失</p>
             </#if>
             <#if params.ResultCode=="0000">
             <p>状态：账户正常</p>
             </#if>
        </div>
        <#if params.ResultCode=="0000">
        <button type="button" class="ture" onclick="clickBind2()">挂失账户</button>
        </#if>
        <#if params.ResultCode=="0201">
        <button type="button" class="ture" onclick="clickBind3()">解除挂失</button>
        </#if>
    </li>
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
                <span class="am-nav"></span>
            </a>
        </li>
    </ul>
</div>
</body>
</html>
