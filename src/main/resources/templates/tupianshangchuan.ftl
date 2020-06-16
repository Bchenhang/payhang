<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap Fileinput Demo</title>
    <link href="touxiang/css/bootstrap.min.css" rel="stylesheet">
    <link href="touxiang/css/bootstrap-fileinput.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <div class="page-header">
        <h3>FormData图片上传</h3>
        <form>
            <div class="form-group" id="uploadForm" enctype='multipart/form-data'>
                <div class="h4">图片预览</div>
                <div class="fileinput fileinput-new" data-provides="fileinput"  id="exampleInputUpload">
                    <div class="fileinput-new thumbnail" style="width: 200px;height: auto;max-height:150px;">
                        <img id='picImg' style="width: 100%;height: auto;max-height: 140px;" src="touxiang/images/noimage.png" alt="" />
                    </div>
                    <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 200px; max-height: 150px;"></div>
                    <div>
                        <span class="btn btn-primary btn-file">
                            <span class="fileinput-new">选择文件</span>
                            <span class="fileinput-exists">换一张</span>
                            <input type="file" name="pic1" id="picID" accept="image/gif,image/jpeg,image/x-png"/>
                        </span>
                        <a href="javascript:;" class="btn btn-warning fileinput-exists" data-dismiss="fileinput">移除</a>
                    </div>
                </div>
            </div>
            <button type="button" id="uploadSubmit" class="btn btn-info">提交</button>
        </form>
    </div>
</div>


<script type="text/javascript" src="js/jquery.min.js"></script>
<script src="touxiang/js/bootstrap-fileinput.js"></script>
<script type="text/javascript">
    $(function () {
        //比较简洁，细节可自行完善
        $('#uploadSubmit').click(function () {

           var reads= new FileReader();

           var f=document.getElementById('picID').files[0];
           if (f!=null) {
            reads.readAsDataURL(f);

            reads.onload=function (e) {
                dealImage(this.result, 500, useImg);
                alert(this.result.length);
            };
           }else{
               alert("请选择图片")
           }
        });

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
        str= base64;
        alert(str.length);
        $.ajax({
            url: "/pay/img",
            type: "post",
            data:{imgStr:base64},
            dataType: "json",
            success: function (data) {
                alert("成功！"+data.id)
            }
        })
    }
</script>
</body>
</html>