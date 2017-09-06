<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
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
	</style>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=kq53sCGqFHXGrRIUUNaB2xuM"></script>
	<!-- 加载百度地图样式信息窗口 -->
	<script type="text/javascript" src="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.js"></script>
	<link rel="stylesheet" href="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.css" />
	<!-- 加载城市列表 -->
	<script type="text/javascript" src="http://api.map.baidu.com/library/CityList/1.2/src/CityList_min.js"></script>
	<title>叠加麻点图层</title>
</head>
<body>
<div class="merchantlist content">
<ul id="wash_list"></ul>
</div>
	<div id="l-map"></div>
	<div id="result">
		<button id="open">打开</button><button id="close">关闭</button>
	</div>
	<!--城市列表-->
	<div class="sel_container"><strong id="curCity">北京市</strong> [<a id="curCityText" href="javascript:void(0)">更换城市</a>]</div>
	<div class="map_popup" id="cityList" style="display:none;">
		<div class="popup_main">
			<div class="title">城市列表</div>
			<div class="cityList" id="citylist_container"></div>
			<button id="popup_close"></button>
		</div>
	</div>
</body>
</html>


<script type="text/javascript">
var ds = jQuery.parseJSON('[{"areaId":42,"cityId":7,"districtId":43,"districtName":"回龙观"},{"areaId":1,"cityId":7,"districtId":59,"districtName":"望京"},{"areaId":45,"cityId":7,"districtId":68,"districtName":"草桥"},{"areaId":45,"cityId":7,"districtId":74,"districtName":"丰台其他"},{"areaId":1,"cityId":7,"districtId":89,"districtName":"常营"},{"areaId":1,"cityId":7,"districtId":97,"districtName":"安贞"},{"areaId":45,"cityId":7,"districtId":113,"districtName":"方庄"},{"areaId":41,"cityId":7,"districtId":193,"districtName":"永定路"},{"areaId":42,"cityId":7,"districtId":57,"districtName":"北七家"},{"areaId":1,"cityId":7,"districtId":60,"districtName":"酷车小镇"},{"areaId":44,"cityId":7,"districtId":129,"districtName":"德胜门"},{"areaId":51,"cityId":7,"districtId":133,"districtName":"惠河汽配城"},{"areaId":1,"cityId":7,"districtId":65,"districtName":"安贞"},{"areaId":45,"cityId":7,"districtId":70,"districtName":"青塔"},{"areaId":45,"cityId":7,"districtId":112,"districtName":"西国贸汽配城"},{"areaId":41,"cityId":7,"districtId":137,"districtName":"东北旺"},{"areaId":1,"cityId":7,"districtId":170,"districtName":"欢乐谷"},{"areaId":41,"cityId":7,"districtId":42,"districtName":"清河"},{"areaId":1,"cityId":7,"districtId":98,"districtName":"来广营"},{"areaId":1,"cityId":7,"districtId":102,"districtName":"小红门"},{"areaId":43,"cityId":7,"districtId":126,"districtName":"西黄村"},{"areaId":41,"cityId":7,"districtId":54,"districtName":"四季青"},{"areaId":49,"cityId":7,"districtId":82,"districtName":"良乡"},{"areaId":42,"cityId":7,"districtId":88,"districtName":"天通苑"},{"areaId":42,"cityId":7,"districtId":87,"districtName":"昌平"},{"areaId":1,"cityId":7,"districtId":90,"districtName":"天通苑"},{"areaId":2,"cityId":7,"districtId":110,"districtName":"鼓楼"},{"areaId":45,"cityId":7,"districtId":119,"districtName":"右安门"},{"areaId":45,"cityId":7,"districtId":120,"districtName":"张仪村"},{"areaId":41,"cityId":7,"districtId":122,"districtName":"清华大学"},{"areaId":41,"cityId":7,"districtId":123,"districtName":"阜石路"},{"areaId":41,"cityId":7,"districtId":130,"districtName":"定慧寺"},{"areaId":41,"cityId":7,"districtId":135,"districtName":"中关村"},{"areaId":41,"cityId":7,"districtId":136,"districtName":"西土城路"},{"areaId":1,"cityId":7,"districtId":147,"districtName":"酒仙桥"},{"areaId":41,"cityId":7,"districtId":189,"districtName":"西二旗"},{"areaId":41,"cityId":7,"districtId":50,"districtName":"上地"},{"areaId":2,"cityId":7,"districtId":66,"districtName":"幸福大街"},{"areaId":1,"cityId":7,"districtId":91,"districtName":"十里堡"},{"areaId":41,"cityId":7,"districtId":199,"districtName":"航天桥"},{"areaId":51,"cityId":7,"districtId":229,"districtName":"新华大街"},{"areaId":1,"cityId":7,"districtId":100,"districtName":"姚家园"},{"areaId":45,"cityId":7,"districtId":115,"districtName":"六里桥"},{"areaId":1,"cityId":7,"districtId":197,"districtName":"三元桥"},{"areaId":1,"cityId":7,"districtId":209,"districtName":"双井"},{"areaId":1,"cityId":7,"districtId":3,"districtName":"国贸"},{"areaId":1,"cityId":7,"districtId":101,"districtName":"大望路"},{"areaId":41,"cityId":7,"districtId":131,"districtName":"知春路"}]');
$(function() {
	
/* 	// 百度地图API功能
	var map = new BMap.Map("l-map");          // 创建地图实例
	var point = new BMap.Point(116.403694,39.927552);  // 创建点坐标
	map.centerAndZoom(point, 15);                 // 初始化地图，设置中心点坐标和地图级别
	map.enableScrollWheelZoom();
	map.addControl(new BMap.NavigationControl());  //添加默认缩放平移控件 */
	
	// map
	var latlng = new BMap.Point(116.4018, 39.91105);
	map = new BMap.Map("l-map");
	map.centerAndZoom(latlng, 12);
	map.enableScrollWheelZoom(true);
	//var ctrl = new BMapLib.TrafficControl({
    //    showPanel: true //是否显示路况提示面板
    //});      
	map.addControl(new BMap.NavigationControl());  //添加默认缩放平移控件
   // map.addControl(ctrl);
  //  ctrl.setAnchor(BMAP_ANCHOR_BOTTOM_RIGHT);
    var markIcoRed = new BMap.Icon("http://www.exc118.com/images/protal/coordinate.gif", new BMap.Size(24, 31));// 红色
	markIcoRed.setAnchor(new BMap.Size(14, 32));
    var markIcoBlue = new BMap.Icon("http://www.exc118.com/images/protal/coordinate.gif", new BMap.Size(24, 31)); // 蓝色
    markIcoBlue.setAnchor(new BMap.Size(14, 32));
    markIcoBlue.setImageOffset(new BMap.Size(0, -31));
    
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
    	url: "http://localhost/template-web1/getLocations",
    	dataType: "json",
    	success: function(msg) {
    		//alert("msg=="+msg);
    		var html = '';
    		$.each(msg, function(i, n) {
    			html += '<li class="bu_item_' + i + '" aid="' + n.aid + '" did="' + n.did + '" lid=",' + n.ls + ',">';
    			html += '	<a href="javascript:;">';
    			html += '        <em>' + (i+1) + '</em>';
    			html += '        <h4>' + n.name + '</h4>';
    			html += '        <p>地址：' + n.address + '</p>';
    			html += '        <p>电话：' + n.tel + '</p>';
    			//html += '        <p>营业时间：' + n.bhours + '</p>';
    			html += '        <div class="price">';
    			if(n.p1>0||n.p4>0){
    				html += '            <span class="sub" style="width:120px;">精洗：' + n.p1 + '~'+n.p4+'分</span>';
    			}
    			if(n.p2>0||n.p3>0){
    				html += '            <span class="sub" style="width:120px;">普洗：' + n.p2 + '~'+n.p3+'分</span>';
    			}
    			html += '        </div>';
    			html += '    </a>';
    			html += '</li>';
    			alert(html);
				var marker = new BMap.Marker();
				marker.setTitle(n.name);
				marker.setPosition(new BMap.Point(n.lng, n.lat));
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
					var cur_top = $(".content").scrollTop();
					var left_h = $(".content").height();
					var header_h = $("header").outerHeight(true);
					$(".content").animate({scrollTop: top + cur_top - header_h - (left_h / 2)}, 100);
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
			    if(n.p1>0||n.p4>0){
			    	content += '    <p><span class="r"><span class="org">' + n.p1 + '~'+n.p4+'</span> 积分</span>精洗：</p>';
			    }
			    if(n.p2>0||n.p3>0){
			    	content += '    <p><span class="r"><span class="org">' + n.p2 + '~'+n.p3+'</span> 积分</span>普洗：</p>';
			    }
			    content += '</div>';
			    content += '<div class="c"></div>';
			    content += '</div>';
				searchInfoWindow = new BMapLib.SearchInfoWindow(map, content, {
						title  : n.name,      //标题
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
    		
    		$("#wash_list").html(html);
    		
    		
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
    	}
    });
});
	
	///////////////
/*	var customLayer;
	function addCustomLayer(keyword) {
		if (customLayer) {
			map.removeTileLayer(customLayer);
		}
		customLayer=new BMap.CustomLayer({
			geotableId: 30960,
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
	document.getElementById("open").onclick = function(){
		addCustomLayer();
	};
	document.getElementById("close").onclick = function(){
		if (customLayer) {
			map.removeTileLayer(customLayer);
		}
	};
	// 创建CityList对象，并放在citylist_container节点内
	var myCl = new BMapLib.CityList({container : "citylist_container", map : map});

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
	};*/
</script>
