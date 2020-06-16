<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="initial-scale=1,maximum-scale=1, minimum-scale=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>访客绑定</title>
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
        }h
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
            color:#9fa3a7;
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
        .ture{ background: #ff2c4c;  color: #fff; border-radius: 5px; line-height: 35px; padding: 0 15px; position: absolute; right: 6%; bottom: 91%; border: 0;}
        .tkyy{ width:100%; height:40px; line-height:40px; font-size:1em; font-weight:800; position:relative; text-align:center}
        .tkyy span{ color:#cc1118}
        .tkyy1{ width:100%; height:28px; line-height:28px; font-size:1em; font-weight:800; position:relative; }
        .tkyy1 span{ color:#cc1118}
    </style>
</head>
<body>

<div class="pc-kk-form">
    <br>
    <form action=""  method="post" id="loginForm">
        <div class="tkyy1">&nbsp;&nbsp;&nbsp;身份证号码<span>*</span></div>
        <div class="pc-kk-form-list">
            <input type="text" placeholder="请输入15位或18位数字" id="sf">
        </div>
        <div class="tkyy1">&nbsp;&nbsp;&nbsp;用户姓名<span>*</span></div>
        <div class="pc-kk-form-list">
            <input type="text" placeholder="请输入中文或字母" id="xm">
        </div>
        <div class="tkyy1">&nbsp;&nbsp;&nbsp;用户性别<span>*</span></div>
        <div class="pc-kk-form-list">
            <div class="nice-select" name="nice-select">
                <input type="text" placeholder="性别" id="xb" readonly>
                <ul>
                    <li value="1">男</li>
                    <li value="2">女</li>

                </ul>
            </div>
        </div>
        <div class="tkyy1">&nbsp;&nbsp;&nbsp;工作单位<span>*</span></div>
        <div class="pc-kk-form-list">
            <input type="text" placeholder="请输入中文或字母" id="gz">
        </div>
        <div class="tkyy1">&nbsp;&nbsp;&nbsp;车牌号码<span>*选填</span></div>
        <div class="pc-kk-form-list">
            <input type="text" placeholder="示例：津A12345" id="cp">
        </div>
        <div class="tkyy1">&nbsp;&nbsp;&nbsp;电话号码<span>*</span></div>
        <div class="pc-kk-form-list">
            <input type="text" placeholder="11位手机号码" id="dh">
        </div>
        <div class="pc-kk-form-btn"> <a class="ture" href="/pay/fangketup"  style="display: block;">照片采集</a></div>
        <br>
        <br>
        <div class="pc-kk-form-btn">
            <button id="submitbut" type="button" style="display: block;">保存</button>
        </div>
    </form>
</div>


<script type="text/javascript" src="js/jqueryfangke.js"></script>
<script>
    $("#submitbut").click(function(){
        var sf=$('#sf').val();
        var xm=$('#xm').val();
        var gz=$('#gz').val();
        var cp=$('#cp').val();
        var dh=$('#dh').val();
        var xb=$('#xb').val();
        if (sf!="" && xm!="" && gz!=""  && dh!="") {
            var sf1 = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
            var cp1=/^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$/;
            var xm1=/^[\u4E00-\u9FA5A-Za-z]+$/;
            var gz1=/^[\u4E00-\u9FA5A-Za-z]+$/;
            if (cp!="") {
                if (cp1.test(cp)==false) {
                    HuiFang.Funtishi("车牌格式不合法！");
                    return  false;
                }
            }
            var dh1=/^1[3456789]\d{9}$/;
            if(sf1.test(sf) === false){
                HuiFang.Funtishi("身份证格式不合法！");
                return  false;
            }else if (xm1.test(xm) === false) {
                HuiFang.Funtishi("姓名格式不合法！");
                return  false;
            }else if (gz1.test(gz) === false) {
                HuiFang.Funtishi("工作单位格式不合法！");
                return  false;
            }else if (dh1.test(dh) === false) {
                HuiFang.Funtishi("电话格式不合法！");
                return  false;
            }else if (xb==""){
                HuiFang.Funtishi("请选择性别！");
                return  false;
            }else{
                $.ajax({
                    url: "/pay/fangkeBD",
                    type: "post",
                    data:{sf:sf,
                        xm:xm,
                        xb:xb,
                        gz:gz,
                        cp:cp,
                        dh:dh
                    },
                    dataType: "json",
                    success: function (data) {
                        window.location.href="http://hang.nat100.top/pay/fangkeTZ?id=1";
                        if (data.code=="0000") {
                            HuiFang.Funtishi("信息保存成功！");

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

    });
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