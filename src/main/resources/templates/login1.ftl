<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <script type="text/javascript" src="js/jqueryy.min.js"></script>
    <script type="text/javascript" src="js/amazeui.min.js"></script>
    <link rel="stylesheet" href="css/amazeui.min.css" type="text/css"/>
    <link rel="stylesheet" href="css/styleelogin.css" type="text/css"/>
    <script type="text/javascript">
        $(function () {

         /*   refreshCount()*/
        });
        function refreshCount() {
            $.ajax({
                url: "/pay/tishi",
                type: "post",
                data:{},
                dataType: "json",
                success: function (data) {
                    if (data.ResultCode=="0000" || data.ResultCode=="0201") {
                        HuiFang.Funtishi("账户已绑定！");
                        window.location.href =data.url+"/wechat/pay1?id=12";
                    }else  if (data.code=="ON") {
                        HuiFang.Funtishi("服务器故障！");
                    } else if (data.code=="3333") {
                    }else{
                        HuiFang.Funtishi(data.ResultMsg);
                    }

                }
            })
        }
        function clickBind() {
                //获取值
                var name = $("#mobile").val();
                var iccid = $("#nickname").val();
                var pass = $("#password").val();
                if(name==""||pass==""){
                    HuiFang.Funtishi("用户名，工号，密码，不能为空");
                    return false;
                }
                $.ajax({
                    url: "/pay/wan",
                    type: "post",
                    data:{
                        name: name,
                        iccid:iccid,
                        pass: pass
                    },
                    dataType: "json",
                    success: function (data) {
                        if (data.code=="OK" && data.ResultCode=="0000" || data.ResultCode=="0201"){
                            HuiFang.Funtishi("绑定成功！");
                            window.location.href =data.url+"/pay1?id=12";
                        }else if (data.code=="CN" && data.ResultCode=="0000" || data.ResultCode=="0201") {
                            HuiFang.Funtishi("绑定成功！");
                            window.location.href =data.url+"/pay1?id=12";
                        }else if (data.code=="ON"){
                            HuiFang.Funtishi("服务器故障");
                        }else{
                            HuiFang.Funtishi(data.ResultMsg);
                        }
                    }
                })
          }
        function clickBind3() {
            window.location.href="http://hang.nat100.top/pay/fangke";
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
    <h1 class="am-header-title">
        <a href="#title-link" class="">账号绑定</a>
    </h1>
</header>
<div class="logo"><img src="images/登录.png"/></div>
<input type="text" required="required" name="nickname" id="nickname" placeholder="请输入工号" class="login-password" >
<br>
<input type="password" required="required" name="mobile" id="password" placeholder="请输入密码" class="login-name">
<br>
<input type="text" required="required" name="mobile" id="mobile" placeholder="请输入用户名" class="login-password">
<br>
<input type="button" value="绑定/登入" class="money-btn"  onclick="clickBind()" style="background-color: #5d94fb">

<#--<input type="button" value="访客入口" class="money-btn"  onclick="clickBind3()" style="background-color: #5d94fb">-->

</p>
</body>
</html>

