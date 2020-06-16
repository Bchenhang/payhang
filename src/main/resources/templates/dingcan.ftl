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
    <link rel="stylesheet" type="text/css" href="css/date.css">
    <script type="text/javascript" src="js/jquery.min.js" ></script>
    <script type="text/javascript" src="js/date.js"></script>
    <script type="text/javascript" src="js/iscroll_date.js"></script>
    <script src="js/vue.js"></script>
    <style type="text/css">
        table {
            width:auto;
            height:auto;
            max-width:100%;
            max-height:100%;
            border: 5px;
            /*margin-bottom: 10px;*/
            height: 55px;
        }
        table{ /* 表格整体样式 */
            margin:0px;  /* 外边距50px */
            border-collapse:collapse; /* 合并为单一的边框线 */
        }
        table.tb1 td{padding:10px;border:1px solid green;}
        th {
            height: 50px;
        }
        th, td {
            /*border-bottom: 1px solid #ddd;*/
        }
    </style>

</head>
<body>
<header data-am-widget="header" class="am-header am-header-default jz">
    <h1 class="am-header-title">
        <a href="#title-link" class="al" style="color: #f37b1d;  font-size:25px;" >6月点餐服务</a>
    </h1>
</header>
<#--<input type="button" onclick="delAll()" value="批量删除" />
<input type="button" onclick="che()" style="font-size: 20px" value="全选/反选" />-->


<div id="datePlugin"></div>
<input type="text" id="dateinput" style="width:90%;height:50px;line-height:50px;display:block;margin:10px auto;font-size:16px;text-align:center;" />


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
    $(function(){
        //初始化日期插件
        $('#dateinput').date();
    });
    //全选
    function cheAll(){
        var cek = $("#che")[0].checked;
        var ck = $("input[name='ck']");
        for(var i = 0; i < ck.length; i++){
            ck[i].checked = cek;
        }
    }
    function hang(){
        var r=confirm("是否点餐!");
    }

    //反选
    function che(){
        alert("hja ")
        var cks = document.getElementsByName("ck");
        for(var i = 0; i < cks.length; i++) {
            cks[i].checked = !cks[i].checked;
        }
    }

    //批量删除
    function delAll(){
        var ck = $("input:checked[name='ck']");
        if(ck.length == 0){
            alert("请选择,然后进行删除");
            return;
        }
        var f=confirm("确认删除!!");
        if(!f){
            return;
        }
        for(var i = 0; i < ck.length; i++){
            ck[i].parentNode.parentNode.remove();
        }
    }

</script>
</body>
</html>
