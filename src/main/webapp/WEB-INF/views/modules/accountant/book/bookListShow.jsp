<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>账本管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#treeTable").treeTable({expandLevel : 3}).show();
		});
    	
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/accountant/book/listShow">账本列表</a></li>
	</ul>
	<sys:message content="${message}"/>
	<form id="listForm" method="post">
		<table id="treeTable" class="table table-striped table-bordered table-condensed hide">
			<thead><tr><th>名称</th><th style="text-align:center;">编码</th><th style="text-align:center;">末级账本</th><shiro:hasPermission name="accountant:book:my:edit"><th>操作</th></shiro:hasPermission></tr></thead>
			<tbody><c:forEach items="${list}" var="menu">
				<tr id="${menu.id}" pId="${menu.parent.id ne '0'?menu.parent.id:'0'}">
					<td >${menu.name}</td>
					<td style="text-align:center;">${menu.code}</td>
					<td style="text-align:center;">
						${menu.finalStage eq '1'?'是':'否'}
					</td>
					<shiro:hasPermission name="accountant:book:my:edit"><td nowrap>
						<a href="${ctx}/accountant/book/bookform?id=${menu.id}">修改</a>
						<a href="${ctx}/accountant/book/delete?id=${menu.id}" onclick="return confirmx('要删除该菜单及所有子菜单项吗？', this.href)">删除</a>
						<a href="${ctx}/accountant/book/bookform?parent.id=${menu.id}">${menu.finalStage eq '1'?'':'添加下级菜单'}</a>
					</td></shiro:hasPermission>
				</tr>
			</c:forEach></tbody>
		</table>
		
	 </form>
</body>
</html>