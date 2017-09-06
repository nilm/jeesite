<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>提现申请管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
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
			$("#failSubmit").click(function (){
				$("#action").val("fail");
				$("#inputForm").submit();
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/account/cashout/">提现申请列表</a></li>
		<li class="active"><a href="${ctx}/account/cashout/${targetAction}/toAudit?id=${cashout.id}">提现处理为
		${fns:getDictLabel(targetAction, 'base_audit_status', '')}
		</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cashout" action="${ctx}/account/cashout/audit" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<input type="hidden" id="action" name="action" value="${targetAction}"> 
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">前台用户：</label>
			<div class="controls">
			${cashout.webUser.userName}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">真实姓名：</label>
			<div class="controls">
			${cashout.webUser.realName}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">提现金额：</label>
			<div class="controls">
				<form:input path="applyAmount" htmlEscape="false" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">提现费用：</label>
			<div class="controls">
				<form:input path="cashoutFee" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">提现到账类型：</label>
			<div class="controls">
				${fns:getDictLabel(cashout.cardType, 'account_cashout_card_type', '')}
			</div>
		</div>
		<c:choose>
				<c:when test="${cashout.cardType =='bank' }">
					<div class="control-group">
						<label class="control-label">
						银行卡号：</label>
						<div class="controls">
							${cashout.bankNo}
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">
						提现银行：</label>
						<div class="controls">
							${cashout.bankName}
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">
						支行：</label>
						<div class="controls">
							${cashout.bankBranchName}
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="control-group">
						<label class="control-label">
						支付宝账号：</label>
						<div class="controls">
							${cashout.alipayNo}
						</div>
					</div>
					
				</c:otherwise>
		</c:choose>
		
		<div class="control-group">
			<label class="control-label">申请ip：</label>
			<div class="controls">
				${cashout.applyIp }
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">当前状态：</label>
			<div class="controls" style="color: red;">
				${fns:getDictLabel(cashout.status, 'base_audit_status', '')}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">处理状态为：</label>
			<div class="controls" style="color: green;">
				${fns:getDictLabel(targetAction, 'base_audit_status', '')}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">描述：</label>
			<div class="controls">
				<form:textarea path="content" htmlEscape="false" rows="4" maxlength="2000" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<input id="failSubmit" class="btn btn-primary" type="button" value="不通过"/>&nbsp;
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="通过"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>