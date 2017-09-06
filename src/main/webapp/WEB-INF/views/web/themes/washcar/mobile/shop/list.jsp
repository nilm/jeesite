<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<html>
<head>
<title>洗车家|到店洗车</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    
	<script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=47d2b43dc4f7746bd30bd75744981473"></script>
	<script src="${ctxStatic}/jquery-plugin/jquery.cookie.js" type="text/javascript"></script>
	<script src="${ctxStatic}/washcar/map/js/amap.js" type="text/javascript"></script>

	
	<link rel="stylesheet" href="${ctxStatic}/washcar/common/css/ch_base.css" />
	<link rel="stylesheet" href="${ctxStatic}/washcar/map/css/ch_wis.css?v=5" />
   </head>
<body>
	<header>
        <%-- <a href="javascript:history.go(-1);" class="h_back"><img src="${ctxStatic}/washcar/map/images/wis_r1_c33.png" alt="后退按钮"></a> --%>
        <a href="${ctx}/washcar/goMap" class="h_next"><img src="${ctxStatic}/washcar/map/images/wis_r1_c6.png" alt="地图模式"></a>
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
 --%>
	<div id="loadingdiv" style="text-align: center;margin-top: 50px;">
		<img src="${ctxStatic}/washcar/map/images/loading2.gif" />
	</div>


    <!-- 结果列表START -->
    <div class="wis_list">
        <div class="wisbu_mask" id="jWisbuMask"></div>
        <div id="storelist">
	        
        </div>
   </div>
    <!-- 当前位置START -->
    <div class="wis_loc">
        <img src="${ctxStatic}/washcar/map/images/wis_r1_c9.png" alt="位置锚点" class="wis_loc_anch">
        <div class="wis_loc_name ell"></div>
        <img src="${ctxStatic}/washcar/map/images/wis_r1_c4.png" alt="刷新" class="wis_refresh" id="btnresh">
    </div>
    <!-- 当前位置END -->
    <script type="text/javascript">
     var cxt ='${ctx}';
     var ctxStatic = "${ctxStatic}";
    </script>
    	<script src="${ctxStatic}/washcar/shop/js/list.js?r=12" type="text/javascript"></script>