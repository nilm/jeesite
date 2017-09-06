<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html>
<html>
<head>
	<title><sitemesh:title default="欢迎光临"/> - ${site.title}</title>
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />

	<%@include file="/WEB-INF/views/modules/cms/front/include/head.jsp" %>
	<sitemesh:head/>
</head>
<body>
	<sitemesh:body/>
</body>
</html>