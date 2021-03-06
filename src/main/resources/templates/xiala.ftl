<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Page Title</title>
  <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
  <meta name="apple-mobile-web-app-capable" content="yes">
  <link rel="stylesheet" href="xiala/css/common.css">
  <link rel="stylesheet" href="xiala/option/mescroll.css">
  <link rel="stylesheet" href="xiala/option/mescroll-option.css">
  <style>
    /*下拉刷新回调的提示*/
    .download-tip {
      z-index: 9900;
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 24px;
      line-height: 24px;
      font-size: 12px;
      text-align: center;
      background-color: rgba(80, 175, 85, .7);
      color: white;
      display: none;
      -webkit-transition: top 300ms;
      transition: top 300ms;
    }

    /*展示上拉加载的数据列表*/
    .news-list li {
      padding: 16px;
      border-bottom: 1px solid #eee;
    }

    .news-list .new-content {
      font-size: 14px;
      margin-top: 6px;
      margin-left: 10px;
      color: #666;
    }
  </style>
</head>

<body>
  <!-- 拟态框 -->
  <div class="modal hide"></div>
  <!-- 按钮组 -->

  <p id="downloadTip" class="download-tip">1条新内容</p>

  <div class="btn-group">
    <div class="search_rule">
      <p class="def_sort">
        <span>
          综合排序<i class="sort_rule"></i>
        </span>
      </p>
      <p>
        <span>转发优先</span>
      </p>
      <p>
        <span>发布优先</span>
      </p>
    </div>
    <div class="icon_toggle" data-toggle="large">
      <span></span>
    </div>
  </div>


  <!--滑动区域-->
  <div id="mescroll" class="mescroll">
    <div class="pan_list" data-toggle="large">
      <!--展示上拉加载的数据列表-->
      <div class="cp_dtl_list">
        <!-- 滚屏 -->
        <div id="newsList" class="news-list">
        </div>

      </div>
    </div>

    <!-- icon_toggle large -->
  </div>


  <script src="xiala/js/common.js"></script>
  <script src="xiala/option/mescroll.js"></script>
  <script src="xiala/option/mescroll-option.js"></script>
  <script>
    window.onload = function () {
      Util.init();

      !function () {
        var mescroll = initMeScroll("mescroll", {
          down: {
            auto: false,//是否在初始化完毕之后自动执行下拉回调callback; 默认true
            callback: downCallback, //下拉刷新的回调
          },
          up: { //加载数据
            auto: true,//是否触发上拉加载的回调
            isBoth: true, //上拉加载时,如果滑动到列表顶部是否可以同时触发下拉刷新;默认false,两者不可同时触发; 这里为了演示改为true,不必等列表加载完毕才可下拉;
            callback: upCallback, //上拉加载的回调
            page: { // 要使用它提供的分页参数， 把分页功能托管给他
              num: 0,
              size: 10,
              time: null
            },
          }
        });

        /*下拉刷新的回调 */ //class="active"
        function downCallback() {
          getListDataFromNet(0, 1, function (data) {
            //联网成功的回调,隐藏下拉刷新的状态
            console.log(data);
            mescroll.endSuccess();
            //设置列表数据
            setListData(data, false);
            //显示提示
            var tip = doucment.getElementById("downloadTip");
            tip.style = "top:35px;";
            setTimeout(function () {
              tip.style = "top:0;";
            }, 2000);
          }, function () {
            //联网失败的回调,隐藏下拉刷新的状态
            mescroll.endErr();
          });
        }

        /*上拉加载的回调 page = {num:1, size:10}; num:当前页 从1开始, size:每页数据条数 */
        function upCallback(page) {
          console.log('加载数据');
          //联网加载数据
          console.log("num:" + page.num);
          getListDataFromNet(page.num, page.size, function (data) {
            mescroll.endSuccess(data.length); //传参:数据的总数; mescroll会自动判断列表如果无任何数据,则提示空;列表无下一页数据,则提示无更多数据;
            //设置列表数据
            // console.log(data);
            setListData(data, true);
          }, function () {
            //联网失败的回调,隐藏上拉加载的状态
            mescroll.endErr();
          });
        }

        /*设置列表数据*/
        function setListData(data, isAppend) {
          var str = '';
          var listDom = document.getElementById("newsList");
          for (var i = 0; i < data.length; i++) {
            var newObj = data[i];
            str += '<div class="cp_dtls">'
              + '<div class="cp_img">'
              + '<img src="xiala/image/timg.jpg" alt="">'
              + '</div>'
              + '<div class="cp_desc">'
              + '<p class="cp_tit"><a href="javascript:;">【低至1299】Xiaomi/小米 6X智能AI双摄全面屏拍照学生老人手机小米8周年官方旗舰店正品双卡双待4G全网通 </a></p>'
              + '<div class="cp_price"><span>基本信息</span></div>'
              + '<div class="cp_dtl clearfix">'
              + '<span>转发次数(次) :' + newObj.title + '</span>'
              + '<span>地址:杭州江干区</span>'
              + '</div></div></div>';
          }
          // console.log(isAppend);
          if (isAppend) {
            console.log('加载');
            listDom.innerHTML += str;
          } else {
            console.log('上拉刷新');
            return false;
            // listDom.insertBefore(div, div.firstChild);//加在列表的前面,下拉刷新
          }
        }

        /*联网加载列表数据*/
        var downIndex = 0;
        function getListDataFromNet(pageNum, pageSize, successCallback, errorCallback) {
          //延时两秒,模拟联网
          setTimeout(function () {
            console.log(pageNum);
            try {
              var newArr = [];
              if (pageNum == 0) {
                //此处模拟下拉刷新返回的数据
                downIndex++;
                var newObj = { title: "【新增话题" + downIndex + "】 新增话题", content: "新增话题的内容" };
                newArr.push(newObj);
              } else {
                //此处模拟上拉加载返回的数据
                for (var i = 0; i < pageSize; i++) {
                  var upIndex = (pageNum - 1) * pageSize + i + 1;
                  // console.log(upIndex);
                  var newObj = {
                    title: upIndex,
                    content: "内容内容内容内容内容内容内容内容内容内容"
                  };
                  newArr.push(newObj);
                }
              }
              //联网成功的回调
              successCallback && successCallback(newArr);
            } catch (e) {
              //联网失败的回调
              errorCallback && errorCallback();
            }
          }, 2000)
        }

      }();

    }
  </script>
</body>

</html>