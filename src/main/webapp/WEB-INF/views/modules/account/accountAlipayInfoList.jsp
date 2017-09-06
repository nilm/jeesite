<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>支付宝信息管理</title>
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
		<li class="active"><a href="${ctx}/account/accountAlipayInfo/">支付宝信息列表</a></li>
		<shiro:hasPermission name="account:accountAlipayInfo:edit"><li><a href="${ctx}/account/accountAlipayInfo/form">支付宝信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="accountAlipayInfo" action="${ctx}/account/accountAlipayInfo/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>支付宝持有人：</label>
				<form:input path="owner" htmlEscape="false" maxlength="60" class="input-medium"/>
			</li>
			<li><label>支付宝账号：</label>
				<form:input path="alipayNo" htmlEscape="false" maxlength="128" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>用户Id</th>
				<th>支付宝持有人</th>
				<th>支付宝账号</th>
				<th>删除标示</th>
				<shiro:hasPermission name="account:accountAlipayInfo:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="accountAlipayInfo">
			<tr>
				<td><a href="${ctx}/account/accountAlipayInfo/form?id=${accountAlipayInfo.id}">
					${accountAlipayInfo.}
				</a></td>
				<td>
					${accountAlipayInfo.owner}
				</td>
				<td>
					${accountAlipayInfo.alipayNo}
				</td>
				<td>
					${fns:getDictLabel(accountAlipayInfo.delFlag, 'del_flag', '')}
				</td>
				<shiro:hasPermission name="account:accountAlipayInfo:edit"><td>
    				<a href="${ctx}/account/accountAlipayInfo/form?id=${accountAlipayInfo.id}">修改</a>
					<a href="${ctx}/account/accountAlipayInfo/delete?id=${accountAlipayInfo.id}" onclick="return confirmx('确认要删除该支付宝信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>