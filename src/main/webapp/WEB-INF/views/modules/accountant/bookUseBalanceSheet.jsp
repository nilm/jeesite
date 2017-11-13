<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
	<title>资产负债表</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
        $(function () {
            totalA('currentAssets');
            totalA('nonCurrentAssets');
            totalA('currentLiabilities');
            totalA('nonCurrentLiabilities');
            totalA('ownershipInteres');
            var currentAssets_begin=parseFloat($("#currentAssets_begin").text());
            var currentAssets_end=parseFloat($("#currentAssets_end").text());
            var nonCurrentAssets_begin=parseFloat($("#nonCurrentAssets_begin").text());
            var nonCurrentAssets_end=parseFloat($("#nonCurrentAssets_end").text());
            var currentLiabilities_begin=parseFloat($("#currentLiabilities_begin").text());
            var currentLiabilities_end=parseFloat($("#currentLiabilities_end").text());
            var nonCurrentLiabilities_begin=parseFloat($("#nonCurrentLiabilities_begin").text());
            var nonCurrentLiabilities_end=parseFloat($("#nonCurrentLiabilities_end").text());
            var ownershipInteres_begin=parseFloat($("#ownershipInteres_begin").text());
            var ownershipInteres_end=parseFloat($("#ownershipInteres_end").text());
            document.getElementById("assets_begin").innerHTML = currentAssets_begin+nonCurrentAssets_begin;
            document.getElementById("assets_end").innerHTML = currentAssets_end+nonCurrentAssets_end;
            document.getElementById("ships_begin").innerHTML = currentLiabilities_begin+nonCurrentLiabilities_begin+ownershipInteres_begin;
            document.getElementById("ships_end").innerHTML = currentLiabilities_end+nonCurrentLiabilities_end+ownershipInteres_end;

        });

        function totalA(type) {
            var name1 = type+'_begin';   //生成函数名1
            window[name1] = 0;//给函数名1赋值
            var name2 = type+'_end';   //生成函数名2
            window[name2] = 0;//给函数名2赋值
            $("#"+type+" tr").each(function () {
                window[name1] += parseFloat($(this).find('td:eq(2)')[0].innerHTML);
                window[name2] += parseFloat($(this).find('td:eq(3)')[0].innerHTML);
            });
            if(isNaN(window[name1])) window[name1]=0;
            if(isNaN(window[name2])) window[name2]=0;
            document.getElementById(name1).innerHTML = window[name1];
            document.getElementById(name2).innerHTML = window[name2];
        }
        function totalAmountCal(type) {
            var currentAssets_begin = 0
            var currentAssets_end = 0
            $("#"+type+" tr").each(function () {
                currentAssets_begin += parseFloat($(this).find('td:eq(2)')[0].innerHTML);
                currentAssets_end += parseFloat($(this).find('td:eq(3)')[0].innerHTML);
            });
            if(isNaN(currentAssets_begin)) currentAssets_begin=0;
            if(isNaN(currentAssets_end)) currentAssets_end=0;
            document.getElementById("currentAssets_begin").innerHTML = currentAssets_begin;
            document.getElementById("currentAssets_end").innerHTML = currentAssets_end;
        }


        function create_name(a,b,c){
            var name = a+"_"+b;   //生成函数名
            window[name] = c;
            window['name'] = 200;   //注意看中括号里的内容加引号和不加引号的区别
        }
        function create_variable(num){
            var name = num+"_test";   //生成函数名
            window[name] = 100;
            window['name'] = 200;   //注意看中括号里的内容加引号和不加引号的区别
        }
	</script>

</head>
<body>
	<ul class="nav nav-tabs"  >
		<li class="active"><a href="${ctx}/accountant/bookusetotal/getBalanceSheet">资产负债表</a></li>
	</ul>
	<sys:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-bordered table-condensed">
		<thead>

			<tr style="height: 50px;">
				<th colspan="8" style="text-align: center;font-size: 20px;">资产负债表</th>
			</tr>
		</thead>
		<tbody>
		<tr>
			<td  colspan="4" style="vertical-align: top;width: 50%;">
				<table id="leftTable" class="table table-striped table-bordered table-condensed">
					<thead>
						<tr>
							<th style="text-align: center;width: 25%">资产</th>
							<th style="text-align: center;width: 5%;">行次</th>
							<th style="text-align: center;width: 25%">期末余额</th>
							<th style="text-align: center;width: 25%">期初余额</th>
						</tr>
					</thead>

					<tr >
						<td colspan="4" style="text-align: left;"> 流动资产:</td>
					</tr>
					<tbody id="currentAssets">
						<c:forEach items="${currentAssets}" var="row" varStatus="status">
							<tr>
								<td style="text-align: center;">
										${row.assetsCategory.text}
								</td>
								<td style="text-align: center;">
										${ status.index + 1}
								</td>
								<td>
										${row.endingBalance}
								</td>
								<td>
										${row.beginningBalance}
								</td>
							</tr>
						</c:forEach>
					</tbody>
					<tr>
						<td style="text-align: center;font-weight: 900;">
							流动资产合计
						</td>
						<td style="text-align: center;">

						</td>
						<td id="currentAssets_begin">

						</td>
						<td id="currentAssets_end">

						</td>
					</tr>
					<tr >
						<td colspan="4" > 非流动资产：</td>
					</tr>
					<tbody id="nonCurrentAssets">
						<c:forEach items="${nonCurrentAssets}" var="row" varStatus="status" >
							<tr>
								<td style="text-align: center;">
										${row.assetsCategory.text}
								</td>
								<td style="text-align: center;">
										${ status.index + 1+fn:length(currentAssets)}
								</td>
								<td>
										${row.endingBalance}
								</td>
								<td>
										${row.beginningBalance}
								</td>
							</tr>
						</c:forEach>
					</tbody>
					<tr>
						<td style="text-align: center;font-weight: 900;">
							非流动资产合计
						</td>
						<td style="text-align: center;">

						</td>
						<td id="nonCurrentAssets_begin">

						</td>
						<td id="nonCurrentAssets_end">

						</td>
					</tr>
				</table>

			</td>
			<td  colspan="4"  style="vertical-align: top;width: 50%;">
				<table id="rightTable" class="table table-striped table-bordered table-condensed">
					<thead>
					<th  style="text-align: center;width: 25%">负债和所有者权益</th>
					<th  style="text-align: center;width: 5%">行次</th>
					<th  style="text-align: center;width: 25%">期末余额</th>
					<th  style="text-align: center;width: 25%">期初余额</th>
					<thead>
					<tr >
						<td colspan="4"  > 流动负债：</td>
					</tr>
					<tbody id="currentLiabilities">
						<c:forEach items="${currentLiabilities}" var="row" varStatus="status">
							<tr>
								<td style="text-align: center;">
										${row.assetsCategory.text}
								</td>
								<td style="text-align: center;">
										${ status.index + 1}
								</td>
								<td>
										${row.endingBalance}
								</td>
								<td>
										${row.beginningBalance}
								</td>
							</tr>
						</c:forEach>
					</tbody>
					<tr>
						<td style="text-align: center;font-weight: 900;">
							流动负债合计
						</td>
						<td style="text-align: center;">

						</td>
						<td id="currentLiabilities_begin">

						</td>
						<td id="currentLiabilities_end">

						</td>
					</tr>
					<tr >
						<td colspan="4" > 非流动负债：</td>
					</tr>
					<tbody id="nonCurrentLiabilities">
						<c:forEach items="${nonCurrentLiabilities}" var="row" varStatus="status">
							<tr>
								<td style="text-align: center;">
										${row.assetsCategory.text}
								</td>
								<td style="text-align: center;">
										${ status.index + 1+fn:length(currentLiabilities)}
								</td>
								<td>
										${row.endingBalance}
								</td>
								<td>
										${row.beginningBalance}
								</td>
							</tr>
						</c:forEach>
					<tbody/>
					<tr>
						<td style="text-align: center;font-weight: 900;">
							非流动负债合计
						</td>
						<td style="text-align: center;">

						</td>
						<td id="nonCurrentLiabilities_begin">

						</td>
						<td id="nonCurrentLiabilities_end">

						</td>
					</tr>
					<tr >
						<td colspan="4" > 所有者权益（或股东权益）:</td>
					</tr>
					<tbody id="ownershipInteres">
						<c:forEach items="${ownershipInteres}" var="row" varStatus="status">
							<tr>
								<td style="text-align: center;">
										${row.assetsCategory.text}
								</td>
								<td style="text-align: center;">
										${ status.index + 1+fn:length(currentLiabilities)+fn:length(nonCurrentLiabilities)}
								</td>
								<td>
										${row.endingBalance}
								</td>
								<td>
										${row.beginningBalance}
								</td>
							</tr>
						</c:forEach>
					</tbody>
					<tr>
						<td style="text-align: center;font-weight: 900;">
							所有者权益（或股东权益）合计
						</td>
						<td style="text-align: center;">

						</td>
						<td id="ownershipInteres_begin">

						</td>
						<td id="ownershipInteres_end">

						</td>
					</tr>
				</table>

			</td>
		</tr>
		<tr>
				<td style="text-align: center;font-weight: 900;width: 16%">资产合计</td>
				<td style="width:3%"></td>
				<td id="assets_begin"  style="width: auto"></td>
				<td id="assets_end" style="width: auto" ></td>
				<td style="text-align: center;font-weight: 900;width: 16%">负债和所有者权益合计</td>
				<td style="width: 3%"></td>
				<td id="ships_begin" style="width: auto" ></td>
				<td id="ships_end" style="width: auto"></td>
		</tr>

		</tbody>
	</table>

</body>
</html>