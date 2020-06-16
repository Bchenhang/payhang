<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Geolocation Components Demo - zoom effect</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,
    minimum-scale=1,maximum-scale=1,user-scalable=no">
    <style>
        * {margin: 0; padding: 0; border: 0;}
        body {
            position: absolute;
            width: 100%;
            height: 100%;
        }
        #geoPage, #markPage {
            position: relative;
        }
    </style>
</head>
<body>
<!--  通过 iframe 嵌入前端定位组件，此处没有隐藏定位组件，使用了定位组件的在定位中视觉特效  -->
<iframe id="geoPage" width="100%" height="30%" frameborder=0 scrolling="no"
        src="https://apis.map.qq.com/tools/geolocation?key=your key&referer=myapp&effect=zoom"></iframe>

<script type="text/JavaScript">
    var loc;
    var isMapInit = false;
    //监听定位组件的message事件
    window.addEventListener('message', function(event) {
        loc = event.data; // 接收位置信息
        console.log('location', loc);

        if(loc  && loc.module == 'geolocation') { //定位成功,防止其他应用也会向该页面post信息，需判断module是否为'geolocation'
            var markUrl = 'https://apis.map.qq.com/tools/poimarker' +
                    '?marker=coord:' + loc.lat + ',' + loc.lng +
                    ';title:我的位置;addr:' + (loc.addr || loc.city) +
                    '&key=your key&referer=myapp';
            //给位置展示组件赋值
            document.getElementById('markPage').src = markUrl;
        } else { //定位组件在定位失败后，也会触发message, event.data为null
            alert('定位失败');
        }

        /* 另一个使用方式
        if (!isMapInit && !loc) { //首次定位成功，创建地图
            isMapInit = true;
            createMap(event.data);
        } else if (event.data) { //地图已经创建，再收到新的位置信息后更新地图中心点
            updateMapCenter(event.data);
        }
        */
    }, false);
    //为防止定位组件在message事件监听前已经触发定位成功事件，在此处显示请求一次位置信息
    document.getElementById("geoPage").contentWindow.postMessage('getLocation', '*');

    //设置6s超时，防止定位组件长时间获取位置信息未响应
    setTimeout(function() {
        if(!loc) {
            //主动与前端定位组件通信（可选），获取粗糙的IP定位结果
            document.getElementById("geoPage")
                    .contentWindow.postMessage('getLocation.robust', '*');
        }
    }, 6000); //6s为推荐值，业务调用方可根据自己的需求设置改时间，不建议太短
</script>

<!-- 接收到位置信息后 通过 iframe 嵌入位置标注组件 -->
<iframe id="markPage" width="100%" height="70%" frameborder=0 scrolling="no" src=""></iframe>
</body>
</html>
