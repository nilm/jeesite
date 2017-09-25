<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>账本记录管理</title>
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
		<li class="active"><a href="${ctx}/accountant/bookRecord/">账本记录列表</a></li>
		<shiro:hasPermission name="accountant:bookRecord:edit"><li><a href="${ctx}/accountant/bookRecord/form">账本记录添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="bookRecord" action="${ctx}/accountant/bookRecord/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>用户：</label>
				<sys:treeselect id="user" name="user.id" value="${bookRecord.user.id}" labelName="user.name" labelValue="${bookRecord.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>公司：</label>
				<sys:treeselect id="company" name="company.id" value="${bookRecord.company.id}" labelName="company.name" labelValue="${bookRecord.company.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>业务：</label>
				<form:select path="bizId" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${businesses}" itemLabel="name" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>金额：</label>
				<form:input path="amount" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>当前状态：</label>
				<form:input path="status" htmlEscape="false" maxlength="125" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>用户</th>
				<th>公司</th>
				<th>业务</th>
				<th>摘要</th>
				<th>金额</th>
				<th>当前状态</th>
				<th>备注</th>
				<shiro:hasPermission name="accountant:bookRecord:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bookRecord">
			<tr>
				<td><a href="${ctx}/accountant/bookRecord/form?id=${bookRecord.id}">
					${bookRecord.user.name}
				</a></td>
				<td>
					${bookRecord.company.name}
				</td>
				<td>
					${bookRecord.biz.name}
				</td>
				<td>
					${bookRecord.digest}
				</td>
				<td>
					${bookRecord.amount}
				</td>
				<td>
					${fns:getDictLabel(bookRecord.status, 'accountant_book_status', '')}
				</td>
				<td>
					${bookRecord.remarks}
				</td>
				<shiro:hasPermission name="accountant:bookRecord:edit"><td>
    				<a href="${ctx}/accountant/bookRecord/form?id=${bookRecord.id}">修改</a>
					<a href="${ctx}/accountant/bookRecord/delete?id=${bookRecord.id}" onclick="return confirmx('确认要删除该账本记录吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>