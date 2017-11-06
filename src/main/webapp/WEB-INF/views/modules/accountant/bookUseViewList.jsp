<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>账本明细</title>
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
		<li class="active"><a href="${ctx}/accountant/bookRecord/">账本明细</a></li>
	</ul>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<tbody>
		<tr>
			<td>${book.name}</td>
			<td colspan="3">
				${book.name}
				<c:if test="${book.category == 'left'}">账页属左账页，增加额记入账页左栏。</c:if>
				<c:if test="${book.category == 'right'}">账页属右账页，增加额记入账页右栏。</c:if>
			</td>
			<td></td>
		</tr>
		</tbody>
	</table>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">

		<thead>
			<tr>
				<th>日期</th>
				<th>摘要</th>
				<th>
					<c:if test="${book.category == 'left'}">左（增加）</c:if>
					<c:if test="${book.category == 'right'}">左（减少）</c:if>
				</th>
				<th>
					<c:if test="${book.category == 'left'}">左（减少）</c:if>
					<c:if test="${book.category == 'right'}">右（增加）</c:if>
				</th>
				<th>累计</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bookRecordDetail">
			<tr>
				<td>
					<fmt:formatDate value="${bookRecordDetail.createDate}" pattern="yyyy-MM-dd HH:mm:ss" />

				</td>
				<td>
					${bookRecordDetail.record.digest}
				</td>
				<td>
					<c:if test="${bookRecordDetail.direction == 'left'}">${bookRecordDetail.amount}</c:if>
				</td>
				<td>
					<c:if test="${bookRecordDetail.direction == 'right'}">${bookRecordDetail.amount}</c:if>
				</td>
				<td>
					${bookRecordDetail.balance}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>