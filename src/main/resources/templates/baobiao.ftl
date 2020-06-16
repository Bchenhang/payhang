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
	padding-right: 15px;
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
<section class="aui-flexView">
    <header class="aui-navBar aui-navBar-fixed" style="background-color: #f2f2f2">
       <div class="aui-center">
         <span class="aui-center-title" style="size:25px">考勤日报</span>
       </div>
    </header>
    <div id="divcss5">
        <table>
            <tr id="hang">
                <td> <input type="button" value="前一天" onclick="hou()"  style="width:100%;height:30px;line-height:30px;display:block;margin:13px auto;font-size:16px;text-align:center;"></td>
                <td>
                    <div class="section">
                        <input type="text" id="demo_date"   onchange="function()"  value="" size="12" height:30px; style="width:100%;line-height:30px;display:block;margin:5px auto;font-size:16px;text-align:center;" />
                    </div></td>
                <td> <input type="button" value="后一天" onclick=" qian()" style="width:100%;height:30px;line-height:30px;display:block;margin:13px auto;font-size:16px;text-align:center;"></td>
            </tr>
        </table>
    </div>
    <section class="aui-scrollView">
        <div class="aui-header-set" id="div_id">

        </div>
    </section>
</section>
<script>
    $(function () {
        var today=new Date();
        var yesterday_milliseconds=today.getTime()-1000*60*60*24;
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
        clickBind(strYesterday);
        $("#demo_date").attr("value",strYesterday);
    });

    $("#demo_date").change(function(){
        var rq=$('#demo_date').val();
        clickBind(rq)
    });

    function clickBind(demo_date) {
        //获取值
            $.ajax({
                url: "/pay/baobiao",
                type: "post",
                data:{
                    rq : demo_date
                },
                dataType: "json",
                success: function (data) {
                    if (data.ResultCode=="0000"){
                       var i='  <div class="aui-header-set-list">\n' +
                               '                <div class="aui-flex-box">\n' +
                               '                    <h2>当天考勤</h2>\n' +
                               '                </div>\n' +
                               '                <div class="aui-class-item">\n' +
                               '                    <a href="javascript:;" class="aui-header-set-item">上班：</a>\n' +
                               '                    <a href="javascript:;" class="aui-header-set-item">'+data.InTime1+'&nbsp;</a>\n' +
                               '                    <a href="javascript:;" class="aui-header-set-item">下班：</a>\n' +
                               '                    <a href="javascript:;" class="aui-header-set-item">'+data.OutTime1+'&nbsp;</a>\n' +
                               '                </div>\n' +
                               '                <div class="aui-class-item">\n' +
                               '                    <a href="javascript:;" class="aui-header-set-item">上班：</a>\n' +
                               '                    <a href="javascript:;" class="aui-header-set-item">'+data.InTime2+'&nbsp;</a>\n' +
                               '                    <a href="javascript:;" class="aui-header-set-item">下班：</a>\n' +
                               '                    <a href="javascript:;" class="aui-header-set-item">'+data.OutTime2+'&nbsp;</a>\n' +
                               '                </div>\n' +
                               '                <div class="aui-class-item">\n' +
                               '                    <a href="javascript:;" class="aui-header-set-item">迟到：</a>\n' +
                               '                    <a href="javascript:;" class="aui-header-set-item">'+data.LateMin+'/分钟</a>\n' +
                               '                    <a href="javascript:;" class="aui-header-set-item">早退：</a>\n' +
                               '                    <a href="javascript:;" class="aui-header-set-item">'+data.EarlyMin+'/分钟</a>\n' +
                               '                </div>\n' +
                               '            </div>\n' +
                               '            <div class="aui-header-set-list">\n' +
                               '                <div class="aui-flex-box">\n' +
                               '                    <h2>当月考勤</h2>\n' +
                               '                </div>\n' +
                               '                <div class="aui-class-item">\n' +
                               '                    <a href="javascript:;" class="aui-header-set-item">迟到：</a>\n' +
                               '                    <a href="javascript:;" class="aui-header-set-item">'+data.LateCnt+'次</a>\n' +
                               '                    <a href="javascript:;" class="aui-header-set-item">早退：</a>\n' +
                               '                    <a href="javascript:;" class="aui-header-set-item">'+data.EarlyCnt+'次</a>\n' +
                               '                    <a href="javascript:;" class="aui-header-set-item">请假：</a>\n' +
                               '                    <a href="javascript:;" class="aui-header-set-item">'+data.LeaveDay+'天</a>\n' +
                               '                    <a href="javascript:;" class="aui-header-set-item">加班：</a>\n' +
                               '                    <a href="javascript:;" class="aui-header-set-item">'+data.OverTime+'/时</a>\n' +
                               '                    <a href="javascript:;" class="aui-header-set-item">旷工：</a>\n' +
                               '                    <a href="javascript:;" class="aui-header-set-item">'+data.AbsentDay+'/天</a>\n' +
                               '                    <a href="javascript:;" class="aui-header-set-item">出勤：</a>\n' +
                               '                    <a href="javascript:;" class="aui-header-set-item">'+data.WorkDay+'天</a>\n' +
                               '                    <a href="javascript:;" class="aui-header-set-item">出差：</a>\n' +
                               '                    <a href="javascript:;" class="aui-header-set-item">'+data.TripDay+'天</a>\n' +
                               '                </div>\n' +
                               '            </div>';
                        $("#div_id").empty();
                        document.getElementById("div_id").innerHTML = i;
                    }else{
                        $("#div_id").empty();
                        HuiFang.Funtishi(data.ResultMsg);
                    }
                }
            })
            /* window.location.href ="/pay/kaoqingjilu?krq="+krq+"&jrq="+jrq;*/
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

        clickBind(rq) ;     //
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

        clickBind(rq)      //
    }
    </script>
</body>
</html>
