<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/base/webUser/">前台用户列表</a></li>
		<shiro:hasPermission name="base:webUser:edit"><li><a href="${ctx}/base/webUser/form">前台用户添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="webUser" action="${ctx}/base/webUser/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>用户名：</label>
				<form:input path="userName" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>用户名</th>
				<th>手机</th>
				<th>手机已验证</th>
				<th>用户类型</th>
				<th>积分</th>
				<th>创建时间</th>
				<shiro:hasPermission name="base:webUser:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="webUser">
			<tr>
				<td><a href="${ctx}/base/webUser/form?id=${webUser.id}">
					${webUser.userName}
				</a></td>
				<td>
					${webUser.mobile}
				</td>
				<td>
					${fns:getDictLabel(webUser.mobileValidated, 'yes_no', '')}
				</td>
				<td>
					${fns:getDictLabel(webUser.userType, '', '')}
				</td>
				<td>
					${webUser.points}
				</td>
				<td>
					<fmt:formatDate value="${webUser.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="base:webUser:edit"><td>
    				<a href="${ctx}/base/webUser/form?id=${webUser.id}">修改</a>
					<a href="${ctx}/base/webUser/delete?id=${webUser.id}" onclick="return confirmx('确认要删除该前台用户吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>