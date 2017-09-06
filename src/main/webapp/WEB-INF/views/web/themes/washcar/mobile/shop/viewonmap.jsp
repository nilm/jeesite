<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />

<script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>

	<script src='http://webapi.amap.com/maps?v=1.3&key=47d2b43dc4f7746bd30bd75744981473'></script>
	
	<link rel="stylesheet" href="${ctxStatic}/washcar/common/css/ch_base.css" />	
	<link rel="stylesheet" href="${ctxStatic}/washcar/mobile/css/common.css?v=1" />
<%-- 	<link rel="stylesheet" href="${ctxStatic}/washcar/mobile/css/ddwash/ddxc_map.css?v=1" /> --%>
	
	<script src="${ctxStatic}/jquery-plugin/jquery.cookie.js" type="text/javascript"></script>
	
<style type="text/css">
	.infoWindow{position:relvtive;width:250px;position:relative;height:auto;background: #F2F2F2;z-index: 999;padding:10px;border-radius: 5px;  box-shadow: 2px 2px 20px #666;}
	.infoWindow div{width:100%;overflow: hidden;line-height: 25px;font-size:13px;}
	.infoWindow h5{display:inline-block;font-size:0.9rem;color:black;width:210px;line-height: 20px;}
	.infoWindow .closeInfoWindow{display: inline-block;position: absolute;font-size:1.5em;color:black;width:20px;height:20px;line-height: 20px;text-align: center;top:5px;right:5px;}
	.infoWindow .evaluation a{display: inline-block;float: right;width:60px;line-height: 20px;}
	
	.infoWindow i{ display: inline-block;
				  width: 15px;
				  height: 15px;
				  background-image: url(${ctxStatic }/washcar/common/img/icon-star3x.png);
				  background-position: center center;
				  background-repeat: no-repeat;
				  background-size: 100%;
				  float: left;
				  margin-top: 5px;
				  margin-right: 5px;
	  }
	 .infoWindow .active{background-image: url(${ctxStatic }/washcar/common/img/icon-starh3x.png);}
	 .infoWindow .navigation{display:inline-block;padding:0px 10px;height:auto;line-height: 25px;margin:5px 80px;background: #199ADD;text-align: center;  border-radius: 5px;font-weight: bold;color:white;}
	 .infoWindow .navigation em{float:left;margin-top:5px;width: 14px; height: 14px;display: inline-block;background-image: url(../../images/ddwash/icon-biao3x.png);background-position: center center;background-repeat: no-repeat;background-size: 100%;}
	
	 .ddxc_listmk_header_dhtb{content: url(../../images/ddwash/ddxc_dttb.png);}
	
	 .infoWindow_bottom{display:block; border-width:12px; position:absolute; bottom:-24px; left:110px;border-style:solid dashed dashed; border-color:#F2F2F2 transparent transparent;font-size:0; line-height:0;}
</style>
	
</head>
<body>

<header>
    <a href="${ctx}/washcar/shop" class="h_down"><img src="${ctxStatic}/washcar/common/img/wis_r1_c33.png" alt="返回"  id="toPageListh"></a>
    <a href="${ctx}/washcar/shop" class="h_next"><img src="${ctxStatic}/washcar/common/img/list_top.png" alt="列表模式"></a>
    <h1>地图模式</h1>
</header>

	<div id="loadingdiv" style="text-align: center;margin-top: 50px;">
		<img src="${ctxStatic}/washcar/map/images/loading2.gif" />
	</div>
	<div id="allmap"></div>
    <!-- 当前位置START -->
    <div class="wis_loc">
        <img src="${ctxStatic}/washcar/map/images/wis_r1_c9.png" alt="位置锚点" class="wis_loc_anch">
        <div class="wis_loc_name ell"></div>
        <img src="${ctxStatic}/washcar/map/images/wis_r1_c4.png" alt="刷新" class="wis_refresh" id="btnresh">
    </div>

</body>	
    <script type="text/javascript">
     var ctx ='${ctx}';
    </script>
<script type="text/javascript" src="${ctxStatic}/washcar/shop/js/amap.js"></script>
<script type="text/javascript" src="${ctxStatic}/washcar/shop/js/washcar_map.js"></script>
</html>