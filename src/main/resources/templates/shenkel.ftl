<!DOCTYPE html>
<html>
<head>
<title>首页</title>
<meta http-equiv="Content-Type" content="textml; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link href="qingjia/index.css" rel="stylesheet" type="text/css" media="all" />
    <link rel="stylesheet" href="qingjia/amazeui.min.css" type="text/css" />
    <link rel="stylesheet" href="qingjia/style.css" type="text/css" />
    <link rel="stylesheet" href="qingjia/jindu/element.min.css" />
<script type="text/javascript" src="qingjia/jquery-1.8.2.min.js"></script>

    <style>
         .ture{ background: #ff2c4c;  color: #fff; border-radius: 5px; line-height: 35px; padding: 0 15px; position: absolute; right: 5px; bottom: 10px; border: 0;}
         .turel{ background: #999;  color: #fff; border-radius: 5px; line-height: 35px; padding: 0 15px; position: absolute; right: 70px; bottom: 10px; border: 0;}
         .el-icon-check:before {
             content: "\e611";
         }
         .el-step__head.is-success{
             color: #67c23a;
             border-color: #67c23a;
             line-height:23px;
         }
    </style>


</head>
<body class="loading">

<div class="wrapper">

    <header data-am-widget="header" class="am-header am-header-default jz">
        <h1 class="am-header-title">
            <a href="#title-link" class="">请假详情</a>
        </h1>
    </header>

   		<div class="Account">
            <div class="Acc-b">
            	<h4>请假明细</h4>
                <ul>
                	<li>学员姓名：<span style="color:#999;">陈航</span></li>
                	<li>请假类型：<span style="color:#999;">事假</span></li>
                    <li>开始时间：<span style="color:#999;">2019-06-08 17:45</span></li>
                    <li>结束时间：<span style="color:#999;">2019-07-09 12:00</span></li>
                    <li>请假事由：<span style="color:#999;">阿迪斯发打发发达斯阿迪，阿迪斯发打发发达斯阿迪，阿迪斯发打发发达斯阿迪。</span></li>
                    <li> <div id="myVue" style="line-height:25px">
                        <div style="float:left;"><span>审核进度：</span></div>
                        <el-steps ref="stepCust" :active="stepVal1" align-center    :finish-status="currtentFinshStatus">
                            <el-step  title="待审核" status="success">   </el-step>
                            <el-step  title="班主任"  description="菜头" status="success">   </el-step>
                            <el-step  title="后勤主任"  description="静旋" status="success"> </el-step>
                            <el-step  title="副校长"  description="陈航" status="error"></el-step>
                            <el-button type="button" class="ture" @click="next(1)">同意</el-button>
                            <el-button type="button" class="turel" @click="next(2)">拒绝</el-button>
                        </el-steps>
                    </div></li>
                </ul>
                <br>
                <br>
            </div>
        </div>
    <div style="height: 49px;"></div>
    <div data-am-widget="navbar" class="am-navbar  gm-foot am-no-layout" id="">
        <ul class="am-navbar-nav am-cf am-avg-sm-4">
            <li class="">
                <a href="/pay/pay1?id=12" class="">
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
                    <span class="am-nav"></span>
                </a>
            </li>

        </ul>
    </div>
</div>
</body>
<script type="text/javascript" src="qingjia/jindu/vue.min.js" ></script>
<script type="text/javascript" src="qingjia/jindu/element.min.js" ></script>
<script type="text/javascript">
    new Vue({
        el: '#myVue',
        data: {
            stepVal1: 0,
            currtentStatus:"success ",
            currtentFinshStatus:"success",
        },
        methods: {
            next(a) {
                // this.currtentFinshStatus="error"
                if (a==1) {
                    if (this.stepVal1++ > 3) this.stepVal1 = 0;

                }else if (a==2) {
                    //this.$refs.stepCust.finishStatus="error"
                    this.$refs.stepCust.steps[this.$refs.stepCust.active].status="error"
                    // this.$refs.stepCust.processStatus="error"
                    // this.stepVal1=1;
                    // if (this.stepVal1-- <= 0) this.stepVal1 = 4;
                }
            }
        }
    })
</script>
</html>
