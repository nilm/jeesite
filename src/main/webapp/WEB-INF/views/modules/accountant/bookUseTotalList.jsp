<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>总账本列表</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/accountant/book/">总账本(科目)列表</a></li>
	</ul>
	<sys:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th colspan="2" style="text-align: center;">左账本</th>
				<th colspan="2" style="text-align: center;">右账本</th>
			</tr>

		</thead>
		<tbody>
		<tr>
			<td  colspan="2" style="vertical-align: top">
				<table id="leftTable" class="table table-striped table-bordered table-condensed">
					<thead>
						<tr>
							<th>账本名称</th>
							<th>累计</th>
						</tr>
					</thead>
					<tbody>

						<tr id="assets_category">
							<td colspan="2" style="text-align: center;"> 资产类</td>
						</tr>
						<c:forEach items="${assets_category}" var="row">
							<tr>
								<td><a href="${ctx}/accountant/bookusetotal/view?id=${row.id}">
									${row.name}
								</a></td>
								<td>
									${row.sumAmount}
								</td>
							</tr>
						</c:forEach>
						<tr id="expenses_category">
							<td colspan="2"  style="text-align: center;"> 费用类</td>
						</tr>
						<c:forEach items="${expenses_category}" var="row">
							<tr>
								<td><a href="${ctx}/accountant/bookusetotal/view?id=${row.id}">
										${row.name}
								</a></td>
								<td>
										${row.sumAmount}
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>

			</td>
			<td  colspan="2"  style="vertical-align: top">
				<table id="rightTable" class="table table-striped table-bordered table-condensed">
					<thead>
					<th>账本名称</th>
					<th>累计</th>
					<thead>
					<tbody>

					<tr id="owners_equity_category">
						<td colspan="2"  style="text-align: center;"> 所有者权益类</td>
					</tr>
					<c:forEach items="${owners_equity_category}" var="row">
						<tr>
							<td><a href="${ctx}/accountant/bookusetotal/view?id=${row.id}">
									${row.name}
							</a></td>
							<td>
									${row.sumAmount}
							</td>
						</tr>
					</c:forEach>
					<tr id="liabilities_category">
						<td colspan="2"  style="text-align: center;"> 负债类</td>
					</tr>
					<c:forEach items="${liabilities_category}" var="row">
						<tr>
							<td><a href="${ctx}/accountant/bookusetotal/view?id=${row.id}">
									${row.name}
							</a></td>
							<td>
									${row.sumAmount}
							</td>
						</tr>
					</c:forEach>
					<tr id="income_category">
						<td colspan="2"  style="text-align: center;"> 收入类</td>
					</tr>
					<c:forEach items="${income_category}" var="row">
						<tr>
							<td><a href="${ctx}/accountant/bookusetotal/view?id=${row.id}">
									${row.name}
							</a></td>
							<td>
									${row.sumAmount}
							</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>

			</td>
		</tr>
		<tr>
			<td>左账本合计</td>
			<td>${left_sum_bookRecordDetail.leftSumAmount - left_sum_bookRecordDetail.rightSumAmount}</td>
			<td>右账本合计</td>
			<td>${right_sum_bookRecordDetail.rightSumAmount - right_sum_bookRecordDetail.leftSumAmount}</td>
		</tr>

		</tbody>
	</table>

</body>
</html>