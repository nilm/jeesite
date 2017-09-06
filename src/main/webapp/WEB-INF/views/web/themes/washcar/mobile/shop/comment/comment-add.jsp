<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<jsp:useBean id="shopComment"  class="com.thinkgem.jeesite.modules.car.entity.ShopComment" scope="request" ></jsp:useBean>
<html>
<head>
	<title>新增评价</title>
	<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0;">
	<script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
	<link rel="stylesheet" href="${ctxStatic}/washcar/mobile/css/comment/ch_base.css" />
	<link rel="stylesheet" href="${ctxStatic}/washcar/mobile/css/payStatus.css" />
</head>
<body>
	<form:form id="inputForm"  modelAttribute="shopComment" action="${ctx}/${frontPath}/shop/comment/doAdd" method="post" class="form-horizontal">
		 <form:hidden path="orderId" id="orderId" name="orderId" value="${orderId } "/>
		<sys:message content="${message}"/>
		<div class="pay_mark">
		    <div class="pay_mark_tps">请给本次体验打个分吧</div>
		    <div class="pay_star">
		   <form:hidden  path="point"  class="wis_item_star star5" id="point" /> 
		    <div class="wis_item_star star0" id="jRating" ></div>
		    </div>
		</div>
		<!-- 打分END -->
		<!-- 意见与建议START -->
		<div class="pay_ta_wr">
				<form:textarea path="content" htmlEscape="false" rows="4" maxlength="255" class="pay_ta" placeholder="在这里可以写下更多感受或建议"/>
		</div>
		<div class="btn_rating_grp">
			<button id="btnCancel" class="btn_rating btn_rating_back"  type="button" onclick="history.go(-1)">返 回</button>&nbsp;
			<button id="btnSubmit" class="btn_rating">保 存</button>
		</div>
	</form:form>
<script type="text/javascript">
document.getElementById("jRating").onclick=function(evt){
	var pageX = evt.pageX - 10;
	var starCount = parseInt(pageX/24) + 1;
	this.className = "wis_item_star star" + starCount;
	$('#point').val(starCount);
};
</script>
</body>
</html>