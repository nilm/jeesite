<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户积分管理</title>
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
		<li class="active"><a href="${ctx}/account/pointDetail/">用户积分列表</a></li>
		<shiro:hasPermission name="account:pointDetail:edit"><li><a href="${ctx}/account/pointDetail/form">用户积分添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="pointDetail" action="${ctx}/account/pointDetail/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>web用户：</label>
				<form:input path="userId" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>合作机构：</label>
				<form:input path="companyId" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>积分交易类型：</label>
				<form:input path="changeType" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label>积分流动方向：</label>
				<form:input path="fundDirection" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label>创建时间：</label>
				<input name="beginCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${pointDetail.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/> - 
				<input name="endCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${pointDetail.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>web用户</th>
				<th>积分交易类型</th>
				<th>积分流动方向</th>
				<th>积分交易对象类型</th>
				<shiro:hasPermission name="account:pointDetail:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="pointDetail">
			<tr>
				<td><a href="${ctx}/account/pointDetail/form?id=${pointDetail.id}">
					${pointDetail.userId}
				</a></td>
				<td>
					${pointDetail.changeType}
				</td>
				<td>
					${pointDetail.fundDirection}
				</td>
				<td>
					${pointDetail.targetType}
				</td>
				<shiro:hasPermission name="account:pointDetail:edit"><td>
    				<a href="${ctx}/account/pointDetail/form?id=${pointDetail.id}">修改</a>
					<a href="${ctx}/account/pointDetail/delete?id=${pointDetail.id}" onclick="return confirmx('确认要删除该用户积分吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>