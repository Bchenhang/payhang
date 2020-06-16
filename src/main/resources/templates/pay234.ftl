<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <link rel="stylesheet" href="css/styleeee.css">
    <script type="text/javascript" src="js/jquery.min.js" ></script>
    <script type="text/javascript" src="js/amazeui.min.js"></script>
    <link rel="stylesheet" href="css/amazeui.min.css" type="text/css" />
    <link rel="stylesheet" href="css/stylee.css" type="text/css" />
    <link href="css/styleee.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="js/jqueryyy.min.js"></script>
  <title></title>
</head>

<body>
<header data-am-widget="header" class="am-header am-header-default jz" style="background-color: #f2f2f2">
    <div class="am-header-left am-header-nav">
    </div>
    <h1 class="am-header-title">
        <a href="#title-link" class="" style="color: #333333">账户充值</a>
    </h1>
</header>
  <div class="container">
    <div class="row">
      <div class="container_logo">
        <div class="play col-xs-10 col-sm-10 col-md-10 col-lg-10">
          <img src="./images/充值主页.png" />
        </div>
      </div>
    </div>
      <div class="row">
        <div class="play col-xs-10 col-sm-10 col-md-10 col-lg-10">
          <div class="form-group">
            <input type="hidden" class="getId" name="id">
            <h4>充值金额</h4>
            <div class="number_amount">
              <label >￥</label>
              <input type="number" id="cz_money" name="amount" disabled="true">
            </div>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="quick_amount col-xs-10 col-sm-10 col-md-10 col-lg-10" id="hang">
                      <p class="col-xs-3 col-sm-3 col-md-3 col-lg-3" data-item='${(params.chargeval1)!''}'>${(params.chargeval1)!''}</p>
                      <p class="col-xs-3 col-sm-3 col-md-3 col-lg-3" data-item='${(params.chargeval2)!''}'>${(params.chargeval2)!''}</p>
                      <p class="col-xs-3 col-sm-3 col-md-3 col-lg-3" data-item='${(params.chargeval3)!''}'>${(params.chargeval3)!''}</p>
                      <p class="col-xs-3 col-sm-3 col-md-3 col-lg-3" data-item='${(params.chargeval4)!''}'>${(params.chargeval4)!''}</p>
                      <p class="col-xs-3 col-sm-3 col-md-3 col-lg-3" data-item='${(params.chargeval5)!''}'>${(params.chargeval5)!''}</p>
                      <p class="col-xs-3 col-sm-3 col-md-3 col-lg-3" data-item='${(params.chargeval6)!''}'>${(params.chargeval6)!''}</p>
        </div>
      </div>
      <div class="row">
        <div class="_submit col-xs-10 col-sm-10 col-md-10 col-lg-10">
          <input type="button" value="充值" onclick="clickBind('${(params.ResultCode)!''}','${(params.ResultMsg)!''}')" class="btn btn-primary submit-amount">
        </div>
        <div class="_submit col-xs-10 col-sm-10 col-md-10 col-lg-10">
          <input type="button" value="订单详情" onclick="clickBind1('${(params.ResultCode)!''}','${(params.url)!''}','${(params.ResultMsg)!''}')" class="btn btn-primary1 submit-amount">
        </div>
      </div>
  </div>
  </div>
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
  <div class="modal fade" tabindex="-1" role="dialog" id='exampleModal'>
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
          <h4 class="modal-title">提示</h4>
        </div>
        <div class="modal-body">
          <p>输入金额不能超出5000元</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-primary" data-dismiss="modal" aria-label="Close">确定</button>
        </div>
      </div>
    </div>
  </div>
  <div class="mask"></div>
</body>
<script src="js/jqueryboot.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script>
var $amountInput = $('[type="number"]');
var amount = '';
var $getId = $('[type="hidden"]');
var getparse=ParaMeter();
$getId.val(getparse.id);
$(".quick_amount p").off("click").on("click", function () {
  amount = $(this).text();
  if (!$(this).hasClass('active')) {
    $(this).addClass('active').siblings().removeClass('active');
    $amountInput.val(amount);
  } else {
    $(this).removeClass('active');
    $amountInput.val('');
  }
})
$amountInput.on('input propertychange', function () {
  if ($(this).val() > 5000) {
    $('#exampleModal').modal('show')
  }
  if($(this).val()!==$('.quick_amount p.active').text()){
    $('.quick_amount p').removeClass('active');
  }
})
$('#exampleModal').on('hidden.bs.modal', function (e) {
  $amountInput.val(5000);
})
function ParaMeter()
{
  var obj={};
  var arr=location.href.substring(location.href.lastIndexOf('?')+1).split("&");
  for(var i=0;i < arr.length;i++){
  var aa=arr[i].split("=");
  obj[aa[0]]=aa[1];
}
  return obj;
}
function clickBind(ResultCode,ResultMsg) {
    //获取值
       if (ResultCode=="0000") {
        var money = $("#cz_money").val();
           if (money==""){
               HuiFang.Funtishi("请选择金额！");
           }else{
            $.ajax({
            url: "/pay/wechat/create",
            type: "post",
            data:{
                price: money
            },
            dataType: "json",
            success: function (data) {
                if (data.orderid!=null){
                    window.location.href =data.url+"/wechat/pay?orderid="+data.orderid;
                }
            }
        })
           }
    }else{
           HuiFang.Funtishi(ResultMsg);
    }
}
function clickBind1(ResultCode,url,ResultMsg) {
    if (ResultCode=="0000") {
        window.location.href =url+"/pay1?id=13";
    }else{
        HuiFang.Funtishi(ResultMsg);
    }
    //获取值

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

</html>