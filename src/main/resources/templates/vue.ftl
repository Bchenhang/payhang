<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>完美</title>
    <script src="js/vue.js"></script>
    <style type="text/css">
        table {
            border: 1px solid black;
        }
        table {
            width: 100%;
        }

        th {
            height: 50px;
        }
        th, td {
            border-bottom: 1px solid #ddd;
        }
    </style>
</head>
<body>

    <div id="app">
        <runoob></runoob>
    </div>


<script>
    var Child = {
        template: '<h1>自定义组件!</h1>'
    }

    // 创建根实例
    new Vue({
        el: '#app',
        components: {
            // <runoob> 将只在父模板可用
            'runoob': Child
        }
    })
</script>
</body>
</html>