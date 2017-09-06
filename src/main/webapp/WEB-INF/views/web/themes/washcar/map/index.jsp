<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    
	<script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=kq53sCGqFHXGrRIUUNaB2xuM"></script>
	
	<link rel="stylesheet" href="${ctxStatic}/washcar/common/css/ch_base.css" />
	<link rel="stylesheet" href="${ctxStatic}/washcar/map/css/ch_wis.css" />
	
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
			$("#myaddress").css("line-height","1.6").addClass("p_5 f_14").html("<i></i>正在定位中...");
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
					$(".wis_list").before(shopstr);
					$("#hcity").html(data.cityname+'<i class="list_mark_header_left list_header_left_icon"></i>');
					$("#htitle").html(data.cityname+"洗车网点");
				}else{
					alert("未获取到商家，请稍后重试！",2000);
				}
		},'json');
    	}
    	
    	function getTemplate(json){
    		var str='';
    		str+='<div class="wis_item">';
				str+='	<a href="${ctx}/washcar/shop/?shopid='+json.shopId+'&dis='+json.dis+'">';
				str+='		<img src="${ctxStatic}/washcar/map/images/wis_r1_c2.png" onerror=this.src="/jeesite/static/washcar/common/img/xiche.jpg" class="wis_item_img">';
				str+='  </a>';
				str+='  <div class="wis_list_r">';
				str+='      <div class="wis_list_s">'+json.minamt+'元起</div>';
				str+='      <div class="wis_list_anch">';
				if(json.dis>0){
					str+='          <img src="${ctxStatic}/washcar/map/images/wis_r1_c10.png" alt="锚点">'+json.dis+'千米';
				}
				str+='      </div>';
				str+='   </div>';
				str+='   <div class="wis_list_m">';
				str+='       <a href="${ctx}/washcar/shop/?shopid='+json.shopId+'&dis='+json.dis+' class="wis_item_h1 ell">'+json.name+'</a>';
				str+='       <div class="wis_item_small ell">'+json.address+'</div>';
				str+='       <div class="wis_item_star star'+json.level+'"></div>';
				str+='   </div>';
				str+='</div>';
				return str;
    	}
    </script>
   </head>
<body>
	<header>
        <a href="javascript:history.go(-1);" class="h_back"><img src="${ctxStatic}/washcar/common/img/wis_r1_c33.png" alt="后退按钮"></a>
        <a href="${ctx}/washcar/map/goMap" class="h_next"><img src="${ctxStatic}/washcar/map/images/wis_r1_c6.png" alt="导航按钮"></a>
        <h1>到店洗车</h1>
    </header>
    <!-- 顶部Banner START -->
    <%-- <div class="wis_ban" id="jWisBan">
        <a class="wis_ban_unit jWisBanUnit">北京</a>
        <a class="wis_ban_unit jWisBanUnit">离我最近</a>
        <a class="wis_ban_unit jWisBanUnit">正在营业</a>
        <a class="wis_ban_unit jWisBanUnit last-child">搜索<img src="${ctxStatic}/washcar/map/images/wis_r1_c16.png" alt="搜索"></a>
        <div class="wisbu_conts" id="jWisbuConts">
            <div class="wisbu_cont jWisbuCont">
                <a href="#" class="btn btn_block btn_solid_blue">当前城市：北京</a>
                <div class="wisbu_tps">
                    <img src="${ctxStatic}/washcar/map/images/wis_r1_c12.png" alt="覆盖城市">
                    覆盖城市
                </div>
                <div class="wisbu_btn_grp" id="jWisbuBtnGrp">
                    <div class="wisbu_btn_unit jWisbuBtnUnit">
                        <a href="javascript:;" class="btn btn_block btn_border_gray active">北京</a>
                     </div>
                    <div class="wisbu_btn_unit jWisbuBtnUnit">
                        <a href="javascript:;" class="btn btn_block btn_border_gray">天津</a>
                     </div>
                    <div class="wisbu_btn_unit jWisbuBtnUnit">
                        <a href="javascript:;" class="btn btn_block btn_border_gray">青岛</a>
                     </div>
                    <div class="wisbu_btn_unit jWisbuBtnUnit">
                        <a href="javascript:;" class="btn btn_block btn_border_gray">济南</a>
                     </div>
                </div>
            </div>
            <div class="wisbu_cont2 jWisbuCont">
                <a class="wisbu_cont2_item">价格优先</a>
                <a class="wisbu_cont2_item">人气优先</a>
                <a class="wisbu_cont2_item">好评优先</a>
            </div>
            <div class="wisbu_cont3 jWisbuCont">
                <a class="wisbu_cont3_item">我去过的</a>
                <a class="wisbu_cont3_item">全部</a>
            </div>
            <div class="wisbu_cont4 jWisbuCont">
                <div class="wisbu_zsy_ipt">
                    <input type="text" class="wisbu_search" placeholder="请输入商户名称等关键信息">
                </div>
            </div>
        </div>
    </div> --%>
    <!-- 顶部Banner END -->
    <!-- 结果列表START -->
   <!--  <div class="wis_list">
        <div class="wisbu_mask" id="jWisbuMask"></div>
        
    </div> -->
<%-- 	<div class="list_mark_header">
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
 --%>
<form class="wis_list">
	<span id="myaddress">
		<i></i>
	</span>
	<font>
		<a href="javascript:;" id="btnresh"></a>
	</font>
</form>

<div style="height: 20px;"></div>