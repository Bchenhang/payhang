<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>打卡明细</title>
  <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
  <meta name="apple-mobile-web-app-capable" content="yes">
  <link rel="stylesheet" href="css/common.css">
  <link rel="stylesheet" href="css/mescroll.css">
  <link rel="stylesheet" href="css/mescroll-option.css">
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
          <#--滚屏-->



        <div id="newsList" class="news-list">
        </div>

      </div>
    </div>

    <!-- icon_toggle large -->
  </div>


  <script src="jquery/common.js"></script>
  <script src="jquery/mescroll.js"></script>
  <script src="jquery/mescroll-option.js"></script>
  <script type="text/javascript" src="js/jqueryyy.min.js"></script>
  <script type="text/javascript">

      $(function () {
          var str='';
          $.ajax({
              url: "/pay/n",
              type: "post",
              data:{},
              dataType: "json",
              success: function (data) {
                str += '<div class="cp_dtls">'
                          + '<div class="cp_img">'
                          + '<img src="images/kaoqing/timg.jpg" alt="">'
                          + '</div>'
                          + '<div class="cp_desc">'
                          + '<p class="cp_tit"><a href="javascript:;">【低至1299】Xiaomi/小米 6X智能AI双摄全面屏拍照学生老人手机小米8周年官方旗舰店正品双卡双待4G全网通 </a></p>'
                          + '<div class="cp_price"><span>基本信息</span></div>'
                          + '<div class="cp_dtl clearfix">'
                          + '<span>转发次数(次) : </span>'
                          + '<span>地址:杭州江干区</span>'
                          + '</div></div></div>';
                  $(".cp_dtl_list").html(str);
              }
          })
      })
  </script>
</body>

</html>