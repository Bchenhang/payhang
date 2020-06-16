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
<script  type="text/css">

</script>
    <script type="text/javascript">

        $(function () {
            var system = {};
            var p = navigator.platform;
            var u = navigator.userAgent;

            system.win = p.indexOf("Win") == 0;
            system.mac = p.indexOf("Mac") == 0;
            system.x11 = (p == "X11") || (p.indexOf("Linux") == 0);
            if (system.win || system.mac || system.xll) {//如果是PC转
                if (u.indexOf('Windows Phone') > -1) {  //win手机端

                }else {
                    window.location.href = "Expires.aspx?error=1";
                }
            }
        })
    </script>
</head>
<body>
<div class="reg2" align="center">
    <input type="button" value="刷新" class="money-btn"  onclick="refreshCount()">
</div>
<div style="height: 49px;"></div>
<div data-am-widget="navbar" class="am-navbar  gm-foot am-no-layout" id="">

</div>

</body>
</html>
