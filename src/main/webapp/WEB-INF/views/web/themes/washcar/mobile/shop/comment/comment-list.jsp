<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
	<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>评价</title>
    <link rel="stylesheet" href="${ctxStatic}/washcar/mobile/css/comment/ch_base.css" />
	<link rel="stylesheet" href="${ctxStatic}/washcar/mobile/css/comment/comment.css" />
</head>
<body>
<!-- 标题START -->
<header>
    <a href="javascript:history.go(-1);" class="h_back"><img src="${ctxStatic}/washcar/common/img/wis_r1_c33.png" alt="后退按钮"></a>
    <h1>评价</h1>
</header>
<!-- 标题END -->

<!-- 评论模块START -->
<c:forEach items="${pages.list }" var="comment">
<div class="comm_md">
    <div class="comm_info">
        <div class="comm_up">
            <span class="comm_tel"><c:out value="${fn:substring(comment.username,0,4)}" />***<c:out value="${fn:substring(comment.username,7,11)}" /></span>
            <span class="comm_time"><fmt:formatDate value="${comment.createDate }" pattern="yyyy-MM-dd HH:mm" /></span>
        </div>
        <div class=" ">
            <div class="wis_item_star star${comment.point }"></div>
        </div>
        <div class="pay_comment">
            评价：${comment.content }
        </div>
    </div>
</div>
</c:forEach>
<a href="#" class="wis_more">更多...</a>
</body>
</html>