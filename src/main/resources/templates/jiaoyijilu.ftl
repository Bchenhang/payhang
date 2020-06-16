<!DOCTYPE html>
<html lang="en">
    <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0">
    <title></title>
        <script type="text/javascript" src="js/jquery.min.js"></script>
        <script type="text/javascript" src="js/mobiscroll.custom.min.js"></script>
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
                                            var m="";
                                            //获取值
                                            if (krq==""||jrq==""){
                                                HuiFang.Funtishi("查询日期，不能为空");
                                            } else {
                                                krq += " 00:00:00";
                                                jrq += " 23:59:59";
                                                if (CompareDate(jrq, krq)){
                                                    $.ajax({
                                                        url: "/pay/jiaoyijilu",
                                                        type: "post",
                                                        data: {
                                                            krq: krq,
                                                            jrq: jrq
                                                        },
                                                        dataType: "json",
                                                        success: function (data) {
                                                            if (data.list != "") {
                                                                for (var o in data.list) {
                                                                    js += '<li>\n' +
                                                                            '<h2><i></i><span id="hang">交易类型：';
                                                                    if (data.list[o].flag == 1) {
                                                                        m = '现金充值';
                                                                    } else if (data.list[o].flag == 2) {
                                                                        m = '充值赠送';
                                                                    } else if (data.list[o].flag == 3) {
                                                                        m = '终端充值';
                                                                    } else if (data.list[o].flag == 4) {
                                                                        m = '一般补贴';
                                                                    } else if (data.list[o].flag == 5) {
                                                                        m = '清零补偿';
                                                                    } else if (data.list[o].flag == 6) {
                                                                        m = '微信充值';
                                                                    } else if (data.list[o].flag == 7) {
                                                                        m = '支付宝充值';
                                                                    } else if (data.list[o].flag == 8) {
                                                                        m = '银行转账';
                                                                    } else if (data.list[o].flag == 9) {
                                                                        m = '其他充值';
                                                                    } else if (data.list[o].flag == 10) {
                                                                        m = '开卡收押金';
                                                                    }else if (data.list[o].flag == 11) {
                                                                        m = '补办收押金';
                                                                    } else if (data.list[o].flag == 12) {
                                                                        m = '清零补现金';
                                                                    } else if (data.list[o].flag == 13) {
                                                                        m = '冲正扣补贴';
                                                                    }else if (data.list[o].flag == 14) {
                                                                        m = '冲正扣现金';
                                                                    }else if (data.list[o].flag == 15) {
                                                                        m = '圈存到账';
                                                                    }else if (data.list[o].flag == 20) {
                                                                        m = '现金转账';
                                                                    } else if (data.list[o].flag == 21) {
                                                                        m = '补贴转账';
                                                                    } else if (data.list[o].flag == 30) {
                                                                        m = '更正退现金';
                                                                    } else if (data.list[o].flag == 31) {
                                                                        m = '更正退补贴';
                                                                    } else if (data.list[o].flag == 32) {
                                                                        m = '消费现金返还';
                                                                    } else if (data.list[o].flag == 33) {
                                                                        m = '消费补贴返还';
                                                                    } else if (data.list[o].flag == -1) {
                                                                        m = '消费';
                                                                    } else if (data.list[o].flag == -2) {
                                                                        m = '消费现金';
                                                                    } else if (data.list[o].flag == -3) {
                                                                        m = '消费补贴';
                                                                    } else if (data.list[o].flag == -4) {
                                                                        m = '清补贴';
                                                                    } else if (data.list[o].flag == -5) {
                                                                        m = '订餐';
                                                                    } else if (data.list[o].flag == -6) {
                                                                        m = '消费';
                                                                    } else if (data.list[o].flag == -7) {
                                                                        m = '记账';
                                                                    } else if (data.list[o].flag == -8) {
                                                                        m = '计次';
                                                                    } else if (data.list[o].flag == -10) {
                                                                        m = '退押金';
                                                                    } else if (data.list[o].flag == -20) {
                                                                        m = '现金转账';
                                                                    } else if (data.list[o].flag == -21) {
                                                                        m = '补贴转账';
                                                                    } else if (data.list[o].flag == -30) {
                                                                        m = '补录扣现金';
                                                                    } else if (data.list[o].flag == -31) {
                                                                        m = '补录扣补贴';
                                                                    } else if (data.list[o].flag == -32) {
                                                                        m = '充值纠错';
                                                                    }
                                                                    js += m;
                                                                    k = '</span>\n' +
                                                                            '<b>余额：' + data.list[o].balance + '</b></h2>\n' +
                                                                            '<p><img src="images/金额小图片.png"/><span>交易金额：' + data.list[o].amount + '</span></p>\n' +
                                                                            ' <p style="border-bottom: 1px solid #ddd;">\n' +
                                                                            '<img src="images/时间小图片.png"/>\n' +
                                                                            '<span style="border-bottom: 0;">交易时间：' + data.list[o].attendtime + '</span>\n' +
                                                                            '</p>\n' +
                                                                            ' </li>';
                                                                    js += k;
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
                                   HuiFang.Funtishi("查询日期不规范！");
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

</style>
    </head>
    <body>
    <header  data-am-widget="header" class="am-header am-header-default jz" style="background-color: #f2f2f2">
        <h1 class="am-header-title">
            <a href="#title-link" class="" style="color: #333333">交易记录</a>
        </h1>
        <div class="section">
            <input type="text" class="demo_date" id="statrTime" value="" style="border:0.5px solid #ddd"/>
        </div>
        <!-- Date & Time demo markup -->
        <div class="section">
            <input type="text" class="demo_date" id="endTime"  value=""  style="border:0.5px solid #ddd"/>
        </div>
        <div align="center">
            <input type="button" value="查  询" onclick="clickBind()" style="width: 120px; height: 30px;BORDER-RIGHT: #7b9ebd 1px solid; BORDER-TOP: #7b9ebd 1px solid;BORDER-LEFT: #7b9ebd 1px solid; BORDER-BOTTOM: #7b9ebd 1px solid;background-color:#1465f8;color: #f2f2f2"/>
        </div>
    </header>

    <ul class="order" id="div_id" style="padding-top: 140px">

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
            </a>
        </li>

    </ul>
</div>
<script>
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
