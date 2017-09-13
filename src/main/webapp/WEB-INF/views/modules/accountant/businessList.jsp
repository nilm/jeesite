<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>会计业务管理</title>
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
		<li class="active"><a href="${ctx}/accountant/business/">会计业务列表</a></li>
		<shiro:hasPermission name="accountant:business:edit"><li><a href="${ctx}/accountant/business/form">会计业务添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="business" action="${ctx}/accountant/business/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>用户id：</label>
			</li>
			<li><label>公司id：</label>
				<form:input path="companyId" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>业务名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="125" class="input-medium"/>
			</li>
			<li><label>显示否：</label>
				<form:radiobuttons path="showHide" items="${fns:getDictList('show_hide')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>主键</th>
				<th>业务名称</th>
				<th>排序</th>
				<th>备注</th>
				<th>显示否</th>
				<shiro:hasPermission name="accountant:business:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="business">
			<tr>
				<td><a href="${ctx}/accountant/business/form?id=${business.id}">
					${business.id}
				</a></td>
				<td>
					${business.name}
				</td>
				<td>
					${business.sort}
				</td>
				<td>
					${business.remarks}
				</td>
				<td>
					${fns:getDictLabel(business.showHide, 'show_hide', '')}
				</td>
				<shiro:hasPermission name="accountant:business:edit"><td>
    				<a href="${ctx}/accountant/business/form?id=${business.id}">修改</a>
					<a href="${ctx}/accountant/business/delete?id=${business.id}" onclick="return confirmx('确认要删除该会计业务吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>