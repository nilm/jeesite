<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>上门服务</title>
<meta name="format-detection" content="telephone=no"/>
<link rel="stylesheet" href="${ctxStatic}/washcar/common/css/mui.min.css">
<link rel="stylesheet" href="${ctxStatic}/washcar/common/css/smxc_css.css">
<script src="${ctxStatic}/washcar/gate/js/zepto.min.js"></script>
<script src="${ctxStatic}/washcar/gate/js/amap.js"></script>
<script src="${ctxStatic}/washcar/gate/js/tool.js"></script>

<script src='http://webapi.amap.com/maps?v=1.3&key=47d2b43dc4f7746bd30bd75744981473&number=1231231'></script>
<style>
#map .amap-logo,#map .amap-copyright{display:none;}
.body_load_pop{display:none;
   color:white;
   text-align:center;
   width:100%;
   height:100%;
   line-height:100%;
   position:absolute;
   top:0;left:0;
   background-color:rgba(000,000,000,0.3);
    z-index:99;}
.zf_pop{
display:none;
    color:white;
    text-align:center;
    width:100%;
    line-height:100%;
    position:absolute;
    top:0;left:0;
    background-color:rgba(000,000,000,0.8);
    z-index:180;}


.phone-leader-pop{position: absolute;bottom:180px;right: 10px;z-index: 20;}
.phone-leader{display:inline-block;width:52px;height:46px;background-color: #fff;border-radius: 5px;-webkit-box-shadow:0 0 5px #ccc;box-shadow:0 0 5px #ccc; position: relative;transition:width 0.5s;-webkit-transition:width 0.5s;overflow: hidden;}
.phone-leader .leader-icon{width: 52px;height: 46px;float: right;padding: 5px 10px;}
.phone-leader .leader-icon img{width: 100%;}
.phone-leader .leader-number{line-height: 34px;height:34px;color: #222;border-right: 1px solid #e5e5e5;top:6px;right:52px;width: 220px;background-color: #fff;position:absolute;}
.phone-leader .leader-number #input_leader_phone{width:126px; color:#999;   float: left;height: 34px;line-height: 34px;font-size: 14px;padding:0px;margin: auto 0;margin-right:10px;border: 0px;}
.phone-leader .leader-number span{color: #fc5a00;margin-right: 0px;font-size: 14px;}


.keyboard-backdrop{display:none;width: 100%;height: 100%;position: absolute;top: 0;right: 0;bottom: 0;left: 0;z-index: 15;background-color: rgba(000,000,000,0.5);}
.keyboard-main-tel{height: auto;width: 100%;background-color: #f00;position: absolute;left: 0;bottom: 0;}

.keyboard-letter-tel{width: 100%;height:auto;background-color: #cfd2d6;overflow: hidden;padding: 10px 8px;}
.keyboard-letter-tel ul li{float: left;height: 39px;line-height: 39px;width: 14%;margin: 1%;text-align: center;background-color: #f5f6f7;border-radius: 5px;box-shadow: 0px 1px 0px #65686b;font-size:16px;color: #000;font-weight: normal;display: table-cell;vertical-align:middle;}
.keyboard-letter-tel ul li img{width: 21px;height: 15px;vertical-align:middle;}
</style>
</head>
<body style="height: auto;padding-bottom: 50px;">
<!--通出 默认 头部title-->
<div class="header_nav">
	<a class="icon-return">返回</a>
	<a class="icon-doubt">疑问</a>
	<h1 class="mui-title">上门服务</h1>
</div>
<!--end  通出 默认 头部title-->
<!--地图-->
<div id="map" class="smfu_map"></div>
<!--选择停车位 信息-->
<div class="smfw_layout">
	<div class="mui-table-view mui-media-body smfw_search">
		<div id="search_p" class="smfw_search_loginbar">
			<input id="search_word" name="" type="text" placeholder="输入洗车位置" style="background:#fff;">
			<!--<span class="pop_text"></span>-->
			<i id="clear_keyWords" class="mui-icon mui-icon-closeempty"></i>
		</div>
	</div>
</div>

<!--textarea START-->
<div class="mui-input-row" style="margin: 10px 8px;">
	<textarea rows="5" placeholder="多行文本框"></textarea>
</div>
<!--textarea END-->
<!--遮罩层 灰色0.2透明度-->
<div id="map_pop"  class="map_pop_smxc"></div>
<div id="zf_pop" class="zf_pop"></div>
<!--弹出框- 继续下单-->
<div id="div_pop_status" class="mask_pop_status">
	<div id="go_order" class="mui-table-view mui-media-body mask_pop_status_text">
	<!--<p>月黑风高，小e不便前往</p>
	<p>明早9点安排，可否？</p>-->
	</div>
	<div id="div_pop_status_btn" class="mask_pop_status_btn">
	<a class="status_btn_cancel">我再想想</a>
	<a class="status_btn_determine">继续下单</a>
	</div>
</div>

<div id="load_pop" class="body_load_pop"></div>

	<!--上门服务 选择块-->
	<div class="smfw_icon_taxi"><img id="taxi_img" src="${ctxStatic}/washcar/gate/img/smfw-icon-taxi.png"></div>
	<div id="smfw_layout"  class="smfw_locate_layout">
		<h1 id="estimateTime"><!--预计今天<span>19:16</span>前完成洗车--></h1>
		<div class="status">
			<a id="car_info" href="javascript:;">
			<!--<span>玛莎拉蒂总裁</span>
			<span>宝蓝色</span>
			<span>京KN1886</span>
			<i class="mui-icon mui-icon-forward"></i>-->
			</a>
		</div>
	</div>
<div class="smfw_module_layout" style="display:none;">
	<div class="smfw_module_tab">
		<div id="fw_list" class="mui-table-view mui-media-body smfw_module_tab_img">
			<div id="fw_list_content" class="smfw_module_tab_img_list">
			</div>
		</div>
		<div id="div_promotions" class="smfw_module_tab_preferential">
			<!--<span>优惠</span>
			<p>全车镀膜送玻璃水1瓶</p>-->
		</div>
	</div>
	<div class="smfw_wallet_btn_list">
		<div  id="wallet" class="smfw_wallet"><span>钱包</span>
			<a id="coupons_info" href="javascript:;"><i class="mui-icon mui-icon-forward"></i></a>
		</div>
		<div class="smfw_wallet_btn">
			<a href="javascript:;">
			<span id="payPrice" class="width_65">应付款：<!--￥15.00--></span>
			<span id="span_pay" class="width_35">支付</span>
			</a>
		</div>
	</div>
</div>
<!--弹出窗-输入结果查询-->
<div id="car_position" class="xztcw_pop_search">
	<div class="xztcw_pop_search_layout">
	<div  class="mui-table-view mui-media-body xztcw_pop_layout_list head_foot">
		<b>洗车历史</b>
	</div>
	<div id="position_list" class="xztcw_pop_layout_list_scroll"></div>
	</div>
</div>
<!--弹出窗-选择支付方式-->
<div id="smxcPopPay" class="smxc_pop_pay_layout">
	<div  class="smxc_pop_pay">
		<ul>
			<li class="mui-table-view mui-media-body" id="li_zf_-1"><p>请选择支付方式</p></li>
			<li class="mui-table-view mui-media-body" id="li_zf_4"><a href="javascript:;"><i class="pay_baidu_icon"></i>百度钱包支付</a></li>
			<li class="mui-table-view mui-media-body" id="li_zf_3"><a href="javascript:;"><i class="pay_weixin_icon"></i>&nbsp;微&nbsp;&nbsp;信&nbsp;支付</a></li>
			<li class="mui-table-view mui-media-body" id="li_zf_2"><a href="javascript:;"><i class="pay_zfb_icon"></i>支付宝支付</a></li>
			<li id="li_zf_-2"><a href="javascript:;">取消</a></li>
		</ul>
	</div>
</div>
<!--弹出框- 暂未开通-->
<div id="zwkt_pop_status" class="zwkt_pop_status">
	<div class="mui-table-view mui-media-body zwkt_pop_status_text">
		<a class="down-icon"></a>
		<p>您所在区域<em>暂未开通</em>上门服务</p>
		<p>点击小灯泡邀请小E开通此区域</p>
		<div class="zwkt_pop_status_text_icon"><a id="a_open_area" href="javascript:;" class="active"></a></div>
	</div>
	<div class="zwkt_pop_status_btn">
		<a class="zwkt_status_jump"><span id="span_carWash_store"><!--距离您1.5KM有家洗车店，点击查看--></span><i class="mui-icon mui-icon-forward"></i></a>
	</div>
</div>
<!--洗车队长专用键盘-->
<div id="div_leader_keyboard" class="keyboard-backdrop">
	<div class="keyboard-main-tel">
		<div class="keyboard-letter-tel">
			<ul id="ul_leader_keyboard">
				<li>1</li>
				<li>2</li>
				<li>3</li>
				<li>4</li>
				<li>5</li>
				<li style="background-color: #b4b6ba;"><img src="${ctxStatic}/washcar/gate/img/keyboard-delete.png"/></li>
				<li>6</li>
				<li>7</li>
				<li>8</li>
				<li>9</li>
				<li>0</li>
				<li style="background-color: #1979ff;color: #fff;">确定</li>
			</ul>
		</div>
	</div>
</div>
<!--end  选择停车位 信息-->
<div style="display:none" id='workno'></div>
<input id="input_form_submit" type="hidden" name="form_submit" value="true">
<input id="input_form_hash"type="hidden" name="formhash" value="beed8e1b" />

<button type="button" class="sd_pay" onclick="toIndex()">确定</button>



<script type="text/javascript">
function toIndex(){
	var search_word=$("#search_word").val()
	if(search_word!=null || ""!=search_word){
	    $.ajax({
	        type: "post",
	        url: "${ctx}/washcar/gate/map/location/add",
	        data: {search_word:search_word},
	        success: function(data){
	        	window.location.href="${ctx}/washcar/gate"
	        }
	    });	
	}
}
// alert(1313123);
</script>
</body>
<script src="${ctxStatic}/washcar/gate/js/dialog.js"  type="text/javascript"></script>
<script src="${ctxStatic}/washcar/gate/js/map.js"  type="text/javascript"></script>
<script>
$("#position_list").delegate(".xztcw_pop_layout_list", "click", function(){
	$("section").hide();
});
</script>
</html>
