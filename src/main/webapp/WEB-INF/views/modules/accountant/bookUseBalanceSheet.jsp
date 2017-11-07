<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
	<title>资产负债表</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
</head>
<body>
	<ul class="nav nav-tabs"  >
		<li class="active"><a href="${ctx}/accountant/bookusetotal/getBalanceSheet">资产负债表</a></li>
	</ul>
	<sys:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-bordered table-condensed">
		<thead>

			<tr style="height: 50px;">
				<th colspan="4" style="text-align: center;font-size: 20px;">资产负债表</th>
			</tr>
		</thead>
		<tbody>
		<tr>
			<td  colspan="2" style="vertical-align: top;width: 50%;">
				<table id="leftTable" class="table table-striped table-bordered table-condensed">
					<thead>
						<tr>
							<th style="text-align: center;width: 25%">资产</th>
							<th style="text-align: center;width: 5%;">行次</th>
							<th style="text-align: center;width: 25%">期末余额</th>
							<th style="text-align: center;width: 25%">期初余额</th>
						</tr>
					</thead>
					<tbody>

						<tr id="assets_category">
							<td colspan="4" style="text-align: center;"> 资产类</td>
						</tr>
						<c:forEach items="${assets_category}" var="row" varStatus="status">
							<tr>
								<td><a href="${ctx}/accountant/bookusetotal/view?id=${row.id}">
									${row.name}
								</a></td>
								<td style="text-align: center;">
										${ status.index + 1}
								</td>
								<td>
										${row.sumAmount}
								</td>
								<td>
										${row.sumAmount}
								</td>
							</tr>
						</c:forEach>
						<tr id="expenses_category">
							<td colspan="4"  style="text-align: center;"> 费用类</td>
						</tr>
						<c:forEach items="${expenses_category}" var="row" varStatus="status" >
							<tr>
								<td><a href="${ctx}/accountant/bookusetotal/view?id=${row.id}">
										${row.name}
								</a></td>
								<td style="text-align: center;">
										${ status.index + 1+fn:length(assets_category)}
								</td>
								<td>
										${row.sumAmount}
								</td>
								<td>
										${row.sumAmount}
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>

			</td>
			<td  colspan="2"  style="vertical-align: top;width: 50%;">
				<table id="rightTable" class="table table-striped table-bordered table-condensed">
					<thead>
					<th  style="text-align: center;width: 25%">负债和所有者权益</th>
					<th  style="text-align: center;width: 5%">行次</th>
					<th  style="text-align: center;width: 25%">期末余额</th>
					<th  style="text-align: center;width: 25%">期初余额</th>
					<thead>
					<tbody>

					<tr id="owners_equity_category">
						<td colspan="4"  style="text-align: center;"> 所有者权益类</td>
					</tr>
					<c:forEach items="${owners_equity_category}" var="row" varStatus="status">
						<tr>
							<td><a href="${ctx}/accountant/bookusetotal/view?id=${row.id}">
									${row.name}
							</a></td>
							<td style="text-align: center;">
									${ status.index + 1}
							</td>
							<td>
									${row.sumAmount}
							</td>
							<td>
									${row.sumAmount}
							</td>
						</tr>
					</c:forEach>
					<tr id="liabilities_category">
						<td colspan="4"  style="text-align: center;"> 负债类</td>
					</tr>
					<c:forEach items="${liabilities_category}" var="row" varStatus="status">
						<tr>
							<td><a href="${ctx}/accountant/bookusetotal/view?id=${row.id}">
									${row.name}
							</a></td>
							<td style="text-align: center;">
									${ status.index + 1+fn:length(owners_equity_category)}
							</td>
							<td>
									${row.sumAmount}
							</td>
							<td>
									${row.sumAmount}
							</td>
						</tr>
					</c:forEach>
					<tr id="income_category">
						<td colspan="4"  style="text-align: center;"> 收入类</td>
					</tr>
					<c:forEach items="${income_category}" var="row" varStatus="status">
						<tr>
							<td><a href="${ctx}/accountant/bookusetotal/view?id=${row.id}">
									${row.name}
							</a></td>
							<td style="text-align: center;">
									${ status.index + 1+fn:length(owners_equity_category)+fn:length(liabilities_category)}
							</td>
							<td>
									${row.sumAmount}
							</td>
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
			<td>资产合计</td>
			<td>${left_sum_bookRecordDetail.leftSumAmount - left_sum_bookRecordDetail.rightSumAmount}</td>
			<td>负债和所有者权益合计</td>
			<td>${right_sum_bookRecordDetail.rightSumAmount - right_sum_bookRecordDetail.leftSumAmount}</td>
		</tr>

		</tbody>
	</table>

</body>
</html>