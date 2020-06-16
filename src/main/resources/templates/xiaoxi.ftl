<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title></title>
        <meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0" name="viewport"/>
        <meta content="yes" name="apple-mobile-web-app-capable"/>
        <meta content="black" name="apple-mobile-web-app-status-bar-style"/>
        <meta content="telephone=no" name="format-detection"/>
        <link href="css/stylexiaoxi.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="js/jquery.min.js"></script>
        <script type="text/javascript">
            $(function () {
                click();
            });
            function click() {
                var js='';
                var j=1;
                    $.ajax({
                        url: "/pay/xx",
                        type: "post",
                        data:{},
                        dataType: "json",
                        success: function (data) {
                            if (data.list!= "") {
                                for (var o in data.list) {
                                    js +='<a href="javascript:;" class="aui-flex" style="border-bottom:1px solid #e2e2e2">\n' +
                                            '<div class="aui-flex-box">\n' +
                                            '<h1><span style="font-size: 15px;color: black">'+data.list[o].title+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-size: 15px;color: #8c8c8c;font-weight: normal">'+data.list[o].notifytime+'</span></span></h1>\n' +
                                            '<span style="font-size: 15px;color: #8c8c8c;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+data.list[o].content+'</span>\n' +
                                            '<div class="aui-camp-module" style="float:right">\n' +
                                            '<p></p><p></p><p></p><p></p>\n' +
                                            '<span class="aui-camp-module-two">'+data.list[o].remark+'</span>\n' +
                                            '</div>\n' +
                                            '</div>\n' +
                                            '</a>';
                                }
                                document.getElementById("div_id").innerHTML = js;
                            }else{
                                var h='<div align="center">\n' +
                                        '<p style="width: 120px; height: 30px; padding-top: 80px"><h1>当前三天没有记录</h1></p>\n' +
                                        '</div>';
                                document.getElementById("div_id").innerHTML = h;
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

        <!--

         * 17素材vip建站专区模块代码
         * 详尽信息请看官网：http://www.17sucai.com/pins/vip
         *
         * Copyright , 温州易站网络科技有限公司版权所有
         *
         * 请尊重原创，未经允许请勿转载。
         * 在保留版权的前提下可应用于个人或商业用途

        -->

        <section class="aui-flexView">
            <header class="aui-navBar aui-navBar-fixed b-line" style="background-color: #f2f2f2">

                <div class="aui-center" >
                    <span class="aui-center-title">消息通知</span>
                </div>
                <a href="javascript:;" class="aui-navBar-item">
                    <i class="icon icon-sys"></i>
                </a>
            </header>
            <section class="aui-scrollView">
                <div class="aui-camp-content"  style="padding-left:0px; line-height:30px;" id="div_id">

                </div>
            </section>
        </section>

    </body>
</html>
