<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
		<script type="text/javascript" src="qingjia/jquery.min.js" ></script>
		<script type="text/javascript" src="qingjia/amazeui.min.js"></script>
        <script type="text/javascript" src="js/jquery.min.js"></script>
        <script type="text/javascript" src="js/mobiscroll.custom.min.js"></script>
        <link href="css/stylebb.css" rel="stylesheet" type="text/css"/>
        <link href="css/mobiscroll.custom.min.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="css/amazeui.min.css" type="text/css" />
        <link rel="stylesheet" href="css/stylee.css" type="text/css" />
		<link rel="stylesheet" href="qingjia/amazeui.min.css" type="text/css" />
		<link rel="stylesheet" href="qingjia/style.css" type="text/css" />
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
        <script type="text/javascript">
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
                //click(strYesterday)
                $("#demo_date").attr("value",strYesterday);

            });
                function update() {
                 window.parent.location.href="/pay/shenkel";
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

                //click(rq) ;     //
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

              //  click(rq)     //
            }
        </script>

	</head>
	<body>
		 <header data-am-widget="header" class="am-header am-header-default jz">
		      <h1 class="am-header-title">
		          <a href="#title-link" class="">请假记录</a>
		      </h1>
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
        <ul class="near">
        	<li>
        	   <div class="pic"><img src="images/pic.png"/></div>
        	   <div class="text">
        	    	<h2><span>陈飞</span><em style="color: #67c23a">待审核</em></h2>
        	    	<p>类型：事假</p>
        	    	<p>时长：24h</p>
        	   </div>
        	   <button type="button" class="ture" onclick="update()">请假详情</button>
        	</li>
            <li>
                <div class="pic"><img src="images/pic.png"/></div>
                <div class="text">
                    <h2><span>小阳</span><em>同意</em></h2>
                    <p>类型：事假</p>
                    <p>时长：24h</p>
                </div>
                <button type="button" class="ture" onclick="update()">请假详情</button>
            </li>
            <li>
                <div class="pic"><img src="images/pic.png"/></div>
                <div class="text">
                    <h2><span>吴海</span><em style="color: #ff2c4c">拒绝</em></h2>
                    <p>类型：事假</p>
                    <p>时长：24h</p>
                </div>
                <button type="button" class="ture" onclick="update()">请假详情</button>
            </li>

        </ul>
         </section>
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
