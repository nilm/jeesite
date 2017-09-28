<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>会计国标账本(科目)管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/accountant/book/">会计国标账本(科目)列表</a></li>
		<li class="active"><a href="${ctx}/accountant/book/form?id=${book.id}&parent.id=${bookparent.id}">会计国标账本(科目)<shiro:hasPermission name="accountant:book:edit">${not empty book.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="accountant:book:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="book" action="${ctx}/accountant/book/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">上级父级主键:</label>
			<div class="controls">
				<sys:treeselect id="parent" name="parent.id" value="${book.parent.id}" labelName="parent.name" labelValue="${book.parent.name}"
					title="父级主键" url="/accountant/book/treeData" extId="${book.id}" cssClass="" allowClear="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">科目编码：</label>
			<div class="controls">
				<form:input path="code" htmlEscape="false" maxlength="20" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">排序：</label>
			<div class="controls">
				<form:input path="sort" htmlEscape="false" class="input-xlarge required digits"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">账本名称：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="125" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">辅助码：</label>
			<div class="controls">
				<form:input path="assistCode" htmlEscape="false" maxlength="128" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">账本方向：</label>
			<div class="controls">
				<form:radiobuttons path="category" items="${fns:getDictList('accountant_left_right')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">账本性质：</label>
			<div class="controls">
				<form:select path="accountantCategory" class="input-xlarge required">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('accountant_category')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">账本分类：</label>
			<div class="controls">
				<form:select path="property" class="input-xlarge required">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('accountant_book_property')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<!--
		<div class="control-group">
			<label class="control-label">资产负债表分类：</label>
			<div class="controls">
				<form:input path="assetsCategory" htmlEscape="false" maxlength="125" class="input-xlarge "/>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">利润表分类：</label>
			<div class="controls">
				<form:input path="profitsCategory" htmlEscape="false" maxlength="125" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">会计科目版本（标准）：</label>
			<div class="controls">
				<form:input path="version" htmlEscape="false" maxlength="125" class="input-xlarge "/>
			</div>
		</div>-->

		<div class="control-group">
			<label class="control-label">末级账本：</label>
			<div class="controls">
				<form:radiobuttons path="finalStage" items="${fns:getDictList('yes_no')}"  itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">账本类型：</label>
			<div class="controls">
				<form:radiobuttons path="type" items="${fns:getDictList('accountant_type')}"  itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
			</div>
		</div>
		<!--
		<div class="control-group">
			<label class="control-label">当前状态：</label>
			<div class="controls">
				<form:input path="status" htmlEscape="false" maxlength="125" class="input-xlarge "/>
			</div>
		</div>
		-->
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="accountant:book:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>