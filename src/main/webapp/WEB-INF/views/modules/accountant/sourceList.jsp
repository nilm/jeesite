<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>原始业务记录管理</title>
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
		<li class="active"><a href="${ctx}/accountant/source/">原始业务记录列表</a></li>
		<shiro:hasPermission name="accountant:source:edit"><li><a href="${ctx}/accountant/source/form">原始业务记录添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="source" action="${ctx}/accountant/source/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>信息类型：</label>
				<form:select path="type" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('accountant_source_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>业务：</label>
				<form:select path="bizId" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${businesses}" itemLabel="name" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>创建人：</label>
				<sys:treeselect id="createBy" name="createBy.id" value="${source.createBy.id}" labelName="createBy.name" labelValue="${source.createBy.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>信息类型</th>
				<th>业务</th>
				<th>文本信息</th>
				<th>录入人</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="accountant:source:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="source">
			<tr>
				<td><a href="${ctx}/accountant/source/form?id=${source.id}">
					${fns:getDictLabel(source.type, 'accountant_source_type', '')}
				</a></td>
				<td>
					${fns:getDictLabel(source.bizId, '', '')}
				</td>
				<td>
					${source.text}
				</td>
				<td>
					${source.createBy.name}
				</td>
				<td>
					<fmt:formatDate value="${source.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${source.remarks}
				</td>
				<shiro:hasPermission name="accountant:source:edit"><td>
    				<a href="${ctx}/accountant/source/form?id=${source.id}">修改</a>
					<a href="${ctx}/accountant/source/delete?id=${source.id}" onclick="return confirmx('确认要删除该原始业务记录吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>