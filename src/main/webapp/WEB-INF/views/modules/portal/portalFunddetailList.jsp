<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>平台资金流动管理</title>
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
		<li class="active"><a href="${ctx}/portal/portalFunddetail/">平台资金流动列表</a></li>
		<shiro:hasPermission name="portal:portalFunddetail:edit"><li><a href="${ctx}/portal/portalFunddetail/form">平台资金流动添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="portalFunddetail" action="${ctx}/portal/portalFunddetail/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>创建时间：</label>
				<input name="beginCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${portalFunddetail.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/> - 
				<input name="endCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${portalFunddetail.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>资金类型：</label>
				<form:select path="changeType" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>操作资金：</label>
				<form:input path="operate" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>资金流动方向：</label>
				<form:select path="direction" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>资金对象：</label>
				<form:input path="target" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>创建时间</th>
				<th>资金类型</th>
				<th>资金流动方向</th>
				<shiro:hasPermission name="portal:portalFunddetail:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="portalFunddetail">
			<tr>
				<td><a href="${ctx}/portal/portalFunddetail/form?id=${portalFunddetail.id}">
					<fmt:formatDate value="${portalFunddetail.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</a></td>
				<td>
					${fns:getDictLabel(portalFunddetail.changeType, '', '')}
				</td>
				<td>
					${fns:getDictLabel(portalFunddetail.direction, '', '')}
				</td>
				<shiro:hasPermission name="portal:portalFunddetail:edit"><td>
    				<a href="${ctx}/portal/portalFunddetail/form?id=${portalFunddetail.id}">修改</a>
					<a href="${ctx}/portal/portalFunddetail/delete?id=${portalFunddetail.id}" onclick="return confirmx('确认要删除该平台资金流动吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>