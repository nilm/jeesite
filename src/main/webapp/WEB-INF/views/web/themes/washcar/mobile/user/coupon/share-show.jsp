<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>

<html>

<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
	<meta name="format-detection" content="telephone=no,email=no,adress=no">
    <title>分享优惠券</title> 
    <link rel="stylesheet" href="${ctxStatic}/washcar/common/css/ch_base.css">
    <link rel="stylesheet" href="${ctxStatic}/washcar/user/css/couponDetail.css">
    <script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js" type="text/javascript"></script>
	<script type="text/javascript">
	var _sharetitle='洗车家,洗洗更健康'
	,_sharecontent='我是一个洗车家，洗车本领强，我要把你的脏车子洗的更漂亮，洗了轮胎又洗灯，洗的好逗比'
	,_shareweibo='分享给微博'
	,_shareurl='http://100.tunnel.chinaonlinemoney.com/test/weixin/share/getShareCoupon?cmId=${cmId}&orderId=${orderId}'
	,_sharepic='http://static8.depositphotos.com/1000154/1010/v/950/depositphotos_10107004-Car-Wash---vector-icon.jpg';

	wx.config({
	    debug:false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
	    appId: 'wxfad1b30aa93537cd', // 必填，公众号的唯一标识
	    timestamp: '${timestamp}', // 必填，生成签名的时间戳
	    nonceStr: '${noncestr}', // 必填，生成签名的随机串
	    signature: '${signature}',// 必填，签名，见附录1
	    jsApiList: ['onMenuShareQQ','onMenuShareTimeline','onMenuShareAppMessage'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
	});
	    function wxfn(){
	            wx.onMenuShareTimeline({// 分享朋友圈
	                 title: _sharetitle, // 分享标题
	                 link:_shareurl, // 分享链接
	                 imgUrl: _sharepic, // 分享图标  
	                 success: function() {
	                	 location.href="${ctx}/shop/comment/toAdd?orderId=${orderId}";
	                 },
	                 cancel: function() {
	                 }
	               });
	           wx.onMenuShareAppMessage({
	             title: _sharetitle, // 分享微信好友
	             desc:_sharecontent,
	             link: _shareurl, // 分享链接
	             imgUrl: _sharepic, // 分享图标
	             type: '', // 分享类型,music、video或link，不填默认为link
	             success: function() {
	            	 location.href="${ctx}/shop/comment/toAdd?orderId=${orderId}";
	                 },
	                 cancel: function() {
	                   
	                 }
	           });

	        }
	$(function(){
	   wx.ready(wxfn);
	})
	</script>
</head>
<body>
<!-- 标题START -->
<header>
    <h1>微信分享</h1>
</header>
<!-- 标题END -->


<!-- 订单详情下START -->
<div class="od_list">
    <div class="od_item">
        <div class="od_item_lb" onclick="wxfn();">测分享给朋友</div>
    </div>
    <div class="od_item">
        <div class="od_item_lb" >点击右上角的分享</div>
    </div>
</div>
<!-- 订单详情下END -->
</body>
</html>


