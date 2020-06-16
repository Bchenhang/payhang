<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>步骤条实例</title>
		<link rel="stylesheet" href="qingjia/jindu/element.min.css" />
	</head>
	<body>
		<div id="myVue">

			<p>1.剧中当前步骤：{{stepVal1}}</p>
		    <el-steps :active="stepVal1" align-center finish-status="success">
			  <el-step title="步骤 1"></el-step>
			  <el-step title="步骤 2"></el-step>
			  <el-step title="步骤 3"></el-step>
			</el-steps>
			<el-button style="margin-top: 12px;" @click="next">下一步</el-button>
			<h3>2.靠左动态步骤条。</h3>
			<p>当前步骤：{{stepVal2}}</p>
			<el-steps :space="200" :active="stepVal2" finish-status="success">
			  <el-step title="已完成"></el-step>
			  <el-step title="进行中"></el-step>
			  <el-step title="步骤 3"></el-step>
			</el-steps>
		</div>
	</body>
	<script type="text/javascript" src="qingjia/jindu/vue.min.js" ></script>
	<script type="text/javascript" src="qingjia/jindu/element.min.js" ></script>
    <script type="text/javascript">
		new Vue({
		    el: '#myVue',
			data: {
			    stepVal1: 0,
			    stepVal2: 2,
			    stepVal3: 3,
			    stepVal4: 4,
			    stepVal5: 1,
			    stepVal6: 2,
			    stepVal7: 3
 			},
			methods: {
			    next() {
			        if (this.stepVal1++ > 2) this.stepVal1 = 0;
			    }
			}
	    })
	</script>
</html>
