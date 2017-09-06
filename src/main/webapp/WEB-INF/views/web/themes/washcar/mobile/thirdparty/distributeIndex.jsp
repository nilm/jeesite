<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>登录</title>
	<meta name="decorator" content="cms_default_${site.theme}"/>
	<meta name="description" content="JeeSite ${site.description}" />
	<meta name="keywords" content="JeeSite ${site.keywords}" />
	<script src="${ctxStatic}/washcar/gate/js/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	function goList(){
		window.location.href="${ctx}/washcar/distribute/list";
	}
	function goIng(){
		window.location.href="${ctx}/washcar/distribute/sent";
	}
	function goMine(){
		window.location.href="${ctx}/washcar/distribute/mylist";
	}
</script>
</head>
<body>
<header>
    <h1>洗车人派单</h1>
</header>
    <div class="row">
           	<div >
                <div class="input-row">
                    <button onclick="goList()">可选订单</button>
                </div>
                <div class="input-row">
                    <button onclick="goIng()">派送订单</button>
                </div>
                <div class="input-row">
                    <button onclick="goMine()">我的订单</button>
                </div>
            </div>
    </div>
</body>
</html>