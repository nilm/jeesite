<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>个人中心</title> 
    <link rel="stylesheet" href="${ctxStatic}/washcar/common/css/ch_base.css">
    <link rel="stylesheet" href="${ctxStatic}/washcar/user/css/orderDetail.css">
    <script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
	
	<script type="text/javascript">
	//去评论
	function goComment(orderId){
		 window.location.href="${ctx}/${frontPath}/shop/comment/toAdd?orderId="+orderId;
		 return false;
	}
	</script>
</head>
<body>
<!-- 标题START -->
<header>
    <a href="javascript:window.history.go(-1);" class="h_back"><img src="${ctxStatic}/washcar/common/img/wis_r1_c33.png" alt="后退按钮"></a>
    <h1>订单详情</h1>
</header>
<!-- 标题END -->

<!-- 订单详情上START -->
<div class="od_item od_item_h1">${dto.product.name }</div>
<div class="od_list">
    <div class="od_item">
        <div class="od_item_lt">订单总金额</div>
        <div class="od_item_rt">￥${dto.order.amount }</div>
    </div>
    <!-- <div class="od_item">
        <div class="od_item_lt">优惠券支付金额</div>
        <div class="od_item_rt">￥5</div>
    </div> -->
    <div class="od_item">
        <div class="od_item_lt">实际支付金额</div>
        <div class="od_item_rt">￥${dto.order.actualAmount }</div>
    </div>
</div>
<!-- 订单详情上END -->

<!-- 订单详情下START -->
<div class="od_list">
    <div class="od_item">
        <div class="od_item_lb">支付方式</div>
        <div class="od_item_rb">微信支付</div>
    </div>
    <div class="od_item">
        <div class="od_item_lb">支付时间</div>
        <div class="od_item_rb"><fmt:formatDate value="${dto.order.payDate }" pattern="yyyy-MM-dd HH:mm" /></div>
    </div>
    <div class="od_item">
        <div class="od_item_lb">订单编号</div>
        <div class="od_item_rb">${dto.order.orderNo }</div>
    </div>
    <div class="od_item">
        <div class="od_item_lb">服务方</div>
        <div class="od_item_rb">${dto.product.company.name }</div>
    </div>
    <c:if test="${!order.comment}">
    <div class="od_item">
        <div class="od_item_lb"></div>
        <div class="od_item_rb">
        <span onclick="return goComment('${order.order.id }');" style="float:right;margin-right:10px;">去评论</span>
        </div>
    </div>
    </c:if>
</div>
<!-- 订单详情下END -->

<!-- 再次购买该服务START -->
<a href="${ctx}/washcar/shop/detail?shopid=${dto.order.companyId }" class="sd_pay">再次购买该服务</a>
<!-- 再次购买该服务END -->
</body>
</html>


