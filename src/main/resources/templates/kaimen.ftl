
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title></title>
	<meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0" name="viewport" />
	<meta content="yes" name="apple-mobile-web-app-capable" />
	<meta content="black" name="apple-mobile-web-app-status-bar-style" />
	<meta content="telephone=no" name="format-detection" />
	<link href="css/stylekm.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/tab.js"></script>
    <style type="text/css">
     #main{
         width:100%;
         height:100%;
     }
     #div_id{
         width:100%;
         height:100%;
         text-align:center;

     }
     #mask{
         width:100%;
         height:30%;
         text-align:center;
         position:absolute;
         left:1%;
         top:1%;
         filter:alpha(opacity=100);-moz-opacity:0.6;opacity:0.60;
     }
 </style>
</head>
<body>
<section class="aui-flexView">
	<header class="aui-navBar aui-navBar-fixed b-line" style="background-color: #f2f2f2">
		<div class="aui-center">
			<span class="aui-center-title">远程开门</span>
		</div>
	</header>

	<section class="aui-scrollView">
		<div class="aui-tab" id="main">

			<div class="tab-panel" id="div_id">
				<div class="tab-panel-item tab-active" style="padding-top: 140px">
			    <#--数据-->
				</div>

			</div>
            <div id="mask"></div>
		</div>

	</section>

</section>

<script>
    $(function(){
        clickBind();
    });
    function clickBind() {
        var js='';
        //获取值
        $.ajax({
            url: "/pay/mendian",
            type: "post",
            data:{},
            dataType: "json",
            success: function (data) {
                if (data.ResultCode=="0000") {
                if (data.Door != "") {
                    for (var o in data.Door) {
                        js += '<a href="javascript:;" class="aui-flex b-line" >\n' +
                                '<div class="aui-comm-user">\n' +
                                '<img src="images/kaimen1.png" alt="">\n' +
                                '</div>\n' +
                                '<div class="aui-flex-box">\n' +
                                '<h2>描述：' + data.Door[o].Remark + '</h2>\n' +
                                '<h3>终端机号：<span id="zd">' + data.Door[o].ClockNo + '</span></h3>\n' +
                                '<p>子门点号：<span id="zm">' + data.Door[o].SubNo + '</span></p>\n' +
                                '</div>\n' +
                                '<div class="aui-follow" onclick="chen('+data.Door[o].ClockNo+','+data.Door[o].SubNo+')">\n' +
                                '<span id="test" style="background: #4d8df4;display:inline-block;width:60px;text-align:center;"><i style="color: #f2f2f2">开门</i></span>\n' +
                                '</div>\n' +
                                '</a>';

                    }
                    document.getElementById("div_id").innerHTML = js;
                }else {
                    var h='<div align="center">\n' +
                            '<p style="width: 120px; height: 30px; padding-top: 80px"><h1>当前没有门点</h1></p>\n' +
                            '</div>';
                    document.getElementById("div_id").innerHTML = h;
				}
                }else{
                    HuiFang.Funtishi(data.ResultMsg);
				}
            },
            beforeSend : function(){
                $("#loader").show();
            },
            complete : function(){
                hideMask();
            }
        })
    }
function  chen(zd,zm) {
    $.ajax({
        url: "/pay/kai",
        type: "post",
        data:{
            zd:zd,
			zm:zm
		},
        dataType: "json",
        success: function (data) {
          if (data.ResultCode=="0000"){
              HuiFang.Funtishi("开门成功！");
		  }else{
              HuiFang.Funtishi(data.ResultMsg);
		  }
        },
        beforeSend : function(){
            showMask();
        },
        complete : function(){
            hideMask();
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

    function showMask(){
        $("#mask").attr("style","background:url('images/jiazai2.gif') no-repeat center center;width:100%;height:100%;");

        $("#mask").show();
    }
    //隐藏遮罩层
    function hideMask(){

        $("#mask").hide();
    }
</script>
</body>

</html>
