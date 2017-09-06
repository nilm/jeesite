<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>

<style type="text/css">
		body, html{
			width: 100%;
			height: 100%;
			margin:0;
			font-family:"微软雅黑";
			font-size:14px;
		}
		#l-map {
			width:100%; 
			height: 100%;
			left:342px;/* 应该为js计算获得 */
			height:500px;
			overflow: hidden;
		}
		#result{
			width:100%;
		}
		li{
			line-height:28px;
		}
		.cityList{
			height: 320px;
			width:372px;
			overflow-y:auto;
		}
		.sel_container{
			z-index:9999;
			font-size:12px;
			position:absolute;
			right:0px;
			top:0px;
			width:140px;
			background:rgba(255,255,255,0.8);
			height:30px;
			line-height:30px;
			padding:5px;
		}
		.map_popup {
			position: absolute;
			z-index: 200000;
			width: 382px;
			height: 344px;
			right:0px;
			top:40px;
		}
		.map_popup .popup_main { 
			background:#fff;
			border: 1px solid #8BA4D8;
			height: 100%;
			overflow: hidden;
			position: absolute;
			width: 100%;
			z-index: 2;
		}
		.map_popup .title {
			background: url("http://map.baidu.com/img/popup_title.gif") repeat scroll 0 0 transparent;
			color: #6688CC;
			font-weight: bold;
			height: 24px;
			line-height: 25px;
			padding-left: 7px;
		}
		.map_popup button {
			background: url("http://map.baidu.com/img/popup_close.gif") no-repeat scroll 0 0 transparent;
			cursor: pointer;
			height: 12px;
			position: absolute;
			right: 4px;
			top: 6px;
			width: 12px;
		}	
		.left_content {
			  background-color: #fff;
		    left: 0;
		    position: absolute;
		    top: 0;
		    width: 340px;
		    z-index: 999;
		    height: 379px;
    		overflow-y: auto;
			}
			.map{
				//position: relative;
				}
	</style>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=kq53sCGqFHXGrRIUUNaB2xuM"></script>
	<!-- 加载百度地图样式信息窗口 -->
	<script type="text/javascript" src="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.js"></script>
	<link rel="stylesheet" href="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.css" />
	<!-- 加载城市列表 -->
	<script type="text/javascript" src="http://api.map.baidu.com/library/CityList/1.2/src/CityList_min.js"></script>
	
	<!-- 路况 -->
	<link href="http://api.map.baidu.com/library/TrafficControl/1.4/src/TrafficControl_min.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="http://api.map.baidu.com/library/TrafficControl/1.4/src/TrafficControl_min.js"></script>
	  <script type="text/javascript" src="http://developer.baidu.com/map/jsdemo/demo/convertor.js"></script>
	  
<div class="header" style="height:150px;border: 1px solid #000;">
		头
		</div>
	<div class="map">
		
<!-- 		<div class="left_content company_content">
			<ul class="company_list" id="wash_cars">
				
			</ul>
			
		</div> -->
	
	<div id="l-map" class="right-content"></div>
			<!-- <div id="result">
				<button id="open">打开</button><button id="close">关闭</button>
			</div>
			-->
			<!--城市列表-->
			<!--
			<div class="sel_container"><strong id="curCity">北京市</strong> [<a id="curCityText" href="javascript:void(0)">更换城市</a>]</div>
			<div class="map_popup" id="cityList" style="display:none;">
				<div class="popup_main">
					<div class="title">城市列表</div>
					<div class="cityList" id="citylist_container"></div>
					<button id="popup_close"></button>
				</div>
			</div>
			-->
		</div>

</body>
</html>
<c:url value="/getLocations" var="getLocations"></c:url>
<script type="text/javascript">
var ds = jQuery.parseJSON('[{"name":"\u5317\u4eac\u6c11\u65b0\u946b\u665f\u6c7d\u8f66\u670d\u52a1\u7ad9","lat":"39.876596","lng":"116.387369","tel":"010-83106100","address":"\u5317\u4eac\u5e02\u4e30\u53f0\u533a\u53f3\u5916\u4e1c\u5e8413\u53f7","bhours":"","p1":"0","p4":"0","p2":"21","p3":"29"},{"name":"\u9753\u8f66\u4f1a\u4ea6\u5e84\u5e97","lat":"39.806815","lng":"116.514668","tel":"010-67877619","address":"\u5317\u4eac\u5e02\u4ea6\u5e84\u5f00\u53d1\u533a\u5b8f\u8fbe\u5317\u8def12\u53f7\u521b\u65b0\u5927\u53a6101","bhours":"","p1":"0","p4":"0","p2":"33","p3":"47"},{"name":"\u5317\u4eac\u4e16\u5609\u946b\u6e90\u6c7d\u8f66\u670d\u52a1\u4e2d\u5fc3","lat":"39.8021","lng":"116.479254","tel":"010-67899945","address":"\u7ecf\u6d4e\u6280\u672f\u5f00\u53d1\u533a\u897f\u73af\u5317\u8def\u5bcc\u6e90\u91cc\u7269\u4e1a1\u5c42","bhours":"","p1":"0","p4":"0","p2":"28","p3":"40"},{"name":"\u5317\u4eac\u6d01\u4eae\u6c7d\u8f66\u7ef4\u4fee\u4e2d\u5fc3","lat":"39.749542","lng":"116.32828","tel":"010-69298853","address":"\u5317\u4eac\u5e02\u5927\u5174\u533a\u6e05\u6e90\u897f\u8def55\u53f7","bhours":"","p1":"0","p4":"0","p2":"24","p3":"24"},{"name":"\u7f8e\u5149\u6c7d\u8f66\u517b\u62a4\u4e2d\u5fc3","lat":"40.014533","lng":"116.376478","tel":"13911367558","address":"\u5317\u4eac\u5e02\u6d77\u6dc0\u533a\u5317\u6c99\u6ee9\u6865\u53171\u516c\u91cc\u8def\u897f\u79d1\u53c1\u6865\u897f\u5357\u89d2","bhours":"","p1":"0","p4":"0","p2":"37.5","p3":"45"},{"name":"\u661f\u98de\u8fbe\u6c7d\u8f66\u670d\u52a1\u516c\u53f8","lat":"39.874311","lng":"116.369746","tel":"13910162513","address":"\u53f3\u5b89\u95e8\u897f\u6ee8\u6cb3\u8def\u897f\u5934\u67612\u53f7\u4e2d\u77f3\u6cb9\u52a0\u6cb9\u7ad9\u5185","bhours":"","p1":"0","p4":"0","p2":"25","p3":"31"},{"name":"\u4e2d\u745e\u6c7d\u8f66\u88c5\u9970\uff08\u4e2d\u745e\u6c7d\u670d\u738b\u56fd\uff09","lat":"39.964792","lng":"116.496377","tel":"010-84503868","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u5357\u5341\u91cc\u5c4548\u53f7\u96622\u53f7\u697c2-01","bhours":"","p1":"0","p4":"0","p2":"24","p3":"29"},{"name":"\u5317\u4eac\u5e02\u5723\u6797\u6c7d\u4fee","lat":"39.878399","lng":"116.392156","tel":"13718914312","address":"\u592a\u5e73\u885719\u53f7","bhours":"","p1":"0","p4":"0","p2":"30","p3":"45"},{"name":"\u91d1\u5229\u76db\u6e90\u6c7d\u8f66\u670d\u52a1\u4e2d\u5fc3","lat":"39.897298","lng":"116.671705","tel":"010-60528245","address":"\u901a\u5dde\u533a\u8fd0\u6cb3\u5927\u8857\u4e5d\u68f5\u681111\u53f7","bhours":"","p1":"0","p4":"0","p2":"19","p3":"24"},{"name":"\u5317\u4eac\u5e02\u5929\u5929\u610f\u6c7d\u8f66\u88c5\u9970\u6709\u9650\u516c\u53f8","lat":"39.895205","lng":"116.388367","tel":"13718914312","address":"\u9676\u7136\u4ead\u5c0f\u533a\u5e73\u623f1\u53f7","bhours":"","p1":"0","p4":"0","p2":"20","p3":"29"},{"name":"\u5317\u4eac\u7965\u4ea6\u884c\u6c7d\u8f66\u670d\u52a1\u6709\u9650\u516c\u53f8","lat":"39.772121","lng":"116.518771","tel":"010-67808799","address":"\u5317\u4eac\u5e02\u5927\u5174\u533a\u4ea6\u5e84\u9547\u51c9\u6c34\u6cb3\u4e00\u533a50\u53f7","bhours":"","p1":"0","p4":"0","p2":"24","p3":"28"},{"name":"\u5317\u4eac\u5e7f\u8fbe\u5bcc\u6d01\u6c7d\u8f66\u670d\u52a1\u6709\u9650\u516c\u53f8","lat":"39.887589","lng":"116.273708","tel":"010-57228160","address":"\u5317\u4eac\u5e02\u4e30\u53f0\u533a\u9b4f\u5bb6\u6751\u5357\u8def21\u53f7\u96625\u53f7\u697c\u5e95\u5546","bhours":"","p1":"0","p4":"0","p2":"27","p3":"39"},{"name":"\u4e2d\u8f66\uff08\u5317\u4eac\uff09\u6c7d\u4fee\u8fde\u9501\u6709\u9650\u516c\u53f8\u5b89\u8d1e\u5206\u516c\u53f8","lat":"39.976703","lng":"116.405125","tel":"010-64420561","address":"\u671d\u9633\u533a\u5b89\u8d1e\u897f\u91cc4\u533a16\u53f7\u697c","bhours":"","p1":"0","p4":"0","p2":"24","p3":"29"},{"name":"\u6765\u5b9d\u6c7d\u8f66\u7f8e\u5bb9\u5e97","lat":"39.798582","lng":"116.497221","tel":"010-67820970","address":"\u5317\u4eac\u5e02\u4ea6\u5e84\u7ecf\u6d4e\u6280\u672f\u5f00\u53d1\u533a\u5929\u5b9d\u4e2d\u88573\u53f7","bhours":"","p1":"0","p4":"0","p2":"18","p3":"18"},{"name":"\u9f9f\u535a\u58eb\u6c7d\u8f66\u7f8e\u5bb9\u8fde\u9501","lat":"39.798169","lng":"116.334233","tel":"13621325613","address":"\u5317\u4eac\u5e02\u5927\u5174\u533a\u897f\u7ea2\u95e8\u5730\u94c1\u7ad9\u4e16\u5609\u535a\u82d163\u53f7","bhours":"","p1":"0","p4":"0","p2":"21","p3":"28"},{"name":"\u5317\u4eac\u6e05\u6e90\u4e16\u7eaa\u6c7d\u8f66\u670d\u52a1\u6709\u9650\u8d23\u4efb\u516c\u53f8","lat":"40.014255","lng":"116.361486","tel":"010-51551102","address":"\u6d77\u6dc0\u533a\u5317\u822a\u897f\u95e8\u4e94\u9053\u53e3\u8d2d\u7269\u5e7f\u573a\u897f\u4fa7\u65b0\u6751\u56db\u53f7","bhours":"","p1":"0","p4":"0","p2":"24","p3":"24"},{"name":"\u5317\u4eac\u5174\u8fd0\u6765\u6c7d\u8f66\u7ef4\u4fee\u6709\u9650\u516c\u53f8","lat":"39.748536","lng":"116.346968","tel":"010-61232169","address":"\u5317\u4eac\u5e02\u5927\u5174\u533a\u9ec4\u6751\u9547\u897f\u8def\u6e14\u6751\u6751\u59d4\u4f1a\u5357800\u7c73","bhours":"","p1":"0","p4":"0","p2":"18","p3":"24"},{"name":"\u5317\u4eac\u5e02\u6e14\u6e56\u6c7d\u8f66\u670d\u52a1\u90e8","lat":"39.864309","lng":"116.415538","tel":"13701271647","address":"\u4e30\u53f0\u533a\u4e1c\u6728\u6a28\u56ed\u505c\u8f66\u573a\u9662\u5185","bhours":"","p1":"0","p4":"0","p2":"18","p3":"21"},{"name":"\u535a\u6587\u6c7d\u8f66\u517b\u62a4\u8fde\u9501\u4e2d\u5fc3","lat":"39.777975","lng":"116.54501","tel":"15011255012","address":"\u5317\u4eac\u5e02\u7ecf\u6d4e\u6280\u672f\u5f00\u53d1\u533a\u5eb7\u5b9a\u885718\u53f7\u6c38\u5eb7\u516c\u5bd3\u5e95\u5546","bhours":"","p1":"0","p4":"0","p2":"28","p3":"38"},{"name":"\u5317\u4eac\u5c1a\u8f66\u4f1a\u56fd\u9645\u540d\u8f66\u670d\u52a1\u673a\u6784","lat":"39.86326","lng":"116.391149","tel":"010-83494654","address":"\u5317\u4eac\u5e02\u4e30\u53f0\u533a\u5357\u4e09\u73af\u5185\u6d0b\u6865\u5411\u897f500\u7c73\u8f85\u8def","bhours":"","p1":"0","p4":"0","p2":"31","p3":"92"},{"name":"\u5317\u4eac\u6cf0\u5fb7\u884c\u6c7d\u8f66\u7ef4\u4fee\u670d\u52a1\u6709\u9650\u516c\u53f8","lat":"39.869823","lng":"116.39574","tel":"13031138341","address":"\u4e30\u53f0\u533a\u5357\u4e09\u73af\u4e2d\u8def\u897f\u7f57\u56ed28\u53f7\u9662","bhours":"","p1":"0","p4":"0","p2":"24","p3":"29"},{"name":"\u5317\u4eac\u5929\u4f51\u660e\u667a\u88c5\u9970\u670d\u52a1\u4e2d\u5fc3","lat":"39.859226","lng":"116.603243","tel":"010-85380642","address":"\u671d\u9633\u533a\u9ed1\u5e84\u6237\u90ce\u5404\u5e84\u6751\u6751\u59d4\u4f1a\u4e1c\u4fa7\u4e03\u91cc\u8def5\u53f7","bhours":"","p1":"0","p4":"0","p2":"18","p3":"24"},{"name":"\u51c0\u8f66\u6c47","lat":"39.93349","lng":"116.468861","tel":"010-65167375","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u4e1c\u4e09\u73af\u5317\u8def\u753226\u53f7\u535a\u745e\u5927\u53a6B3\u5c4292-96","bhours":"","p1":"0","p4":"0","p2":"29","p3":"41"},{"name":"\u4e1c\u65b9\u6c38\u4fe1","lat":"39.871946","lng":"116.408649","tel":"010-87818806","address":"\u4e1c\u57ce\u533a\u6c38\u5b9a\u95e8\u5916\u5927\u885760\u53f7\u9662","bhours":"","p1":"0","p4":"0","p2":"18","p3":"29"},{"name":"\u5317\u4eac\u56de\u9f99\u89c2\u946b\u8bda\u6c7d\u8f66\u6e05\u6d17\u4e2d\u5fc3","lat":"40.070684","lng":"116.351763","tel":"13522933410","address":"\u5317\u4eac\u5e02\u660c\u5e73\u533a\u56de\u9f99\u89c2\u9547\u9ec4\u571f\u4e1c\u675119\u53f7","bhours":"","p1":"0","p4":"0","p2":"20","p3":"26"},{"name":"\u68a6\u4e4b\u8f66","lat":"40.075901","lng":"116.328272","tel":"010-82941449","address":"\u5317\u4eac\u5e02\u660c\u5e73\u533a\u56de\u9f99\u89c2\u65b0\u9f99\u57ce\u516d\u53f7\u697c\u5bf9\u9762\u5fb7\u56fd\u9a6c\u724c","bhours":"","p1":"0","p4":"0","p2":"24","p3":"29"},{"name":"\u5341\u91cc\u5821\u6d17\u8f66\u5382\uff08\u5341\u91cc\u5821\u5e97\uff09","lat":"39.922847","lng":"116.512416","tel":"18610052972","address":"\u671d\u9633\u533a\u5341\u91cc\u58211\u53f7\u697c\u5357\u4fa71\u5e73\u623f","bhours":"","p1":"0","p4":"0","p2":"24","p3":"33"},{"name":"\u817e\u8fbe\u5e86\u7ea2\u6c7d\u8f66\u88c5\u9970\u670d\u52a1\u6709\u9650\u516c\u53f8","lat":"40.094336","lng":"116.426699","tel":"010-81778267","address":"\u660c\u5e73\u533a\u5317\u4e03\u5bb6\u9547\u4e1c\u4e09\u65d7\u6751\u6751\u5317\u5317\u8fb0\u4e9a\u8fd0\u6751\u6c7d\u8f66\u8d38\u6613\u4ea4\u6613\u5e02\u573a\u4e2d\u5fc3\u5317\u533a","bhours":"","p1":"0","p4":"0","p2":"59","p3":"71"},{"name":"\u4eae\u6d01\u6d17\u8f66\u5e97","lat":"40.09664","lng":"116.350293","tel":"13911411165","address":"\u56de\u9f99\u89c2\u6d41\u661f\u82b1\u56ed\u4e09\u533a\u897f\u95e8\u5f80\u5317400\u7c73","bhours":"","p1":"0","p4":"0","p2":"14","p3":"20"},{"name":"\u946b\u4e9a\u817e\u8fbe","lat":"40.08243","lng":"116.338644","tel":"13520777172","address":"\u660c\u5e73\u533a\u56de\u9f99\u89c2\u5c11\u6797\u6b66\u672f\u5b66\u6821","bhours":"","p1":"0","p4":"0","p2":"16","p3":"21"},{"name":"0318\u6c7d\u8f66\u670d\u52a1\u4e2d\u5fc3","lat":"40.08243","lng":"116.338644","tel":"13811306193","address":"\u660c\u5e73\u533a\u56de\u9f99\u89c2\u4f53\u80b2\u516c\u56ed\u4e1c\u95e8\u5357200\u7c73","bhours":"","p1":"0","p4":"0","p2":"16","p3":"22"},{"name":"\u5317\u4eac\u534e\u5cf0\u6e90\u6c7d\u8f66\u670d\u52a1\u4e2d\u5fc3","lat":"40.058289","lng":"116.337615","tel":"18910646585","address":"\u660c\u5e73\u533a\u897f\u4e09\u65d7\u6865\u4e1c\u5317\u89d2\u91d1\u699c\u56ed\u5c0f\u533a\u5317\u95e8\u5e73\u623f","bhours":"","p1":"0","p4":"0","p2":"15","p3":"21"},{"name":"\u9753\u8f66\u5802\u6c7d\u8f66\u670d\u52a1","lat":"40.064545","lng":"116.419086","tel":"010-84821190","address":"\u5317\u4eac\u5e02\u660c\u5e73\u533a\u5929\u901a\u82d1\u9f99\u5fb7\u5e7f\u573a\u5411\u5317200\u7c73","bhours":"","p1":"0","p4":"0","p2":"24","p3":"29"},{"name":"\u58f9\u6377\u6c7d\u8f66\u670d\u52a1","lat":"39.871658","lng":"116.465357","tel":"010-67486966-10","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u5927\u7f8a\u574a\u8def168\u53f7","bhours":"","p1":"0","p4":"0","p2":"47","p3":"0"},{"name":"\u5317\u4eac\u7504\u6613\u884c\u6c7d\u8f66\u88c5\u9970\u4e2d\u5fc3","lat":"39.887632","lng":"116.453561","tel":"15810989476","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u52b2\u677e\u516b\u533a826\u53f71\u5c42","bhours":"","p1":"0","p4":"0","p2":"27","p3":"32"},{"name":"\u5317\u4eac\u4eac\u6770\u6c7d\u8f66\u670d\u52a1\u6709\u9650\u516c\u53f8","lat":"40.045023","lng":"116.337526","tel":"13911693050","address":"\u5317\u4eac\u5e02\u6d77\u6dc0\u533a\u6e05\u6cb3\u6e05\u4e0a\u56ed\u5c0f\u533a1\u53f7\u697c\u5e95\u5546","bhours":"","p1":"0","p4":"0","p2":"20","p3":"26"},{"name":"\u8302\u9686\u8fbe\u6c7d\u8f66\u7f8e\u5bb9\u4e2d\u5fc3","lat":"39.974123","lng":"116.441315","tel":"13321153088","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u5149\u7199\u95e8\u5317\u91cc20\u53f7\u697c\u9053\u5bb6\u5e38\u9152\u5e97\u540e\u9662","bhours":"","p1":"0","p4":"0","p2":"24","p3":"29"},{"name":"\u5317\u4eac\u559c\u8f66\u90ce\u6c7d\u8f66\u670d\u52a1\u6709\u9650\u516c\u53f8","lat":"40.006143","lng":"116.43165","tel":"15210142066","address":"\u671d\u9633\u533a\u5c0f\u8425\u5317\u8def23\u53f7\u96627\u53f7\u697c\u5e95\u5546","bhours":"","p1":"0","p4":"0","p2":"28","p3":"39"},{"name":"3M\u9646\u6865\u6c7d\u8f66\u7f8e\u5bb9\u4e2d\u5fc3","lat":"39.976333","lng":"116.340485","tel":"010-62004417","address":"\u6d77\u6dc0\u533a\u4e2d\u5173\u6751\u4e1c\u8def123-3\u53f7\u697c","bhours":"","p1":"0","p4":"0","p2":"35","p3":"47"},{"name":"\u5317\u4eac\u4e07\u4f17\u745e\u901a\u6c7d\u8f66\u7ef4\u4fee\u6709\u9650\u516c\u53f8","lat":"39.991924","lng":"116.353168","tel":"010-82331810","address":"\u6d77\u6dc0\u533a\u5317\u56db\u73af\u4e2d\u8def246\u53f7\uff08\u5317\u4eac\u57ce\u5e02\u5b66\u9662\u5bf9\u9762\uff09","bhours":"","p1":"0","p4":"0","p2":"21","p3":"29"},{"name":"\u5317\u4eac\u65b0\u601d\u8def\u6c7d\u8f66\u670d\u52a1\u6709\u9650\u516c\u53f8","lat":"39.945494","lng":"116.385744","tel":"010-83224169","address":"\u5317\u4eac\u5e02\u897f\u57ce\u533a\u5fb7\u5185\u5927\u8857219\u53f7","bhours":"","p1":"0","p4":"0","p2":"21","p3":"29"},{"name":"\u5317\u4eac\u91d1\u4e4b\u6865\u5965\u901a\u6c7d\u8f66\u670d\u52a1\u6709\u9650\u516c\u53f8","lat":"39.863252","lng":"116.351339","tel":"010-63847830","address":"\u4e30\u53f0\u533a\u4e07\u6cc9\u5bfa\u6886\u5b50\u4e95117\u53f7","bhours":"","p1":"0","p4":"0","p2":"24","p3":"24"},{"name":"\u5317\u4eac\u4eac\u9a70\u9510\u6d3e\u6c7d\u8f66\u7ef4\u4fee\u6709\u9650\u516c\u53f8","lat":"39.858528","lng":"116.421158","tel":"010-87822098","address":"\u5317\u4eac\u5e02\u4e30\u53f0\u533a\u8d3e\u5bb6\u82b1\u56ed3\u53f7\u966218\u53f7\u697c101","bhours":"","p1":"0","p4":"0","p2":"29","p3":"35"},{"name":"\u9a70\u8010\u666e\u6c7d\u8f66\u7f8e\u5bb9\u88c5\u9970\u8fde\u9501\u5e97","lat":"39.848672","lng":"116.480781","tel":"010-97166787","address":"\u5341\u516b\u91cc\u5e97\u5357\u6865\u5415\u5bb6\u8425\u5415\u8425\u5609\u56edA\u533a\u5357\u5899","bhours":"","p1":"0","p4":"0","p2":"21","p3":"33"},{"name":"\u5317\u4eac\u77e5\u6625\u6c7d\u8f66\u88c5\u9970\u6709\u9650\u516c\u53f8","lat":"39.982085","lng":"116.342875","tel":"13621007685","address":"\u5317\u4eac\u5e02\u6d77\u6dc0\u533a\u77e5\u6625\u8def118\u9662\u5185","bhours":"","p1":"0","p4":"0","p2":"24","p3":"35"},{"name":"\u4eac\u8f66\u6c47(\u5317\u4eac\uff09\u6c7d\u8f66\u6280\u672f\u670d\u52a1\u6709\u9650\u516c\u53f8","lat":"39.828427","lng":"116.494592","tel":"010-87690030","address":"\u671d\u9633\u533a\u535a\u5927\u8def\u75321\u53f7","bhours":"","p1":"192","p4":"249","p2":"71","p3":"92"},{"name":"\u5317\u4eac\u5b63\u6e05\u6c38\u6d01\u6c7d\u8f66\u670d\u52a1\u6709\u9650\u516c\u53f8","lat":"39.953421","lng":"116.251436","tel":"010-88452633","address":"\u6d77\u6dc0\u533a\u674f\u77f3\u53e3\u8def40\u53f7","bhours":"","p1":"0","p4":"0","p2":"30","p3":"35"},{"name":"\u5b89\u534e\u4e16\u901a\u6c7d\u8f66","lat":"39.90501","lng":"116.350509","tel":"010-63280372","address":"\u5317\u4eac\u5e02\u897f\u57ce\u533a\u767d\u4e91\u89c2\u8857\u4e1c\u53e3\u5b89\u534e\u4e16\u901a\u6c7d\u8f66","bhours":"","p1":"0","p4":"0","p2":"27","p3":"29"},{"name":"\u5317\u4eac\u6052\u8fbe\u4f1f\u4e1a\u6c7d\u8f66\u88c5\u9970","lat":"39.958953","lng":"116.521695","tel":"010-51193849","address":"\u671d\u9633\u533a\u9752\u5e74\u8def\u5317\u53e3118\u53f7","bhours":"","p1":"0","p4":"0","p2":"21","p3":"33"},{"name":"\u9753\u8f66\u4f1a\u4e30\u76ca\u6865\u5e97","lat":"39.862958","lng":"116.315269","tel":"010-63870512","address":"\u4e30\u7ba1\u8def16\u53f7\u897f\u56fd\u8d38\u6c7d\u914d\u57fa\u5730A7-1038\u5ba4","bhours":"","p1":"0","p4":"0","p2":"59","p3":"59"},{"name":"\u5317\u4eac\u65b9\u5174\u6d01\u6d01\u6c7d\u8f66\u88c5\u9970\u670d\u52a1\u6709\u9650\u516c\u53f8","lat":"39.977836","lng":"116.34542","tel":"010-82117635","address":"\u5317\u4eac\u6d77\u6dc0\u533a\u592a\u9633\u56ed\u5c0f\u533a2\u53f7\u697c\u5730\u4e0b\u4e00\u5c42","bhours":"","p1":"0","p4":"0","p2":"24","p3":"24"},{"name":"\u5317\u4eac\u5e02\u76db\u7965\u6c7d\u8f66\u670d\u52a1\u4e2d\u5fc3","lat":"40.070854","lng":"116.431355","tel":"010-52498852","address":"\u5317\u4eac\u5e02\u660c\u5e73\u533a\u5929\u901a\u82d1\u91d1\u767e\u4e07\u7ea2\u8def\u706f600\u7c73\u8def\u5317","bhours":"","p1":"0","p4":"0","p2":"30","p3":"45"},{"name":"\u90a3\u5bb6\u6d17\u8f66\u62a4\u7406\u4e2d\u5fc3","lat":"40.08243","lng":"116.338644","tel":"010-57228603","address":"\u5317\u4eac\u5e02\u660c\u5e73\u533a\u56de\u9f99\u89c2\u4e1c\u4e9a\u5317\u5c0f\u533a\u5317\u95e8\u5e95\u554616","bhours":"","p1":"0","p4":"0","p2":"24","p3":"29"},{"name":"\u73af\u5b87\u8def\u901a\u6c7d\u8f66\u7f8e\u5bb9\u4e2d\u5fc3","lat":"40.081443","lng":"116.348693","tel":"010-81727204","address":"\u660c\u5e73\u533a\u56de\u9f99\u89c2\u897f\u5927\u8857\u6587\u5316\u8def\u946b\u5730\u5e02\u573a\u4e1c\u95e8","bhours":"","p1":"0","p4":"0","p2":"20","p3":"24"},{"name":"\u4f17\u4fe1\u6c7d\u8f66\u6280\u672f\u670d\u52a1\u4e2d\u5fc3","lat":"40.091932","lng":"116.33885","tel":"010-82919819","address":"\u660c\u5e73\u533a\u80b2\u77e5\u4e1c\u8def\u5357\u5934\u4e1c50\u7c73","bhours":"","p1":"0","p4":"0","p2":"14","p3":"18"},{"name":"\u5b8f\u6d9b\u6c7d\u8f66\u670d\u52a1\u6709\u9650\u516c\u53f8","lat":"39.79341","lng":"116.345264","tel":"13901318417","address":"\u5317\u4eac\u5e02\u5927\u5174\u533a\u897f\u7ea2\u95e8\u9547\u5b8f\u65ed\u8def1\u5c42236\u53f7","bhours":"","p1":"0","p4":"0","p2":"28","p3":"21"},{"name":"\u798f\u9f99\u8fbe\u6c7d\u8f66\u88c5\u9970\u4e2d\u5fc3","lat":"39.79341","lng":"116.345264","tel":"13124725208","address":"\u5317\u4eac\u5e02\u5927\u5174\u533a\u897f\u7ea2\u95e8\u745e\u6d77\u4e09\u533a294\u53f7","bhours":"","p1":"0","p4":"0","p2":"30","p3":"37.5"},{"name":"\u5317\u4eac\u6e9f\u6e24\u6e7e\u6c7d\u8f66\u88c5\u9970\u5546\u884c","lat":"39.838015","lng":"116.455888","tel":"010-61004891","address":"\u671d\u9633\u533a\u5357\u56db\u73af\u8096\u6751\u6865\u5357\u4e00\u516c\u91cc\u5c0f\u7ea2\u95e8\u6c7d\u8f66\u7528\u54c1\u57ceA\u533a09\u53f7","bhours":"","p1":"0","p4":"0","p2":"24","p3":"24"},{"name":"\u5317\u4eac\u8d8a\u946b\u8fbe\u6c7d\u8f66\u4fee\u7406\u670d\u52a1\u4e2d\u5fc3","lat":"39.875368","lng":"116.41354","tel":"010-67251107","address":"\u5317\u4eac\u5e02\u5d07\u6587\u533a\u6c38\u5916\u6843\u6768\u8def15\u53f7","bhours":"","p1":"0","p4":"0","p2":"21","p3":"29"},{"name":"\u822a\u5929\u6c7d\u4fee","lat":"39.956846","lng":"116.431488","tel":"010-84222208","address":"\u5317\u4eac\u5e02\u4e1c\u57ce\u533a\u548c\u5e73\u91cc\u4e1c\u885715\u53f7","bhours":"","p1":"0","p4":"0","p2":"21","p3":"40"},{"name":"\u5317\u4eac\u5929\u4fdd\u9686\u6c7d\u8f66\u670d\u52a1\u6709\u9650\u8d23\u4efb\u516c\u53f8","lat":"39.906495","lng":"116.451545","tel":"010-67752135","address":"\u5317\u4eac\u5e02\u4e1c\u57ce\u533a\u5fe0\u5b9e\u91cc\u5357\u88571\u53f7\u5e7f\u6e20\u95e8\u6865\u5411\u5317100\u7c73","bhours":"","p1":"0","p4":"0","p2":"24","p3":"24"},{"name":"\u5b8f\u6e90\u5cf0\u6865\u5de5\u4f53\u5e97","lat":"39.931546","lng":"116.444173","tel":"010-65539090","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u671d\u5916\u5409\u5e86\u91cc\u5c0f\u533a\u4e03\u53f7\u697c","bhours":"","p1":"0","p4":"0","p2":"38","p3":"38"},{"name":"\u5317\u4eac\u5e02\u661f\u706b\u6c7d\u8f66\u7ef4\u4fee\u670d\u52a1\u90e8","lat":"39.890969","lng":"116.357423","tel":"010-63513474","address":"\u5317\u4eac\u5e02\u897f\u57ce\u533a\u5357\u7ebf\u91cc56\u53f7","bhours":"","p1":"0","p4":"0","p2":"24","p3":"29"},{"name":"\u5317\u4eac\u9f99\u660a\u7fd4\u6c7d\u8f66\u7ef4\u4fee\u4e2d\u5fc3","lat":"39.878189","lng":"116.414935","tel":"010-87273068","address":"\u5317\u4eac\u5e02\u4e1c\u57ce\u533a\u6c38\u5916\u4e1c\u6ee8\u6cb3\u8def11\u53f7","bhours":"","p1":"0","p4":"0","p2":"21","p3":"22"},{"name":"\u5929\u5b89\u6c7d\u4fee","lat":"39.804602","lng":"116.315944","tel":"010-81793332","address":"\u5317\u4eac\u5e02\u4e30\u53f0\u82b1\u4e61\u9ad8\u7acb\u5e84584\u53f7","bhours":"","p1":"0","p4":"0","p2":"24","p3":"24"},{"name":"\u540d\u819c\u9970\u754c","lat":"39.86666","lng":"116.459641","tel":"010-67650116","address":"\u5317\u4eac\u4e30\u53f0\u5357\u4e09\u73af\u65b9\u5e84\u6865\u5f80\u5357800\u7c73\u8def\u4e1c","bhours":"","p1":"0","p4":"0","p2":"24","p3":"29"},{"name":"\u9f99\u819c\u4e13\u8425\u5e97\uff08\u4e91\u7fd4\u9e4f\u5e97\uff09","lat":"40.080552","lng":"116.315009","tel":"010-81793332","address":"\u5317\u4eac\u660c\u5e73\u56de\u9f99\u89c2\u6b27\u5fb7\u5b9d\u6c7d\u8f66\u57ce4S\u5357\u5904","bhours":"","p1":"0","p4":"0","p2":"24","p3":"29"},{"name":"\u5317\u4eac\u9e3f\u8fd0\u80dc\u8fbe\u6c7d\u8f66\u6280\u672f\u670d\u52a1\u6709\u9650\u516c\u53f8","lat":"39.819685","lng":"116.297859","tel":"13718036528","address":"\u4e30\u53f0\u533a\u4e30\u8446\u8def168\u53f7\u5317\u4eac\u56fd\u9645\u82b1\u56ed198\u53f71\u81f32\u5c42","bhours":"","p1":"0","p4":"0","p2":"21","p3":"29"},{"name":"\u5317\u4eac\u5c0f\u9a6c\u6d17\u8f66","lat":"39.930353","lng":"116.218792","tel":"13718036528","address":"\u6d77\u6dc0\u533a\u961c\u77f3\u8def\u664b\u5143\u6865\u4e1c\u5317\u89d2","bhours":"","p1":"0","p4":"0","p2":"21","p3":"29"},{"name":"\u5317\u4eac\u5e02\u6cf0\u5fb7\u884c\u6c7d\u8f66\u7ef4\u4fee\u670d\u52a1\u6709\u9650\u516c\u53f8","lat":"39.869823","lng":"116.39574","tel":"010-87259766","address":"\u5317\u4eac\u5e02\u4e30\u53f0\u533a\u5357\u4e09\u73af\u4e2d\u8def\u897f\u7f57\u56ed28\u53f7\u9662","bhours":"","p1":"0","p4":"0","p2":"24","p3":"29"},{"name":"\u5317\u4eac\u5e02\u5929\u5929\u610f\u6c7d\u8f66\u88c5\u9970\u6709\u9650\u516c\u53f8","lat":"39.884635","lng":"116.39007","tel":"010-63522492","address":"\u897f\u57ce\u533a\u9676\u7136\u4ead\u5c0f\u533a\u5e73\u623f1\u53f7","bhours":"","p1":"0","p4":"0","p2":"24","p3":"28"},{"name":"\u7acb\u65b0\u6c7d\u8f66\u7ef4\u4fee\u7ad9","lat":"39.93428","lng":"116.37319","tel":"13301281796","address":"\u897f\u57ce\u533a\u897f\u9ec4\u57ce\u697c\u5317\u885723\u53f7","bhours":"","p1":"0","p4":"0","p2":"45","p3":"67.5"},{"name":"\u5b8f\u6e90\u5cf0\u6865\u751c\u6c34\u56ed\u5e97","lat":"39.934145","lng":"116.486948","tel":"010-65067884","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u751c\u6c34\u56ed\u5317\u91cc\u4e03\u53f7\u697c\u5e95\u5546","bhours":"","p1":"0","p4":"0","p2":"38","p3":"38"},{"name":"\u5317\u4eac\u534e\u76db\u7965\u6c7d\u8f66\u670d\u52a1\u4e2d\u5fc3","lat":"40.083882","lng":"116.452624","tel":"010-52498652","address":"\u660c\u5e73\u533a\u5929\u901a\u82d1\u91d1\u767e\u4e07\u7ea2\u7eff\u706f\u5411\u4e1c600\u7c73","bhours":"","p1":"0","p4":"0","p2":"18","p3":"24"},{"name":"\u5317\u4eac\u946b\u6d0b\u660e\u73e0\u6c7d\u8f66\u88c5\u9970\u884c","lat":"40.014533","lng":"116.376478","tel":"010-62310097","address":"\u6d77\u6dc0\u533a\u5317\u6c99\u6ee9\u6865\u53171\u516c\u91cc\u8def\u897f\u79d1\u835f\u6865\u897f\u5357\u89d2","bhours":"","p1":"0","p4":"0","p2":"29","p3":"29"},{"name":"\u4eac\u4eba\u6d17\u8f66\u5e97","lat":"40.09664","lng":"116.346699","tel":"13911411165","address":"\u660c\u5e73\u533a\u56de\u9f99\u89c2\u6d41\u661f\u82b1\u56ed\u4e09\u533a\u897f\u95e8\u5f80\u4e1c400\u7c73","bhours":"","p1":"0","p4":"0","p2":"22.5","p3":"30"},{"name":"\u5317\u4eac\u5174\u8fd0\u6765\u6c7d\u8f66\u88c5\u9970\u7f8e\u5bb9","lat":"39.748735","lng":"116.34283","tel":"010-61232169","address":"\u5927\u5174\u533a\u98de\u6e05\u6e90\u897f\u91cc\u79cb\u62696\u53f7\u95e8\u5e97","bhours":"","p1":"0","p4":"0","p2":"18","p3":"24"},{"name":"\u5317\u4eac\u9e3f\u6e90\u80dc\u8fbe\u6c7d\u8f66\u6280\u672f\u6709\u9650\u516c\u53f8","lat":"39.819685","lng":"116.297859","tel":"13718036528","address":"\u4e30\u53f0\u4e30\u8446\u8def168\u53f7\u5317\u4eac\u56fd\u9645\u82b1\u56ed198\u53f71\u81f32\u5c42","bhours":"","p1":"0","p4":"0","p2":"30","p3":"45"},{"name":"\u660c\u9f99\u7231\u8f66\u7f8e\u5bb9\u88c5\u9970\u4e2d\u5fc3","lat":"40.071287","lng":"116.342037","tel":"010-82919819","address":"\u660c\u5e73\u533a\u80b2\u77e5\u4e1c\u8def\u5357\u5934\u4e1c50\u7c73","bhours":"","p1":"0","p4":"0","p2":"14","p3":"18"},{"name":"\u5317\u4eac\u5eb7\u5fb7\u6e90\u7535\u8111\u6d17\u8f66\u884c","lat":"39.897632","lng":"116.347581","tel":"010-63313930","address":"\u897f\u57ce\u533a\u5e7f\u5b89\u95e8\u5916\u5e7f\u534e\u8f69\u5c0f\u533a\u5317\u95e8","bhours":"","p1":"0","p4":"0","p2":"24","p3":"29"},{"name":"\u5317\u4eac\u7f8e\u4ed1\u6d01\u6c7d\u8f66\u88c5\u9970\u6709\u9650\u516c\u53f8","lat":"39.93046","lng":"116.523654","tel":"010-59227021","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u9752\u5e74\u8def\u5c45\u4f4f\u5c0f\u533a\u4e09\u53f7\u697c","bhours":"","p1":"0","p4":"0","p2":"25","p3":"31"},{"name":"\u5317\u4eac\u5e02\u671d\u9633\u534e\u5317\u6c7d\u8f66\u4fee\u7406\u5e97","lat":"39.930461","lng":"116.523692","tel":"010-85515885","address":"\u671d\u9633\u533a\u5e73\u623f\u4e61\u59da\u5bb6\u56ed\u9752\u5e74\u8def\u5317\u53e3","bhours":"","p1":"0","p4":"0","p2":"26","p3":"27"},{"name":"\u5317\u4eac\u6fb3\u5170\u6c7d\u8f66\u88c5\u9970\u6709\u9650\u516c\u53f8","lat":"39.901823","lng":"116.497827","tel":"010-87955805","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u6cbf\u6d77\u8d5b\u6d1b\u57ce416-1","bhours":"","p1":"0","p4":"0","p2":"21","p3":"27"},{"name":"\u8f66\u4e4b\u7ffc\u5317\u4eac\u5bcc\u529b\u53c8\u4e00\u57ce\u5e97","lat":"39.853402","lng":"116.571054","tel":"010-59640008","address":"\u671d\u9633\u533a\u5bcc\u529b\u53c8\u4e00\u57ceA\u533a\u5317\u4fa7","bhours":"","p1":"0","p4":"0","p2":"27","p3":"33"},{"name":"\u5317\u4eac\u5927\u5bcc\u6c7d\u914d\u6709\u9650\u516c\u53f8","lat":"40.043765","lng":"116.425288","tel":"010-84937118","address":"\u671d\u9633\u533a\u5965\u8fd0\u6751\u5927\u7f8a\u574a1\u53f7\u697c1\u5c42","bhours":"","p1":"0","p4":"0","p2":"21","p3":"21"},{"name":"\u817e\u8fbe\u5e86\u7ea2\u6c7d\u8f66\u9500\u552e\u6709\u9650\u516c\u53f8","lat":"40.098059","lng":"116.420312","tel":"010-81778267","address":"\u5317\u4eac\u5e02\u660c\u5e73\u533a\u5317\u4e03\u5bb6\u9547\u4e1c\u4e09\u65d7\u5317\u8fb0\u4e9a\u8fd0\u6751\u4ea4\u6613\u5e02\u573aB\u533a","bhours":"","p1":"90","p4":"120","p2":"59","p3":"71"},{"name":"\u5317\u4eac\u5e02\u4efb\u5c14\u884c\u6c7d\u8f66\u7ef4\u4fee\u6709\u9650\u8d23\u4efb\u516c\u53f8","lat":"39.869057","lng":"116.459599","tel":"010-67671720","address":"\u671d\u9633\u533a\u5341\u91cc\u6cb3\u6751\u767d\u5899\u5b50270\u53f7","bhours":"","p1":"0","p4":"0","p2":"20","p3":"31"},{"name":"\u535a\u8a89\u60e0\u6c7d\u8f66","lat":"40.08243","lng":"116.338644","tel":"13366251991","address":"\u660c\u5e73\u533a\u56de\u9f99\u89c2\u5317\u65b9\u946b\u5730\u5efa\u6750\u767e\u8d27\u5e02\u573a","bhours":"","p1":"0","p4":"0","p2":"18","p3":"24"},{"name":"\u5343\u5ea6\u5f71\u97f3\u97f3\u54cd\u6539\u88c5","lat":"39.863856","lng":"116.31751","tel":"010-63870110","address":"\u5317\u4eac\u5e02\u4e30\u53f0\u533a\u4e30\u7ba1\u8def16\u53f7\u897f\u56fd\u8d38\u6c7d\u914d\u57fa\u5730A8-1006","bhours":"","p1":"0","p4":"0","p2":"19","p3":"24"},{"name":"\u534e\u9633\u5bfc\u822a\u4e13\u8425 \u6c7d\u8f66\u7f8e\u5bb9\u88c5\u9970","lat":"39.868786","lng":"116.553085","tel":"010-67297899","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u4e94\u65b9\u6865\u897f\u4e94\u65b9\u5929\u96c5\u6c7d\u914d\u57ce8\u533a83-85\u53f7","bhours":"","p1":"0","p4":"0","p2":"21","p3":"24"},{"name":"\u5317\u4eac\u8f66\u767e\u80fd\u6c7d\u8f66\u88c5\u9970\u6709\u9650\u516c\u53f8\u592a\u9633\u5bab\u5e97","lat":"40.028398","lng":"116.443415","tel":"13311362827","address":"\u671d\u9633\u533a\u592a\u9633\u5bab\u4e2d\u8def\u9f99\u79b9\u52a0\u6cb9\u7ad9\u5185","bhours":"","p1":"0","p4":"0","p2":"38","p3":"47"},{"name":"\u5317\u4eac\u8f66\u767e\u80fd\u6c7d\u8f66\u88c5\u9970\u6709\u9650\u516c\u53f8\u65e5\u575b\u5e97","lat":"39.923532","lng":"116.447594","tel":"13311362827","address":"\u5317\u4eac\u671d\u9633\u533a\u957f\u5b89\u8857\u5317500\u7c73\u65e5\u575b\u8def\u4e2d\u77f3\u5316\u52a0\u6cb9\u7ad9\u5185","bhours":"","p1":"0","p4":"0","p2":"38","p3":"47"},{"name":"\u5317\u4eac\u4f17\u4e49\u4fe1\u6c7d\u8f66\u670d\u52a1\u4e2d\u5fc3","lat":"39.880657","lng":"116.50276","tel":"010-67360259","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u7d2b\u5357\u5bb6\u56ed\u5c0f\u533a205\u697c\u5e95\u55461-3","bhours":"","p1":"0","p4":"0","p2":"18","p3":"24"},{"name":"\u7279\u798f\u83b1\uff08\u5317\u4eac\uff09\u79d1\u6280\u6709\u9650\u516c\u53f8","lat":"39.882294","lng":"116.299872","tel":"18500594250","address":"\u4e30\u53f0\u533a\u5c0f\u4e95\u5c0f\u533a1\u53f7\u8def1\u533a1470","bhours":"","p1":"0","p4":"0","p2":"33","p3":"66"},{"name":"\u76c8\u52a8\u56fd\u9645","lat":"40.086115","lng":"116.327163","tel":"010-81719892","address":"\u5317\u4eac\u5e02\u660c\u5e73\u533a\u56de\u9f99\u89c2\u4e09\u5408\u5e84\u6751\u4e09\u5408\u5e84\u56ed\u897f\u505c\u8f66\u573a\u5317\u5e73\u65b94-10","bhours":"","p1":"0","p4":"0","p2":"18","p3":"21"},{"name":"\u9753\u8f66\u6c7d\u8f66\u670d\u52a1\u4e2d\u5fc3","lat":"40.058289","lng":"116.337615","tel":"13718019950","address":"\u5317\u4eac\u5e02\u660c\u5e73\u533a\u897f\u4e09\u65d7\u6865\u5317\u91d1\u699c\u5c0f\u533a\u5317\u95e8","bhours":"","p1":"0","p4":"0","p2":"12","p3":"18"},{"name":"\u7231TA\uff08\u7f8e\u7f57\u57ce\u767e\u76db\u5e97\uff09","lat":"39.895913","lng":"116.494688","tel":"010-67728115","address":"\u671d\u9633\u533a\u4e1c\u56db\u73af\u4e2d\u8def\u5927\u90ca\u4ead\u6865\u7f8e\u7f57\u57ce\u8d2d\u7269\u4e2d\u5fc3B2","bhours":"","p1":"0","p4":"0","p2":"100","p3":"100"},{"name":"\u7231TA\uff08\u6148\u4e91\u5bfa\u5bb6\u4e50\u798f\u5e97\uff09","lat":"39.925438","lng":"116.495185","tel":"010-85711745","address":"\u671d\u9633\u533a\u4e1c\u56db\u73af\u4e2d\u8def39\u53f7\u534e\u4e1a\u56fd\u9645\u4e2d\u5fc3\u5bb6\u4e50\u798fB2","bhours":"","p1":"0","p4":"0","p2":"100","p3":"100"},{"name":"\u7231TA\uff08\u671b\u4eac\u516d\u4f70\u672c\u5e97\uff09","lat":"40.014492","lng":"116.473524","tel":"010-64751725","address":"\u671d\u9633\u533a\u5e7f\u987a\u5317\u5927\u8857\u516d\u4f70\u672c\u5546\u4e1a\u4e2d\u5fc3B2","bhours":"","p1":"0","p4":"0","p2":"100","p3":"100"},{"name":"\u7231TA\uff08\u56de\u9f99\u89c2\u534e\u8054\u5e97\uff09","lat":"40.081596","lng":"116.326137","tel":"010-80770824","address":"\u660c\u5e73\u533a\u56de\u9f99\u89c2\u897f\u5927\u8857\u534e\u8054\u5546\u53a6B1","bhours":"","p1":"0","p4":"0","p2":"100","p3":"100"},{"name":"\u7231TA\uff08\u51ef\u5fb7\u7cbe\u54c1\u8d2d\u7269\u4e2d\u5fc3\uff09","lat":"39.924499","lng":"116.30213","tel":"13693305961","address":"\u6d77\u6dc0\u533a\u4e07\u5bff\u8def\u51ef\u5fb7\u8d2d\u7269\u4e2d\u5fc3","bhours":"","p1":"0","p4":"0","p2":"100","p3":"100"},{"name":"\u7231TA\uff08\u8d22\u5bcc\u8d2d\u7269\u4e2d\u5fc3\u5e97\uff09","lat":"39.922952","lng":"116.464598","tel":"010-65308873","address":"\u671d\u9633\u533a\u4e1c\u4e09\u73af\u4e2d\u8def\u4e03\u53f7\u8d22\u5bcc\u8d2d\u7269\u4e2d\u5fc3B2","bhours":"","p1":"0","p4":"0","p2":"100","p3":"100"},{"name":"\u7231TA\uff08\u5927\u5174\u706b\u795e\u5e99\u5e97\uff09","lat":"39.737292","lng":"116.349146","tel":"18810206160","address":"\u5927\u5174\u533a\u9ec4\u6751\u4e1c\u5927\u88571\u53f7\u706b\u795e\u5e99\u8d2d\u7269\u4e2d\u5fc3F\u5ea7B2","bhours":"","p1":"0","p4":"0","p2":"100","p3":"100"},{"name":"\u7231TA\uff08\u534e\u6da6\u4e94\u5f69\u57ce\u5e97\uff09","lat":"40.036473","lng":"116.339837","tel":"010-82815523","address":"\u6d77\u6dc0\u533a\u6e05\u6cb3\u4e2d\u885768\u53f7\u534e\u6da6\u4e94\u5f69\u57ceB1","bhours":"","p1":"0","p4":"0","p2":"100","p3":"100"},{"name":"\u7231TA\uff08\u671b\u4eac\u65b0\u4e00\u57ce\u5e97\uff09","lat":"39.999657","lng":"116.478875","tel":"01064732213","address":"\u671d\u9633\u533a\u961c\u8363\u885710\u53f7\u65b0\u4e00\u57ce\u8d2d\u7269\u4e2d\u5fc3B2","bhours":"","p1":"0","p4":"0","p2":"100","p3":"100"},{"name":"\u7231TA\uff08\u7fe0\u5fae\u51ef\u5fb7Mall\u5e97\uff09","lat":"39.921591","lng":"116.30953","tel":"010-68231587","address":"\u6d77\u6dc0\u533a\u516c\u4e3b\u575f\u7fe0\u5fae\u51ef\u5fb7mall\u8d2d\u7269\u4e2d\u5fc3B2","bhours":"","p1":"0","p4":"0","p2":"100","p3":"100"},{"name":"3M\u9646\u6865\u6c7d\u8f66\u7f8e\u5bb9\u4e2d\u5fc3","lat":"39.981668","lng":"116.338757","tel":"010-82111911","address":"\u5317\u4eac\u5e02\u6d77\u6dc0\u533a\u77e5\u6625\u8def76\u53f7","bhours":"","p1":"0","p4":"0","p2":"35","p3":"47"},{"name":"3M\u9646\u6865\u6c7d\u8f66\u7f8e\u5bb9\u4e2d\u5fc3","lat":"39.970523","lng":"116.362057","tel":"010-82210302","address":"\u5317\u4eac\u5e02\u6d77\u6dc0\u533a\u5e08\u5927\u5317\u8def10\u53f7\u5317\u90ae\u79d1\u6280\u5927\u53a6\u505c\u8f66\u573a","bhours":"","p1":"0","p4":"0","p2":"35","p3":"47"},{"name":"3M\u9646\u6865\u6c7d\u8f66\u7f8e\u5bb9\u4e2d\u5fc3","lat":"39.893531","lng":"116.437921","tel":"010-67191832","address":"\u5317\u4eac\u5e02\u4e1c\u57ce\u533a\u5e78\u798f\u5927\u885734\u53f7\uff08\u8def\u5317\uff09","bhours":"","p1":"0","p4":"0","p2":"35","p3":"47"},{"name":"\u52c7\u535a\u592a\u6c7d\u8f66\u7f8e\u5bb9\u4e2d\u5fc3","lat":"39.967455","lng":"116.474061","tel":"13811053426","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u4e09\u5143\u6865\u9704\u4e91\u8def\u9704\u4e91\u91cc8\u53f7","bhours":"","p1":"0","p4":"0","p2":"24","p3":"29"},{"name":"\u5317\u4eac\u6765\u987a\u6c7d\u8f66\u670d\u52a1\u6709\u9650\u516c\u53f8","lat":"39.879798","lng":"116.645838","tel":"010-60552822","address":"\u5317\u4eac\u5e02\u901a\u5dde\u533a\u4e5d\u68f5\u6811\u897f\u8def178\u53f7\uff08\u9ea6\u5f53\u52b3\u65c1\uff09","bhours":"","p1":"0","p4":"0","p2":"29","p3":"29"},{"name":"\u8f66\u4e4b\u53cb","lat":"39.931681","lng":"116.604996","tel":"010-56857455","address":"\u671d\u9633\u533a\u671d\u9633\u5317\u8def17\u53f7\u5e38\u8425\u534e\u8054\u8d2d\u7269\u4e2d\u5fc3B1\u505c\u8f66\u573a","bhours":"","p1":"0","p4":"0","p2":"26","p3":"29"},{"name":"\u8f66\u4e4b\u53cb","lat":"39.924885","lng":"116.5341","tel":"010-63864400","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u671d\u9633\u8def\u592a\u5e73\u5e84\u75321\u53f7","bhours":"","p1":"0","p4":"0","p2":"26","p3":"29"},{"name":"\u9f9f\u535a\u58eb\u76f4\u8425\u793a\u8303\u4e2d\u5fc3","lat":"39.906917","lng":"116.686119","tel":"13522350191","address":"\u7389\u5e26\u6cb3\u4e1c\u8857199\u53f7","bhours":"","p1":"0","p4":"0","p2":"33","p3":"41"},{"name":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u4e94\u73af\u6c7d\u8f66\u4fee\u7406\u7ad9","lat":"39.947449","lng":"116.529489","tel":"010-85577306","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u5e73\u623f\u4e61\u59da\u5bb6\u56ed","bhours":"","p1":"0","p4":"0","p2":"18","p3":"24"},{"name":"\u5317\u4eac\u6c5f\u53cb\u6c7d\u8f66\u88c5\u9970\u670d\u52a1\u4e2d\u5fc3","lat":"40.017976","lng":"116.471652","tel":"010-64742980","address":"\u5229\u6cfd\u897f\u56ed122\u53f7\u697c\u5e95\u5546","bhours":"","p1":"0","p4":"0","p2":"22","p3":"28"},{"name":"\u5b89\u83b1\uff08\u5317\u4eac\uff09\u6c7d\u8f66\u670d\u52a1\u8fde\u9501\u6709\u9650\u516c\u53f8","lat":"39.907457","lng":"116.694676","tel":"13911578171","address":"\u901a\u5dde\u533a\u7389\u5e26\u6cb3\u4e1c\u88574\u53f7\u5b89\u83b1\u5927\u53a6A\u5ea7\u4e00\u5c42","bhours":"","p1":"0","p4":"0","p2":"22","p3":"22"},{"name":"\u8d5b\u6d6a\u6c7d\u8f66\u7f8e\u5bb9\u5feb\u4fee\u901a\u5dde\u5e97","lat":"39.895455","lng":"116.669995","tel":"010-81515600","address":"\u5317\u4eac\u5e02\u901a\u5dde\u533a\u845b\u5e03\u5e97\u4e1c\u91cc102-9\u53f7","bhours":"","p1":"0","p4":"0","p2":"20","p3":"24"},{"name":"\u60a6\u8fbe\u7ef4\u4fee\u6d17\u8f66\u623f","lat":"39.952868","lng":"116.267322","tel":"13910135110","address":"\u56db\u5b63\u9752\u4f5f\u5bb6\u575f\u6807\u5fd74s\u5e97\u5411\u5317200\u7c73","bhours":"","p1":"0","p4":"0","p2":"12","p3":"14"},{"name":"\u5317\u4eac\u660e\u9759\u96c5\u6c7d\u8f66\u670d\u52a1\u6709\u9650\u516c\u53f8","lat":"39.855127","lng":"116.294861","tel":"010-63731919","address":"\u5317\u4eac\u5e02\u4e30\u53f0\u533a\u6b63\u9633\u5927\u885765\u53f7","bhours":"","p1":"0","p4":"0","p2":"21","p3":"35"},{"name":"\u7f8e\u8f66\u6e90\u65b0\u4e2d\u5173\u5e97","lat":"39.984432","lng":"116.321947","tel":"13926019393","address":"\u4e2d\u5173\u6751\u65b0\u4e2d\u5173\u8d2d\u7269\u4e2d\u5fc3B2","bhours":"","p1":"0","p4":"0","p2":"29","p3":"29"},{"name":"\u5317\u4eac\u4e50\u798f\u6c7d\u8f66\u7efc\u5408\u670d\u52a1\u4e2d\u5fc3","lat":"39.823063","lng":"116.49844","tel":"010-87601202","address":"\u5317\u4eac\u5e02\u7ecf\u6d4e\u6280\u672f\u5f00\u53d1\u533a\u535a\u5927\u8def\u5357\u4e94\u73af\u8363\u534e\u6865\u5411\u5317300\u7c73","bhours":"","p1":"0","p4":"0","p2":"24","p3":"33"},{"name":"\u5317\u4eac\u5361\u8fea\u5361\u6c7d\u8f66\u88c5\u9970\u6709\u9650\u516c\u53f8","lat":"39.915885","lng":"116.434075","tel":"010-65254608","address":"\u5317\u4eac\u5e02\u4e1c\u57ce\u533a\u5efa\u56fd\u95e8\u5185\u5927\u88579\u53f7\u5730\u4e0b\u4e00\u5c42","bhours":"","p1":"0","p4":"0","p2":"24","p3":"28"},{"name":"\u7f8e\u8f66\u6e90\u6765\u798f\u58eb\u5e97","lat":"39.946359","lng":"116.438955","tel":"13926019393","address":"\u4e1c\u76f4\u5185\u5927\u88571\u53f7\u6765\u798f\u58eb\u8d2d\u7269\u4e2d\u5fc3B3","bhours":"","p1":"0","p4":"0","p2":"29","p3":"29"},{"name":"\u8f66\u7235\u58eb\uff08\u53cc\u6865\u5e97\uff09","lat":"39.912152","lng":"116.58888","tel":"010-65478790","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u5eb7\u60e0\u56ed2\u53f7\u96622\u53f7\u697c1\u81f32\u5c42103","bhours":"","p1":"0","p4":"0","p2":"18","p3":"24"},{"name":"\u7f8e\u8f66\u6e90\u5927\u949f\u5bfa\u5e97","lat":"39.971416","lng":"116.349992","tel":"13926019393","address":"\u5927\u949f\u5bfa\u4e2d\u5764\u5e7f\u573aB3","bhours":"","p1":"0","p4":"0","p2":"29","p3":"29"},{"name":"\u9a70\u52a0\u5929\u4f51\u9999\u96ea\u6c7d\u8f66\u670d\u52a1\u4e2d\u5fc3","lat":"39.846124","lng":"116.37173","tel":"010-67527662","address":"\u5609\u56ed\u8def\u5b89\u592a\u533b\u9662\u5bf9\u9762","bhours":"","p1":"0","p4":"0","p2":"27","p3":"33"},{"name":"\u5317\u4eac\u7f8e\u5229\u660a\u76db\u8fbe\u6c7d\u8f66\u914d\u4ef6\u9500\u552e\u4e2d\u5fc3","lat":"39.881172","lng":"116.670757","tel":"010-60545568","address":"\u5317\u4eac\u5e02\u901a\u5dde\u533a\u68a8\u56ed\u5730\u533a\u5927\u7a3f\u6751","bhours":"","p1":"0","p4":"0","p2":"20","p3":"32"},{"name":"\u8482\u9f99\u6d17\u8f66\u7f8e\u5bb9","lat":"39.888376","lng":"116.27824","tel":"010-51159118","address":"\u697c\u5e02\u53e3\u8def11\u53f7\u9662\u897f\u5e73\u623f10\u53f7\uff08\u5cb3\u5404\u5e84\u7ea2\u661f\u7f8e\u51ef\u9f99\u5357\u95e8\u5bf9\u9762\uff09","bhours":"","p1":"0","p4":"0","p2":"20","p3":"24"},{"name":"\u7f8e\u56fd\u5bf0\u7403\u7a97\u819c\u4e94\u65b9\u8001\u9093\u6388\u6743\u65bd\u5de5\u5e97","lat":"39.871898","lng":"116.55022","tel":"010-87330063","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u76db\u534e\u6c7d\u914d\u57ceB\u533a1\u53f7","bhours":"","p1":"0","p4":"0","p2":"24","p3":"24"},{"name":"\u8f66\u7acb\u7f8e\u6c7d\u8f66\u7f8e\u5bb9\u5e97","lat":"39.910481","lng":"116.38092","tel":"010-83567418","address":"\u5317\u4eac\u5e02\u897f\u57ce\u533a\u5ba3\u6b66\u95e8\u5185\u5927\u88572\u53f7\u4e2d\u56fd\u534e\u7535\u5927\u53a6","bhours":"","p1":"0","p4":"0","p2":"33","p3":"33"},{"name":"\u5929\u4e88\u6c7d\u8f66\u670d\u52a1\u4e2d\u5fc3","lat":"39.894399","lng":"116.647386","tel":"010-51271190","address":"\u6021\u4e50\u5317\u8857\u753296\u53f7","bhours":"","p1":"0","p4":"0","p2":"29","p3":"35"},{"name":"\u7f8e\u56fd\u5bf0\u7403\u7a97\u819c\u4e94\u65b9\u8001\u9093\u6388\u6743\u65bd\u5de5\u5e97","lat":"39.869661","lng":"116.546843","tel":"010-87330063","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u4e94\u65b9\u5929\u96c5\u6c7d\u914d\u57ce\u897f7-120\u53f7","bhours":"","p1":"0","p4":"0","p2":"24","p3":"24"},{"name":"\u5317\u4eac\u6167\u7fd4\u6cfd\u5546\u8d38\u6709\u9650\u516c\u53f8\uff08\u897f\u57ce\u5206\u516c\u53f8\uff09","lat":"39.949863","lng":"116.364956","tel":"010-62229969","address":"\u897f\u76f4\u95e8\u5317\u987a\u57ce\u885711\u53f7\u5c0f\u767d\u697c","bhours":"","p1":"0","p4":"0","p2":"29","p3":"35"},{"name":"\u8f66\u7f8e\u884c\uff08\u5317\u4eac\uff09\u6c7d\u8f66\u670d\u52a1\u6709\u9650\u516c\u53f8","lat":"39.892859","lng":"116.353028","tel":"010-63301910","address":"\u5317\u4eac\u5e02\u897f\u57ce\u533a\u5e7f\u5916\u5927\u885728\u53f7","bhours":"","p1":"0","p4":"0","p2":"24","p3":"29"},{"name":"\u5c3c\u5c14\u68ee\u5149\u660e\u6865\u5e97","lat":"39.889995","lng":"116.449434","tel":"010-67189400","address":"\u5317\u4eac\u5e02\u4e1c\u57ce\u533a\u5149\u660e\u8def\u75321\u53f7","bhours":"","p1":"0","p4":"0","p2":"29","p3":"41"},{"name":"\u5317\u4eac\u5965\u5b9d\u4f1f\u4e1a\u6c7d\u8f66\u670d\u52a1\u6709\u9650\u516c\u53f8","lat":"39.924002","lng":"116.192837","tel":"010-8921972","address":"\u6768\u5e84\u5927\u885785-7\u53f7","bhours":"","p1":"0","p4":"0","p2":"27","p3":"33"},{"name":"\u94fe\u8f6630\u5feb\u6377\u8f66\u517b\u62a4","lat":"39.967149","lng":"116.51962","tel":"010-64372914","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u4e1c\u91cc\u4e61\u5c06\u53f0\u6d3c\u753280\u53f7","bhours":"","p1":"0","p4":"0","p2":"21","p3":"24"},{"name":"\u5317\u4eac\u91d1\u7231\u8f66\u6c7d\u8f66\u88c5\u9970\u4e2d\u5fc3\uff08\u82f1\u56fd\u5c3c\u5c14\u68ee\u6c7d\u8f66\u670d\u52a1\u4e2d\u5fc3\uff09","lat":"39.919509","lng":"116.535153","tel":"13901087379","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u671d\u9633\u8def\u5174\u9686\u8857103\u53f7","bhours":"","p1":"0","p4":"0","p2":"29","p3":"41"},{"name":"\u5317\u4eac\u5915\u9633\u8fce\u5bbe\u6c7d\u8f66\u88c5\u9970\u670d\u52a1\u4e2d\u5fc3","lat":"39.917258","lng":"116.535783","tel":"010-85758038","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u5174\u9686\u897f\u885710\u53f7","bhours":"","p1":"0","p4":"0","p2":"18","p3":"21"},{"name":"\u5317\u4eac\u84dd\u7bad\u5821\u6c7d\u8f66\u670d\u52a1\u4e2d\u5fc3","lat":"39.88889","lng":"116.370756","tel":"010-83560946","address":"\u5317\u4eac\u5e02\u897f\u57ce\u533a\u76ca\u6c11\u5df716\u53f7","bhours":"","p1":"0","p4":"0","p2":"35","p3":"41"},{"name":"\u94f6\u8c6a\u8f66\u6c47","lat":"39.892696","lng":"116.236678","tel":"010-52316605","address":"\u5317\u4eac\u5e02\u4e30\u53f0\u533a\u5c0f\u74e6\u7a91\u5f20\u4eea\u6751\u8def2\u53f7\u5143\u548c\u6c7d\u914d\u57ce\u5e95\u5546A47-48","bhours":"","p1":"0","p4":"0","p2":"27","p3":"39"},{"name":"777\u6c7d\u8f66\u7f8e\u5bb9","lat":"39.925919","lng":"116.583629","tel":"010-65476997","address":"\u5317\u4eac\u5e02\u671d\u9633\u5317\u8def\u6b27\u5c1a\u8d85\u5e02\u505c\u8f66\u573a\u5357\u4fa7","bhours":"","p1":"0","p4":"0","p2":"24","p3":"24"},{"name":"\u5317\u4eac\u56db\u8fbe\u901a\u6c7d\u8f66\u4fee\u7406\u6709\u9650\u516c\u53f8","lat":"39.809871","lng":"116.739899","tel":"010-81503193","address":"\u5317\u4eac\u5149\u901a\u5dde\u533a\u673a\u7535\u4e00\u4f53\u5316\u4ea7\u4e1a\u57fa\u5730\u5609\u521b\u56db\u8def2\u53f7","bhours":"","p1":"0","p4":"0","p2":"16","p3":"16"},{"name":"\u5317\u4eac\u90c1\u5cad\u5c9b\u6c7d\u8f66\u6280\u672f\u6709\u9650\u516c\u53f8","lat":"39.962152","lng":"116.453486","tel":"010-84484792","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u5de6\u5bb6\u5e84\u4e1c\u8857\uff08\u9759\u5b89\u5e02\u573a\u659c\u5bf9\u9762\uff09","bhours":"","p1":"0","p4":"0","p2":"22","p3":"28"},{"name":"\u8d5b\u68a6\u9a70\u6c7d\u8f66\u7f8e\u5bb9\u5feb\u4fee\u4fdd\u517b\u55b7\u6f06","lat":"39.897834","lng":"116.709591","tel":"13522760123","address":"\u5317\u4eac\u5e02\u901a\u5dde\u533a\u6ee8\u6cb3\u4e2d\u8def\u5065\u9f99\u68ee\u5065\u8eab\u4ff1\u4e50\u90e8\u5bf9\u9762","bhours":"","p1":"0","p4":"0","p2":"21","p3":"27"},{"name":"\u5317\u6c7d\u6d17\u8f66\u7f8e\u5bb9\u88c5\u9970\u670d\u52a1\u4e2d\u5fc3","lat":"40.008498","lng":"116.427847","tel":"010-65476997","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u5927\u5c6f\u8def238\u53f7","bhours":"","p1":"0","p4":"0","p2":"30","p3":"30"},{"name":"\u5317\u4eac\u666f\u5fd7\u817e\u98de\u6d17\u8f66\u4e2d\u5fc3","lat":"39.904496","lng":"116.217111","tel":"18611798364","address":"\u5317\u4eac\u5e02\u77f3\u666f\u5c71\u533a\u4eac\u539f\u8def7\u53f7\u666f\u56ed\u725b\u5976\u5382\u5382\u533a\u53172\u53f7","bhours":"","p1":"0","p4":"0","p2":"21","p3":"21"},{"name":"\u5317\u4eac\u6591\u9a6c\u7ebf\u6c7d\u8f66\u670d\u52a1\u6709\u9650\u516c\u53f8","lat":"39.899828","lng":"116.512067","tel":"010-53599381","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u767e\u5b50\u6e7e\u4e1c\u91cc\u7532422\u53f7\u697c","bhours":"","p1":"0","p4":"0","p2":"24","p3":"35"},{"name":"\u5317\u4eac\u4e50\u798f\u8f66\u7ba1\u5bb6","lat":"39.82237","lng":"116.49844","tel":"010-87601202","address":"\u5317\u4eac\u671d\u9633\u533a\u7ecf\u6d4e\u6280\u672f\u5f00\u53d1\u533a\u535a\u5927\u8def\u5357\u4e94\u73af\u8363\u534e\u6865\u5411\u5317200\u7c73","bhours":"","p1":"0","p4":"0","p2":"24","p3":"33"},{"name":"\u65fa\u5174\u8fbe\u6c7d\u8f66","lat":"39.887909","lng":"116.683617","tel":"010-81543626","address":"\u5317\u4eac\u5e02\u901a\u5dde\u533a\u68a8\u56ed\u6751\u5c0f\u7a3f\u6751\u59d4\u4f1a\u5357500\u7c73","bhours":"","p1":"0","p4":"0","p2":"18","p3":"18"},{"name":"\u9177\u5361\u9177\u5c1a","lat":"39.889662","lng":"116.65761","tel":"010-81532218","address":"\u5317\u4eac\u5e02\u901a\u5dde\u533a\u4e5d\u68f5\u6811\u897f\u8def92\u53f729~30","bhours":"","p1":"0","p4":"0","p2":"25","p3":"30"},{"name":"\u5317\u4eac\u5e02\u534e\u6e90\u9f0e\u76db\u6c7d\u8f66\u7ef4\u4fee\u4e2d\u5fc3","lat":"39.922639","lng":"116.209663","tel":"010-68811691","address":"\u77f3\u666f\u5c71\u533a\u516b\u89d2\u5317\u8def11\u53f7\u9662\uff08\u8425\u4e1a\u7528\u623f\uff091-3\u53f7","bhours":"","p1":"0","p4":"0","p2":"24","p3":"35"},{"name":"\u5317\u4eac\u5e02\u4e07\u5b9d\u4f1f\u4e1a\u6c7d\u8f66\u4fee\u7406\u4e2d\u5fc3","lat":"39.830715","lng":"116.489104","tel":"010-87694388","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u535a\u5927\u8def16\u53f7","bhours":"","p1":"0","p4":"0","p2":"18","p3":"21"},{"name":"\u5317\u4eac\u5929\u827a\u7965\u9e3f\u6c7d\u8f66\u914d\u4ef6\u9500\u552e\u516c\u53f8","lat":"39.930161","lng":"116.557253","tel":"010-65756199","address":"\u671d\u9633\u5317\u8def\u671d\u4e1c\u6c7d\u914d8\u53f7","bhours":"","p1":"0","p4":"0","p2":"20","p3":"24"},{"name":"\u4e2d\u4e1c\u6c7d\u4fee","lat":"39.924002","lng":"116.192837","tel":"010-88921972","address":"\u5317\u4eac\u5e02\u77f3\u666f\u5c71\u533a\u6768\u5e84\u5927\u885785-7\u53f7","bhours":"","p1":"0","p4":"0","p2":"27","p3":"33"},{"name":"\u71d5\u5317\u6c7d\u8f66\u7ef4\u4fee\u4e2d\u5fc3","lat":"39.999154","lng":"116.432036","tel":"010-64940431","address":"\u671d\u9633\u533a\u5c0f\u8425\u8def\u80b2\u6167\u91cc18\u53f7\u697c\u5e95\u5546","bhours":"","p1":"0","p4":"0","p2":"35","p3":"47"},{"name":"\u5317\u4eac\u4fca\u8c6a\u6c7d\u8f66\u670d\u52a1\u6709\u9650\u516c\u53f8","lat":"39.945157","lng":"116.37052","tel":"13521027378","address":"\u5317\u4eac\u5e02\u897f\u57ce\u533a\u5357\u8349\u538211\u53f77\u5e62\u4e00\u5c42","bhours":"","p1":"0","p4":"0","p2":"35","p3":"47"},{"name":"\u5317\u4eac\u5e05\u559c\u7ea2\u6c7d\u8f66\u88c5\u9970\u670d\u52a1\u4e2d\u5fc3","lat":"40.034169","lng":"116.42808","tel":"010-84926878","address":"\u671d\u9633\u533a\u5317\u82d12\u53f7\u697c93\u53f7","bhours":"","p1":"0","p4":"0","p2":"21","p3":"29"},{"name":"\u5317\u4eac\u8def\u901a\u8fdc\u6c7d\u8f66\u7ef4\u4fee\u4e2d\u5fc3","lat":"40.039946","lng":"116.305849","tel":"010-62962204","address":"\u6d77\u6dc0\u533a\u9a6c\u8fde\u6d3c\u5317\u8def\u83ca\u56ed\u4e1c\u7ad9\u8def\u5317","bhours":"","p1":"0","p4":"0","p2":"24","p3":"29"},{"name":"\u5b8f\u6e90\u5cf0\u6865\u60e0\u65b0\u5e97","lat":"39.983527","lng":"116.422292","tel":"010-84856339","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u5c0f\u5173\u4e1c\u91cc12\u53f7","bhours":"","p1":"0","p4":"0","p2":"38","p3":"38"},{"name":"3M\u9646\u6865\u6c7d\u8f66\u7f8e\u5bb9\u4e2d\u5fc3","lat":"39.893531","lng":"116.437921","tel":"010-67191832","address":"\u5317\u4eac\u5e02\u4e1c\u57ce\u533a\u5e78\u798f\u5927\u885734\u53f7\u8def\u5357","bhours":"","p1":"0","p4":"0","p2":"35","p3":"47"},{"name":"3M\u6c7d\u8f66\u7f8e\u5bb9\u4e2d\u5fc3\u5730","lat":"40.081443","lng":"116.348693","tel":"010-81727204","address":"\u5317\u4eac\u5e02\u660c\u5e73\u533a\u56de\u9f99\u89c2\u6d41\u661f\u82b1\u56ed\u4e09\u533a\u897f\u95e8\u5f80\u5317200\u7c73","bhours":"","p1":"0","p4":"0","p2":"35","p3":"47"},{"name":"\u4e2d\u9e3f\u53d1\u6c7d\u8f66\u88c5\u9970\u90e8","lat":"40.027168","lng":"116.286654","tel":"010-62827411","address":"\u6d77\u6dc0\u533a\u5929\u79c0\u82b1\u56ed\u8377\u5858\u6708\u820d1\u53f7\u697c\u4e00\u5c42003\u5e95\u5546","bhours":"","p1":"0","p4":"0","p2":"33","p3":"41"},{"name":"\u5317\u4eac\u5e7f\u5927\u884c\u6c7d\u8f66\u88c5\u9970\u670d\u52a1\u90e8","lat":"39.891903","lng":"116.353451","tel":"010-63406635","address":"\u897f\u57ce\u533a\u5e7f\u5916\u5357\u885718\u53f7\u697c\u4e0b\u5e73\u623f","bhours":"","p1":"0","p4":"0","p2":"27","p3":"35"},{"name":"\u5317\u4eac\u742a\u6717\u6c7d\u8f66\u670d\u52a1\u6709\u9650\u516c\u53f8","lat":"39.953803","lng":"116.255872","tel":"010-60605109","address":"\u56db\u5b63\u9752\u674f\u77f3\u53e3\u8def55\u53f7\u96c5\u68ee\u8ddf\u6c7d\u8f66\u7528\u54c1\u5e02\u573a\u4e2d\u5fc3A1\u533a205","bhours":"","p1":"0","p4":"0","p2":"24","p3":"82"},{"name":"\u5317\u4eac\u4e00\u7403\u6c7d\u8f66\u670d\u52a1\u6709\u9650\u516c\u53f8","lat":"39.882925","lng":"116.641789","tel":"010-58014655","address":"\u5317\u4eac\u5e02\u901a\u5dde\u533a\u6021\u4e50\u4e2d\u8def284\u53f7","bhours":"","p1":"0","p4":"0","p2":"29","p3":"36"},{"name":"\u5317\u4eac\u8f66\u4e4b\u5c0a\u597d\u8fd0\u6c7d\u8f66\u88c5\u9970","lat":"39.918788","lng":"116.649156","tel":"010-60510103","address":"\u5317\u4eac\u5e02\u901a\u5dde\u533a\u901a\u60e0\u5317\u8def\u8d22\u653f\u5b66\u9662\u9644\u8fd1","bhours":"","p1":"0","p4":"0","p2":"24","p3":"29"},{"name":"\u5317\u4eac\u8f66\u4e4b\u5c0a\u6c7d\u8f66\u88c5\u9970\u6709\u9650\u516c\u53f8","lat":"39.906285","lng":"116.662851","tel":"18612261311","address":"\u5317\u4eac\u5e02\u901a\u5dde\u533a\u65b0\u57ce\u5357\u517355\u53f7","bhours":"","p1":"0","p4":"0","p2":"24","p3":"33"},{"name":"\u5317\u4eac\u5e02\u5144\u5f1f\u884c\u6c7d\u8f66\u670d\u52a1\u6709\u9650\u516c\u53f8","lat":"39.898045","lng":"116.64134","tel":"010-81562345","address":"\u5317\u4eac\u5e02\u901a\u5dde\u533a\u68a8\u56ed\u9547\u674e\u8001\u516c\u5e84\u67514\u53f7","bhours":"","p1":"0","p4":"0","p2":"20","p3":"24"},{"name":"\u534e\u9e4f\u9f99\u6c7d\u8f66","lat":"39.879489","lng":"116.655319","tel":"010-53619028","address":"\u5317\u4eac\u5e02\u901a\u5dde\u533a\u5c0f\u7a3f\u6751\u5de5\u4e1a\u56ed\u533a","bhours":"","p1":"0","p4":"0","p2":"20","p3":"29"},{"name":"\u5317\u4eac\u798f\u7fd4\u987a\u53d1\u6c7d\u8f66\u670d\u52a1\u4e2d\u5fc3","lat":"39.936427","lng":"116.374482","tel":"010-66182791","address":"\u897f\u57ce\u533a\u8d75\u767b\u79b9\u8def114\u53f7","bhours":"","p1":"0","p4":"0","p2":"35","p3":"47"},{"name":"\u745e\u6d3e\u67ef\u6d17\u8f66\u4e2d\u5fc3","lat":"39.903412","lng":"116.247964","tel":"010-88697109","address":"\u77f3\u666f\u5c71\u83b2\u82b3\u4e1c\u6865\u4e1c\u5317\u89d2\u8fdc\u6d0b\u5c71\u6c34\u5357\u533a\u897f\u95e838\u53f7\u697c\u5e95\u5546","bhours":"","p1":"0","p4":"0","p2":"35","p3":"41"},{"name":"\u767e\u8f66\u6c47","lat":"39.796736","lng":"116.355016","tel":"010-60252844","address":"\u897f\u7ea2\u95e8\u9547\u653f\u5e9c\u5317\u4fa7\u4e343\u53f7\uff08\u897f\u7ea2\u95e8\u6865\u5317150\u7c73\u8def\u4e1c\u58f3\u724c\u52a0\u6cb9\u7ad9\u5185\uff09","bhours":"","p1":"0","p4":"0","p2":"20","p3":"28"},{"name":"\u8f66\u738b\u6c7d\u8f66\u7f8e\u5bb9\u4f1a\u6240","lat":"39.800327","lng":"116.329221","tel":"13269386650","address":"\u5927\u5174\u897f\u7ea2\u95e8\u5b8f\u76db\u8def1\u5c42\u5174\u6d77\u5bb6\u56ed\u65e5\u82d1\u5e95\u5546\u4e1c\u5317\u89d2","bhours":"","p1":"0","p4":"0","p2":"24","p3":"35"},{"name":"\u5317\u4eac\u9ec4\u6751\u597d\u7f8e\u6c7d\u8f66\u7528\u54c1\u9500\u552e\u90e8","lat":"39.743199","lng":"116.348029","tel":"13522325631","address":"\u5927\u5174\u533a\u9ec4\u6751\u4e2d\u91cc3\u53f7\u697c1\u5c421\u53f7","bhours":"","p1":"0","p4":"0","p2":"24","p3":"29"},{"name":"\u5317\u4eac\u6587\u5496\u601d\u5427\u6c7d\u8f66\u88c5\u9970\u6709\u9650\u516c\u53f8","lat":"40.015975","lng":"116.473543","tel":"13910004428","address":"\u671d\u9633\u671b\u4eac\u5e7f\u987a\u5317\u5927\u88575\u53f7\u6587\u5496\u601d\u5427","bhours":"","p1":"71","p4":"71","p2":"0","p3":"0"},{"name":"\u8f66\u4e4b\u7ffc\u77f3\u69b4\u56ed\u5e97","lat":"39.84442","lng":"116.428366","tel":"010-87254566","address":"\u5317\u4eac\u4e30\u53f0\u533a\u77f3\u69b4\u56ed\u5357\u91cc7\u53f7","bhours":"","p1":"0","p4":"0","p2":"28","p3":"40"},{"name":"\u6613\u8f66\u751f\u6d3b\u6c7d\u8f66\u670d\u52a1\u8fde\u9501\uff08\u8fdc\u6d0b\u65b0\u5e72\u7ebf\u5e97\uff09","lat":"39.963164","lng":"116.466839","tel":"4000107877","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u4e09\u5143\u6865\u8fdc\u6d0b\u65b0\u5e72\u7ebfB\u505a\u5730\u4e0b\u505c\u8f66\u573a","bhours":"","p1":"0","p4":"0","p2":"29","p3":"29"},{"name":"\u6613\u8f66\u751f\u6d3b\u6c7d\u8f66\u670d\u52a1\u8fde\u9501\uff08\u71d5\u838e\u6865\u5e97\uff09","lat":"39.958675","lng":"116.470504","tel":"4000107877","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u4e1c\u4e09\u73af\u4eae\u9a6c\u6865\u5a01\u65af\u6c40\u5927\u996d\u5e97\u5730\u4e0b\u505c\u8f66\u573aB2\u5c42","bhours":"","p1":"0","p4":"0","p2":"29","p3":"29"},{"name":"\u6613\u8f66\u751f\u6d3b\u6c7d\u8f66\u670d\u52a1\u8fde\u9501\uff08\u8fdc\u6d0b\u4e07\u548c\u57ce\u5e97\uff09","lat":"39.999318","lng":"116.442339","tel":"4000107877","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u5317\u56db\u73af\u6210\u6167\u8def\u8fdc\u6d0b\u4e07\u548c\u57ceA\u533a\u5730\u4e0b\u505c\u8f66\u573aB1\u5c42","bhours":"","p1":"0","p4":"0","p2":"29","p3":"29"},{"name":"\u6613\u8f66\u751f\u6d3b\u6c7d\u8f66\u670d\u52a1\u8fde\u9501\uff08\u4e07\u79d1\u516c\u56ed\u4e94\u53f7\u5e97\uff09","lat":"39.931415","lng":"116.484316","tel":"4000107877","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u671d\u9633\u516c\u56ed\u5357\u7ea6500\u7c73\u4e07\u79d1\u516c\u56ed\u4e94\u53f7\u5730\u4e0b\u505c\u8f66\u573aB1\u5c42","bhours":"","p1":"0","p4":"0","p2":"29","p3":"29"},{"name":"\u6613\u8f66\u751f\u6d3b\u6c7d\u8f66\u670d\u52a1\u8fde\u9501\uff08\u76d8\u53e4\u5927\u89c2\u5e97\uff09","lat":"39.995717","lng":"116.392945","tel":"4000107877","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u5317\u56db\u73af\u4e2d\u8def27\u53f7\u76d8\u53e4\u5927\u89c2\u5730\u4e0b\u505c\u8f66\u573aB3\u5c42\u7c89\u533a","bhours":"","p1":"0","p4":"0","p2":"29","p3":"29"},{"name":"\u6613\u8f66\u751f\u6d3b\u6c7d\u8f66\u670d\u52a1\u8fde\u9501\uff08\u82f1\u7279\u516c\u5bd3\u5e97\uff09","lat":"39.974467","lng":"116.443517","tel":"4000107877","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u897f\u575d\u6cb3\u897f\u91cc28\u53f7\u82f1\u7279\u516c\u5bd3\u5730\u4e0b\u505c\u8f66\u573aB3\u5c42","bhours":"","p1":"0","p4":"0","p2":"29","p3":"29"},{"name":"\u6613\u8f66\u751f\u6d3b\u6c7d\u8f66\u670d\u52a1\u8fde\u9501\uff08\u534e\u6da6\u897f\u5824\u7ea2\u5c71\u5e97\uff09","lat":"39.898855","lng":"116.343538","tel":"4000107877","address":"\u5317\u4eac\u5e02\u897f\u57ce\u533a\u5e7f\u5916\u5927\u8857305\u53f7\u897f\u5824\u7ea2\u5c71\u5c0f\u533a\u5730\u4e0b\u505c\u8f66\u573aB2\u5c42","bhours":"","p1":"0","p4":"0","p2":"29","p3":"29"},{"name":"\u6613\u8f66\u751f\u6d3b\u6c7d\u8f66\u670d\u52a1\u8fde\u9501\uff08\u79a7\u745e\u90fd\u5e97\uff09","lat":"39.925678","lng":"116.470779","tel":"4000107877","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u671d\u9633\u8def139\u53f7\u9662\u9996\u521b\u79a7\u745e\u90fd\u5c0f\u533a2\u53f7\u697c\u5730\u4e0bB2\u5c42","bhours":"","p1":"0","p4":"0","p2":"29","p3":"29"},{"name":"\u6613\u8f66\u751f\u6d3b\u6c7d\u8f66\u670d\u52a1\u8fde\u9501\uff08\u7ea2\u73ba\u53f0\u5e97\uff09","lat":"39.986445","lng":"116.445295","tel":"4000107877","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u4e1c\u4e09\u73af\u592a\u9633\u5bab\u6865\u5411\u5317800\u7c73\u7ea2\u73ba\u53f0\u5c0f\u533a\u5730\u4e0bB1\u5c42","bhours":"","p1":"0","p4":"0","p2":"29","p3":"29"},{"name":"\u6613\u8f66\u751f\u6d3b\u6c7d\u8f66\u670d\u52a1\u8fde\u9501\uff08\u5bcc\u8d35\u56ed\u5e97\uff09","lat":"39.899949","lng":"116.438336","tel":"4000107877","address":"\u5317\u4eac\u5e02\u4e1c\u57ce\u533a\u5e7f\u6e20\u8def\u5185\u5927\u8857\u5bcc\u8d35\u56ed\u5bb6\u4e50\u798f\u5730\u4e0b\u505c\u8f66\u573aB2\u5c42","bhours":"","p1":"0","p4":"0","p2":"29","p3":"29"},{"name":"\u6613\u8f66\u751f\u6d3b\u6c7d\u8f66\u670d\u52a1\u8fde\u9501\uff08\u4e07\u56fd\u57ceMOMA\u5e97\uff09","lat":"39.955095","lng":"116.443323","tel":"4000107877","address":"\u5317\u4eac\u5e02\u4e1c\u57ce\u533a\u4e1c\u76f4\u95e8\u9999\u6cb3\u56ed\u8def1\u53f7\u4e07\u56fd\u57ceMOMA\u5730\u4e0b\u505c\u8f66\u573aB3\u5c42","bhours":"","p1":"0","p4":"0","p2":"29","p3":"29"},{"name":"\u6613\u8f66\u751f\u6d3b\u6c7d\u8f66\u670d\u52a1\u8fde\u9501\uff08\u7b2c\u4e94\u5e7f\u573a\u5e97\uff09","lat":"39.937693","lng":"116.44034","tel":"4000107877","address":"\u5317\u4eac\u5e02\u4e1c\u57ce\u533a\u671d\u9633\u95e8\u5317\u5927\u88573\u53f7\u4e94\u77ff\u5e7f\u573a\u5730\u4e0b\u505c\u8f66\u573aB4\u5c42","bhours":"","p1":"0","p4":"0","p2":"29","p3":"29"},{"name":"\u6613\u8f66\u751f\u6d3b\u6c7d\u8f66\u670d\u52a1\u8fde\u9501\uff08\u4e0a\u7b2cMOMA\u5e97\uff09","lat":"40.050151","lng":"116.321128","tel":"4000107877","address":"\u5317\u4eac\u5e02\u6d77\u6dc0\u533a\u4e0a\u5730\u5b81\u5b89\u8def\u4e0a\u7b2cMOMA\u5c0f\u533a\u5730\u4e0b\u505c\u8f66\u573aB2\u5c42","bhours":"","p1":"0","p4":"0","p2":"29","p3":"29"},{"name":"\u6613\u8f66\u751f\u6d3b\u6c7d\u8f66\u670d\u52a1\u8fde\u9501\uff08\u57ce\u5efa\u5927\u53a6\u5e97\uff09","lat":"39.974948","lng":"116.377708","tel":"4000107877","address":"\u5317\u4eac\u5e02\u6d77\u6dc0\u533a\u5317\u592a\u5e73\u5e84\u8def18\u53f7\u57ce\u5efa\u5927\u53a6\u5730\u4e0b\u505c\u8f66\u573aB2\u5c42","bhours":"","p1":"0","p4":"0","p2":"29","p3":"29"},{"name":"\u6613\u8f66\u751f\u6d3b\u6c7d\u8f66\u670d\u52a1\u8fde\u9501\uff08\u6e05\u534e\u79d1\u6280\u56ed\u5e97\uff09","lat":"40.00044","lng":"116.33806","tel":"4000107877","address":"\u5317\u4eac\u5e02\u6d77\u6dc0\u533a\u4e2d\u5173\u6751\u4e1c\u8def1\u53f7\u6e05\u534e\u79d1\u6280\u56ed\u5927\u53a6C\u5ea7\u5730\u4e0b\u505c\u8f66\u573aB3\u5c42","bhours":"","p1":"0","p4":"0","p2":"29","p3":"29"},{"name":"\u6613\u8f66\u751f\u6d3b\u6c7d\u8f66\u670d\u52a1\u8fde\u9501\uff08\u9f99\u6e56\u82b1\u76db\u9999\u918d\u5e97\uff09","lat":"39.881332","lng":"116.641226","tel":"4000107877","address":"\u5317\u4eac\u5e02\u901a\u5dde\u533a\u68a8\u56ed\u9547\u534a\u58c1\u5e97\u5927\u885725\u53f7\u9f99\u6e56\u82b1\u76db\u9999\u918d\u5c0f\u533a\u5730\u4e0bB1\u5c42","bhours":"","p1":"0","p4":"0","p2":"29","p3":"29"},{"name":"\u6613\u8f66\u751f\u6d3b\u6c7d\u8f66\u670d\u52a1\u8fde\u9501\uff08\u5929\u65f6\u540d\u82d1\u5e97\uff09","lat":"39.912158","lng":"116.640395","tel":"4000107877","address":"\u5317\u4eac\u5e02\u901a\u5dde\u533a\u5317\u82d1\u73af\u5c9b\u5730\u94c1\u7ad9\u897f\u4fa7\u5929\u65f6\u540d\u82d1\u5c0f\u533a\u5730\u4e0b2\u53f7\u5e93B1\u5c42","bhours":"","p1":"0","p4":"0","p2":"29","p3":"29"},{"name":"\u6613\u8f66\u751f\u6d3b\u6c7d\u8f66\u670d\u52a1\u8fde\u9501\uff08\u73af\u7403\u8d38\u6613\u4e2d\u5fc3\u5e97\uff09","lat":"39.973774","lng":"116.416758","tel":"4000107877","address":"\u5317\u4eac\u5e02\u4e1c\u57ce\u533a\u5317\u4e09\u73af36\u53f7\u73af\u7403\u8d38\u6613\u4e2d\u5fc3C\u5ea7B2\u5c42","bhours":"","p1":"0","p4":"0","p2":"29","p3":"29"},{"name":"\u6613\u8f66\u751f\u6d3b\u6c7d\u8f66\u670d\u52a1\u8fde\u9501\uff08\u897f\u6d77\u56fd\u9645\u4e2d\u5fc3\u5e97\uff09","lat":"39.969641","lng":"116.315771","tel":"4000107877","address":"\u5317\u4eac\u5e02\u6d77\u6dc0\u533a\u5317\u4e09\u73af\u897f\u8def99\u53f7\u897f\u6d77\u56fd\u9645\u4e2d\u5fc3\u5730\u4e0b\u505c\u8f66\u573aB2\u5c42","bhours":"","p1":"0","p4":"0","p2":"29","p3":"29"},{"name":"\u6613\u8f66\u751f\u6d3b\u6c7d\u8f66\u670d\u52a1\u8fde\u9501\uff08\u91d1\u878d\u8857\u6d32\u9645\u5e97\uff09","lat":"39.924874","lng":"116.364207","tel":"010-66553886","address":"\u5317\u4eac\u5e02\u897f\u57ce\u533a\u91d1\u878d\u885711\u53f7\u6d32\u9645\u9152\u5e97\u5730\u4e0b\u505c\u8f66\u573aB3\u5c42","bhours":"","p1":"0","p4":"0","p2":"29","p3":"29"},{"name":"\u6613\u8f66\u751f\u6d3b\u6c7d\u8f66\u670d\u52a1\u8fde\u9501\uff08\u5609\u7f8e\u4e2d\u5fc3\u5e97\uff09","lat":"39.992444","lng":"116.48662","tel":"4000107877","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u671b\u4eac\u5e7f\u987a\u5357\u5927\u885716\u53f7\u65b0\u4e16\u754c\u767e\u8d27\u671b\u4eac\u5e97\u5730\u4e0bB3\u5c42","bhours":"","p1":"0","p4":"0","p2":"29","p3":"29"},{"name":"\u6613\u8f66\u751f\u6d3b\u6c7d\u8f66\u670d\u52a1\u8fde\u9501\uff08\u8fdc\u6d0b\u5149\u534e\u56fd\u9645\u5e97\uff09","lat":"39.921175","lng":"116.460798","tel":"4000107877","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u91d1\u6850\u897f\u8def10\u53f7\u8fdc\u6d0b\u5149\u534e\u56fd\u9645\u5927\u53a6\u5730\u4e0b\u505c\u8f66\u573aB1\u5c42","bhours":"","p1":"0","p4":"0","p2":"29","p3":"29"},{"name":"\u6613\u8f66\u751f\u6d3b\u6c7d\u8f66\u670d\u52a1\u8fde\u9501\uff08\u51a0\u57ce\u540d\u6566\u9053\u5e97\uff09","lat":"39.899015","lng":"116.453533","tel":"4000107877","address":"\u5317\u4eac\u5e02\u4e1c\u57ce\u533a\u4e1c\u4e8c\u73af\u5e7f\u6e20\u5bb6\u56ed5\u53f7\u6566\u9053\u5927\u53a6\u5730\u4e0b\u505c\u8f66\u573aB2\u5c42","bhours":"","p1":"0","p4":"0","p2":"29","p3":"29"},{"name":"\u6613\u8f66\u751f\u6d3b\u6c7d\u8f66\u670d\u52a1\u8fde\u9501\uff08\u91d1\u9685\u5609\u534e\u5e97\uff09","lat":"40.042265","lng":"116.314642","tel":"4000107877","address":"\u5317\u4eac\u5e02\u6d77\u6dc0\u533a\u4e0a\u5730\u4e09\u88579\u53f7\u91d1\u9685\u5609\u534e\u5927\u53a6\u5730\u4e0b\u505c\u8f66\u573aB1\u5c42","bhours":"","p1":"0","p4":"0","p2":"29","p3":"29"},{"name":"\u534e\u8c0a\u5144\u5f1f\u6c7d\u8f66\uff08\u65b0\u6b23\u6c7d\u8f66\u9ec4\u6d77\u8def\u5e97\uff09","lat":"41.798882","lng":"123.295254","tel":"024-66673567","address":"\u94c1\u897f\u533a\u9ec4\u6d77\u8def89\u53f7","bhours":"","p1":"0","p4":"0","p2":"18","p3":"20"},{"name":"\u82f1\u56fd\u5c3c\u5c14\u68ee\u6c7d\u8f66\u670d\u52a1\u4e2d\u5fc3","lat":"39.919509","lng":"116.535153","tel":"15699938016","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u9ad8\u7891\u5e97\u5174\u9686\u8857103\u53f7","bhours":"","p1":"0","p4":"0","p2":"29","p3":"29"},{"name":"\u9753\u8f66\u6bbf\u5802","lat":"39.780815","lng":"116.341791","tel":"010-60221980","address":"\u5317\u4eac\u5e02\u5927\u5174\u533a\u90c1\u82b1\u56ed\u4e8c\u91cc\u5546\u4e1a22\u53f7","bhours":"","p1":"0","p4":"0","p2":"59","p3":"71"},{"name":"\u9e3f\u4e91\u7965\u5546\u8d38","lat":"39.994703","lng":"116.478022","tel":"010-62133772","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u671b\u4eac\u671b\u82b1\u897f\u91cc13\u53f7\u697c","bhours":"","p1":"0","p4":"0","p2":"29","p3":"35"},{"name":"\u957f\u57ce\u6da6\u6ed1\u6cb9\u517b\u62a4\u4e2d\u5fc3\uff08\u6e05\u6cb3\u5e97\uff09","lat":"39.998509","lng":"116.359651","tel":"010-82411366 ","address":"\u5317\u4eac\u5e02\u6d77\u6dc0\u533a\u5b66\u9662\u8def\u68c0\u6d4b\u573a\u5bf9\u9762\u52a0\u6cb9\u7ad9\u5185","bhours":"","p1":"0","p4":"0","p2":"35","p3":"35"},{"name":"\u957f\u57ce\u6da6\u6ed1\u6cb9\u517b\u62a4\u4e2d\u5fc3\uff08\u534e\u6e05\u5e97\uff09","lat":"39.998189","lng":"116.341418","tel":"010-82872858 ","address":"\u5317\u4eac\u5e02\u6d77\u6dc0\u533a\u4e94\u9053\u53e3\u534e\u6e05\u5609\u56ed\u4e1c\u4fa750\u7c73","bhours":"","p1":"0","p4":"0","p2":"35","p3":"35"},{"name":"\u957f\u57ce\u6da6\u6ed1\u6cb9\u517b\u62a4\u4e2d\u5fc3\uff08\u4e9a\u8fd0\u6751\u5e97\uff09","lat":"40.013998","lng":"116.413002","tel":"010-64839897 ","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u5b89\u7acb\u8def\u6167\u5fe0\u5317\u91cc219\u53f7\u697c1\u5c42","bhours":"","p1":"0","p4":"0","p2":"35","p3":"35"},{"name":"\u957f\u57ce\u6da6\u6ed1\u6cb9\u517b\u62a4\u4e2d\u5fc3\uff08\u5a92\u4f53\u6751\u5e97\uff09","lat":"40.044485","lng":"116.418928","tel":"010-84929286 ","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u5929\u5c45\u56ed4\u53f7\u697c\u5e95\u5546113-114\u53f7","bhours":"","p1":"0","p4":"0","p2":"35","p3":"35"},{"name":"\u957f\u57ce\u6da6\u6ed1\u6cb9\u517b\u62a4\u4e2d\u5fc3\uff08\u5317\u82d1\u5e97\uff09","lat":"40.037856","lng":"116.444982","tel":"010-84950510 ","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u6765\u5e7f\u8425\u9752\u5e74\u57ce\u793e\u533a16\u53f7\u697c-3-4","bhours":"","p1":"0","p4":"0","p2":"35","p3":"35"},{"name":"\u957f\u57ce\u6da6\u6ed1\u6cb9\u517b\u62a4\u4e2d\u5fc3\uff08\u5341\u91cc\u5821\u5e97\uff09","lat":"39.925046","lng":"116.508574","tel":"010-59814622 ","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u5341\u91cc\u5821\u4e1c\u91cc124\u697c\u5e95\u5546","bhours":"","p1":"0","p4":"0","p2":"35","p3":"35"},{"name":"\u957f\u57ce\u6da6\u6ed1\u6cb9\u517b\u62a4\u4e2d\u5fc3\uff08\u671d\u9633\u8def\u5e97\uff09","lat":"39.993524","lng":"116.368466","tel":"010-65751826 ","address":"\u5317\u4eac\u5e02\u671d\u9633\u533a\u4e1c\u82c7\u8def\u79d1\u6280\u5927\u5b66\u5bf9\u9762","bhours":"","p1":"0","p4":"0","p2":"35","p3":"35"},{"name":"\u957f\u57ce\u6da6\u6ed1\u6cb9\u517b\u62a4\u4e2d\u5fc3\uff08\u9c81\u8c37\u5e97\uff09","lat":"39.908379","lng":"116.230132","tel":"010-68654589 ","address":"\u5317\u4eac\u5e02\u77f3\u666f\u5c71\u533a\u53cc\u9526\u56ed\u5c0f\u533a16\u53f7\u697c16-1","bhours":"","p1":"0","p4":"0","p2":"35","p3":"35"},{"name":"\u957f\u57ce\u6da6\u6ed1\u6cb9\u517b\u62a4\u4e2d\u5fc3\uff08\u84b2\u9ec4\u6986\u5e97\uff09","lat":"39.875811","lng":"116.426575","tel":"010-63856780 ","address":"\u5317\u4eac\u5e02\u4e30\u53f0\u533a\u84b2\u9ec4\u6986\u4e8c\u91cc26\u53f7\u9662","bhours":"","p1":"0","p4":"0","p2":"35","p3":"35"},{"name":"\u957f\u57ce\u6da6\u6ed1\u6cb9\u517b\u62a4\u4e2d\u5fc3\uff08\u5149\u5f69\u8def\u5e97\uff09","lat":"39.843553","lng":"116.42188","tel":"010-67282820 ","address":"\u5317\u4eac\u5e02\u4e30\u53f0\u533a\u77f3\u69b4\u5e84\u5149\u5f69\u8def70\u53f7\u897f\u533a3\u53f7\u697c\u4e00\u5c42","bhours":"","p1":"0","p4":"0","p2":"35","p3":"35"},{"name":"\u957f\u57ce\u6da6\u6ed1\u6cb9\u517b\u62a4\u4e2d\u5fc3\uff08\u897f\u9a6c\u5e84\u5e97\uff09","lat":"39.927223","lng":"116.646305","tel":"010-80544028 ","address":"\u5317\u4eac\u5e02\u901a\u5dde\u533a\u7269\u8d44\u5b66\u9662\u8def\u5546\u4e1a\u697c","bhours":"","p1":"0","p4":"0","p2":"35","p3":"35"},{"name":"\u957f\u57ce\u6da6\u6ed1\u6cb9\u517b\u62a4\u4e2d\u5fc3\uff08\u68a8\u56ed\u5e97\uff09","lat":"39.882915","lng":"116.651494","tel":"010-80816628 ","address":"\u5317\u4eac\u5e02\u901a\u5dde\u533a\u68a8\u56ed\u4e91\u666f\u91cc\u8def\uff08\u65d7\u8230\u51ef\u65cb\uff09\u4e07\u80dc\u5317\u91cc351\u53f7","bhours":"","p1":"0","p4":"0","p2":"35","p3":"35"},{"name":"\u957f\u57ce\u6da6\u6ed1\u6cb9\u517b\u62a4\u4e2d\u5fc3\uff08\u5929\u901a\u82d1\u5e97\uff09","lat":"40.064057","lng":"116.42449","tel":"010-84816566 ","address":"\u5317\u4eac\u5e02\u660c\u5e73\u533a\u4e1c\u5c0f\u53e3\u9547\u4e2d\u6ee9\u6751\u4e1c\u5730\u8d28\u52d8\u5bdf\u6280\u672f\u9662\u5bb6\u5c5e\u697c\u5357\u4fa7","bhours":"","p1":"0","p4":"0","p2":"35","p3":"35"},{"name":"\u957f\u57ce\u6da6\u6ed1\u6cb9\u517b\u62a4\u4e2d\u5fc3\uff08\u56de\u9f99\u89c2\u5e97\uff09","lat":"40.085045","lng":"116.356248","tel":"010-80757855 ","address":"\u5317\u4eac\u5e02\u660c\u5e73\u533a\u9f99\u89c2\u9f99\u8dc3\u82d12\u533a1\u53f7\u697c\u4e00\u5c42","bhours":"","p1":"0","p4":"0","p2":"35","p3":"35"},{"name":"\u957f\u57ce\u6da6\u6ed1\u6cb9\u517b\u62a4\u4e2d\u5fc3\uff08\u9ad8\u6559\u56ed\u5e97\uff09","lat":"40.157621","lng":"116.285892","tel":"010-53059618","address":"\u5317\u4eac\u5e02\u660c\u5e73\u533a\u6c99\u6cb3\u9547\u4e30\u5584\u6751\u5146\u4e30\u5bb6\u56ed12\u53f72\u53f7\u697c","bhours":"","p1":"0","p4":"0","p2":"35","p3":"35"},{"name":"\u7acb\u65b0\u6c7d\u8f66\u7ef4\u4fee\u7ad9\uff08\u897f\u9ec4\u57ce\u6839\u5e97\uff09","lat":"39.931211","lng":"116.383533","tel":"13301281796","address":"\u5317\u4eac\u5e02\u897f\u57ce\u533a\u897f\u9ec4\u57ce\u6839\u5317\u885723\u53f7","bhours":"","p1":"0","p4":"0","p2":"24","p3":"41"},{"name":"\u5317\u4eac\u666e\u4e50\u4f73\u6021\u6c7d\u8f66\u670d\u52a1\u4e2d\u5fc3","lat":"39.9131","lng":"116.289542","tel":"13301281796","address":"\u5317\u4eac\u5e02\u6d77\u6dc0\u533a\u897f\u7fe0\u8def\uff08\u51c0\u96c5\u5927\u9152\u5e97\u65c1\uff09","bhours":"","p1":"0","p4":"0","p2":"24","p3":"41"},{"name":"\u6668\u5347\u6c7d\u8f66\u517b\u62a4\u4e2d\u5fc3","lat":"39.702095","lng":"118.207424","tel":"0315-3296219","address":"\u9ad8\u65b0\u533a\u6c34\u673a\u8def\u674e\u5404\u5e84\u67511\u680b17\u53f7\uff08\u4e09\u5341\u4e94\u4e2d\u5b66\u897f\u4fa7\uff09","bhours":"","p1":"0","p4":"0","p2":"14","p3":"19"},{"name":"\u65b0\u534e\u8f66\u9970","lat":"39.603184","lng":"118.204118","tel":"0315-2888123","address":"\u8def\u5357\u533a\u5510\u67cf\u8def\u897f\u4fa7\u5cb3\u5404\u5e84\u8def\u5357\u4fa7\uff08\u91d1\u6052\u56fd\u9645\u6c7d\u914d\u57ce6-29\u53f7\uff09","bhours":"","p1":"0","p4":"0","p2":"71","p3":"94"},{"name":"\u65b0\u6f6e\u6c7d\u8f66\u7f8e\u5bb9","lat":"37.8994602","lng":"112.555303","tel":"13935122799","address":"\u674f\u82b1\u5cad\u533a\u65b0\u5efa\u5317\u8def230\u53f7","bhours":"","p1":"0","p4":"0","p2":"22","p3":"28"}]');
</script>
<script type="text/javascript">
var markers = new Array();
var windowsInfos = new Array();

	$(function(){
		
/* 	   if(supportsGeoLocation()){
	         alert("你的浏览器支持 GeoLocation.");
	      }else{
	         alert("不支持 GeoLocation.")
	      } */
		var latlng = new BMap.Point(116.4018, 39.91105);//// 创建地图实例
		map = new BMap.Map("l-map");
		map.centerAndZoom(latlng, 12);
		
   	var markIcoRed = new BMap.Icon('${ctxStatic}/map-baidu/images/coordinate.gif', new BMap.Size(24, 31));// 红色
	markIcoRed.setAnchor(new BMap.Size(14, 32));
    var markIcoBlue = new BMap.Icon('${ctxStatic}/map-baidu/images/coordinate.gif', new BMap.Size(24, 31)); // 蓝色
    markIcoBlue.setAnchor(new BMap.Size(14, 32));
    markIcoBlue.setImageOffset(new BMap.Size(0, -31));
	   
	   getLocation();	// 获得当前位置并初始化地图
	   
	     
		//左侧导航点击事件
		
	$(document).on("mouseenter", "#wash_list li", function() {
		var markerId = $(this).index();
		var marker = markers[markerId];
		var point = marker.getPosition();
		map.panTo(point);
		marker.setIcon(markIcoBlue);
	}).on("mouseleave", "#wash_cars li", function() {
		var markerId = $(this).index();
		var marker = markers[markerId];
		marker.setIcon(markIcoRed);
	}).on("click", "#wash_cars li", function() {
		var markerId = $(this).index();
		var windowsInfo = windowsInfos[markerId];
		var marker = markers[markerId];
		windowsInfo.open(marker);
	});
		
		resizeContainer();
		
		//$(".left_content").css("overflow","hidden");
		
		$(window).resize(function() {
			resizeContainer();
		});
	
	var markLableStyle = {
			display : "block",
			background : "transparent",
			fontSize : "14px/24px",
			width : "24px",
			height : "31px",
			padding : "0",
			border : "none",
			color : "#fff",
			textAlign : "center",
			lineHeight : "24px",
			fontFamily : "Microsoft YaHei"
		};
		
	$.ajax({
    	type: "get",
    	url: "/jeesite/washcar/map/getLocations",
    	dataType: "json",
    	success: function(ds1) {
				//ds  为服务器获得数据
				var html = '';
				$.each(ds1, function(i, n) {
		    			html += '<li class="bu_item_' + i + '>';
		    			html += '	<a href="javascript:;">';
		    			html += '        <em>' + (i+1) + '</em>';
		    			html += '        <h4>' + n.name + '</h4>';
		    			html += '        <p>地址：' + n.address + '</p>';
		    			html += '        <p>电话：' + n.tel + '</p>';
		    			//html += '        <p>营业时间：' + n.bhours + '</p>';
		    			html += '        <div class="price">';
		    			if(n.min_precise>0||n.max_precise>0){
		    				html += '            <span class="sub" style="width:120px;">精洗：' + n.min_precise + '~'+n.max_precise+'分</span>';
		    			}
		    			if(n.min_standard>0||n.max_standard>0){
		    				html += '            <span class="sub" style="width:120px;">普洗：' + n.min_standard + '~'+n.max_standard+'分</span>';
		    			}
		    			html += '        </div>';
		    			html += '    </a>';
		    			html += '</li>';
		    			
						var marker = new BMap.Marker();
						marker.setTitle(n.name);
						marker.setPosition(new BMap.Point(n.longitude, n.latitude));
						marker.setIcon(markIcoRed);
						
						var lable = new BMap.Label(i + 1);
						lable.setStyle(markLableStyle);
						marker.setLabel(lable);
						
						map.addOverlay(marker);
						markers[i] = marker;
						marker.addEventListener("mouseover", function() {
							//$("#bu_items").show();$("#sp_items").hide();
							//$(".top_type li").eq(0).addClass("hover").siblings().removeClass("hover");
							var top = $(".bu_item_" + i).offset().top;
							var cur_top = $(".company_content").scrollTop();
							var left_h = $(".company_content").height();
							var header_h = $("header").outerHeight(true);
							$(".company_content").animate({scrollTop: top + cur_top - header_h - (left_h / 2)}, 100);
							$(".bu_item_" + i).addClass("hover").siblings().removeClass("hover");
							marker.setIcon(markIcoBlue);
						});
						marker.addEventListener("mouseout", function() {
							marker.setIcon(markIcoRed);
							$(".bu_item_" + i).removeClass("hover");
						});
						//创建检索信息窗口对象
					    var searchInfoWindow = null;
					    var content = '';
					    content += '<div class="mappop">';
					    content += '<div class="info">';
					    content += '	<h4>' + n.name + '</h4>';
					    content += '    <p>地址：' + n.address + '</p>';
					    content += '    <p>电话：' + n.tel + '</p>';
					    //content += '    <p>营业时间：' + n.bhours + '</p>';
					    content += '</div>';
					    content += '<div class="price">';
					    content += '	<h4>价位</h4>';
					    if(n.min_precise>0||n.max_precise>0){
					    	content += '    <p><span class="r"><span class="org">' + n.min_precise + '~'+n.max_precise+'</span> 积分</span>精洗：</p>';
					    }
					    if(n.min_standard>0||n.max_standard>0){
					    	content += '    <p><span class="r"><span class="org">' + n.min_standard + '~'+n.max_standard+'</span> 积分</span>普洗：</p>';
					    }
					    content += '</div>';
					    content += '<div class="c"></div>';
					    content += '</div>';
						searchInfoWindow = new BMapLib.SearchInfoWindow(map, content, {
								title  : "洗车家-"+n.name,      //标题
								width  : 500,             //宽度
								panel  : "panel",         //检索结果面板
								enableAutoPan : true,     //自动平移
								searchTypes   :[
									BMAPLIB_TAB_TO_HERE,  //到这里去
									BMAPLIB_TAB_FROM_HERE //从这里出发
								]
							});
						windowsInfos[i] = searchInfoWindow;
						marker.addEventListener("click", function() {
							searchInfoWindow.open(marker);
						});
		    		});
		    		$("#wash_cars").html(html);
    	}//ds 处理完成
	});	 //ajax 结束		
    		
    		var hash = location.hash;
    		
    		if (hash != "" && hash.length > 1) {
    			hash = hash.substring(1, hash.length);
    			var cons = hash.split("&");
    			for (i=0;i<cons.length;i++) {
    				var con = cons[i].split("=");
    				var key = con[0];
    				var value = con[1];
    				
    				if (key == "aid") {
    					$(".area a").click();
    					$("#positions a[aid=" + value + "]").click();
    				}
    				if (key == "did") {
    					$("#positions a[did=" + value + "]").click();
    				}
    				if (key == "lid") {
    					$(".type a").click();
    					$("#labels a[lid=" + value + "]").click();
    				}
    				if (key == "keyword") {
    					$("#searchWord").val(decodeURIComponent(value));
    					$("#searchBtn").click();
    				}
    			}
    			if ($("#wash_list li:visible").length > 0)
    			$("#wash_list li:visible").eq(0).click();
    		}

   	//jquery 结束
});	 		

/*		
	var customLayer;
	function addCustomLayer(keyword) {
		if (customLayer) {
			map.removeTileLayer(customLayer);
		}
		customLayer=new BMap.CustomLayer({
			geotableId: 76578,
			q: '', //检索关键字
			tags: '', //空格分隔的多字符串
			filter: '' //过滤条件,参考http://developer.baidu.com/map/lbs-geosearch.htm#.search.nearby
		});
		map.addTileLayer(customLayer);
		customLayer.addEventListener('hotspotclick',callback);
	}
	function callback(e)//单击热点图层
	{
			var customPoi = e.customPoi;//poi的默认字段
			var contentPoi=e.content;//poi的自定义字段
			var content = '<p style="width:280px;margin:0;line-height:20px;">地址：' + customPoi.address + '<br/>价格:'+contentPoi.dayprice+'元'+'</p>';
			var searchInfoWindow = new BMapLib.SearchInfoWindow(map, content, {
				title: customPoi.title, //标题
				width: 290, //宽度
				height: 40, //高度
				panel : "panel", //检索结果面板
				enableAutoPan : true, //自动平移
				enableSendToPhone: true, //是否显示发送到手机按钮
				searchTypes :[
					BMAPLIB_TAB_SEARCH,   //周边检索
					BMAPLIB_TAB_TO_HERE,  //到这里去
					BMAPLIB_TAB_FROM_HERE //从这里出发
				]
			});
			var point = new BMap.Point(customPoi.point.lng, customPoi.point.lat);
			searchInfoWindow.open(point);
	}
	*/
	//document.getElementById("open").onclick = function(){
	//	addCustomLayer();
	//};
	//document.getElementById("close").onclick = function(){
	//	if (customLayer) {
	//		map.removeTileLayer(customLayer);
	//	}
	//};
	// 创建CityList对象，并放在citylist_container节点内
	/*var myCl = new BMapLib.CityList({container : "citylist_container", map : map});

	// 给城市点击时，添加相关操作
	myCl.addEventListener("cityclick", function(e) {
		// 修改当前城市显示
		document.getElementById("curCity").innerHTML = e.name;

		// 点击后隐藏城市列表
		document.getElementById("cityList").style.display = "none";
	});
	// 给“更换城市”链接添加点击操作
	document.getElementById("curCityText").onclick = function() {
		var cl = document.getElementById("cityList");
		if (cl.style.display == "none") {
			cl.style.display = "";
		} else {
			cl.style.display = "none";
		}	
	};
	// 给城市列表上的关闭按钮添加点击操作
	document.getElementById("popup_close").onclick = function() {
		var cl = document.getElementById("cityList");
		if (cl.style.display == "none") {
			cl.style.display = "";
		} else {
			cl.style.display = "none";
		}	
	};
*/
	function resizeContainer() {
	var header_h = $(".header_wrap").outerHeight(true);
	var footer_h = $("footer").outerHeight(true);
	var container_h = $(window).height() - header_h;
	$(".container, .map .leftmenu, .map_box").height(container_h);
	$(".map .merchantlist").height(container_h-90);
	}
	   // 检测浏览器是否支持HTML5
    function supportsGeoLocation(){
     return !!navigator.geolocation;
   }  
	   
    function getLocation(){
		//mapIt定位成功时，执行的函数    locationError 定位失败时，执行的函数
      navigator.geolocation.getCurrentPosition(translatePoint,locationError);
	}
	   // 尝试一下不转换  结果转换偏东  不转换 偏西？
    function translatePoint(position){ 
    	var currentLat = position.coords.latitude; 
    	var currentLon = position.coords.longitude; 
    	//alert(currentLon);
    	var gpsPoint = new BMap.Point(currentLon, currentLat); 
    	// gpsPoint：转换前坐标，第二个参数为转换方法，0表示gps坐标转换成百度坐标，callback回调函数，参数为新坐标点 
    	BMap.Convertor.translate(gpsPoint, 0, initMap); //转换坐标 
    } 
	   
	   
    // function initMap(position){
    	 function initMap(point){
    	
    	// 转换时注视点以下三行
        //var lon = position.coords.longitude;
       // var lat = position.coords.latitude;
    	// var point = new BMap.Point(""+lon+"",""+lat+"");
    	 
        // alert("您位置的经度是："+lon+" 纬度是："+lat);
    	// 百度地图API功能
    	//var point = new BMap.Point(116.403694,39.927552);  // 创建点坐标
    	
    	map.centerAndZoom(point, 17); // 初始化地图，设置中心点坐标和地图级别
    	map.enableScrollWheelZoom();
    	map.addControl(new BMap.NavigationControl());  //添加默认缩放平移控件
    	
    	var ctrl = new BMapLib.TrafficControl({
    		showPanel: false //是否显示路况提示面板
    	});      
    	map.addControl(ctrl);
    	ctrl.setAnchor(BMAP_ANCHOR_BOTTOM_RIGHT);  
    	
    	map.addControl(new BMap.ScaleControl()); 
    	map.addControl(new BMap.OverviewMapControl()); 
    	map.addOverlay(new BMap.Marker(point)) 
    }
    

    // 定位失败时，执行的函数
    function locationError(error){
   switch(error.code)
     {
     case error.PERMISSION_DENIED:
       alert("User denied the request for Geolocation.");
       break;
     case error.POSITION_UNAVAILABLE:
        alert("Location information is unavailable.");
       break;
     case error.TIMEOUT:
        alert("The request to get user location timed out.");
       break;
     case error.UNKNOWN_ERROR:
        alert("An unknown error occurred.");
       break;
     }
   }
</script>