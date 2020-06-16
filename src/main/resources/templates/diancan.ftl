<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<title></title>
    <link href="css/mobiscroll.custom.min.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="css/styleliebiao.css" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="css/date.css">
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/date.js"></script>
    <script type="text/javascript" src="js/iscroll_date.js"></script>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <!-- Mobiscroll JS and CSS Includes -->
    <script type="text/javascript" src="js/mobiscroll.custom.min.js"></script>

    <style type="text/css">
        .section {
            position: relative;
            height: 30px;
            padding-left: 20px;
            padding-right: 20px;
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
        table { border: 0; margin:auto;background-color: #2379f7}
        #divcss5{margin:0,auto;text-align:center;background-color: #2379f7;height: 50px}
    </style>
</head>
	
<body>
<!--头部  star-->
<header style="" >
		<div class="_left"></div><span >订餐服务</span>
</header>
<!--头部 end-->
<!--内容 star-->
<div class="contaniner fixed-cont">
	<div class="pay_img"><img src="images/diancan/美食.png"></div>
    <div id="divcss5">
 <table>
	 <tr id="hang">
         <td> <input type="button" value="前一天" onclick="hou()"  style="width:100%;height:30px;line-height:30px;display:block;margin:0px auto;font-size:12px;text-align:center;"></td>
         <td>
             <div class="section">
                 <input type="text" id="demo_date"   onchange="dcAjax($(this).val())"  value="" size="12" height:30px; style="width:100%;line-height:22px;display:block;margin:10px auto;font-size:13px;text-align:center;" />
             </div></td>
         <td> <input type="button" value="后一天" onclick=" qian()" style="width:100%;height:30px;line-height:30px;display:block;margin:0px auto;font-size:12px;text-align:center;"></td>
	 </tr>
 </table>
    </div>
    <div id="datePlugin"></div>
    <!--支付 star-->
	<div class="pay">
		<div class="show" id="lish">
			<li ><label><img src="images/diancan/早餐.png" ><span>早餐</span><input id="text" name="Fruit" type="checkbox" value="" onclick="setAll1()"/><span></span></label></li>
    		<li ><label><img src="images/diancan/午餐.png" ><span>中餐</span><input id="text" name="Fruit" type="checkbox" value="" onclick="setAll1()"/><span></span></label></li>
    		<li ><label><img src="images/diancan/晚餐.png" ><span>晚餐</span><input id="text" name="Fruit" type="checkbox" value="" onclick="setAll1()"/><span></span></label></li>
            <li ><label><img src="images/diancan/夜宵.png" ><span>夜宵</span><input id="text" name="Fruit" type="checkbox" value="" onclick="setAll1()"/><span></span></label></li>
            <li ><label><img src="images/diancan/全选.png" ><span>整日全选</span><input id="text1" name="Fruit1" type="checkbox" value="" onclick="setAll()" /><span></span></label> </li>
		</div>
	</div> 
    <!--支付 end--> 
    
    
</div>


<div class="book-recovery-bot2" id="footer">
	<a href="#" onclick="diancan()">
	<div class="payBottom">
    	<li class="textfr">确认</li>
        <li class="textfl">点餐</li>
    </div>
    </a>
</div>
<!--内容 end-->
        

<script type="text/javascript">

    $(function () {
        var myDate = new Date();
        var nowY = myDate.getFullYear();
        var nowM = myDate.getMonth()+1;
        var nowD = myDate.getDate();
        var enddate = nowY+"-"+(nowM<10 ? "0" + nowM : nowM)+"-"+(nowD<10 ? "0"+ nowD : nowD);//当前日期
        dcAjax(enddate);
        $("#demo_date").attr("value",enddate);
    });

    function dcAjax(dateTime){
        var loves = document.getElementsByName("Fruit");
        var loves1 = document.getElementsByName("Fruit1");
        var checkbox1= document.getElementById("text1");
        $.ajax({
            url: "/pay/dianselect",
            type: "post",
            data:{
                rq: dateTime
            },
            dataType: "json",
            success: function (data) {
                if (data.ResultCode=="0000") {
                    if (data.Breakfast==1) {
                        loves[0].checked=true;
                    }else{
                        loves[0].checked=false;
                    }
                    if (data.Lunch==1) {
                        loves[1].checked=true;
                    }else{
                        loves[1].checked=false;
                    }
                    if (data.Supper==1) {
                        loves[2].checked=true;
                    }else{
                        loves[2].checked=false;
                    }
                    if (data.Midnight==1) {
                        loves[3].checked=true;
                    }else{
                        loves[3].checked=false;
                    }
                    loves1[0].checked=false;
                }else{
                    HuiFang.Funtishi(data.ResultMsg);
                }



            }
        })
    }

	//点餐
    function diancan() {
        var a = new Array(4);
        var rq=$('#demo_date').val();
        if (rq!="") {
        var loves = document.getElementsByName("Fruit");

        if (dqrq()==true){
        for (var i = 0; i < loves.length; i++) {
            console.log(loves[i].checked); // true
            if (loves[i].checked==true) {
                a[i]=1;
			}else{
                a[i]=0;
			}
        }
        var zan=a[0];
        var zhong=a[1];
        var wan=a[2];
        var ye=a[3];
            $.ajax({
                url: "/pay/diancan",
                type: "post",
                data:{
                    zao: zan,
                    zhong: zhong,
                    wan: wan,
                    ye: ye,
                    rq: rq
                },
                dataType: "json",
                success: function (data) {
                    if (data.ResultCode=="0000") {
                        HuiFang.Funtishi("操作成功！");
                    }else{
                        HuiFang.Funtishi(data.ResultMsg);
                    }
                }
            })
          }else{
              HuiFang.Funtishi("请选择当天后的日期！");
          }
        }else{
            HuiFang.Funtishi("请选择点餐日期！");
		}
    }
	//多选框
    function setAll() {
        var loves = document.getElementsByName("Fruit");
        var checkbox1= document.getElementById("text1")
        //console.log(checkbox1.checked); // true
		if (checkbox1.checked==true) {
            for (var i = 0; i < loves.length; i++) {
                loves[i].checked = true;
                }
            }else{
            for (var i = 0; i < loves.length; i++) {
                loves[i].checked = false;
               }
			}
       }
       //全选/全不选
    function setAll1() {
        var loves = document.getElementsByName("Fruit");
        var checkbox1= document.getElementById("text1")
        //console.log(checkbox1.checked); // true
        if (checkbox1.checked==true) {
            for (var i = 0; i < loves.length; i++) {
                if (loves[i].checked ==false)
                    checkbox1.checked=false;
                 }
        }
    }
      //计算当前日期
	function dqrq() {
        var rq=$('#demo_date').val();
        var today=new Date();//获取当前时间(没有格式化)
        var year=today.getFullYear();//获取年份,四位数
        var month=today.getMonth()+1;//获取月份,0-11
        var day=today.getDate();//获取几号
        if(month<=9){//格式化
            month="0"+month;
        }
        if(day<=9){
            day="0"+day;
        }
        today=year+"-"+month+"-"+day;

        if(rq >= today){//对比日期大小

            return true;
        }else{
            return false;
        }
    }
     //hou一天
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

        dcAjax(rq);      //
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

            dcAjax(rq);      //
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
</script>

</body>
</html>