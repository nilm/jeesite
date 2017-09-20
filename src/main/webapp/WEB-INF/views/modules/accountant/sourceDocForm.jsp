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
			$("#bizId").change(function(){
			    var getBizSubjectsURL ="${ctx}/accountant/sourceDoc/getBizSubjects?biz.id="+$(this).val();
			    $.ajax({
                    url:getBizSubjectsURL,
                    dataType: 'json',
                        success:function(reponse){
                            //处理账本选择
                            console.log(reponse);
                            $('#select_suject_content').html("");
                            var data = reponse.data;
                            var sum = data.length;
                            var result = '';
                            if(sum == "0"){
                                result ='<p class="no_rankInfo">暂无账本数据~</p >';
                                $('.more_wrap').hide();
                            }else{
                                var  flag = false;
//                            <select name='targetSubjectName'>
                                var sourceDocSubjectRowIdx = 0, sourceDocSubjectTpl = $("#sourceDocSubjectTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
                                $("#sourceDocSubjectList").html('');
                                for(var i = 0; i < sum; i++){
                                    addRow('#sourceDocSubjectList', sourceDocSubjectRowIdx, sourceDocSubjectTpl, data[i]);
                                    sourceDocSubjectRowIdx = sourceDocSubjectRowIdx + 1;

                                    if (data[i].fixed == "1" ){
                                        result += "定选<b>"+ data[i].subjectName +"</b>";
                                        result +=  data[i].direction =="1" ?"增加 ; ":"减少 ; ";
									}else{
                                        result +="挑选<b>"+ data[i].subjectName +"</b>"
                                        result += data[i].direction =="1" ?"增加 ; ":"减少 ; ";
									}
                                }
//                                $('.select_suject').show();
                            }
                            $('#select_suject_content').append(result);
                        }
				});
				});
		});
		function addRow(list, idx, tpl, row){
			$(list).append(Mustache.render(tpl, {
				idx: idx, delBtn: true, row: row
			}));
			$(list+idx).find("select").each(function(){
				$(this).val($(this).attr("data-value"));
			});
			$(list+idx).find("input[type='checkbox'], input[type='radio']").each(function(){
				var ss = $(this).attr("data-value").split(',');
				for (var i=0; i<ss.length; i++){
					if($(this).val() == ss[i]){
						$(this).attr("checked","checked");
					}
				}
			});
		}
		function delRow(obj, prefix){
			var id = $(prefix+"_id");
			var delFlag = $(prefix+"_delFlag");
			if (id.val() == ""){
				$(obj).parent().parent().remove();
			}else if(delFlag.val() == "0"){
				delFlag.val("1");
				$(obj).html("&divide;").attr("title", "撤销删除");
				$(obj).parent().parent().addClass("error");
			}else if(delFlag.val() == "1"){
				delFlag.val("0");
				$(obj).html("&times;").attr("title", "删除");
				$(obj).parent().parent().removeClass("error");
			}
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/accountant/sourceDoc/">原始业务记录列表</a></li>
		<li class="active"><a href="${ctx}/accountant/sourceDoc/form?id=${sourceDoc.id}">原始业务记录<shiro:hasPermission name="accountant:sourceDoc:edit">${not empty sourceDoc.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="accountant:sourceDoc:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="sourceDoc" action="${ctx}/accountant/sourceDoc/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<!--
		<div class="control-group">
			<label class="control-label">用户id：</label>
			<div class="controls">
				<sys:treeselect id="user" name="user.id" value="${sourceDoc.user.id}" labelName="user.name" labelValue="${sourceDoc.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">公司id：</label>
			<div class="controls">
				<sys:treeselect id="company" name="company.id" value="${sourceDoc.company.id}" labelName="company.name" labelValue="${sourceDoc.company.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		-->
		<div class="control-group">
			<label class="control-label">时间：</label>
			<div class="controls">
				<input name="recordDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					   value="<fmt:formatDate value="${sourceDoc.recordDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">业务(摘要)：</label>
			<div class="controls">
				<form:select path="bizId" class="input-xlarge required">
					<form:option value="" label=""/>
					<form:options items="${businesses}" itemLabel="name" itemValue="id" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">金额：</label>
			<div class="controls">
				<form:input path="money" htmlEscape="false" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">附件数：</label>
			<div class="controls">
				<form:input path="attachmentCount" htmlEscape="false" maxlength="128" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">账户类型：</label>
			<div class="controls">
				<form:select path="accountType" class="input-xlarge required">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('accountant_soucre_doc_account_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">摘要：</label>
			<div class="controls">
				<form:input path="digest" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>


		<!--
		<div class="control-group">
			<label class="control-label">当前状态：</label>
			<div class="controls">
				<form:radiobuttons path="status" items="${fns:getDictList('accountant_soucre_doc_status')}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">分配时间：</label>
			<div class="controls">
				<input name="assignDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${sourceDoc.assignDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">处理人：</label>
			<div class="controls">
				<form:input path="accountantUserId" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">处理时间：</label>
			<div class="controls">
				<input name="handleDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${sourceDoc.handleDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		-->

		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
			<div class="control-group">
				<label class="control-label">原始业务记录附件：</label>
				<div class="controls">
					<sys:ckfinder input="sourceDocAttachmentList_filesPath" type="images" uploadPath="/accountant" selectMultiple="true" maxWidth="100" maxHeight="100"/>
					<input id="sourceDocAttachmentList_filesPath" name="filesPath" type="hidden" value="" maxlength="200" class="input-small required"/>
				</div>
			</div>
			<div class="control-group" id="select_suject">
				<label class="control-label">账本选择：</label>
				<div class="controls" id="select_suject_content">

				</div>
			</div>
			<div class="control-group">
				<label class="control-label">原账本选择：</label>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th class="hide"></th>
								<th>账本</th>
								<th>金额</th>
								<shiro:hasPermission name="accountant:sourceDoc:edit"><th width="10">&nbsp;</th></shiro:hasPermission>
							</tr>
						</thead>
						<tbody id="sourceDocSubjectList">
						</tbody>
						<shiro:hasPermission name="accountant:sourceDoc:edit"><tfoot>
							<tr><td colspan="6"><a href="javascript:" onclick="addRow('#sourceDocSubjectList', sourceDocSubjectRowIdx, sourceDocSubjectTpl);sourceDocSubjectRowIdx = sourceDocSubjectRowIdx + 1;" class="btn">新增</a></td></tr>
						</tfoot></shiro:hasPermission>
					</table>
					<script type="text/template" id="sourceDocSubjectTpl">//<!--
						<tr id="sourceDocSubjectList{{idx}}">
							<td class="hide">
								<input id="sourceDocSubjectList{{idx}}_id" name="sourceDocSubjectList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="sourceDocSubjectList{{idx}}_delFlag" name="sourceDocSubjectList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>
								<sys:treeselect id="sourceDocSubjectList{{idx}}_subject" name="sourceDocSubjectList[{{idx}}].subjectId" value="{{row.subjectId}}" labelName="subjectName" labelValue="{{row.subjectName}}"
					title="选择账本" url="/accountant/book/treeData" extId="sourceDocSubjectList[{{idx}}]._subjectId" cssClass="" allowClear="true"/>
							</td>
							<td>
								<input id="sourceDocSubjectList{{idx}}_amount" name="sourceDocSubjectList[{{idx}}].amount" rows="4" maxlength="255" class="input-small ">{{row.amount}}</textarea>
							</td>
							<shiro:hasPermission name="accountant:sourceDoc:edit"><td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#sourceDocSubjectList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td></shiro:hasPermission>
						</tr>//-->
					</script>
					<script type="text/javascript">
						var sourceDocSubjectRowIdx = 0, sourceDocSubjectTpl = $("#sourceDocSubjectTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						$(document).ready(function() {
							var data = ${fns:toJson(sourceDoc.sourceDocSubjectList)};
							for (var i=0; i<data.length; i++){
								addRow('#sourceDocSubjectList', sourceDocSubjectRowIdx, sourceDocSubjectTpl, data[i]);
								sourceDocSubjectRowIdx = sourceDocSubjectRowIdx + 1;
							}
						});
					</script>
				</div>
			</div>
		<div class="form-actions">
			<shiro:hasPermission name="accountant:sourceDoc:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>