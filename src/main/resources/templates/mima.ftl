<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1" />
    <title></title>
    <link rel="stylesheet" href="css/new_file.css" type="text/css"/>
    <link href="css/mobiscroll.custom.min.css" rel="stylesheet" type="text/css" />
    <style>

        input {
            width: 100%;
            height: 100%;
            display: block;
            padding: 0 10px;
            border: 0;  // 去除未选中状态边框
        }
    </style>
</head>

<body >
<!--头部  star-->
<header style="color:#fff">
    <span style="font-size: 21px">修改密码</span>
</header>
<!--头部 end-->

<!--内容 star-->
<div class="contaniner fixed-cont">
    <!--1-->
    <div class="tkyy">&nbsp;&nbsp;&nbsp;旧密码<span>*</span></div>
    <div class="assess_nr" style="text-align:center;">
        <input type="password" class="" id="password1" maxlength="6" onkeyup="value=value.replace(/[^\w\.\/]/ig,'')" placeholder="请输入6位数字或字母"/>
    </div>
    <div class="tkyy">&nbsp;&nbsp;&nbsp;新密码<span>*</span></div>
    <div class="assess_nr">
        <input type="password" class="" id="password2"  style="outline:none;" maxlength="6" onkeyup="value=value.replace(/[^\w\.\/]/ig,'')" placeholder="请输入6位数字或字母"/>
    </div>
    <div class="tkyy">&nbsp;&nbsp;&nbsp;确认密码<span>*</span></div>
    <div class="assess_nr">
        <input type="password" class="" id="password3"  style="outline:none;" maxlength="6" onkeyup="value=value.replace(/[^\w\.\/]/ig,'')" placeholder="请输入6位数字或字母"/>
    </div>
    <!--2-->
    <a href="#" onclick="clickBind()"><div class="submit_button">修改密码</div></a>


</div>

<!--内容 end-->

<script type="text/javascript" src="js/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="js/jquery.selectbox-0.2.js"></script>


<!-- Mobiscroll JS and CSS Includes -->
<script type="text/javascript" src="js/mobiscroll.custom.min.js"></script>
<script type="text/javascript">
  /*  var xxx = document.getElementById('password2');
    setInterval(function(){
        xxx.scrollIntoView(false);
    },200)*/
    function clickBind() {
        var password1 = $("#password1").val();
        var password2 = $("#password2").val();
        var password3 = $("#password3").val();
        //获取值
        if (password1==""||password2=="" ||password3==""){
            HuiFang.Funtishi("请完善信息");
        } else{
            if (password2==password3) {
                $.ajax({
                    url: "/pay/mima",
                    type: "post",
                    data:{
                        password1 : password1, password2 : password2
                    },
                    dataType: "json",
                    success: function (data) {
                        if (data.ResultCode=="0000"){
                            HuiFang.Funtishi("修改成功！");
                            window.location.href =data.url+"/wechat/authorize?id=1&appid="+data.appid;
                        }else{
                            HuiFang.Funtishi(data.ResultMsg);
                        }
                    }
                })
            }else{
                HuiFang.Funtishi("密码不一致");
            }

            /* window.location.href ="/pay/kaoqingjilu?krq="+krq+"&jrq="+jrq;*/
        }

    }
    $(function () {
        $("[name='country']").selectbox({
            effect:"fade"
        });

        $("[name='position']").selectbox({
            effect:"slide"
        });
    });
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
</body>
</html>