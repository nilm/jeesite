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
	
	<script src="${ctxStatic}/jquery-plugin/jquery.cookie.js" type="text/javascript"></script>

</head>

<body>
<div class="hidden_lnglat" style="display: none">${lnglat}</div>
<header>
    <a href="javascript:void(0);" class="h_down"><img src="${ctxStatic}/washcar/common/img/wis_r1_c33.png" alt="返回"></a>
    <a href="${ctx}/washcar/shop" class="h_next"><img src="${ctxStatic}/washcar/common/img/list_top.png" alt="列表模式"></a>
    <h1>地图导航</h1>
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
<script type="text/javascript" src="${ctxStatic}/washcar/shop/js/washcar_nav.js"></script>
</html>