\<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>账本管理</title>
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
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
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
		<li><a href="${ctx}/accountant/book/listShow">账本列表</a></li>
		<li class="active"><a href="${ctx}/accountant/book/bookform?id=${menu.id}&parent.id=${menu.parent.id}">账本<shiro:hasPermission name="accountant:book:my:edit">${not empty menu.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="accountant:book:my:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="menu" action="${ctx}/accountant/book/savechild" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">上级账本:</label>
			<div class="controls">
                <sys:treeselect id="menu" name="parent.id" value="${menu.parent.id}" labelName="parent.name" labelValue="${menu.parent.name}"
					title="账本" url="/accountant/book/treeData" extId="${menu.id}" cssClass="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">账本名称:</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="50" class="required input-xlarge"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">辅助码:</label>
			<div class="controls">
				<form:input path="assistCode" htmlEscape="false" maxlength="50" class="required input-xlarge"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否末级账本:</label>
			<div class="controls">
				<form:radiobutton path="finalStage" value="1" />是 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<form:radiobutton path="finalStage" value="0"/>否
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		
		<div class="form-actions">
			<shiro:hasPermission name="accountant:book:my:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>