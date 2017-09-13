<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>业务账本关系模板管理</title>
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
		<li class="active"><a href="${ctx}/accountant/bizBookTemplate/">业务账本关系模板列表</a></li>
		<shiro:hasPermission name="accountant:bizBookTemplate:edit"><li><a href="${ctx}/accountant/bizBookTemplate/form">业务账本关系模板添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="bizBookTemplate" action="${ctx}/accountant/bizBookTemplate/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>用户id：</label>
			</li>
			<li><label>公司id：</label>
				<form:input path="companyId" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>业务id：</label>
				<form:select path="bizId" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>账本id：</label>
				<form:select path="bookId" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>方向：</label>
				<form:radiobuttons path="direction" items="${fns:getDictList('accountant_biz_plus_minus')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</li>
			<li><label>账本类型：</label>
				<form:radiobuttons path="category" items="${fns:getDictList('accountant_left_right')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</li>
			<li><label>使用次数：</label>
				<form:input path="useCount" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>用户id</th>
				<th>公司id</th>
				<th>业务id</th>
				<th>账本id</th>
				<th>定选否</th>
				<th>方向</th>
				<th>账本类型</th>
				<th>使用次数</th>
				<th>生成日期</th>
				<th>备注</th>
				<shiro:hasPermission name="accountant:bizBookTemplate:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bizBookTemplate">
			<tr>
				<td><a href="${ctx}/accountant/bizBookTemplate/form?id=${bizBookTemplate.id}">
					${bizBookTemplate.user.id}
				</a></td>
				<td>
					${bizBookTemplate.companyId}
				</td>
				<td>
					${fns:getDictLabel(bizBookTemplate.bizId, '', '')}
				</td>
				<td>
					${fns:getDictLabel(bizBookTemplate.bookId, '', '')}
				</td>
				<td>
					${fns:getDictLabel(bizBookTemplate.fixed, 'yes_no', '')}
				</td>
				<td>
					${fns:getDictLabel(bizBookTemplate.direction, 'accountant_biz_plus_minus', '')}
				</td>
				<td>
					${fns:getDictLabel(bizBookTemplate.category, 'accountant_left_right', '')}
				</td>
				<td>
					${bizBookTemplate.useCount}
				</td>
				<td>
					<fmt:formatDate value="${bizBookTemplate.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${bizBookTemplate.remarks}
				</td>
				<shiro:hasPermission name="accountant:bizBookTemplate:edit"><td>
    				<a href="${ctx}/accountant/bizBookTemplate/form?id=${bizBookTemplate.id}">修改</a>
					<a href="${ctx}/accountant/bizBookTemplate/delete?id=${bizBookTemplate.id}" onclick="return confirmx('确认要删除该业务账本关系模板吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>