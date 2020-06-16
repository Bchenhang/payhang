<!DOCTYPE HTML>
<html>

	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1 maximum-scale=2, user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes" />
		<meta name="mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-title" content="Add to Home">
		<meta name="format-detection" content="telephone=no">
		<meta http-equiv="x-rim-auto-match" content="none">
		<title>采集照片</title>
		<!-- 网站的ico图标 -->
		<link rel="shortcut icon" href="tupian/img/favicon.jpg" type="image/x-icon">
		<link href="tupian/css/publi.css" rel="stylesheet" type="text/css">
		<link href="tupian/css/style.css" rel="stylesheet" type="text/css">
		<!--[if lt IE 9]>
			<script src="tupian/js/html5.js"></script>
			<script src="tupian/js/respond.min.js"></script>
		<![endif]-->
	</head>

	<body>
		<!-- ====================================loading -->
		<section id="loading"></section>
		<!-- ====================================页面开始 -->
		<!--登录-->
		<header class="acc_head">
			<div class="clearfix">
				<h1 class="tc">头像上转</h1>
			</div>

		</header>
		<section class="acc_apply">
			<ul>
				<li style="border-top: 0; margin-bottom: 60px;">
					<div class="acc_img">
						<p class="tc">参考样例</p>
						<div id="sss" style="width: 100%;height: 290px">
							<img class="acc_imgin" src="${params}" id="img0" style="width: 100%;height: 100%">
						</div>
						<div class="acc_sc">
							<a href="javascript:;" class="tc acc_scicon">选择图片</a>
							<input type="file" name="file0" id="file0" multiple class="ph08" accept="image/*" />

						</div>
						<p class="ph09 ">注:支持jpg、jpeg、png、gif格式照片。大小不超过5M</p>
					</div>
				</li>
			</ul>
		</section>
		<footer class="acc_foot clearfix">
			<a href="/pay/imgtc" class="fl tc acc_cancel" id="ak">退出</a>
			<a href="#" class="fl tc acc_sure">提交</a>
		</footer>
		<!--弹出层-->
		<article id="tip">
			<div class="pack">
				<h1 class="tc">提交成功</h1>
				<p class="tc"></p>
				<a href="#">确定</a>
			</div>
		</article>
		<!-- 网站要用到的一些类库 -->
		<script src="tupian/js/jquery1.8.3.min.js"></script>
		<script src="tupian/js/script.js"></script>
		<script type="text/javascript">
		
			$(function() {
				/*document.documentElement.style.fontSize=document.documentElement.clientWidth*12/320+'px';*/
				$(window).on("load", function() {
						$("#loading").fadeOut();
					})
					// ========================================浮层控制
				$("#tip .pack a").on("click", function() {
					$("#tip").fadeOut()
					$("#tip .pack p").html("")
					return false;
				})

				function alerths(str) {
					$("#tip").fadeIn()
					$("#tip .pack p").html(str)
					return false;
				}
				$(".acc_sure").on("click", function() {
                    var reads= new FileReader();

                    var f=document.getElementById('file0').files[0];
                    if (f!=null) {
                        HuiFang.Funtishi("开始上传！");
                    getOrientation(f, function (orientation) {
                        var reader = new FileReader();
                        reader.readAsDataURL(f);
                        reader.onload = function(evt){
                            var base64 = evt.target.result;
                            // 将图片旋转到正确的角度
                            resetOrientation(base64, orientation, function (resultBase64) {
                                dealImage(resultBase64,358,useImg);
                            });
                        }
                    });
                    }else{
                        HuiFang.Funtishi("请选择图片！");
					}
				})
				$("#file0").change(function() {
					if (this.files && this.files[0]) {
						var objUrl = getObjectURL(this.files[0]);
						console.log("objUrl = " + objUrl);
						if (objUrl) {
							$("#img0").attr("src", objUrl);
							$("#file0").click(function(e) {
								$("#img0").attr("src", objUrl);
							});
						} else {
							//IE下，使用滤镜
							this.select();
							var imgSrc = document.selection.createRange().text;
							var localImagId = document.getElementById("sss");
							//图片异常的捕捉，防止用户修改后缀来伪造图片
							try {
								preload.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = data;
							} catch (e) {
								this._error("filter error");
								return;
							}
							this.img.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale',src=\"" + data + "\")";
						}
					}
				});
				//建立一個可存取到該file的url
				function getObjectURL(file) {
					var url = null;
					if (window.createObjectURL != undefined) { // basic
						url = window.createObjectURL(file);
					} else if (window.URL != undefined) { // mozilla(firefox)
						url = window.URL.createObjectURL(file);
					} else if (window.webkitURL != undefined) { // webkit or chrome
						url = window.webkitURL.createObjectURL(file);
					}
					return url;
				}
			})
            function dealImage(base64, w, useImg) {
                var newImage = new Image();
                var quality = 0.6;    //压缩系数0-1之间
                newImage.src = base64;
                newImage.setAttribute("crossOrigin", 'Anonymous');	//url为外域时需要
                var imgWidth, imgHeight;
                newImage.onload = function () {
                    imgWidth = this.width;
                    imgHeight = this.height;
                    var canvas = document.createElement("canvas");
                    var ctx = canvas.getContext("2d");
                    if (Math.max(imgWidth, imgHeight) > w) {
                        if (imgWidth > imgHeight) {
                            canvas.width = w;
                            canvas.height = w * imgHeight / imgWidth;
                        } else {
                            canvas.height = w;
                            canvas.width = w * imgWidth / imgHeight;
                        }
                    } else {
                        canvas.width = imgWidth;
                        canvas.height = imgHeight;
                        quality = 0.6;
                    }
                    ctx.clearRect(0, 0, canvas.width, canvas.height);
                    ctx.drawImage(this, 0, 0, canvas.width, canvas.height);
                    var base64 = canvas.toDataURL("image/jpeg", quality); //压缩语句
                    // 如想确保图片压缩到自己想要的尺寸,如要求在50-150kb之间，请加以下语句，quality初始值根据情况自定
                    // while (base64.length / 1024 > 150) {
                    // 	quality -= 0.01;
                    // 	base64 = canvas.toDataURL("image/jpeg", quality);
                    // }
                    // 防止最后一次压缩低于最低尺寸，只要quality递减合理，无需考虑
                    // while (base64.length / 1024 < 50) {
                    // 	quality += 0.001;
                    // 	base64 = canvas.toDataURL("image/jpeg", quality);
                    // }
                    useImg(base64);//必须通过回调函数返回，否则无法及时拿到该值
                }
            }
            function useImg(base64) {
                $.ajax({
                    url: "/pay/img",
                    type: "post",
                    data:{imgStr:base64},
                    dataType: "json",
                    success: function (data) {
                        HuiFang.Funtishi("照片上传成功！");
                    }
                })
            }

            $("#ak").on('click', function () {
                $("#file0").val("");
            })

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

            /**
             * 将图片旋转到正确的角度
             * （解决移动端上传的图片角度不正确的问题）
             * （旋转后返回的是base64，可以参照本目录下的convertBase64ToBlob.js，将base64还原为file input读取得到的文件对象）
             * @param {Dom Object} $fileInput 文件上传输入框
             * @param {Function} callback 旋转完成后的回调函数
             */
            function resetImgOrientation($fileInput, callback) {
                // 绑定change事件
                $fileInput.onchange = function ($event) {
                    var $target = $event.target;
                    if ($target.files && $target.files[0]) {
                        // 获取图片旋转角度
                        getOrientation($target.files[0], function (orientation) {
                            var reader = new FileReader();
                            reader.readAsDataURL($target.files[0]);
                            reader.onload = function(evt){
                                var base64 = evt.target.result;
                                // 将图片旋转到正确的角度
                                resetOrientation(base64, orientation, function (resultBase64) {
                                    callback(resultBase64);
                                });
                            }
                        });
                    }
                }
            }

            // 获取图片旋转的角度
            function getOrientation(file, callback) {
                var reader = new FileReader();
                reader.readAsArrayBuffer(file);
                reader.onload = function(e) {
                    var view = new DataView(e.target.result);
                    if (view.getUint16(0, false) != 0xFFD8) return callback(-2);
                    var length = view.byteLength, offset = 2;
                    while (offset < length) {
                        var marker = view.getUint16(offset, false);
                        offset += 2;
                        if (marker == 0xFFE1) {
                            if (view.getUint32(offset += 2, false) != 0x45786966) return callback(-1);
                            var little = view.getUint16(offset += 6, false) == 0x4949;
                            offset += view.getUint32(offset + 4, little);
                            var tags = view.getUint16(offset, little);
                            offset += 2;
                            for (var i = 0; i < tags; i++)
                                if (view.getUint16(offset + (i * 12), little) == 0x0112)
                                    return callback(view.getUint16(offset + (i * 12) + 8, little));
                        }
                        else if ((marker & 0xFF00) != 0xFF00) break;
                        else offset += view.getUint16(offset, false);
                    }
                    return callback(-1);
                };
            }
            // 将图片旋转到正确的角度
            function resetOrientation(srcBase64, srcOrientation, callback) {
                var img = new Image();
                img.onload = function() {
                    var width = img.width,
                            height = img.height,
                            canvas = document.createElement('canvas'),
                            ctx = canvas.getContext("2d");
                    // set proper canvas dimensions before transform & export
                    if ([5,6,7,8].indexOf(srcOrientation) > -1) {
                        canvas.width = height;
                        canvas.height = width;
                    } else {
                        canvas.width = width;
                        canvas.height = height;
                    }
                    // transform context before drawing image
                    switch (srcOrientation) {
                        case 2: ctx.transform(-1, 0, 0, 1, width, 0); break;
                        case 3: ctx.transform(-1, 0, 0, -1, width, height ); break;
                        case 4: ctx.transform(1, 0, 0, -1, 0, height ); break;
                        case 5: ctx.transform(0, 1, 1, 0, 0, 0); break;
                        case 6: ctx.transform(0, 1, -1, 0, height , 0); break;
                        case 7: ctx.transform(0, -1, -1, 0, height , width); break;
                        case 8: ctx.transform(0, -1, 1, 0, 0, width); break;
                        default: ctx.transform(1, 0, 0, 1, 0, 0);
                    }
                    // draw image
                    ctx.drawImage(img, 0, 0);
                    // export base64
                    callback(canvas.toDataURL('image/jpeg'));
                };
                img.src = srcBase64;
            };
		</script>
	</body>

</html>