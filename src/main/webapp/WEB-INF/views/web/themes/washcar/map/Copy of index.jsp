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
	
    <script type="text/javascript">
    	$(function(){
    		getAddressByGps();
    		  //点击重新定位
    		$("#btnresh").click(function(){
    			$(".mui-card")&&$(".mui-card").remove();
    			$("#loadingdiv").show();
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
									//获取数据
									getDataByCity(latlngcity,r.point.lng+','+r.point.lat);
									//alert('您的位置：'+r.point.lng+','+r.point.lat); 
								}else{
									$("#myaddress").html("<i></i>");
									getDataByCity("",r.point.lng+','+r.point.lat);
								}
							});
				}else{
					//从后台获取经纬度，如果有经纬度那么进入地图，如果没有经纬度。进入城市切换页面
					$("#myaddress").html("<i></i>打开GPS可定位");
					getDataByCity("","");
				}

			},{enableHighAccuracy: true})
    	}
    	
    	function getDataByCity(cityname,location){
    		//从后台获取经纬度，如果有经纬度那么进入地图，如果没有经纬度。进入城市切换页面
			$.post("${ctx}/washcar/map/getNearLocations",{cityname:cityname,location:location},function(data){
			
				var shops=data.shops;
				//alert(data.success);
				if(data.success && shops!=undefined){
					var shopstr="";
					for(var i=0;i<shops.length;i++){
						shopstr+=getTemplate(shops[i]);
					}
					//放到脚部前面
					$("#htitle").html("");
					$("#loadingdiv").hide();
					$(".list_mark_bottom").before(shopstr);
					$("#hcity").html(data.cityname+'<i class="list_mark_header_left list_header_left_icon"></i>');
					$("#htitle").html(data.cityname+"洗车网点");
				}else{
					alert("未获取到商家，请稍后重试！",2000);
				}
		},'json');
    	}
    	
    	function getTemplate(json){
    		var str='';
    		str+='<div class="mui-card">';
				str+='	<ul class="mui-table-view">';
				str+='		<li class="mui-table-view-cell shop_top_border">';
				str+='			<a class="mui-navigate-right" href="${ctx}/washcar/shop/detail?shopid='+json.shopId+'&dis='+json.dis+'">';
				str+='				<img class="mui-pull-left shop_list_img" src="#" onerror=\"this.src=\'${ctxStatic}/washcar/mobile/images/xiche.jpg\'\">';
/*
				if(json.penny=="1"){
				str+='				<div class="ddxc_hdtbmk">';
				str+='					<img src="images/yfqhdtb.png"/>';
				str+='				</div>';
				}
*/
				str+='				<div class="mui-media-body shop_list_info">';
				str+='					<h3>'+json.name+'</h3>';
				str+='					<span class="list_star star_4"></span>';
				str+='					<font>';
				str+='						'+json.minamt+'元起';
				str+='					</font>';
				str+='					<p>'+json.region+'</p>';

				if(json.dis>0){
					str+='					<div class="shop_list_info_distance">'+json.dis+'千米</div>';
				}

				str+='				</div>';
				str+='			</a>';
				str+='		</li>';
				str+='	</ul>';
				str+='</div>';
				return str;
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
			<span><i class="list_mark_header_right list_header_right_icon" id="btnmap">地图</i></span>
		</a>
	</div>

	<div id="loadingdiv" style="text-align: center;margin-top: 50px;">
		<img src="${ctxStatic}/washcar/map/images/loading2.gif" />
	</div>

<form class="list_mark_bottom">
	<span id="myaddress">
		<i></i>
	</span>
	<font>
		<a href="javascript:;" id="btnresh">asdfasdfas</a>
	</font>
</form>

<div style="height: 20px;"></div>