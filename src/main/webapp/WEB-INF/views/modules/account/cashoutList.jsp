<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>提现申请管理</title>
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
		<li class="active"><a href="${ctx}/account/cashout/">提现申请列表</a></li>
		<%-- <shiro:hasPermission name="account:cashout:edit"><li><a href="${ctx}/account/cashout/form">提现申请添加</a></li></shiro:hasPermission> --%>
	</ul>
	<form:form id="searchForm" modelAttribute="cashout" action="${ctx}/account/cashout/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>前台用户：</label>
				<%-- <form:input path="webuserId" htmlEscape="false" maxlength="64" class="input-medium"/> --%>
				<input name="webuserId" name="webUser.id" labelName="webUuser.userName"  htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>提现金额：</label>
				<form:input path="applyAmount" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>状态：</label>
				<form:select path="status" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('base_audit_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>审核时间：</label>
				<input name="auditDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${cashout.auditDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>申请时间：</label>
				<input name="createDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${cashout.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><!-- 用户名、姓名、性别、电话、身份证、提现账号、提现银行、支行、提现总数、到账金额、手续费、提现时间、操作 -->
			<tr>
				<th>用户名</th>
				<th>姓名</th>
				<th>电话</th>
				<th>提现金额</th>
				<th>到账类型</th>
				<th>提现账号</th>
				<th>提现时间</th>
				<th>状态</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cashout">
			<tr>
				<td><a href="${ctx}/account/cashout/form?id=${cashout.id}">
					${cashout.webUser.userName}
				</a></td>
				<td>
					${cashout.webUser.realName}
				</td>
				<td>
					${cashout.webUser.mobile}
				</td>
				<td>
					${cashout.applyAmount}
				</td>
				<td>
					${fns:getDictLabel(cashout.cardType, 'account_cashout_card_type', '')}
				</td>
				<td>
					<c:choose>
						<c:when test="${cashout.cardType =='bank' }">
							${cashout.bankNo}
							${cashout.bankName}
							${cashout.bankBranchName}
						
						</c:when>
						<c:otherwise>
							${cashout.alipayNo}
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					<fmt:formatDate value="${cashout.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${fns:getDictLabel(cashout.status, 'base_audit_status', '')}
				</td>
				<td>
				
				<c:if test="${cashout.status == 'audit' }">
				<shiro:hasPermission name="account:cashout:doing">
    				<a href="${ctx}/account/cashout/doing/toAudit?id=${cashout.id}">处理中</a>
    			</shiro:hasPermission> 
    			</c:if>
				<c:if test="${cashout.status == 'doing' }">
					<shiro:hasPermission name="account:cashout:audit">
	    				<a href="${ctx}/account/cashout/success/toAudit?id=${cashout.id}">审核</a>
	    			</shiro:hasPermission>
				</c:if>
				
    			<a href="${ctx}/account/cashout/form?id=${cashout.id}">查看</a>
				<shiro:hasPermission name="account:cashout:edit">
    				<%-- <a href="${ctx}/account/cashout/form?id=${cashout.id}">修改</a>
					<a href="${ctx}/account/cashout/delete?id=${cashout.id}" onclick="return confirmx('确认要删除该提现申请吗？', this.href)">删除</a> --%>
				</shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>