<!DOCTYPE html>
<html>
<head>
    <script type="text/javascript" src="js/jquery-1.8.2.min.js"></script>
<style type="text/css">
    .mask {
        position: absolute; top: 0px; filter: alpha(opacity=60); background-color: #777;
        z-index: 1002; left: 0px;
        opacity:0.5; -moz-opacity:0.5;

    }
</style>
    <script type="text/javascript">
        $(function(){

        });
        function showMask(){
            $("#mask").attr("style","background:url('images/jiazai5.png') no-repeat center center;width:100%;height:100%;");
            $("#mask").css("height",$(document).height());
            $("#mask").css("width",$(document).width());
            $("#mask").show();
        }
        //隐藏遮罩层
        function hideMask(){

            $("#mask").hide();
        }

    </script>
</head>

<body>
<div id="mask" class="mask">123</div>
<a href="javascript:;" onclick="showMask()" >点我显示遮罩层</a><br />

</body>
</html>