<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>${article.title} - ${category.name}</title>
	<meta name="decorator" content="cms_default_${site.theme}"/>
	<meta name="description" content="${article.description} ${category.description}" />
	<meta name="keywords" content="${article.keywords} ${category.keywords}" />
	<script src="${ctxStatic}/jquery-validation/1.11.0/jquery.validate.method.js" type="text/javascript"></script>
	<script src="${ctxStatic}/web/tools/js/area.js" type="text/javascript"></script>
		<script type="text/javascript">
	
	$(document).ready(function() {

             var validator = $("#baseInfoForm").validate({
                 rules: {//验证规则
                	 userName: {
                         required: true,
                         userName: true,
                         remote: {//远端验证
                            url: '${ctx}/u/check_user_name_exists?rand='+Math.random(),
                            type: "get",
                            get:{
                            	userName:function (){
                            		return $("#userName").val().trim();
                            	}
                            }
                        }
                     },
                     realName: {
                         required: true,
                         realName: true,
                         minlength: 2
                     },
                     idCard: {
                         required: true,
                         card: true
                     },
                     email: {
                    	 required: true,
                    	 email : true,
                         remote: {//远端验证
                             url: '${ctx}/u/check_user_email_exists?rand='+Math.random(),
                             type: "get",
                             get:{
                            	 email:function (){
                             		return $("#email").val().trim();
                             	}
                             }
                         }
                     },
                     province: {
                    	 required: true,
                    	 province : true
                     },
                     city: {
                    	 required: true,
                    	 city:true
                     },
                     region: {
                    	 required: true,
                    	 region: true
                     },
                     address: {
                    	 required: true
                     }
                 },
                 messages: {//错误消息
                	 userName: {
                         required: "请输入用户名",
                         remote: "用户名已经存在"
                     },
                     realName: {
                         required: "请输入真实姓名"
                     },
                     idCard: {
                         required: "请输入身份证号",
                     },
                     email:{
                    	 remote: "邮箱已存在"
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
             // 省份
             jQuery.validator.addMethod("province", function(value, element) {
                 return this.optional(element) || (value != '省份');
             }, "请选择省份");
             jQuery.validator.addMethod("city", function(value, element) {
                 
                 return this.optional(element) || (value != '地级市');
             }, "请选择地级市");
             jQuery.validator.addMethod("region", function(value, element) {
                 
                 return this.optional(element) || (value != '市、县级市');
             }, "请选择市、县级市");

             //重置错误信息
             $("#reset").click(function() {
                 validator.resetForm();
             });

         });
	</script>
</head>
<body>
	<div class="row">
	<user:centerNav />
	   <div class="span10">
	     <div class="row">
	     <form:form modelAttribute="webUser" action="${ctx}/user/baseinfo/update" method="post" id="baseInfoForm" class="form-horizontal">
	       <sys:message content="${message}"/>		
	       <div class="span10">
			
					<div class="control-group">
						<label class="control-label">用户名：</label>
						<div class="controls">
						<input id="userName"  name="userName" value="${sessionScope.WEB_USER.userName }" autocomplete="false" type="text" htmlEscape="false" maxlength="20" class="input-xlarge required"/>
						<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">真实姓名：</label>
						<div class="controls">
						<input id="realName"  name="realName" value="${sessionScope.WEB_USER.realName }" autocomplete="false" type="text" htmlEscape="false" maxlength="20" class="input-xlarge required"/>
						<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">身份证号：</label>
						<div class="controls">
						<input id="idCard"  name="idCard" value="${sessionScope.WEB_USER.idCard }" autocomplete="false" type="text" htmlEscape="false" maxlength="20" class="input-xlarge required"/>
						<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">手机号：</label>
						<div class="controls">
						${sessionScope.WEB_USER.mobile }
						<span class="help-inline" style="padding-left: 255px;"> 不可修改</span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">邮箱：</label>
						<div class="controls">
						<input id="email"  name="email" value="${sessionScope.WEB_USER.email }" autocomplete="false" type="text" htmlEscape="false" maxlength="20" class="input-xlarge required"/>
						<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">性别：</label>
						<div class="controls">
						<form:radiobuttons path="sex" items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
						<span class="help-inline"><font color="red">*</font> </span>
						</div>
						
					</div>
					<div class="control-group">
						<label class="control-label">所在地：</label>
						<div class="controls">
						<span class="arealist">
                        <select id="s_province" name="province" class="input-small required"><option value="省份">省份</option></select>&nbsp;&nbsp;
					    <select id="s_city" name="city" class="input-small required"><option value="地级市">地级市</option></select>&nbsp;&nbsp;
					    <select id="s_county" name="region" class="input-small required"><option value="市、县级市">市、县级市</option></select>
					    <script type="text/javascript">
					    _init_area('${sessionScope.WEB_USER.province == ''? "省份":sessionScope.WEB_USER.province}',
					    		'${sessionScope.WEB_USER.city == ''? "地级市":sessionScope.WEB_USER.city}',
					    		'${sessionScope.WEB_USER.region == ''? "市、县级市":sessionScope.WEB_USER.region}'
					    		);
					    </script>
						<span class="help-inline"><font color="red">*</font> </span>
					</span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">地址：</label>
						<div class="controls">
						<input id="address"  name="address" value="${sessionScope.WEB_USER.address }" autocomplete="false" type="text" htmlEscape="false" maxlength="20" class="input-xlarge required"/>
						<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					<div class="control-group">
						<div class="controls">
						<span class="help-inline">温馨提示：提现时个人信息必须要填写完整。</span>
						</div>
					</div>
					
				<div class="form-actions">
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="修改信息"/>
				</div>
  	       </div>
  	       </form:form>
  	     </div>
  	  </div>
   </div>
</body>
</html>