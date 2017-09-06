<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>登录</title>
	<meta name="decorator" content="cms_default_${site.theme}"/>
	<meta name="description" content="JeeSite ${site.description}" />
	<meta name="keywords" content="JeeSite ${site.keywords}" />
		
	<script type="text/javascript">
	
	$(document).ready(function() {

             var validator = $("#loginForm").validate({
                 rules: {//验证规则
                	 mobile: {
                         required: true,
                         mobile: true
                     },
                     password: {
                         required: true,
                         minlength: 6
                     }
                 },
                 messages: {//错误消息
                	 mobile: {
                         required: "请输入手机号",
                         mobile: "请输入正确的手机号",
                         remote: "手机号已经存在"
                     },
                     password: {
                         required: "请输入密码",
                         minlength: $.validator.format("密码不能小于{0}个字符")
                     }
                 },
 				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				},
                 submitHandler: function(form) {//处理程序
                     //alert("submitted");
                     form.submit();
                 }
                 
             });
          // 手机号码验证
             jQuery.validator.addMethod("mobile", function(value, element) {
                 var length = value.length;
                 return this.optional(element) || (length == 11 && /^[1][3,4,5,7,8][0-9]{9}$/.test(value));
             }, "请正确填写您的手机号码");
             //重置错误信息
             $("#reset").click(function() {
                 validator.resetForm();
             });

         });
	
	function validePhone(sMobile){
		return (/^[1][3,4,5,7,8][0-9]{9}$/.test(sMobile));
	}
	</script>
</head>
<body>
    <div class="row">
        <h4>用户登录</h4>
        <form:form id="loginForm" modelAttribute="webUser" action="${ctx}/u/login" method="post" class="form-horizontal">
				<sys:message content="${message}"/>		
				<input type="hidden" name="last_url" value="${redirectUrl }"/>
					<input type="hidden" name="wxId" value="${openId }" />
				<div class="control-group">
					<label class="control-label">手机：</label>
					<div class="controls">
						<form:input path="mobile" htmlEscape="false" maxlength="100" value="13311319862" class="input-xlarge required"/>
						<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">密码：</label>
						<div class="controls">
							<form:input path="password" autocomplete="false" type="password"  value="456123" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
		
				<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="登录"/>
			<input id="btn" class="btn" type="button" value="注册" onclick="location.href='${ctx}/u/register'"/>
			<a href="${ctx}/u/forgetPwd">忘记密码？</a>
			
		</div>
	</form:form>
    </div>
</body>
</html>