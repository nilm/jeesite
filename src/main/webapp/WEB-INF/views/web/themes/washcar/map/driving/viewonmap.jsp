<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />

<script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=kq53sCGqFHXGrRIUUNaB2xuM"></script>
	
	<link rel="stylesheet" href="${ctxStatic}/washcar/mobile/css/mui.css" />
	<link rel="stylesheet" href="${ctxStatic}/washcar/mobile/css/common.css" />

<style type="text/css">
        body, html, #mapContent {
            padding: 0;
            width: 100%;
            height: 96%;
            overflow: hidden;
        }

	</style>
	
	<!-- 路况 -->
<script type="text/javascript" charset="utf-8">
$(function(){
		//计算屏幕大小
		getAddressByGps();
		$("#mapContent").height($(window).height()-50);
		// 百度地图API功能
		var map = new BMap.Map("mapContent");
		map.centerAndZoom(new BMap.Point(${office.lng},${office.lat}), 13);
        window.M = map;
        var driving = new BMap.DrivingRoute(map, {renderOptions:{map: map, autoViewport: true}});
        window.Driving = driving;
   		//点击重新定位
   		$("#btnresh").click(function(){
   			$(".mui-card")&&$(".mui-card").remove();
   			$("#loadingdiv").show();
   			getAddressByGps();
   		});
});
	//定位的方法
	function getAddressByGps(){
    		//页面加载时初始化用户的坐标，如果没有坐标用浏览器定位
			var geolocation = new BMap.Geolocation();
			$("#myaddress").html("<i></i>正在定位中...");
			geolocation.getCurrentPosition(function(r){
				if(this.getStatus() == BMAP_STATUS_SUCCESS){
					var myGeo = new BMap.Geocoder();
					//清空选择的城市，让系统可以自动定位
					myGeo.getLocation(r.point, function (result) {
				        	if(result){
				            	var addComp = result.addressComponents;
								var latlngcity=addComp.city;
								$("#myaddress").html("<i></i>"+result.address);
								//获取数据
								getDataByCity(latlngcity,r.point.lng,r.point.lat);
							}else{
				            	$("#myaddress").html("<i></i>");
				            	getDataByCity("",r.point.lng,r.point.lat);
							}
				        });
				}else{
					//从后台获取经纬度，如果有经纬度那么进入地图，如果没有经纬度。进入城市切换页面
					$("#myaddress").html("<i></i>打开GPS可定位");
					getDataByCity("","","");
				}
			
			},{enableHighAccuracy: true})
    	}
	
	
	function getDataByCity(cityname,lng,lat){
		
			var p1 = new BMap.Point(lng,lat);
			var p2 = new BMap.Point(${office.lng},${office.lat});
			
			Driving.search(p1, p2);
	}
</script>

</head>
<body>
	<div class="list_mark_header">
		<a href="javascript:;">
			<nav id="hcity" style="width:63px;">北京<i class="list_mark_header_left list_header_left_icon"></i></nav>
		</a>
		<h1 id="htitle">北京洗车网点</h1>
		<a href="javascript:;">
			<span><i class="list_mark_header_right" id="btnmap">地图</i></span>
		</a>
	</div>
<div id="mapContent"></div>
<style>
footer .nav li.myli > a.on > p, footer .nav li.myli > a.active > p {
background-position-y: -40px;
}
</style>
	<form class="list_mark_bottom">
		<span id="myaddress">
			<i></i>
		</span>
		<font>
			<a href="javascript:;" id="btnresh"></a>
		</font>
	</form>
	
<div style="height: 20px;"></div>
