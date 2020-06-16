<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0">
    <title></title>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/mobiscroll.custom.min.js"></script>
    <link href="css/stylebb.css" rel="stylesheet" type="text/css"/>
    <link href="css/mobiscroll.custom.min.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="css/amazeui.min.css" type="text/css" />
    <link rel="stylesheet" href="css/stylee.css" type="text/css" />
    <style>
        .assess_nr {width:95%;overflow: hidden;background-color: #fff; margin-left:2.5%; border-radius:5px; background:#ffffff; border:solid 1px #c4c4c4; padding:8px 2.5%}
        .assess_nr textarea {text-align: justify;width: 100%;border: none;font-size: 1.0em;color: #666; }
        input {
            width: 100%;
            height: 100%;
            display: block;
            padding: 0 10px;
            border: 0;
        }
        .section {
            position: relative;
            height: 32px;
            padding-left: 20px;
            padding-right: 20px;
            margin-bottom: 10px;
            box-sizing: border-box;
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
        table { border: 0; margin:auto;background-color: #dce2e4}
        #divcss5{margin:0,auto;text-align:center;background-color: #dce2e4;height: 60px}
    </style>
</head>
<body>
<header class="aui-navBar aui-navBar-fixed" style="background-color: #f2f2f2">
    <div class="aui-center">
        <span class="aui-center-title" style="font-size: 20px">交易记录</span>
    </div>
</header>
<section class="aui-flexView">

    <div id="divcss5">
    <table>
        <tr id="hang">
            <td> <input type="button" value="前一天" onclick="hou()"  style="width:100%;height:30px;line-height:30px;display:block;margin:13px auto;font-size:16px;text-align:center;"></td>
            <td>
                <div class="section">
                    <input type="text" id="demo_date"   onchange="function()"  value="" size="12" height:30px; style="width:110%;line-height:30px;display:block;margin:5px auto;font-size:16px;text-align:center;" />
                </div></td>
            <td> <input type="button" value="后一天" onclick=" qian()" style="width:100%;height:30px;line-height:30px;display:block;margin:13px auto;font-size:16px;text-align:center;"></td>
        </tr>
    </table>
</div>
    <ul class="order" id="div_id" style="padding-top: 10px">
   <#---->
    </ul>
</section>
<script>
    $(function () {
        var today=new Date();
        var yesterday_milliseconds=today.getTime();
        var yesterday=new Date();
        yesterday.setTime(yesterday_milliseconds);
        var strYear=yesterday.getFullYear();
        var strDay=yesterday.getDate();
        var strMonth=yesterday.getMonth()+1;
        if(strMonth<10)
        {
            strMonth="0"+strMonth;
        }
        if(strDay<10)
        {
            strDay="0"+strDay;
        }
        var strYesterday=strYear+"-"+strMonth+"-"+strDay;
        click(strYesterday)
        $("#demo_date").attr("value",strYesterday);

    });

    $("#demo_date").change(function(){
        var rq=$('#demo_date').val();
        click(rq)
    });
    function click(rq) {
        var js="";
        var k="";
        var m="";
        //获取值
                $.ajax({
                    url: "/pay/jiaoyijilu",
                    type: "post",
                    data: {
                        sj: rq
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
    }


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
    $('#demo_date').mobiscroll().date({
        theme: theme,
        mode: mode,
        display: display,
        dateFormat:"yyyy-mm-dd",
        lang: lang
    });

    // Date & Time demo initialization
    $('#demo_datetime').mobiscroll().datetime({
        theme: theme,
        mode: mode,
        display: display,
        lang: lang,
        dateFormat:"yyyy-mm-dd",
    });

    // Time demo initialization
    $('#demo_time').mobiscroll().time({
        theme: theme,
        mode: mode,
        display: display,
        lang: lang
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
    function qian(){
        var p=$('#demo_date').val();
        if (p!="") {
            var rq="";
            var m = p.substring(0,4);
            var gang= p.substring(4,5);
            var y= p.substring(5,7);
            var r= Number(p.substring(8))+Number(1);
            if (r<10) {
                r="0"+r;
            }
            if (y == "01" || y == "03" || y == "05" || y == "07" || y == "08" || y == "12" || y == "10") {
                if (r>31) {
                    if (y == "01") {
                        y="02";

                    }else if (y == "03") {
                        y="04";

                    }else if (y == "05") {
                        y="06";

                    }else if (y == "07") {
                        y="08";

                    }else if (y == "08") {
                        y="09";

                    }else if (y == "10") {
                        y="11";

                    }else if (y == "12") {
                        y="01";
                    }
                    r="01"
                }
            } else if (y == "04" || y == "06" || y == "09" || y == "11") {
                if (r>30) {
                    if (y == "04") {
                        y="05";

                    }else if (y == "06") {
                        y="07";

                    }else if (y == "09") {
                        y="10";

                    }else if (y == "11") {
                        y="12";
                    }
                    r="01";
                }
            } else if (y == "02") {
                if (r>28) {
                    y="03";
                    r = "01";
                }
            }
            rq=m+gang+y+gang+r;
            $('#demo_date').val(rq);
        }else{
            HuiFang.Funtishi("请选择日期！");
        }

        click(rq) ;     //
    }
    //qian一天
    function hou(){
        var p=$('#demo_date').val();
        var rq="";
        var m = p.substring(0,4);
        var gang= p.substring(4,5);
        var y= p.substring(5,7);
        var r= Number(p.substring(8))-Number(1);
        if (r<10) {
            r="0"+r;
        }
        if (r < 1) {
            if (y == "01" || y == "03" || y == "05" || y == "07" || y == "08" || y == "12" || y == "10") {
                if (y == "01") {
                    y="12";
                    r="31";
                }else if (y == "03") {
                    y="02";
                    r="28"
                }else if (y == "05") {
                    y="04";
                    r="30";
                }else if (y == "07") {
                    y="06";
                    r="30";
                }else if (y == "08") {
                    y="07";
                    r="31";
                }else if (y == "10") {
                    y="09";
                    r="30"
                }else if (y == "12") {
                    y="11";
                    r="30";
                }
            } else if (y == "04" || y == "06" || y == "09" || y == "11") {
                if (y == "04") {
                    y="03";
                    r="31";
                }else if (y == "06") {
                    y="05";
                    r="31";
                }else if (y == "09") {
                    y="08";
                    r="31"
                }else if (y == "11") {
                    y="10";
                    r="31";
                }
            } else if (y == "02") {
                y="01";
                r = "31";
            }
        }
        rq=m+gang+y+gang+r;
        $('#demo_date').val(rq);

        click(rq)     //
    }
</script>
</body>
</html>
