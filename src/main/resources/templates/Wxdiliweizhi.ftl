<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <style type="text/css">
        body, html{width: 100%;height: 100%;margin:0;font-family:"微软雅黑";}
        #allmap{height:300px;width:100%;}
        #r-result{width:100%; font-size:14px;}
    </style>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=4R3SqpZPYo0FLINyylngH24siwoiGBRk"></script>
    <title>浏览器定位</title>
</head>
<body>
<div id="allmap"></div>
<div id="r-result">
</div>
</body>
</html>
<script type="text/javascript">
//加载地图
    var p='';
    var map;
    var pointNow;
    var pointAttendance;
    var geolocation;
    // 百度地图API功能
    map = new BMap.Map("allmap");
    map.enableScrollWheelZoom(true);
    geolocation = new BMap.Geolocation();
        fi();
        SetAttendance(113.43337,23.134797);//给目标划区域
        window.setInterval(fi,5000);//定时刷新 5秒
    function  fi() {//标点  计算距离
        geolocation.getCurrentPosition(function(r){
            if(this.getStatus() == BMAP_STATUS_SUCCESS){
                pointNow = r.point;
                map.centerAndZoom(pointNow,16);
                var mk = new BMap.Marker(pointNow);
                map.addOverlay(mk);
                map.panTo(pointNow);

                pointAttendance = new BMap.Point(113.43337,23.134797);
                var distance = map.getDistance(pointNow, pointAttendance).toFixed(2);
                if (distance <= 5) {
                    p='<p>当前已进入打卡区</p>';
                    document.getElementById("r-result").innerHTML = "";
                    document.getElementById("r-result").innerHTML = p;
                } else {
                    var i=(distance-5).toFixed(2);
                    p='<p>距离打卡区'+i+'米</p>';
                    document.getElementById("r-result").innerHTML = "";
                    document.getElementById("r-result").innerHTML = p;
                }
            }
            else {
                alert('failed'+this.getStatus());
            }
        },{enableHighAccuracy: true})
    }
    function SetAttendance(longitude,latitude) {//划分目标区域
        pointAttendance = new BMap.Point(longitude, latitude);
        circle = new BMap.Circle(pointAttendance, 5, {
            fillColor: "blue",
            strokeWeight: 1,
            fillOpacity: 0.2,
            strokeOpacity: 0.2

        });// 显示签到点的位置（半径为300米的一个圆）
        map.addOverlay(circle);
        //计算当前位置与考勤点距离
    }
</script>
