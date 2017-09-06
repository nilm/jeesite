<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>洗车家|到店洗车</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    
	<script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=kq53sCGqFHXGrRIUUNaB2xuM"></script>
	<script type="text/javascript" charset="UTF-8" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<link rel="stylesheet" href="${ctxStatic}/washcar/common/css/ch_base.css" />
	<link rel="stylesheet" href="${ctxStatic}/washcar/map/css/ch_wis.css" />
	<link rel="stylesheet" href="${ctxStatic}/washcar/mobile/css/shop/ch_sale_detail.css?v=1" />
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
	$(".sd_ck").change(function(){
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
	$("#btnok-bak").click(function(){
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
	$("#btnok").click(function(){
	var mid=$("#txtmid").val();
	var tid=$("#txttid").val();
	var proid=$("#proid").val();//产品id
	var officeId="${office.id }";//商户id
	var yfje=$("#btntotal").html();//实际支付金额
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
	
	// loading(true);
	$.post("${ctx }/weixin/pay/",{
		   
		 proid:proid,
			mid:mid,
			tid:tid,
			lng:lng,
			lat:lat,
			ordercost:cost,
			vouid:vouid,
			officeId:officeId,
			yfje:yfje,
			coupon:voucost
		},function(data){
			var userStatu = data.userStatu;
			if(userStatu == '0'){
				location.href="${ctx }/wx/user/home";
				return;
			}
			var return_code = data.return_code;
			if(return_code!='SUCCESS'){
				alert("下单失败,请稍后再试");
				return;
			}
			 WeixinJSBridge.invoke('getBrandWCPayRequest',{
           		"appId":data.appid,     
          		"timeStamp":data.timeStamp,         
           		"nonceStr":data.nonceStr, 
          		"package":data.packages,     
           		"signType":data.signType, 
           		"paySign":data.paySign 
			},function(res){
				//loading(false);
				//WeixinJSBridge.log(res.err_msg);//{"code":0,"message":"\u5904\u7406\u6210\u529f\uff01","orderid":"DM144524781538930643"}
				if(res.err_msg=="get_brand_wcpay_request:ok"){
					//去商户的产品详情页(购买洗车产品那)
					//location.href="${ctx }/washcar/shop/?shopid=${office.id }";
                    //去当前订单的评价页(新增评价页面那)
					//location.href="${ctx}/shop/comment/toAdd?orderId="+data.orderId;
					//前两个都不是重点。最终应该去分享发优惠券页
					location.href = "${ctx}/weixin/share/goShareCoupon?orderId="+data.orderId;
				}
			}
				);
				
			/* 	alert("${timestamp}~~~~~${nonceStr}~~~${signature}+:"+data.prepay_id);	
			wx.chooseWXPay({
			    timestamp: data.timestamp, // 支付签名时间戳，注意微信jssdk中的所有使用timestamp字段均为小写。但最新版的支付后台生成签名使用的timeStamp字段名需大写其中的S字符
			    nonceStr: data.nonce_str, // 支付签名随机串，不长于 32 位
			    package: "prepay_id="+data.prepay_id, // 统一支付接口返回的prepay_id参数值，提交格式如：prepay_id=***）
			    signType: 'SHA1', // 签名方式，默认为'SHA1'，使用新版支付需传入'MD5'
			    paySign: data.sign, // 支付签名
			    success: function (res) {
			    	alert(res.err_msg+"~~");
			        // 支付成功后的回调函数
			    }
			}); */
			});
	 ///////////////////////
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
		/*{"wxpack":{"appId":"wx5320448e4977da8d",
			"package":"bank_type=WX
			&body=%E6%B4%97%E8%BD%A6%E6%9C%8D%E5%8A%A1//洗车服务
			&fee_type=1&input_charset=UTF-8
			&notify_url=http%3A%2F%2Fexc.vjifen118.com%2Fddwash%2Fwxzf_dd_return.php
			&out_trade_no=DM144524781016337606
			&partner=1220072001
			&spbill_create_ip=124.205.109.130
			&total_fee=4000
			&sign=A9FCCC8510A31E39F4028D9BB73BE625",
			"timeStamp":"1445247819",
			"nonceStr":"s6WjdzTGdkxaIaqJ",
			"paySign":"69828d64ac130cc08f7e19adf1ca604ae0bcfd72",
			"signType":"sha1"}}
		*/
		$.post("${ctx }/weixin/getwxpackage",{
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
				"appId":data.appId,
				"package":data.package,
				"timeStamp":data.timeStamp,
				"nonceStr":data.nonceStr,
				"paySign":data.paySign,
				"signType":data.signType
			},function(res){
				loading(false);
				WeixinJSBridge.log(res.err_msg);//{"code":0,"message":"\u5904\u7406\u6210\u529f\uff01","orderid":"DM144524781538930643"}
				if(res.err_msg=="get_brand_wcpay_request:ok"){
					//location.href="http://exc.vjifen118.com/mnew.php?ac=mapnew&do=grade&mid="+mid+"&tid="+tid+"&ddid="+data.ddid;
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
.pay_button{width: 100%; padding: 0 8px 8px; position: fixed; bottom: 0;max-width: 640px; display: box;  display: -moz-box; display: -webkit-box;}
.pay_button button{float: left;display: block; text-align: center; width: 100%; height: 40px; background:#0e6eb8;border: none;line-height: 30px; color: #FFFFFF; font-size: 16px;font-family: "微软雅黑";}
.pay_button button i{font-size: 24px; font-style: normal;}

.pay_method{float: left; display: none; width: 100%; background: #FFFFFF;border-radius: 6px;position: absolute;left: 0;bottom: 8px;z-index: 20000;}

</style>
</head>
<body>
<!-- 标题START -->
<header>
    <a href="javascript:history.go(-1);" class="h_back"><img src="${ctxStatic}/washcar/common/img/wis_r1_c33.png" alt="后退按钮"></a>
    <h1>商户详情</h1>
</header>

<!-- 标题END -->

<!-- 商户详情Banner START -->
<div class="sd_ban">
	<img src="${ctx}${office.picture }" onerror='this.src="${ctxStatic}/washcar/mobile/images/shop/980_390.jpg"' alt="banner" width="100%">
    <div class="sd_ban_wr">
        <div class="sd_title">${office.name }</div>
        <div class="sd_addr">${office.address }</div>
        <div class="sd_time_wr">
            <div class="sd_time">营业时间:${office.openDate }至${office.closeDate }</div>
            <div class="sd_dist">
                <img src="${ctxStatic}/washcar/mobile/images/shop/loc_black.png" alt="锚点">${dis }km
            </div>
        </div>
    </div>
</div>
<!-- 商户详情Banner END -->

<!-- 电话联系START -->
<div class="sd_tel_conn">
    <a href="tel:${office.phone }">电话</a>
    <a href="${ctx }/washcar/goMapdh?shopid=${office.id }">导航 <img src="${ctxStatic}/washcar/mobile/images/shop/nav_gray.png" alt="导航"></a>
</div>
<!-- 电话联系END -->

<!-- 服务项目列表START -->
<div class="sd_comm">
		<div class="sd_comm_l" style="width:50%;">
			<div class="wis_item_star star${ avgPoint}" style=" left: 50%; top: 50%; margin: -10px 0 0 -50px;"></div>
		</div>
    <div class="sd_comm_r">
        <span class="sd_comm_r_a">订单(<strong>${orderCount}</strong>)</span>
        <%-- 20160313暂时不用
        <span class="sd_comm_r_a">评价(<a href="${ctx}/shop/comment/list?shopId=${office.id }"><strong>${commentCount}</strong></a>)</span> 
        --%>
    </div>
</div>
<div class="sd_serv_list">
	<c:forEach items="${products }" var="product" varStatus="status">
		<label class="sd_serv_item">
			<input type="radio" name="pro_radio" class="sd_ck" value="${product.actualamt }" id="pro_${product.id }" dataid="${product.id }"  <c:if test="${status.first }">checked</c:if> >
			<div class="sd_fkck_wr">
            	<div class="sd_fkck"></div>
       		</div>
       	    <div class="sd_price">￥${product.actualamt }</div>
       	    <div class="sd_serv_md_wr">
	            <div class="sd_semd_title">${product.name }</div>
	            <div class="sd_semd_summary">
	           
	            </div>
        </div>
    </label>
	</c:forEach>
</div>
<!-- 服务项目列表END -->

<!-- 支付START -->
<div class="sd_coupon">暂无优惠券</div>
<!-- <a href="#" class="sd_pay">洗完支付25元</a> -->
 <form class="sd_pay">
	<button type="button" id="btnok" class="sd_pay">洗完付<span id="btntotal">20</span>元</button>
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
</html>