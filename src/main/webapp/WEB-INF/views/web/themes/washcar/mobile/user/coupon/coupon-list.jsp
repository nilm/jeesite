<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
	<meta name="format-detection" content="telephone=no,email=no,adress=no">
    <title>个人中心</title> 
    <link rel="stylesheet" href="${ctxStatic}/washcar/common/css/ch_base.css">
    <link rel="stylesheet" href="${ctxStatic}/washcar/user/css/myCoupon.css">
    <script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
	
</head>
<body>
<!-- 标题START -->
<header>
    <a href="javascript:window.history.go(-1);" class="h_back"><img src="${ctxStatic}/washcar/common/img/wis_r1_c33.png" alt="后退按钮"></a>
    <h1>优惠券</h1>
</header>
<!-- 标题END -->

<div class="cp_hds" id="jCpHds">
	<div class="cp_hd active jCpHd">可用优惠券</div>
	<div class="cp_hd jCpHd">历史优惠券</div>
</div>

<!-- 可用优惠券列表 -->
<div class="serv_list first">
    <div class="hi_item_wrap">
        <c:forEach items="${currnetList }" var="coupon" >
        <a href="${ctx }/wx/user/coupon/detail?couponId=${coupon.id}">
        <div class="serv_item">
        
            <div class="serv_item_price">￥${coupon.amount }</div>
            <div class="serv_main">
                <div class="serv_mtitle"><c:if test="${coupon.model.type=='0' }" >到店</c:if><c:if test="${coupon.model.type=='1' }" >上门</c:if>洗车优惠券</div>
                <div class="serv_summary">有效期：<fmt:formatDate value="${coupon.startDate }" pattern="yyyy-MM-dd" />至<fmt:formatDate value="${coupon.endDate }" pattern="yyyy-MM-dd" /><br>
                [满减]满${coupon.model.limitAmount }元可用</div>
            </div>
        </div>
        </a>
        </c:forEach>
    </div>
</div>

<!-- 历史优惠券列表 -->
<div class="serv_list last" style="display:none;">
    <div class="hi_item_wrap">
        <c:forEach items="${historyList }" var="coupon" >
        <div class="serv_item">
        
            <div class="serv_item_price">￥${coupon.amount }</div>
            <div class="serv_main">
                <div class="serv_mtitle"><c:if test="${coupon.model.type=='0' }" >到店</c:if><c:if test="${coupon.model.type=='1' }" >上门</c:if>洗车优惠券</div>
                <div class="serv_summary">有效期：<fmt:formatDate value="${coupon.startDate }" pattern="yyyy-MM-dd" />至<fmt:formatDate value="${coupon.endDate }" pattern="yyyy-MM-dd" /><br>
                [满减]满${coupon.model.limitAmount }元可用</div>
            </div>
             <c:if test="${coupon.statu=='1' }" ><div class="cp_used" >已使用</div></c:if><c:if test="${coupon.statu=='2' }" ><div class="cp_outdate">已过期</div></c:if>
        </div>
        </c:forEach>
    </div>
</div>
<!-- 个人信息资料END -->

<script>
//可用优惠券和历史优惠券
$("#jCpHds>.jCpHd").click(function(){
	$(this).addClass("active").siblings(".jCpHd").removeClass("active");
	var vIndex = $(this).index("#jCpHds>.jCpHd");
	$(".serv_list").eq(vIndex).show().siblings(".serv_list").hide();
});
</script>
</body>
</html>


