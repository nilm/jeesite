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
	<link rel="stylesheet" href="${ctxStatic}/washcar/mobile/css/common.css?v=1" />

<style type="text/css">
        body, html, #mapContent {
            padding: 0;
            width: 100%;
            height: 96%;
            overflow: hidden;
        }

	</style>
	<!-- 加载百度地图样式信息窗口 -->
	<script type="text/javascript" src="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.js"></script>
	<link rel="stylesheet" href="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.css" />
	<!-- 加载城市列表 -->
	<script type="text/javascript" src="http://api.map.baidu.com/library/CityList/1.2/src/CityList_min.js"></script>
	
	<!-- 路况 -->
	<link href="http://api.map.baidu.com/library/TrafficControl/1.4/src/TrafficControl_min.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="http://api.map.baidu.com/library/TrafficControl/1.4/src/TrafficControl_min.js"></script>
	  <script type="text/javascript" src="http://developer.baidu.com/map/jsdemo/demo/convertor.js"></script>

<script type="text/javascript">
$(function(){
  		 getAddressByGps();
		  //点击重新定位
		$("#btnresh").click(function(){
			$(".mui-card")&&$(".mui-card").remove();
			//$("#loadingdiv").show();
			getAddressByGps();
		});
		
		//切换到地图
		$("#btnmap").click(function(){
			//loading(true);
			location.href="${ctx}/washcar/map/goMap";
		});
		
		//选择城市
		$("#hcity").click(function(){
			//loading(true);
			location.href="${ctx}/washcar/map/changecity";
		});
   	//jquery 结束
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
				//$.post("mnew.php?ac=mapnew&do=clearcity",function(){});
				
				myGeo.getLocation(r.point, function (result) {
							if(result){
								var addComp = result.addressComponents;
								var latlngcity=addComp.city;
								$("#myaddress").html("<i></i>"+result.address);
								initMap(r.point.lng,r.point.lat);
								//获取数据
								getDataByCity(latlngcity,r.point.lng,r.point.lat);
								//alert('您的位置：'+r.point.lng+','+r.point.lat); 
							}else{
								$("#myaddress").html("<i></i>");
								getDataByCity("",r.point.lng,r.point.lat);
							}
						});
			}else{
				//从后台获取经纬度，如果有经纬度那么进入地图，如果没有经纬度。进入城市切换页面
				$("#myaddress").html("<i></i>打开GPS可定位");
				getDataByCity("","");
			}

		},{enableHighAccuracy: true})
	}
 
	function getPanelCenter(){
   		//获取当前地图中心点的地址
   		var myGeo = new BMap.Geocoder();
   		myGeo.getLocation(cp, function (result) {
   		        	if(result){
   		            	var addComp = result.addressComponents;
   		//window.latlngcity=addComp.city;
   		$("#myaddress").html("<i></i>"+result.address);
   		            }else{
   		            	$("#myaddress").html("<i></i>打开gps可定位");
   		            }
   		        });
   	}
	
	function getDataByCity(cityname,lng,lat){
		//从后台获取经纬度，如果有经纬度那么进入地图，如果没有经纬度。进入城市切换页面
		
		var  location = lng+','+lat ;
		$.post("${ctx}/washcar/map/getNearLocations",{cityname:cityname,location:location},function(data){
		
			var shops=data.shops;
			//alert(data.success);
			if(data.success && shops!=undefined){
				
				M.centerAndZoom(new BMap.Point(lng, lat),14);
				addMarker(0, "1", lng,lat);
				
				var shopstr="";
				for(var i=0;i<shops.length;i++){
					addMarker(shops[i].shopId, shops[i].name, shops[i].lng,shops[i].lat);
				}
				//放到脚部前面
				$("#htitle").html("");
				$("#loadingdiv").hide();
				$("#hcity").html(data.city+'<i class="list_mark_header_left list_header_left_icon"></i>');
				$("#htitle").html(data.city+"洗车网点");
			}else{
				alert("未获取到商家，请稍后重试！",2000);
			}
	},'json');
	}
	
	function initMap(lng, lat){
		//计算屏幕大小
		$("#mapContent").height($(window).height()-64);
		if(lng == '' || lat== ''){
			//latlngcity = "北京";
		}
		//alert(latlngcity);
        var map = new BMap.Map("mapContent");  
        // 创建Map实例
       // map.centerAndZoom(latlngcity, 16);     		// 初始化地图,设置中心点坐标和地图级别
        map.centerAndZoom(new BMap.Point(lng, lat),14);
        map.addControl(new BMap.NavigationControl({anchor: BMAP_ANCHOR_BOTTOM_LEFT, type: BMAP_NAVIGATION_CONTROL_ZOOM}));

        //map.addControl(new BMap.ScaleControl());                    // 添加比例尺控件
       // map.addControl(new BMap.OverviewMapControl());              //添加缩略地图控件
        map.enableScrollWheelZoom();                            //启用滚轮放大缩小
       // map.addControl(new BMap.MapTypeControl());          //添加地图类型控件
       
       	var ctrl = new BMapLib.TrafficControl({
        showPanel: true //是否显示路况提示面板
        });      
	     map.addControl(ctrl);
     	ctrl.setAnchor(BMAP_ANCHOR_TOP_RIGHT);
     	
        window.M = map;
        $("#loadingdiv").hide();
	}
    function addMarker(id, name, x, y) {
        var p = new BMap.Point(x, y);
        var marker = new BMap.Marker(p);//, px = map.pointToPixel(p);
        M.addOverlay(marker);
        marker.enableDragging();
        marker.setTitle(id);


       	var markIcoRed = new BMap.Icon('${ctxStatic}/map-baidu/images/coordinate.gif', new BMap.Size(24, 31));// 红色
    	markIcoRed.setAnchor(new BMap.Size(14, 32));
       	
	    var markIcoBlue = new BMap.Icon('${ctxStatic}/map-baidu/images/coordinate.gif', new BMap.Size(24, 31)); // 蓝色
	    markIcoBlue.setAnchor(new BMap.Size(14, 32));
	    markIcoBlue.setImageOffset(new BMap.Size(0, -31));
	    if(name=='1'){
		    marker.setIcon(markIcoRed);
	    	name="当前位置";
	    }else{
		    marker.setIcon(markIcoBlue);
	    }
	    
        var label = new BMap.Label(name, { offset: new BMap.Size(25, 0) });
        label.setStyles({
    		borderColor:"#808080",
    		color:"#333",
    		cursor:"pointer"
        });
        //marker.setLabel(label); 
       	
        config.marker.add(marker,name);
    }
  //创建InfoWindow
    function createInfoWindow(name){
	    var iw = new BMap.InfoWindow("<b class='iw_poi_title' title='" + name + "'>" + name + "</b><div class='iw_poi_content' style='font-size:12px; display: block;'>"+name+"</div>");
	    return iw;
    }
    var config = {
            runn: false, //是否开始拾取坐标
            marker: {
                list: [],
                add: function (data,name) {
                    config.marker.index++;
                    config.marker.list.push(data);
                   		(function(){
							var _iw = createInfoWindow(name);
							var _marker = data;
							_marker.addEventListener("click",function(){
							this.openInfoWindow(_iw);
							 });
						})();
                },
                index:0
            }
            //save: true //当前设置是否已保存
        };
</script>

    <style type="text/css">
		.list_star{float: left; display: block; width: 75px; height: 18px; background:#00A0E8;background: url(${ctxStatic}/washcar/map/images/list_star.png) no-repeat -75px center; background-size: 150px;}
		.star_1{background-position-x: -60px;}
		.star_2{background-position-x: -45px;}
		.star_3{background-position-x: -30px;}
		.star_4{background-position-x: -15px;}
		.star_5{background-position-x: 0px;}
    </style>
</head>
<body>
<header>
    <a href="javascript:;" class="h_down"><img src="${ctxStatic}/washcar/map/images/change_city.png" alt="向下展开"  id="hcity"></a>
    <a href="javascript:;" class="h_next"><img src="${ctxStatic}/washcar/common/img/list_top.png" alt="导航" id="btnmap"></a>
    <h1>评价</h1>
</header>

	<div id="loadingdiv" style="text-align: center;margin-top: 50px;">
		<img src="${ctxStatic}/washcar/map/images/loading2.gif" />
	</div>
	
	<div id="mapContent"></div>
	
	<form class="list_mark_bottom">
		<span id="myaddress">
			<i></i>
		</span>
		<font>
			<a href="javascript:;" id="btnresh"></a>
		</font>
	</form>
	
<div style="height: 20px;"></div>