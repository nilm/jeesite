<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>会计业务管理</title>
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
		<li><a href="${ctx}/accountant/business/">会计业务列表</a></li>
		<li class="active"><a href="${ctx}/accountant/business/form?id=${business.id}">会计业务<shiro:hasPermission name="accountant:business:edit">${not empty business.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="accountant:business:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="business" action="${ctx}/accountant/business/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">业务名称：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="125" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">业务类型：</label>
			<div class="controls">
				<form:radiobuttons path="bizType" items="${fns:getDictList('accountant_biz_type')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">排序：</label>
			<div class="controls">
				<form:input path="sort" htmlEscape="false" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">显示否：</label>
			<div class="controls">
				<form:radiobuttons path="showHide" items="${fns:getDictList('show_hide')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
			<div class="control-group">
				<label class="control-label">业务栏目模板表：</label>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th class="hide"></th>
								<th>账本名称</th>
								<th>左（借）</th>
								<th>右（贷）</th>
								<th>定选否</th>
								<th>使用次数</th>
								<th>备注</th>
								<shiro:hasPermission name="accountant:business:edit"><th width="10">&nbsp;</th></shiro:hasPermission>
							</tr>
						</thead>
						<tbody id="bizBookTemplateList">
						</tbody>
						<shiro:hasPermission name="accountant:business:edit"><tfoot>
						<script type="text/template" id="bizBookTemplateTpl">//<!--
						<tr id="bizBookTemplateList{{idx}}">
							<td class="hide">
								<input id="bizBookTemplateList{{idx}}_id" name="bizBookTemplateList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="bizBookTemplateList{{idx}}_delFlag" name="bizBookTemplateList[{{idx}}].delFlag" type="hidden" value="0"/>

							</td>
							<td>
							<sys:treeselect id="bizBookTemplateList{{idx}}_bookId" name="bizBookTemplateList[{{idx}}].book.id" value="{{row.book.id}}" labelName="bookName" labelValue="{{row.bookName}}"
					title="选择账本" url="/accountant/book/treeData" extId="bizBookTemplateList[{{idx}}].book.id}" cssClass="" allowClear="true"/>
							<%--<sys:treeselect id="bookRecordDetailList{{idx}}_book" name="bookRecordDetailList[{{idx}}].bookId" value="{{row.bookId}}" labelName="bookName" labelValue="{{row.bookName}}"--%>
								<%--title="选择账本" url="/accountant/book/treeData" extId="bookRecordDetailList[{{idx}}]._bookId" cssClass="" allowClear="true"/>--%>
							<%--</td>--%>

							<td>
							<c:forEach items="${fns:getDictList('accountant_biz_plus_minus')}" var="dict" varStatus="dictStatus">
									<span><input id="bizBookTemplateList{{idx}}_lrDirection${dictStatus.index}" name="bizBookTemplateList[{{idx}}].lrDirection" type="radio" value="left_${dict.value}" data-value="{{row.lrDirection}}"><label for="bizBookTemplateList{{idx}}_lrDirection${dictStatus.index}">${dict.label}</label></span>
								</c:forEach>
							</td>
							<td>
							<c:forEach items="${fns:getDictList('accountant_biz_plus_minus')}" var="dict" varStatus="dictStatus">
									<span><input id="bizBookTemplateList{{idx}}_lrDirection${dictStatus.index}" name="bizBookTemplateList[{{idx}}].lrDirection" type="radio" value="right_${dict.value}" data-value="{{row.lrDirection}}"><label for="bizBookTemplateList{{idx}}_lrDirection${dictStatus.index}">${dict.label}</label></span>
								</c:forEach>
							</td>
							<td>
								<c:forEach items="${fns:getDictList('yes_no')}" var="dict" varStatus="dictStatus">
									<span><input id="bizBookTemplateList{{idx}}_fixed${dictStatus.index}" name="bizBookTemplateList[{{idx}}].fixed" type="radio" value="${dict.value}" data-value="{{row.fixed}}"><label for="bizBookTemplateList{{idx}}_fixed${dictStatus.index}">${dict.label}</label></span>
								</c:forEach>
							</td>
							<td>
								<input id="bizBookTemplateList{{idx}}_useCount" name="bizBookTemplateList[{{idx}}].useCount" type="text" value="{{row.useCount}}" maxlength="64" class="input-small "/>
							</td>
							<td>
								<textarea id="bizBookTemplateList{{idx}}_remarks" name="bizBookTemplateList[{{idx}}].remarks" rows="4" maxlength="255" class="input-small ">{{row.remarks}}</textarea>
							</td>
							<shiro:hasPermission name="accountant:business:edit"><td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#bizBookTemplateList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td></shiro:hasPermission>
						</tr>//-->
						</script>
						<tr><td colspan="8"><a href="javascript:" onclick="addRow('#bizBookTemplateList', bizBookTemplateRowIdx, bizBookTemplateTpl);bizBookTemplateRowIdx = bizBookTemplateRowIdx + 1;" class="btn">新增</a></td></tr>
						</tfoot></shiro:hasPermission>
					</table>
					<script type="text/javascript">
						var bizBookTemplateRowIdx = 0, bizBookTemplateTpl = $("#bizBookTemplateTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						$(document).ready(function() {
							var data = ${fns:toJson(business.bizBookTemplateList)};
							for (var i=0; i<data.length; i++){
								addRow('#bizBookTemplateList', bizBookTemplateRowIdx, bizBookTemplateTpl, data[i]);
								bizBookTemplateRowIdx = bizBookTemplateRowIdx + 1;
							}
						});
					</script>
				</div>
			</div>
		<div class="form-actions">
			<shiro:hasPermission name="accountant:business:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>