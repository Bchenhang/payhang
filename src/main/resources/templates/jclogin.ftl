<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <script type="text/javascript" src="js/jqueryy.min.js"></script>
    <script type="text/javascript" src="js/amazeui.min.js"></script>
    <link rel="stylesheet" href="css/amazeui.min.css" type="text/css"/>
    <link rel="stylesheet" href="css/stylee.css" type="text/css"/>
    <script type="text/javascript">
        //初始化运行加载
   /*     $(function () {
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
        function clickBind() {
                //获取值
                var name = $("#nickname").val();
                var pass = $("#mobile").val();
                if(name==""||pass==""){
                    HuiFang.Funtishi("用户名，工号，不能为空");
                    return false;
                }
                $.ajax({
                url: "/pay/de2",
                type: "post",
                data:{
                    name: name,
                    pass: pass
                },
                dataType: "json",
                success: function (data) {
                    if (data.code=="OK"){
                        HuiFang.Funtishi("解绑成功！");
                        window.location.href =data.url+"/wechat/authorize?id=1";
                    }else{
                        HuiFang.Funtishi("请输入正确的信息！");
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
<header data-am-widget="header" class="am-header am-header-default jz">
    <div class="am-header-left am-header-nav">
        <a href="javascript:history.back()" class="">
            <i class="am-icon-chevron-left"></i>
        </a>
    </div>
    <h1 class="am-header-title">
        <a href="#title-link" class="">接触绑定</a>
    </h1>
</header>
<div class="logo"><img src="images/logo.png"/></div>
<#--<input type="hidden" value="${params.openId}" id="login-op"/>-->
<input type="text" required="required" name="nickname" id="nickname" placeholder="请输入用户名" class="login-name">
<br>
<input type="text" required="required" name="mobile" id="mobile" placeholder="请输入工号" class="login-password">
<br>
<input type="button" value="解绑" class="money-btn"  onclick="clickBind()">
</p>
</body>
</html>

