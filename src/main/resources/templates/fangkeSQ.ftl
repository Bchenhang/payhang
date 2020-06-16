<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>访客申请</title>
    <link rel="stylesheet" href="css/styleSQ.css" type="text/css"/>
    <link href="css/mobiscroll.custom.min.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="css/new_file.css" type="text/css"/>
    <style>
        img {
            border: 0;
        }
        body {
            background: #f7f7f7;
            color: #666;
            font: 12px/150% Arial,Verdana, "microsoft yahei";
        }
        html, body, div, dl, dt, dd, ol, ul, li, h1, h2, h3, h4, h5, h6, p, blockquote, pre, button, fieldset, form, input, legend, textarea, th, td {
            margin: 0;
            padding: 0;
        }
        article,aside,details,figcaption,figure,footer,header,main,menu,nav,section,summary {
            display: block;
            margin: 0;
            padding: 0;
        }
        audio,canvas,progress,video {
            display: inline-block;
            vertical-align: baseline;
        }
        a {
            text-decoration: none;
            color: #08acee;
        }
        a:active,a:hover {
            outline: 0;
        }
        button {
            outline: 0;
        }
        mark {
            color: #000;
            background: #ff0;
        }
        small {
            font-size: 80%;
        }
        img {
            border: 0;
        }
        button,input,optgroup,select,textarea {
            margin: 0;
            font: inherit;
            color: inherit;
            outline: none;
        }
        li {
            list-style: none;
        }
        i {
            font-style: normal;
        }
        a {
            color: #666;
        }
        a:hover {
            color: #eee;
        }
        em {
            font-style: normal;
        }

        h2, h3 {
            font-family: "microsoft yahei";
            font-weight: 100;
        }
        /* ------------------- */
        ::-moz-placeholder {
            color: #9fa3a7;
        }

        ::-webkit-input-placeholder {
            color: #9fa3a7;
        }
        :-ms-input-placeholder {
            color: #9fa3a7;
        }
        .pc-kk-form{
            padding:15px 20px;
        }
        .pc-kk-form-list{
            background:#fff;
            border:1px solid #e5e5e5;
            border-radius:5px;
            height:44px;
            line-height:44px;
            margin-bottom:10px;
        }
        .pc-kk-form-list input{
            width:100%;
            border:none;
            background:none;
            color:#47a3ff;
            font-size:15px;
            height: 36px;
            padding: 4px 10px;
        }
        .pc-kk-form-list textarea{
            background:none;
            border:none;
            height:60px;
            padding:10px;
            resize:none;
            width:94%;
            line-height:22px;
            color:#47a3ff;
            font-size:14px;
        }
        .nice-select{
            position: relative;
            background: #fff url(images/a2.jpg) no-repeat right center;
            background-size:18px;
            width:100%;
            float:left;
            border:1px solid #e5e5e5;
            border-radius:5px;
            height:44px;
            line-height:44px;
        }

        .nice-select ul{
            width: 100%;
            display: none;
            position: absolute;
            left: -1px;
            top: 44px;
            overflow: hidden;
            background-color: #fff;
            max-height: 150px;
            overflow-y: auto;
            border: 1px solid #b9bcbf;
            z-index: 9999;
            border-radius:5px;

        }
        .nice-select ul li{
            padding-left:10px;
        }
        .nice-select ul li:hover{
            background:#f8f4f4;
        }
        .pc-kk-form-list-clear{
            background:none;
            border:none;
        }
        .pc-kk-form-btn button{
            background:#47a3ff;
            color:#fff;
            border:none;
            width:100%;
            height:50px;
            line-height:50px;
            font-size:16px;
            border-radius:50px;
        }
        .tkyy{ width:100%; height:40px; line-height:40px; font-size:1em; font-weight:800; position:relative; text-align:center}
        .tkyy span{ color:#cc1118}
        .tkyy1{ width:100%; height:28px; line-height:28px; font-size:1em; font-weight:800; position:relative; }
        .tkyy1 span{ color:#cc1118}


    </style>
</head>

<body>
<!--内容 star-->
<div class="pc-kk-form">

    <div class="aui-flex aui-flex-one" style="border:1px solid #ece9e9l;background-color: #d8d8d8">
        <div class="aui-welfare-user">
            <img src="images/user1.png" alt="">
        </div>
        <div class="aui-flex-box">
            <h2>陈航</h2>
            <p>430621199509104116</p><#--${params}-->
        </div>
        <div class="aui-address">
            <a href="/pay/fangkeTZ?id=2"><span style="text-decoration: none;">信息修改</span></a>
            <br>
            <br>
            <a href="/pay/fangkejl"><span style="text-decoration: none;">申请记录</span></a>
            <br>
            <br>
            <a href="/pay/fangkeTZ?id=2"><span style="text-decoration: none;">访问审核</span></a>
        </div>
    </div>

    <form action="">
        <div class="tkyy">被访人信息<span>*</span></div>

        <div class="pc-kk-form-list">
            <input type="text" placeholder="被访人姓名" id="xm">
        </div>
        <div class="pc-kk-form-list">
            <input type="text" placeholder="被访人电话" id="dh">
        </div>
        <div class="pc-kk-form-list pc-kk-form-list-clear">
            <div class="nice-select" name="nice-select">
                <input type="text" placeholder="访问人数" id="rs" readonly>
                <ul>
                    <li data-value="1">1</li>
                    <li data-value="2">2</li>
                    <li data-value="3">3</li>
                    <li data-value="4">4</li>
                    <li data-value="5">5</li>
                    <li data-value="6">6</li>
                    <li data-value="6">7</li>
                    <li data-value="6">8</li>
                    <li data-value="6">9</li>
                    <li data-value="6">10</li>
                    <li data-value="6">11</li>
                    <li data-value="6">12</li>
                </ul>
            </div>
        </div>
        <div class="pc-kk-form-list pc-kk-form-list-clear">
            <div class="nice-select" name="nice-select">
            <input type="text" class="demo_datetime" id="statrTime" placeholder="访问日期"/>
            </div>
        </div>
        <div class="pc-kk-form-list" style="height:auto">
            <textarea  placeholder="访问事由" id="sy"></textarea>
        </div>
        <br>
        <div class="pc-kk-form-btn">
            <button id="submitbut" type="button">申请</button>
        </div>
    </form>
</div>

<!--内容 end-->

<script type="text/javascript" src="js/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="js/jquery.selectbox-0.2.js"></script>
<script type="text/css">
    #hang{
       color: #222222;
    }
</script>


<!-- Mobiscroll JS and CSS Includes -->
<script type="text/javascript" src="js/mobiscroll.custom.min.js"></script>
<script type="text/javascript">
    /* var xxx = document.getElementById('shi_id');
     setInterval(function(){
         xxx.scrollIntoView(false);
     },150)*/
    $("#submitbut").click(function(){
        var xm=$('#xm').val();
        var dh=$('#dh').val();
        var rs=$('#rs').val();
        var rq=$('#statrTime').val();
        var sy=$('#sy').val();
        var dh1=/^1[3456789]\d{9}$/;
        if (xm!="" && bm!="" && rs!=""  && rq!="" && sy!="") {
            var xm1=/^[\u4E00-\u9FA5A-Za-z]+$/;
            if(xm1.test(xm) === false){
                HuiFang.Funtishi("姓名格式不合法！");
                return  false;
            }else if (dh1.test(dh) === false) {
                HuiFang.Funtishi("电话格式不合法！");
                return  false;
            }else{
                $.ajax({
                    url: "/pay/fangkeSQ",
                    type: "post",
                    data:{xm:xm,
                        dh:dh,
                        rs:rs,
                        rq:rq,
                        sy:sy
                    },
                    dataType: "json",
                    success: function (data) {
                        alert(data.code)
                        if (data.code=="0000") {
                            HuiFang.Funtishi("信息申请成功！");
                            return true;
                        }else{
                            return false;
                        }
                    }
                })
            }
        }else{
            HuiFang.Funtishi("信息不完整！");
            return  false;
        }
    });
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
    $('[name="nice-select"]').click(function(e){

        $('[name="nice-select"]').find('ul').hide();

        $(this).find('ul').show();

        e.stopPropagation();

    });

    $('[name="nice-select"] li').hover(function(e){

        $(this).toggleClass('on');

        e.stopPropagation();

    });

    $('[name="nice-select"] li').click(function(e){

        var val = $(this).text();

        $(this).parents('[name="nice-select"]').find('input').val(val);

        $('[name="nice-select"] ul').hide();

        e.stopPropagation();

    });

    $(document).click(function(){

        $('[name="nice-select"] ul').hide();

    });
</script>
</body>
</html>