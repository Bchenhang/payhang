﻿<!DOCTYPE html>
<html>
<head>
<title>大家都来抓抓</title>
<meta name="content-type" content="text/html; charset=UTF-8">

<!--<link rel="stylesheet" type="text/css" href="./styles.css">-->
<style type="text/css">
	*{
		margin:0px;
		border:0px;
		padding:0px;
	}
	#wrapper{
		width: 750px;
		height: 1109px;
		margin: 0 auto;
		background-image:url('images/bg.png');
		position:relative;
		z-index:1;
	}
	#rod{
		position:relative;
		top:235px;
		left:-20px;
		width:16px;
		height:3px;
		margin:0 auto;
		background-image: url(images/rod.png);
		background-repeat: repeat-y;
	}
	#hand{
		/*
		width: 124px;
		height: 83px;
		*/
		width: 150px;
		height: 83px;
		position:relative;
		top:235px;
		left:-20px;
		background-position:158px 0px;
		background-image: url(images/hand.png);
		margin:0 auto;
	}
	
	#babys{
		height: 200px;
		width: 500px;
		margin:0 auto;
		overflow: hidden;
		position: relative;
		top:-550px;
		left:-20px;
	}
	
	#uptoy{
		width: 200px;
		height: 200px;
		margin: 0 auto;
		position: relative;
		z-index: 3;
		top:-750px;
		left:-20px;
		display: none;
	}
	
	#start_btn{
		width: 123px;
		height: 115px;
		background-image: url('images/start.png');
		background-position: -40px -20px;
		position: absolute;
		top:790px;
		left:1050px;
		z-index: 4;
		border:none;
		outline: none;
		cursor: pointer;
	}
</style>
</head>

<body>
<div id="wrapper">
	<div id="rod"></div>
	<div id="hand"></div>
</div>

<div id="babys">
	<!-- 
	<img src="images/toy117.png">
	<img src="images/toy117.png">
	<img src="images/toy117.png">
	<img src="images/toy117.png">
	<img src="images/toy117.png">
	 -->
</div>

<div id="uptoy">
	<img src="images/cong.png">
</div>
<div id="start_btn">
</div>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript">
	var toys = new Array();//娃娃数组
	var flag = true;//按钮默认可以点击
	$("#start_btn").click(function(){
		if(!flag){
			alert("不要连续点击，等夹完一次再夹");
			return;
		}
		flag = false;//刚刚被点击完，按钮不能连续点击
		//改变按钮的位置
		$("#start_btn").css({"backgroundPosition":"-40px -160px"});
		//动画将绳子往下移动到200像素
		$("#rod").animate({height:"300px"},1500,"linear",function(){
			//当动画结束的时候，将爪子合起来
			$("#hand").css({"backgroundPosition":"0px 0px","width":"124px"});
			$("#start_btn").css({"backgroundPosition":"-40px -20px"});
		});
		
		//要等爪子落下的时候才判断是否抓到娃娃，需要等待1500号码才执行判断，不管有没有抓到娃娃绳子都还要升上去
		window.setTimeout(function(){
			//循环遍历数组判断，是否可以被夹起来
			for(var i = 0; i < toys.length; i++){
				if($(toys[i]).css("left").match(/\d*/) > 300 && $(toys[i]).css("left").match(/\d*/)  < 400){
					toys[i].remove();//移除这个元素
					
					$("#uptoy").css("display","block");//将隐藏起来的那个可以被夹起来的娃娃显示出来
					
					//让隐藏的娃娃和夹子一起上去
					$("#uptoy").animate({"display":"block","top":"-1100px"},1500,"linear",function(){
						$("#uptoy").css({"display":"none","top":"-750px"});
					});
				}
			}
			
			//动画将绳子移回原来的位置
			$("#rod").animate({height:"3px"},1500,"linear",function(){
				//当动画结束的时候，将爪子松开
				$("#hand").css({"backgroundPosition":"158px 0px","width":"150px"});
				flag = true;//等绳子升上去又可以点击了
			});
		}, 1500);
	});
	//在准备事件的时候让娃娃自动生成并且从左到右移动
	//每隔一秒钟生成一个娃娃并且往右移动
	window.setInterval(function(){
		//创建娃娃元素的图片
		var img = $("<img style='position:absolute;left:0px;' src='images/cong.png'>");
		toys.push(img);//将图片放入到数组最后
		//将娃娃元素追加到框中
		$("#babys").append(img);
		//让娃娃动起来，改变它的绝对定位  4秒钟动完之后移除元素防止元素太多页面卡死
		$(img).animate({left:"900px"},4000,"linear",function(){
			this.remove();//将元素从页面上移除
			toys.shift();//删除数组的第一个元素
		});
	}, 1000);
</script>

<div style="text-align:center;">
</div>
</body>
</html>