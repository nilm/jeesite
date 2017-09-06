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
//有没定位或者是否在范围
var nolnglat=false;
var nolnglatmsg="";
$(function(){
	//默认进来后，选中小车服务
	$("#pro_231").attr("checked",'checked');
	var curentje=$("input[name='pro_radio']:checked").val();
	$("#btntotal").html(curentje);
	$("#ordercost").val(curentje);
	
	//增加定位判断,如果存在优惠券才定位，判断是否允许使用优惠券
	$("#tip_wgps").html("暂无优惠券可用");
	
	//判断经纬度是否合适
	function getIsLngLatOk(lng,lat){
		//记录经纬度
		$("#txtlng").val(lng);
		$("#txtlat").val(lat);
		
		var mid=$("#txtmid").val();
		var tid=$("#txttid").val();
		$.post("storezf.php?do=point",{
		        	lng:lng,
		        	lat:lat,
		        	mid:mid,
		        	tid:tid
		        },function(data){
		        	if(data.success){
		        		nolnglat=true;
		        		nolnglatmsg=data.message;
		        		confirm(data.message,function(){
		        			$("#tip_wgps").html(nolnglatmsg);
		        		},function(){
		        			$("#tip_wgps").html(nolnglatmsg);
		        		});
		        		return true;
		        	}else{
		        		nolnglat=false;
		        		nolnglatmsg="";
		        		
		        		//切换优惠券选择
		        		$("#ygps").show();
		        		$("#wgps").hide();
		        		
		if(231==230){
		$("#qita_230").val();
		}
		
		//获取优惠卷
		var vouid=$("#vouid").val();
		if(vouid!="0"){
		$("#vouid").attr("checked",'checked');
		$("#ordercost").val(curentje);
		curentje=getFee(curentje);
		$("#btntotal").html(curentje);
		}else{
		$("#btntotal").html(curentje);
		$("#ordercost").val(curentje);
		}
		
		//更新当前店面距离
		$("#dis_id").html(data.dis+"km");
		
		        		return false;
		        	}
		        },"json");
	}
	
	$("#vouid").click(function(){
	//判断定位是否允许
	if(nolnglat){
		confirm(nolnglatmsg,function(){});
		return;
	}
	var propoint = $("input[name='pro_radio']:checked").val(); 
	var proid=$("input[name='pro_radio']:checked").attr("dataid");
	if(proid=="230"){
		propoint=$.trim($("#qita_230").val());
	}
	//订单原价
	$("#ordercost").val(propoint);
	if($(this).attr("checked")=="checked"){
		propoint=getFee(propoint);
	if($("#voutype").val()==1){
		$("#btnjfzf").hide();
	}
	}else{
		$("#btnjfzf").show();
	}
		$("#btntotal").html(propoint);
	
	});
	
	//切换产品的时候修改应付价格
	$(".pro_radio").change(function(){
	var propoint = $("input[name='pro_radio']:checked").val(); 
	var proid=$("input[name='pro_radio']:checked").attr("dataid");
	$("#proid").val(proid);
	
	if(propoint=='0'){
		$("#btntotal").html(0);
	}else{
		$("#ordercost").val(propoint);
		propoint=getFee(propoint);
		$("#btntotal").html(propoint);
		$("#qita_230").val("");
	}
	
	if(proid=="230"){
		//去掉优惠券的选择，通知设置不可用
		$("#vouid").removeAttr("checked");
		$("#vouid").attr("disabled", true);
		$("#btnjfzf").show();
	}else{
		var vouid=$("#vouid").val();
			if(vouid!="0"&&!nolnglat){
			$("#vouid").attr("disabled", false);
		}
	}
	});
	
	//其他金额输入事件的绑定
	$("#qita_230").bind("input propertychange",function(){
	var otherval=$.trim($(this).val());
	if(otherval==""){
		otherval=0;
	}else if(otherval.length>7||parseFloat(otherval)>5000){
		otherval=otherval.substr(0,4);
		$(this).val(otherval);
	}else if(isNaN(otherval)){
		$(this).val("");
	}
	if(!isNaN(otherval)&&parseFloat(otherval)>=0&&parseFloat(otherval)<=5000){
		$("#ordercost").val(otherval);
		otherval=getFee(otherval);
		$("#btntotal").html(otherval);
	}
	
	});
	//输入的时候滚动到最底部
	$("#qita_230").click(function(){
		$('html,body').animate({scrollTop: $(document).height()}, 300); 
	});
	
	//获取优惠券
	$(".btngetvouch").click(function(){
		var propoint = $("input[name='pro_radio']:checked").val(); 
		var proid=$("input[name='pro_radio']:checked").attr("dataid");
	if(proid=="230"){
		propoint=$.trim($("#qita_230").val());
	}
	loading(true);
		location.href="storezf.php?do=voucher&midtid=505556675380258_56114006&proid="+proid+"&propoint="+propoint;
	});
	
	//确定按钮
	$("#btnok").click(function(){
		var mid=$("#txtmid").val();
		var tid=$("#txttid").val();
		var proid=$("#proid").val();
		var yfje=$("#btntotal").html();
		var cost=$("#ordercost").val();
		
		if(parseFloat(yfje)<0.01){
			alert("支付金额不应小于1分钱",2000);
			return;
		}
		
		var fid=$("#fid").val();
		
		$("#overlay_ul").toggle();
		$(".pay_method").toggle();
		//$("#mcover").toggle();
	});
	//取消支付
	$("#btncancel").click(function(){
		$("#overlay_ul").toggle();
		$(".pay_method").toggle();
		//$("#mcover").toggle();
	});
	
	//积分支付按钮
	$("#btnjfzf").click(function(){
		//判断积分是否够
		var mid=$("#txtmid").val();
		var tid=$("#txttid").val();
		var proid=$("#proid").val();
		var yfje=$("#btntotal").html();
		var cost=$("#ordercost").val();
		
		var lng=$("#txtlng").val();
		var lat=$("#txtlat").val();
		
		if(parseFloat(yfje)<0.01){
		alert("支付金额不应小于1分钱",2000);
		return;
	}
	
	var vouid="";
	var voucost="";
	if($("#vouid").attr("checked")=="checked"){
		vouid=$("#vouid").val();
		voucost=$("#voucost").val();
	}
	
	confirm("确认要支付"+yfje+"元吗？",function(){
		loading(true);
		location.href="storezf.php?do=jfzf&mid="+mid+"&tid="+tid+"&proid="+proid+"&lng="+lng+"&lat="+lat+"&yfje="+yfje+"&cost="+cost+"&vouid="+vouid+"&voucost="+voucost;
	});
	});
	
	//支付宝支付按钮
	/*
	$("#btnzfbzf").click(function(){
	var mid=$("#txtmid").val();
	var tid=$("#txttid").val();
	var proid=$("#proid").val();
	var yfje=$("#btntotal").html();
	var cost=$("#ordercost").val();
	
	if(parseFloat(yfje)<0.01){
	alert("支付金额不应小于1分钱",2000);
	return;
	}
	
	var vouid="";
	var voucost="";
	if($("#vouid").attr("checked")=="checked"){
	vouid=$("#vouid").val();
	voucost=$("#voucost").val();
	}
	
	confirm("确认要支付"+yfje+"元吗？",function(){
	loading(true);
	location.href="storezf.php?do=zfbzf&mid="+mid+"&tid="+tid+"&proid="+proid+"&yfje="+yfje+"&cost="+cost+"&vouid="+vouid+"&voucost="+voucost;
	});
	});*/
	
	//百付宝支付按钮
	$("#btnbfbzf").click(function(){
		var mid=$("#txtmid").val();
		var tid=$("#txttid").val();
		var proid=$("#proid").val();
		var yfje=$("#btntotal").html();
		var cost=$("#ordercost").val();
		
		var lng=$("#txtlng").val();
		var lat=$("#txtlat").val();
		
		if(parseFloat(yfje)<0.01){
			alert("支付金额不应小于1分钱",2000);
			return;
		}
		
		var vouid="";
		var voucost="";
		if($("#vouid").attr("checked")=="checked"){
			vouid=$("#vouid").val();
			voucost=$("#voucost").val();
		}
		
		confirm("确认要支付"+yfje+"元吗？",function(){
			loading(true);
			location.href="storezf.php?do=bfbzf&mid="+mid+"&tid="+tid+"&lng="+lng+"&lat="+lat+"&proid="+proid+"&yfje="+yfje+"&cost="+cost+"&vouid="+vouid+"&voucost="+voucost;
		});
	});
	
	//微信支付按钮
	$("#btnwxzf").click(function(){
		var mid=$("#txtmid").val();
		var tid=$("#txttid").val();
		var proid=$("#proid").val();
		var yfje=$("#btntotal").html();
		var cost=$("#ordercost").val();
		
		var lng=$("#txtlng").val();
		var lat=$("#txtlat").val();
		
		if(parseFloat(yfje)<0.01){
			alert("支付金额不应小于1分钱",2000);
			return;
		}
		
		var vouid="";
		var voucost="";
		if($("#vouid").attr("checked")=="checked"){
			vouid=$("#vouid").val();
			voucost=$("#voucost").val();
		}
		
		loading(true);
		$.post("storezf.php?do=wxpackage&v=1129",{
			yfje:yfje,
			proid:proid,
			mid:mid,
			tid:tid,
			lng:lng,
			lat:lat,
			cost:cost,
			vouid:vouid,
			voucost:voucost
		},function(data){
		WeixinJSBridge.invoke('getBrandWCPayRequest',{
			"appId":data.wxpack.appId,
			"package":data.wxpack.package,
			"timeStamp":data.wxpack.timeStamp,
			"nonceStr":data.wxpack.nonceStr,
			"paySign":data.wxpack.paySign,
			"signType":data.wxpack.signType
		},function(res){
			loading(false);
			WeixinJSBridge.log(res.err_msg);
			if(res.err_msg=="get_brand_wcpay_request:ok"){
				location.href="http://exc.vjifen118.com/mnew.php?ac=mapnew&do=grade&mid="+mid+"&tid="+tid+"&ddid="+data.ddid;
			}else{
				alert("取消支付",2000);
				window.firstSubmit=true;
			}
		});
		},"json");
	});
});

//判断可用的支付方式,计算应该支付的金额
function getFee(yfje){
	var vouid=$("#vouid").val();
	var isyifen=$("#isyifen").val();
	var voutype=$("#voutype").val();
	var storeyifen=$("#storeyifen").val();
	var voucost=$("#voucost").val();
	if(voucost==undefined){
		voucost=0;
	}
	//alert(yfje+"||"+voucost+"||"+vouid);
	//控制支付方式
	if(vouid!="0"&&$("#vouid").attr("checked")=="checked"){//如果选择了优惠券
	
		//计算金额
		if(voutype==1){//如果是付款券
		//取消积分支付
		$("#btnjfzf").hide();
			return voucost;
		}else{
			var rescost=parseFloat(yfje)-parseFloat(voucost);
		
			if(rescost>0){
				$("#btnjfzf").show();
				return rescost;
			}else{
				//取消积分支付
				$("#btnjfzf").hide();
				return $("#paycost").val();
			}
		}
	}else{
		return yfje;
		//开启积分支付
		$("#btnjfzf").show();
	}

}
</script>

<style type="text/css">
.dialogWindow .dialogContent {
	text-align: center;
	padding: 10px 20px 20px;
}
.dialogWindow header,
.dialogWindow footer {
	width: 100%;
	padding: 0;
	height: 40px;
	line-height: 40px;
	border-radius: 5px 5px;
}
.box {
	border-top: solid 1px #ccc;
}
.dialogWindow .dialogBtn {
	display: block;
	border-left: solid 1px #ccc;
	border-right: none;
	border-top: none;
	border-bottom: none;
	width: 100%;
	line-height: 36px;
	text-align: center;
	margin: auto;
}
#mcover {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.7);
	display: none;
	z-index: 1000;
}
.ddxc_hdtbmk1{position: absolute;float: left; display: block; width: 40px;left: 53px;top: 0px; margin: -1px -1px 0 0;}
.ddxc_hdtbmk1 img{width: 100%;}
/* .list_star{float: left; display: block; width: 75px; height: 18px; background:#00A0E8;background: url(img/list_star.png) no-repeat -75px center; background-size: 150px;}
.star_1{background-position-x: -60px;}
.star_2{background-position-x: -45px;}
.star_3{background-position-x: -30px;}
.star_4{background-position-x: -15px;}
.star_5{background-position-x: 0px;} */

	.shop_detail_content_hint b{ float: right;font-weight: normal;}
    .ddxc_radio label span{float: right;}
    .ddxc_radio label span em{ float:left; display: block;}
    .ddxc_radio label span del{ color: #808080; float: left;display: inline-block; padding-right: 30px;}

   
   	.overlay_ul {
		height: 100%;
		max-width: 640px;
		padding: 0 0px;
		position: absolute;
		z-index: 0;
		left: 0;
		right: 0;
		bottom: 0;
		top: 0;
		margin: auto;
		background: rgba(0,0,0,0.3);
		display: none;
		overflow: hidden;
	}

   
</style>
</head>
<body style="background: #F1F3F2;">
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
	</div> --%>
	
<div class="shop_detail">
	<div class="shop_detail_img">
		<img src="http://oa.exc118.com/images/xcd/56114006.jpg" 
		onerror="this.src='${ctxStatic}/washcar/mobile/images/xiche.jpg'" />
	</div>
	<div class="shop_detail_content">
		<h1>${office.name }</h1>
		<div class="shop_detail_content_content">
			<span class="list_star star_4"></span>
			<font style="color: #999999;"><i class="ddxc_xdtb"></i>4.8分</font>
		</div>
		<div class="shop_detail_content_hint">
			<font></font>9:00至20:00<b id="dis_id">${dis }km</b>
		</div>
	</div>
</div>	

<div class="mui-card">
	<ul class="mui-table-view">
		<li class="mui-table-view-cell">
			<div class="shop_contact_menu" style="height: 26px;">
				<ul>
					<li>
					<a href="${ctx }/washcar/shop/comment_list?shopId=${office.id }">
						<img style="width: 20px;" src="${ctxStatic}/washcar/mobile/images/shop/lishi.png"/>历史评价</a>
					</li>
					<li>
						<a href="tel:${office.phone }">
						<img style="width: 20px;" src="${ctxStatic}/washcar/mobile/images/shop/call.png"/>联系电话</a>
					</li>
					<li>
						<a href="${ctx }/washcar/map/goMapdh?shopid=${office.id }">
							<img style="width: 20px;" src="${ctxStatic}/washcar/mobile/images/shop/nav.png"/>导航
						</a>
					</li> 
				</ul>
			</div>
		</li>
	</ul>
</div>

<c:forEach items="${products }" var="product" varStatus="status">
	<div class="mui-card <c:if test="${status.first }">top_margin</c:if>">
		<ul class="mui-table-view">
			<li class="mui-table-view-cell mui-radio shop_detail_radio top_border">
				<label for="pro_232">${product.name }<em>${product.actualamt }</em>元<font></font></label>
				<input name="pro_radio" class="pro_radio" value="${product.actualamt }" type="radio" id="pro_${product.id }" dataid="${product.id }"  <c:if test="${status.first }">checked="checked"</c:if>>
			</li>
		</ul>
	</div>
</c:forEach>

<!-- <div class="mui-card top_margin">
	<ul class="ddxc_xcjgmk" id="ygps" style="display: none;">
		<li class="mui-table-view-cell mui-checkbox mui-checkbox-cycle ddxc_radio top_border">
			<a class="mui-navigate-right">
				<label>暂无优惠券可用</label>
				<input id="vouid" type="checkbox" value="0" disabled="true">
			</a>
		</li>
	</ul>
	<ul class="ddxc_xcjgmk" id="wgps">
		<li class="mui-table-view-cell mui-checkbox mui-checkbox-cycle ddxc_radio top_border">
			<a class="mui-navigate-right">
			<label id="tip_wgps">正在定位...</label>
			<input id="vouid" type="checkbox" value="0" disabled="true">
		</a>
		</li>
	</ul>
	<ul id="overlay_ul" class="overlay_ul">
		<li style="text-align:right;height:100%!important;right:-15px;left:0px;background-color:rgba(62,78,78,0.7) " ></li>
	</ul>
</div> -->

<form class="pay_button">
	<button type="button" id="btnok">洗完付<i id="btntotal">20</i>元</button>
	<input type="hidden" value="0" id="storeyifen" />
	<input type="hidden" id="proid" value="231"/>
	<input type="hidden" id="fid" value="FS140831854126446355" />
	<input type="hidden" value="505556675380258" id="txtmid" />
	<input type="hidden" value="56114006" id="txttid" />
	<input type="hidden" value="0.05" id="paycost" />
	<input type="hidden" value="" id="ordercost" />
	<input type="hidden" value="" id="txtlng"/>
	<input type="hidden" value="" id="txtlat"/>
	<div class="pay_method">
		<h3>选择付款方式</h3>
		<ul>
			<li id="btnjfzf"><img src="${ctxStatic}/washcar/mobile/images/pay/exc.png" width="20px" /><span style="padding: 0 8px;">积分支付</span></li>
			<li id="btnbfbzf"><img src="${ctxStatic}/washcar/mobile/images/pay/bfb.png"width="20px" /><span style="padding: 0 8px;">百度钱包</span></li>
			<li id="btnwxzf"><img src="${ctxStatic}/washcar/mobile/images/pay/wx.png"width="20px" /><span style="padding: 0 8px;">微信支付</span></li>
			<!--<li id="btnzfbzf"><img src="${ctxStatic}/washcar/mobile/images/pay/zfb.png"width="20px" /><span>支付宝支付</span></li>-->
			<li id="btncancel">取消</li>
		</ul>
	</div>
</form>
<div id="mcover" style="display:none;"></div>
</body>