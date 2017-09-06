<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>

<html>

<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
	<meta name="format-detection" content="telephone=no,email=no,adress=no">
    <title>领取优惠券</title> 
    <link rel="stylesheet" href="${ctxStatic}/washcar/common/css/ch_base.css">
    <link rel="stylesheet" href="${ctxStatic}/washcar/user/css/couponDetail.css">
    <script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js" type="text/javascript"></script>
	<script type="text/javascript">
	function submit(){
		var phone = $("#phone").val();
		if(phone.length<11){
			alert("请输入有效手机号");
			return false;
		}
		location.href="${ctx}/weixin/share/saveShareCoupon?cmId=${cmId}&orderId=${orderId}&code=${code}&phone="+$("#phone").val();
	}
	</script>
</head>
<body>
<!-- 标题START -->
<header>
    <h1>领取优惠券</h1>
</header>
<!-- 标题END -->


<!-- 订单详情下START -->
<div class="od_list">
    <div class="od_item">
	    <c:if test="${statu eq 'unLogin' }">
	    <input type="text" id="phone">
	    <button id="submit" onclick="submit()">领取</button>
		</c:if>
	    <c:if test="${statu ne 'unLogin' }">
        <div class="od_item_lb" onclick="wxfn();">恭喜您获得${coupon.amount }元的优惠券,赶快去用吧</div>
		</c:if>
    </div>
   
</div>
<!-- 订单详情下END -->
</body>
</html>


