<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>短信记录管理</title>
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
		<li class="active"><a href="${ctx}/sms/smsLog/">短信记录列表</a></li>
		<shiro:hasPermission name="sms:smsLog:edit"><li><a href="${ctx}/sms/smsLog/form">短信记录添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="smsLog" action="${ctx}/sms/smsLog/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>手机号码：</label>
				<form:input path="mobile" htmlEscape="false" maxlength="12" class="input-medium"/>
			</li>
			<li><label>发送状态：</label>
				<form:select path="status" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('success_fail')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>发送时间：</label>
				<input name="beginCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${smsLog.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/> - 
				<input name="endCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${smsLog.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
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
				<th>手机号码</th>
				<th>发送状态</th>
				<th>信息内容</th>
				<th>申请ip</th>
				<th>发送时间</th>
				<shiro:hasPermission name="sms:smsLog:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="smsLog">
			<tr>
				<td><a href="${ctx}/sms/smsLog/form?id=${smsLog.id}">
					${smsLog.mobile}
				</a></td>
				<td>
					${fns:getDictLabel(smsLog.status, 'success_fail', '')}
				</td>
				<td>
					${smsLog.content}
				</td>
				<td>
					${smsLog.applyIp}
				</td>
				<td>
					<fmt:formatDate value="${smsLog.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="sms:smsLog:edit"><td>
    				<a href="${ctx}/sms/smsLog/form?id=${smsLog.id}">修改</a>
					<a href="${ctx}/sms/smsLog/delete?id=${smsLog.id}" onclick="return confirmx('确认要删除该短信记录吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>