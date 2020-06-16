<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <script type="text/javascript" src="js/jquery.min.js" ></script>
    <script type="text/javascript" src="js/amazeui.min.js"></script>
    <link rel="stylesheet" href="css/amazeui.min.css" type="text/css" />
    <link rel="stylesheet" href="css/stylee.css" type="text/css" />
    <script src="js/vue.js"></script>
    <style type="text/css">
        table {
            border: 0;
        }
        table {
            width:auto;
            height:auto;
            max-width:100%;
            max-height:100%;
            margin-bottom:  235;
            background-color: rgba(140, 140, 140, 0.21);
            /*margin-bottom: 10px;*/
            height: 55px;
        }
        th {
            height: 50px;
        }
        th, td {
          /*border-bottom: 1px solid #ddd;*/
        }
        img{
            width:auto;
            height:auto;
            max-width:100%;
            max-height:100%;
            margin:1px 0px 5px 3px;/*上 右 下*左/
          /*  padding-right: 22px;*/
        }
    </style>

</head>
<body>
<header data-am-widget="header" class="am-header am-header-default jz">
    <h1 class="am-header-title">
        <a href="#title-link" class="al" style="color: #f37b1d;  font-size:25px;" >一卡通服务</a>
    </h1>
</header>

<div id="table1" style="background-color: #9e9e9e17">
    <table align="center" bgcolor="blue"  frame=above  rules=none >
        <tr>
            <td colspan="2" ><a href="/pay/pay1?id=1" class=""><img src="/pay/images/账户充值3.png"></a></td>
            <td colspan="2" ><a href="/pay/a" class=""><img src="/pay/images/交易记录3.png"></a></td>
        </tr>
        <tr>
            <td colspan="2" ><a href="#title-link" class=""><img src="/pay/images/订餐3.png"></a></td>
            <td ><a href="/pay/pay1?id=3" class=""><img src="/pay/images/卡片挂失.png"></a></td>
            <td ><a href="/pay/pay1?id=3" class=""><img src="/pay/images/卡片解挂.png"></a></td>

        </tr>
        <tr>
            <td ><a href="#title-link" class=""><img src="/pay/images/手工签到3.png"></a></td>
            <td ><a href="#title-link" class=""><img src="/pay/images/请假3.png"></a></td>
            <td ><a href="#title-link" class=""><img src="/pay/images/打卡明细3.png"></a></td>
            <td ><a href="#title-link" class=""><img src="/pay/images/日报表3.png"></a></td>
        </tr>

    </table>
    <table align="center"  frame=above  rules=none>
        <tr>
            <td ><a href="#title-link" class=""><img src="/pay/images/通行足迹3.png"></a></td>
            <td ><a href="#title-link" class=""><img src="/pay/images/远程开门3.png"></a></td>
            <td ><a href="#title-link" class=""><img src="/pay/images/消息通知3.png"></a></td>
        </tr>
    </table>
</div>
<div style="height: 49px;"></div>
<div data-am-widget="navbar" class="am-navbar  gm-foot am-no-layout" id="">
    <ul class="am-navbar-nav am-cf am-avg-sm-4">
        <li class="curr">
            <a href="#title-link" class="curr">
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
    var vm = new Vue({
        el: '#vue_det',
        data: {
            site: "菜鸟教程",
            url: "www.runoob.com",
            alexa: "10000"
        },
        methods: {
            details: function() {
                return  this.site + " - 学的不仅是技术，更是梦想！";
            }
        }
    })
    $.fn.loading = $.fn.loading || function (options) {
        if (loading.isObject(options)) {
            options = $.extend({}, defaultConfig, options);
        } else if (options === 'stop') {
            //停止
            this.each(function (k, v) {
                var exists = $(this).data('loading');
                if (exists && exists instanceof loading) {
                    //如果存在则清除之前的操作
                    exists.clear();
                }
            });
            return this;
        } else {
            options = $.extend({}, defaultConfig);
        }
        this.each(function (k, v) {
            new loading($(this), options.text, options.num, options.rate, options.style);
        });
        return this;
    }
    window.loading = loading;
    })(jQuery)
</script>
</body>
</html>
