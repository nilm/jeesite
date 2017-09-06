<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html> 
<html lang="zh-cn"> 
<head> 
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" /> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title></title> 
<style type="text/css"> 
*{ 
height: 100%; //设置高度，不然会显示不出来 
} 
</style> 
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script> 
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=··············"></script> 
<script type="text/javascript" src="http://developer.baidu.com/map/jsdemo/demo/convertor.js"></script> 
<script> 
$(function(){ 
	navigator.geolocation.getCurrentPosition(translatePoint); //定位 translatePoint 为回调函数
	//在获取坐标成功之后会执行回调函数 callback; callback 方法的参数就是获取到的坐标点；
	//然后可以初始化地图，设置控件、中心点、缩放等级，然后给地图添加point的overlay： 
}); 

	//getCurrentPosition 获取到的坐标是 GPS 经纬度坐标，而百度地图的坐标是经过特殊转换的，
	//所以，在获取定位坐标和初始化地图之间需要进行一步坐标转换工作，
	//该转换方法百度API里面已经提供了，转换一个点或者批量装换的方法均有提供：
	//单个点转换需引用 http://developer.baidu.com/map/jsdemo/demo/convertor.js，
	//批量转换需引用 http://developer.baidu.com/map/jsdemo/demo/changeMore.js，
function translatePoint(position){ 
	var currentLat = position.coords.latitude; 
	var currentLon = position.coords.longitude; 
	var gpsPoint = new BMap.Point(currentLon, currentLat); 
	//gpsPoint：转换前坐标，第二个参数为转换方法，0表示gps坐标转换成百度坐标，callback回调函数，参数为新坐标点 
	BMap.Convertor.translate(gpsPoint, 0, initMap); //转换坐标 
} 
function initMap(point){ 
	//初始化地图 
	map = new BMap.Map("map"); 
	map.addControl(new BMap.NavigationControl()); 
	map.addControl(new BMap.ScaleControl()); 
	map.addControl(new BMap.OverviewMapControl()); 
	map.centerAndZoom(point, 15); 
	map.addOverlay(new BMap.Marker(point)) 
} 
</script> 
</head> 
<body> 
<div id="map"></div> 
</body> 
</html> 