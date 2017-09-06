<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>个人中心</title> 
    <link rel="stylesheet" href="${ctxStatic}/washcar/common/css/ch_base.css">
    <link rel="stylesheet" href="${ctxStatic}/washcar/user/css/orderList.css">
    <script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(function(){
			var vIndex = "${currentType}";
			if(vIndex!=""){
		  	 $("#type"+(Number(vIndex)+1)).addClass("active");
			}else{
				 $("#type0").addClass("active");
			}
		})

	</script>
</head>
<body>
<!-- 标题START -->
<header>
    <a href="javascript:window.history.go(-1);" class="h_back"><img src="${ctxStatic}/washcar/common/img/wis_r1_c33.png" alt="后退按钮"></a>
    <h1>订单列表</h1>
</header>
<!-- 标题END -->

<!--订单页签START-->
<div class="ol_hds" id="jOlHds">
    <a href="${ctx}/${frontPath}/wx/user/order/home" class="ol_hd jOlHd" id="type0">全部订单</a>
    <a href="${ctx}/${frontPath}/wx/user/order/home?type=0" class="ol_hd ol_hd2 jOlHd"  id="type1">到店订单</a>
    <a href="${ctx}/${frontPath}/wx/user/order/home?type=1" class="ol_hd jOlHd" id="type2">上门订单</a>
</div>
<!--订单页签END-->

<div class="ol_list_grp" id="jOlListGrp">
    <!-- 订单面板START -->
    <div class="ol_list jOlList active">
    	<c:forEach items="${list }" var="order" >
	        <a href="${ctx}/${frontPath}/wx/user/order/detail?orderId=${order.order.id }" class="ol_item">
	            <div class="ol_item_num">￥${order.order.amount }</div>
	                <div class="ol_item_quli">${order.product.name }</div>
	            <div class="ol_item_main" >
	                <div class="ol_item_corp"><div>${order.product.company.name }</div>
	                </div>
	                	
	                <div class="ol_item_time"><fmt:formatDate value="${order.order.createDate }" pattern="yyyy-MM-dd hh:mm:ss" /></div>
	            </div>
	        </a>
    	</c:forEach>
    </div>
    <div class="ol_list jOlList">到店订单123</div>
    <div class="ol_list jOlList">上门订单</div>
    <!-- 订单面板END -->

</div>
	<script src="${ctxStatic}/washcar/user/js/orderList.js"></script>
<!-- 个人信息资料END -->
</body>
</html>


