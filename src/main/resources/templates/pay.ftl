tt<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
        <title></title>
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
		<script type="text/javascript" src="js/jquery.min.js" ></script>
		<script type="text/javascript" src="js/amazeui.min.js"></script>
		<link rel="stylesheet" href="css/amazeui.min.css" type="text/css" />
		<link rel="stylesheet" href="css/stylee.css" type="text/css" />
        <link href="css/styleee.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="js/jqueryyy.min.js"></script>
		<script type="text/javascript">
            $(function () {
                $(".aui-current-box a").click(function () {
                    $(this).addClass("this-card");
					var money = $(this).text();
                  /*  money = money.substring(0, money.lastIndexOf('元'));*/
					$("#cz_money").val(money);
                    $(this).siblings().removeClass("this-card");
                });
            });

            function clickBind(ResultCode,url) {

                //获取值
                if (ResultCode=="0000") {
                    var money = $("#cz_money").val();
                    $.ajax({
                        url: "/pay/wechat/create",
                        type: "post",
                        data:{
                            price: money
                        },
                        dataType: "json",
                        success: function (data) {
                            if (data.orderid!=null){
                                window.location.href =url+"/wechat/pay?orderid="+data.orderid;
                            }
                        }
                    })
                }else{
                    alert("请解除挂失！")
                }
            }
            function clickBind1(ResultCode,url) {
                if (ResultCode=="0000") {
                    window.location.href =url+"/pay1?id=13";
                }else{
                    alert("请解除挂失！")
                }
                //获取值

            }
		</script>
	</head>
	<body>
		 <header data-am-widget="header" class="am-header am-header-default jz">
		      <div class="am-header-left am-header-nav">
				</a>
		      </div>
		      <h1 class="am-header-title">
		          <a href="#title-link" class="">账户充值</a>
		      </h1>
        </header>
         <section class="aui-scrollView">
             <div class="divHeight"></div>
             <div class="aui-flex">
             </div>
             <div class="aui-current-box">
                 <a href="javascript:;" class="aui-current-item this-card">
                     <div class="aui-reset-tag"></div>
                     <div class="aui-current-item-hd">
                         <h1 style="font-size:25px">10</h1>
                     </div>
                 </a>
                 <a href="javascript:;" class="aui-current-item">
                     <div class="aui-reset-tag"></div>
                     <div class="aui-current-item-hd">
                         <h1 style="font-size:25px">20</h1>

                     </div>
                 </a>
                 <a href="javascript:;" class="aui-current-item ">
                     <div class="aui-reset-tag"></div>
                     <div class="aui-current-item-hd">
                         <h1 style="font-size:25px">30</h1>
                     </div>
                 </a>
                 <a href="javascript:;" class="aui-current-item">
                     <div class="aui-current-item-hd">
                         <h1 style="font-size:25px">50</h1>
                     </div>
                 </a>
                 <a href="javascript:;" class="aui-current-item ">
                     <div class="aui-current-item-hd">
                         <h1 style="font-size:25px">100</h1>
                     </div>
                 </a>
                 <a href="javascript:;" class="aui-current-item">
                     <div class="aui-current-item-hd">
                         <h1 style="font-size:25px">200</h1>
                     </div>
                 </a>
                 <div class="aui-flex" style="padding-left:5px">
                     <div class="aui-flex-box">
						 <input id="cz_money" type="hidden" value="10">
                         <h2><input type="button" value="支付" class="money-btn"  onclick="clickBind(${params.ResultCode},${params.url})"></h2>
                     </div>
                 </div>
                 <div class="aui-flex" style="padding-left:5px">
                     <div class="aui-flex-box">
                         <input id="cz_money" type="hidden" value="10">
                         <h2><input type="button" value="订单详情" class="money-btn"  onclick="clickBind1(${params.ResultCode},${params.url})"></h2>
                     </div>
                 </div>
             <div class="aui-current-box">
             </div>
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
                        </a>
                    </li>

                </ul>
		  </div>
	</body>
</html>
