<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>数据选择</title>
	<meta name="decorator" content="blank"/>

 <link href="${ctxStatic }/accountant/bookselect.css" rel="stylesheet" enums="text/css" />
<input type="text" name="select_bookId" id="select_bookId"/>
<input type="text" name="select_bookName" id="select_bookName"/>
	<div class="popup_table"  id="books_content"  >
		<table class="account_table">
			<tr>
				<td class="col_1">
					<div class="row_1">左账本</div>
					<div style="padding-left: 10px;color: #00aa00;font-weight: 600;">资产类</div>
						<c:forEach items="${assets_category}" var="row">
							<div><a href="javascript:selectBook(${row.id},'${row.name}')">${row.name}</a></div>
						</c:forEach>
					<div  style="padding-left: 10px;color: #7aba7b;font-weight: 600;">费用类</div>
					<c:forEach items="${expenses_category}" var="row">
						<div><a href="javascript:selectBook(${row.id},'${row.name}')">${row.name}</a></div>
					</c:forEach>
				</td>
				<td class="col_2">
					<div class="row_1">右账本</div>
					<div  style="padding-left: 10px;color: #cf9311;font-weight: 600;">所有者权益类</div>
					<c:forEach items="${owners_equity_category}" var="row">
						<div><a href="javascript:selectBook(${row.id},'${row.name}')">${row.name}</a></div>
					</c:forEach>
					<div  style="padding-left: 10px;color: #cf9311;font-weight: 600;">负债类</div>
					<c:forEach items="${liabilities_category}" var="row">
						<div><a href="javascript:selectBook(${row.id},'${row.name}')">${row.name}</a></div>
					</c:forEach>
					<div  style="padding-left: 10px;color: #cf9311;font-weight: 600;">收入类</div>
					<c:forEach items="${income_category}" var="row">
						<div><a href="javascript:selectBook(${row.id},'${row.name}')">${row.name}</a></div>
					</c:forEach>
				</td>
			</tr>
		</table>
	</div>
<script type="text/javascript">
	function selectBook(bookId,bookName) {
		$("#select_bookId").val(bookId);
		$("#select_bookName").val(bookName);
        top.$.jBox.getBox().find("button[value='ok']").trigger("click");
    }
</script>