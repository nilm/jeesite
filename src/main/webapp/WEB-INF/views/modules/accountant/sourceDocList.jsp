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
		<li class="active"><a href="${ctx}/accountant/sourceDoc/">原始业务记录列表</a></li>
		<shiro:hasPermission name="accountant:sourceDoc:edit"><li><a href="${ctx}/accountant/sourceDoc/form">原始业务记录添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="sourceDoc" action="${ctx}/accountant/sourceDoc/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>用户id：</label>
				<sys:treeselect id="user" name="user.id" value="${sourceDoc.user.id}" labelName="user.name" labelValue="${sourceDoc.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>公司id：</label>
				<sys:treeselect id="company" name="company.id" value="${sourceDoc.company.id}" labelName="company.name" labelValue="${sourceDoc.company.name}"
					title="部门" url="/sys/office/treeData?type=1" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>业务id：</label>
				<form:select path="bizId" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>摘要：</label>
				<form:input path="digest" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label>处理人：</label>
				<form:input path="accountantUserId" htmlEscape="false" maxlength="64" class="input-medium"/>
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
				<th>摘要</th>
				<th>金额</th>
				<th>附件数</th>
				<th>记账时间</th>
				<th>当前状态</th>
				<th>处理人</th>
				<th>备注</th>
				<shiro:hasPermission name="accountant:sourceDoc:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="sourceDoc">
			<tr>
				<td><a href="${ctx}/accountant/sourceDoc/form?id=${sourceDoc.id}">
					${sourceDoc.user.name}
				</a></td>
				<td>
					${sourceDoc.company.name}
				</td>
				<td>
					${fns:getDictLabel(sourceDoc.bizId, '', '')}
				</td>
				<td>
					${sourceDoc.digest}
				</td>
				<td>
					${sourceDoc.money}
				</td>
				<td>
					${sourceDoc.attachmentCount}
				</td>
				<td>
					<fmt:formatDate value="${sourceDoc.recordDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${fns:getDictLabel(sourceDoc.status, 'accountant_soucre_doc_status', '')}
				</td>
				<td>
					${sourceDoc.accountantUserId}
				</td>
				<td>
					${sourceDoc.remarks}
				</td>
				<shiro:hasPermission name="accountant:sourceDoc:edit"><td>
    				<a href="${ctx}/accountant/sourceDoc/form?id=${sourceDoc.id}">修改</a>
					<a href="${ctx}/accountant/sourceDoc/delete?id=${sourceDoc.id}" onclick="return confirmx('确认要删除该原始业务记录吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>