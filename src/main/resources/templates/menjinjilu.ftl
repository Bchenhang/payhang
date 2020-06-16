<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0">
    <title></title>
<#---->
    <script src="jquery/common.js"></script>
    <script src="jquery/mescroll.js"></script>
    <script src="jquery/mescroll-option.js"></script>
<#---->
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/mobiscroll.custom.min.js"></script>
<#---->
    <link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="css/mescroll.css">
    <link rel="stylesheet" href="css/mescroll-option.css">
<#---->
    <link href="css/mobiscroll.custom.min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="js/amazeui.min.js"></script>
    <link rel="stylesheet" href="css/amazeui.min.css" type="text/css" />
    <link rel="stylesheet" href="css/stylee.css" type="text/css" />

    <script type="text/javascript">
        $(function () {
            var myDate = new Date();
            var nowY = myDate.getFullYear();
            var nowM = myDate.getMonth()+1;
            var nowD = myDate.getDate();
            var enddate = nowY+"-"+(nowM<10 ? "0" + nowM : nowM)+"-"+(nowD<10 ? "0"+ nowD : nowD);//当前日期
            $("#endTime").attr("value",enddate);
            $("#statrTime").attr("value",enddate);
            click(enddate,enddate);
        });
        function clickBind(){
            var krq = $("#statrTime").val();
            var jrq = $("#endTime").val();

            click(krq,jrq);
        }
        function CompareDate(d1,d2)
        {
            return ((new Date(d1.replace(/-/g,"\/"))) > (new Date(d2.replace(/-/g,"\/"))));
        }
        function click(krq,jrq) {
            var js="";
            var k="";
            //获取值
            if (krq==""||jrq==""){
                HuiFang.Funtishi("查询日期，不能为空");
            } else{
                krq+=" 00:00:00";
                jrq+=" 23:59:59";
                if (CompareDate(jrq,krq)) {
                    $.ajax({
                        url: "/pay/menjinjilu",
                        type: "post",
                        data: {
                            krq: krq,
                            jrq: jrq
                        },
                        dataType: "json",
                        success: function (data) {
                            if (data.list != "") {
                                for (var o in data.list) {
                                    js += '<div class="cp_dtls" >\n' +
                                            '<div class="cp_desc">\n' +
                                            '<div class="cp_price"><span style="font-size:20px">&nbsp;&nbsp;' + data.name + '</span></div>\n' +
                                            '<div class="cp_dtl clearfix">\n' +
                                            '<span style="color:#595959; font-size:14px">&nbsp;&nbsp;&nbsp;工号：' + data.list[o].iccid + '</span>\n' +
                                            '<span style="color:#595959; font-size:14px">&nbsp;&nbsp;&nbsp;时间：' + data.list[o].attendtime + '</span>\n' +
                                            '<span style="color:#595959; font-size:14px">&nbsp;&nbsp;&nbsp;终端号：' + data.list[o].clockno + '</span>\n' +
                                            '</div></div>';
                                    if (data.list[o].urlimage == "" || data.list[o].urlimage == null) {
                                        k = '<div class="cp_img">\n' +
                                                '<img src="images/touxiang.png" alt="">\n' +
                                                '</div>\n' +
                                                '</div>';
                                        js += k;
                                    } else {
                                        k = '<div class="cp_img">\n' +
                                                '<img src="' + data.list[o].urlimage + '" alt="">\n' +
                                                '</div>\n' +
                                                '</div>';
                                        js += k;
                                    }
                                }
                                document.getElementById("div_id").innerHTML = js;
                                HuiFang.Funtishi("操作成功");
                            } else {
                                var h = '<div align="center">\n' +
                                        '<p style="width: 120px; height: 30px; padding-top: 80px"><h1>当期时间没有记录</h1></p>\n' +
                                        '</div>';
                                document.getElementById("div_id").innerHTML = h;
                                HuiFang.Funtishi("无记录");
                            }
                        }
                    })
                }else{
                    HuiFang.Funtishi("查询时间不规范！");
                }
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

    <style>
        .section {
            position: relative;
            height: 32px;
            padding-left: 13px;
            padding-right: 15px;
            margin-bottom: 10px;
            box-sizing: border-box;
            position: relative;
            top: 7px;
        }
        .section label {
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            height: 32px;
            line-height: 32px;
            font-size: 12px;
        }
        .section>select,  .section>input {
            width: 100%;
            height: 100%;
            display: block;
            padding: 0 10px;
            box-sizing: border-box;
        }
        .download-tip {
            z-index: 9900;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 24px;
            line-height: 24px;
            font-size: 12px;
            text-align: center;
            background-color: rgba(80, 175, 85, .7);
            color: white;
            display: none;
            -webkit-transition: top 300ms;
            transition: top 300ms;
        }

        /*展示上拉加载的数据列表*/
        .news-list li {
            padding: 16px;
            border-bottom: 1px solid #eee;
        }

        .news-list .new-content {
            font-size: 14px;
            margin-top: 6px;
            margin-left: 10px;
            color: #666;
        }
        .cp_dtls{

            border:1px solid  #dddddd;
            border-top-left-radius:1em;
            border-top-right-radius:1em;
            border-bottom-right-radius:0em;
            border-bottom-left-radius:0em;

        }

    </style>
</head>
<body>

<header  data-am-widget="header" class="am-header am-header-default jz" style="background-color: #f2f2f2">

    <h1 class="am-header-title">
        <a href="#title-link" class="" style="color: #333333">门禁记录</a>
    </h1>
    <div class="section">
        <input type="text" class="demo_date" id="statrTime" value="" style="border:0.5px solid #ddd;"/>
    </div>
    <!-- Date & Time demo markup -->
    <div class="section">
        <input type="text" class="demo_date" id="endTime"  value=""  style="border:0.5px solid #ddd"/>
    </div>
    <div align="center">
        <input type="button" value="查  询" onclick="clickBind()" style="width: 120px; height: 30px;BORDER-RIGHT: #7b9ebd 1px solid; BORDER-TOP: #7b9ebd 1px solid;BORDER-LEFT: #7b9ebd 1px solid; BORDER-BOTTOM: #7b9ebd 1px solid;background-color:#1465f8;color: #f2f2f2"/>
    </div>
</header>
<#---->
<div class="pan_list" data-toggle="large">
    <!--展示上拉加载的数据列表-->
    <div class="cp_dtl_list" id="div_id" style="padding-top: 180px">
    <#--滚屏-->

        <div id="newsList" class="news-list">
        </div>
    </div>
</div>
<#---->
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
<script type="text/javascript">
    $(function () {

    });

    var theme = "ios";
    var mode = "scroller";
    var display = "bottom";
    var lang="zh";


    // Select demo initialization
    $('#demo_select').mobiscroll().select({
        theme: theme,     // Specify theme like: theme: 'ios' or omit setting to use default
        mode: mode,       // Specify scroller mode like: mode: 'mixed' or omit setting to use default
        display: display, // Specify display mode like: display: 'bottom' or omit setting to use default
        lang: lang        // Specify language like: lang: 'pl' or omit setting to use default
    });


    // Date demo initialization
    $('.demo_date').mobiscroll().date({
        theme: theme,
        mode: mode,
        display: display,
        dateFormat:"yyyy-mm-dd",
        lang: lang
    });
    // Date & Time demo initialization
    $('.demo_datetime').mobiscroll().datetime({
        theme: theme,
        mode: mode,
        display: display,
        lang: lang,
        dateFormat:"yyyy-mm-dd",
        minDate: new Date(2000,3,10,9,22),
        maxDate: new Date(2030,7,30,15,44),
        stepMinute: 1
    });

    // Time demo initialization
    $('.demo_time').mobiscroll().time({
        theme: theme,
        mode: mode,
        display: display,
        lang: lang
    });
</script>
</body>
</html>
