<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>原始业务记录管理</title>
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
			$("#type").change(function(){
			    var typeVal = $(this).val();
			    if(typeVal == 'text'){
			        $("#voiceText").hide();
			        $("#fixedVoiceText").hide();
			        $("#textContext").show();
				}else if (typeVal == 'voice') {
                    $("#voiceText").show();
                    $("#fixedVoiceText").show();
                    $("#textContext").hide();
				}
			});
            $("#bizId").change(function(){
                var getBizBooksURL ="${ctx}/accountant/bookRecord/getBiz?bizId="+$(this).val();
                $.ajax({
                    url:getBizBooksURL,
                    dataType: 'json',
                    success:function(reponse){
                        //处理账本选择
                        console.log(reponse);
                        $('#text').val("");
                        var data = reponse.data;
                        $('#text').val(data);
                    }
                });
            });
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/accountant/source/">原始业务记录列表</a></li>
		<li class="active"><a href="${ctx}/accountant/source/form?id=${source.id}">原始业务记录<shiro:hasPermission name="accountant:source:edit">${not empty source.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="accountant:source:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="source" action="${ctx}/accountant/source/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">信息类型：</label>
			<div class="controls">
				<form:select path="type" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('accountant_source_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">业务：</label>
			<div class="controls">
				<form:select path="bizId" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${businesses}" itemLabel="name" itemValue="id" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group" id="textContext">
			<label class="control-label">文本信息：</label>
			<div class="controls">
				<form:textarea path="text" htmlEscape="false" rows="4" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group" id="voiceText">
			<label class="control-label">语音转换文本：</label>
			<div class="controls">
				<form:textarea path="voiceConvertText" htmlEscape="false" rows="4" readonly="true" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group" id="fixedVoiceText">
			<label class="control-label">语音修正文本：</label>
			<div class="controls">
				<form:textarea path="fixedVoiceConvertText" htmlEscape="false" rows="4" class="input-xxlarge "/>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">文件路径：</label>
			<div class="controls">
				<sys:ckfinder input="bookRecordAttachmentList_filesPath" type="images" uploadPath="/accountant" selectMultiple="true" maxWidth="100" maxHeight="100"/>
				<input id="bookRecordAttachmentList_filesPath" name="filesPath" type="hidden" value="" maxlength="200" class="input-small required"/>
			</div>
		</div>

		<div class="form-actions">
			<shiro:hasPermission name="accountant:source:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>