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
		<style type="text/css">
			 .table  .amount{
				width: 120px;
				text-align: right;
			}
			 .table th{
				width: 120px;
				text-align: center;
			}
		</style>
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
				<td style="width: 68px;">
					<fmt:formatDate value="${bookRecordDetail.createDate}" pattern="yyyy-MM-dd" />

				</td>
				<td>
					${bookRecordDetail.record.digest}
				</td>
				<td class="amount">
					<c:if test="${bookRecordDetail.direction == 'left'}">
						<fmt:formatNumber pattern="000,000.00" value="${bookRecordDetail.amount}"></fmt:formatNumber>
					</c:if>
				</td>
				<td class="amount">
					<c:if test="${bookRecordDetail.direction == 'right'}">
						<fmt:formatNumber pattern="000,000.00" value="${bookRecordDetail.amount}"></fmt:formatNumber>
					</c:if>
				</td>
				<td class="amount">
					<fmt:formatNumber pattern="000,000.00" value="${bookRecordDetail.balance}"></fmt:formatNumber>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>