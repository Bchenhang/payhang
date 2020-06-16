<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
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

	<body>
		<!--头部  star-->
		<header style="color:#fff">
				<span style="font-size: 21px">请假申请</span>
		</header>
		<!--头部 end-->

        <!--内容 star-->
		<div class="contaniner fixed-cont">
			<!--1-->
            <div class="tkyy">&nbsp;&nbsp;&nbsp;请假类型<span>*</span></div>
            <div class="demo">
				<select name="position" id="country_id">
					<option value="0">事假</option>
					<option value="1">病假</option>
					<option value="2">产假</option>
					<option value="3">补时</option>
					<option value="4">丧假</option>
                    <option value="5">婚假</option>
                    <option value="6">工伤</option>
                    <option value="7">年休</option>
                    <option value="8">探亲</option>

				</select>
			</div>
            <div class="tkyy">&nbsp;&nbsp;&nbsp;开始时间<span>*</span></div>
            <div class="assess_nr" style="text-align:center;">
                <input type="text" class="demo_datetime" id="statrTime" placeholder="请选择日期"/>
            </div>
            <div class="tkyy">&nbsp;&nbsp;&nbsp;结束时间<span>*</span></div>
            <div class="assess_nr">
                <input type="text" class="demo_datetime" id="endTime"  style="outline:none;" placeholder="请选择日期"/>
            </div>
            <div class="tkyy">&nbsp;&nbsp;&nbsp;请假事由<span>*</span></div>
			<section class="assess">
				<div class="assess_nr">
					<textarea rows="4" placeholder="请您输入请假理由" id="shi_id"></textarea>
				</div>
			</section>

			<!--2-->
            <a href="#" onclick="clickBind()" ><div class="submit_button">提交申请</div></a>


		</div>

		<!--内容 end-->

        <script type="text/javascript" src="js/jquery-1.8.2.min.js"></script>
		<script type="text/javascript" src="js/jquery.selectbox-0.2.js"></script>


        <!-- Mobiscroll JS and CSS Includes -->
        <script type="text/javascript" src="js/mobiscroll.custom.min.js"></script>
		<script type="text/javascript">
          /*  var xxx = document.getElementById('shi_id');
            setInterval(function(){
                xxx.scrollIntoView(false);
            },150)*/
          function CompareDate(d1,d2)
          {
              return ((new Date(d1.replace(/-/g,"\/"))) > (new Date(d2.replace(/-/g,"\/"))));
          }
            function clickBind() {
                var lx = $("#country_id").val();
                var krq = $("#statrTime").val();
                var jrq = $("#endTime").val();
                var sy = $("#shi_id").val();
                //获取值
                if (lx==""||krq==""|| jrq==""||sy==""){
                    HuiFang.Funtishi("请完善信息");
                } else{
                   if ( CompareDate(jrq,krq)){
                    $.ajax({
                        url: "/pay/qingjia",
                        type: "post",
                        data:{
                            lx : lx, krq : krq, jrq : jrq,sy : sy
                        },
                        dataType: "json",
                        success: function (data) {
                            if (data.ResultCode=="0000"){
                                document.getElementById("statrTime").value = "";
                                document.getElementById("endTime").value = "";
                                document.getElementById("shi_id").value = "";
                                HuiFang.Funtishi("申请成功！");
                            }else{
                                HuiFang.Funtishi(data.ResultMsg);
                            }
                        }
                    })
                   }else{
                       HuiFang.Funtishi("日期不规范！");
                   }
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