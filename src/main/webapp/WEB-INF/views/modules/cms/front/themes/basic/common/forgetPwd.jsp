<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>忘记密码</title>
	<meta name="decorator" content="cms_default_${site.theme}"/>
	<meta name="description" content="JeeSite ${site.description}" />
	<meta name="keywords" content="JeeSite ${site.keywords}" />
	
	<script type="text/javascript">
	
	$(document).ready(function() {

             var validator = $("#resetPwdForm").validate({
                 rules: {//验证规则
                	 mobile: {
                         required: true,
                         mobile: true/* ,
                         remote: {//远端验证
                            url: '${ctx}/u/check_user_exists?rand='+Math.random(),
                            type: "get",
                            get:{
                            	mobile:function (){
                            		return $("#mobile").val().trim();
                            	}
                            } 
                        }*/
                     },
                     password: {
                         required: true,
                         minlength: 6
                     },
                     newPassword: {
                         required: true,
                         minlength: 6,
                         equalTo: "#password"
                     }
                 },
                 messages: {//错误消息
                	 mobile: {
                         required:"请输入手机号",
                         mobile: "请输入正确的手机号",
                       //  remote: "手机号已经存在"
                     },
                     password: {
                         required: "请输入密码",
                         minlength: $.validator.format("密码不能小于{0}个字符")
                     },
                     newPassword: {
                         required: "请输入确认密码",
                         minlength:"确认密码不能小于6个字符",
                         equalTo: "两次输入密码不一致"
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
	
	function sendMobileCode(){
		var mobile =  $("#mobile").val().trim();
		if(validePhone(mobile)){
			$.get('${ctx}/common/sendVildateCode?phone='+mobile+'&reset=1&rand='+Math.random(),function (data){
				
				if(data.result == 0){
					$("#validateCode").val(data.valideCode);
				}else if(data.result == 0){
					alert("手机号已经存在!");
				}else if(data.result == 2){
					alert("请输入手机号!");
				}
			});
		}
	}
	function validePhone(sMobile){
		return (/^[1][3,4,5,7,8][0-9]{9}$/.test(sMobile));
	}
	</script>
	
</head>
<body>
    <div class="row">
      <div class="span10">
        <h4>忘记密码</h4>
        <form:form id="resetPwdForm" modelAttribute="webUser" action="${ctx}/u/resetPwd" method="post" class="form-horizontal">
				<sys:message content="${message}"/>		
				<div class="control-group">
					<label class="control-label">手机：</label>
					<div class="controls">
						<form:input path="mobile" htmlEscape="false" maxlength="100" class="input-large required"/>
						<input type="button" value="发送验证码" onclick="sendMobileCode();" class="btn"/>
						<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">验证码：</label>
						<div class="controls">
						<form:input path="validateCode" htmlEscape="false" maxlength="6" class="input-xlarge required"/>
						<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">密码：</label>
						<div class="controls">
							<form:input path="password" type="password" autocomplete="false"  htmlEscape="false" maxlength="100" class="input-xlarge required"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">重复密码：</label>
						<div class="controls">
							<form:input path="newPassword" type="password" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
		
				<div class="form-actions">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="提交"/>&nbsp;
				<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
			</div>
	</form:form>
      </div>

    </div>
</body>
</html>