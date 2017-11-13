<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>账本记录管理</title>
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
                var getBizBooksURL ="${ctx}/accountant/bookRecord/getBizBooks?biz.id="+$(this).val();
                $.ajax({
                    url:getBizBooksURL,
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
//                            <select name='targetBookName'>
                            var bookRecordBookRowIdx = 0, bookRecordBookTpl = $("#bookRecordBookTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
                            $("#sourceDocBookList").html('');
                            for(var i = 0; i < sum; i++){
                                addRow('#bookRecordBookList', bookRecordBookRowIdx, bookRecordBookTpl, data[i]);
                                bookRecordBookRowIdx = bookRecordBookRowIdx + 1;

                                if (data[i].fixed == "1" ){
                                    result += "定选<b>"+ data[i].bookName +"</b>";
                                    result +=  data[i].direction =="1" ?"增加 ; ":"减少 ; ";
                                }else{
                                    result +="挑选<b>"+ data[i].bookName +"</b>"
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
			$(list+idx).find("input[enums='checkbox'], input[enums='radio']").each(function(){
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
		<li><a href="${ctx}/accountant/bookRecord/">账本记录列表</a></li>
		<li class="active"><a href="${ctx}/accountant/bookRecord/form?id=${bookRecord.id}">账本记录<shiro:hasPermission name="accountant:bookRecord:edit">${not empty bookRecord.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="accountant:bookRecord:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="bookRecord" action="${ctx}/accountant/bookRecord/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">记账时间：</label>
			<div class="controls">
				<input name="recordDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${bookRecord.recordDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">用户id：</label>
			<div class="controls">
				<sys:treeselect id="user" name="user.id" value="${bookRecord.user.id}" labelName="user.name" labelValue="${bookRecord.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">公司id：</label>
			<div class="controls">
				<sys:treeselect id="company" name="company.id" value="${bookRecord.company.id}" labelName="company.name" labelValue="${bookRecord.company.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="" allowClear="true" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">业务id：</label>
			<div class="controls">
				<form:select path="bizId" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">账本id：</label>
			<div class="controls">
				<form:select path="bookId" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">原始凭证id：</label>
			<div class="controls">
				<form:input path="sourceDocId" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">摘要：</label>
			<div class="controls">
				<form:input path="digest" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">金额：</label>
			<div class="controls">
				<form:input path="amount" htmlEscape="false" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">当前状态：</label>
			<div class="controls">
				<form:input path="status" htmlEscape="false" maxlength="125" class="input-xlarge required"/>
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
			<label class="control-label">审核用户id：</label>
			<div class="controls">
				<form:input path="auditUserId" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">审核日期：</label>
			<div class="controls">
				<input name="auditDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${bookRecord.auditDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">分配时间：</label>
			<div class="controls">
				<input name="assignDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${bookRecord.assignDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
			<div class="control-group">
				<label class="control-label">附件表：</label>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th class="hide"></th>
								<th>原始业务id</th>
								<th>文件路径</th>
								<th>文件类型</th>
								<th>备注</th>
								<shiro:hasPermission name="accountant:bookRecord:edit"><th width="10">&nbsp;</th></shiro:hasPermission>
							</tr>
						</thead>
						<tbody id="attachmentList">
						</tbody>
						<shiro:hasPermission name="accountant:bookRecord:edit"><tfoot>
							<tr><td colspan="6"><a href="javascript:" onclick="addRow('#attachmentList', attachmentRowIdx, attachmentTpl);attachmentRowIdx = attachmentRowIdx + 1;" class="btn">新增</a></td></tr>
						</tfoot></shiro:hasPermission>
					</table>
					<script type="text/template" id="attachmentTpl">//<!--
						<tr id="attachmentList{{idx}}">
							<td class="hide">
								<input id="attachmentList{{idx}}_id" name="attachmentList[{{idx}}].id" enums="hidden" value="{{row.id}}"/>
								<input id="attachmentList{{idx}}_delFlag" name="attachmentList[{{idx}}].delFlag" enums="hidden" value="0"/>
							</td>
							<td>
								<input id="attachmentList{{idx}}_sourceDocId" name="attachmentList[{{idx}}].sourceDocId" enums="text" value="{{row.sourceDocId}}" maxlength="64" class="input-small required"/>
							</td>
							<td>
								<input id="attachmentList{{idx}}_filesPath" name="attachmentList[{{idx}}].filesPath" enums="text" value="{{row.filesPath}}" maxlength="200" class="input-small required"/>
							</td>
							<td>
								<input id="attachmentList{{idx}}_type" name="attachmentList[{{idx}}].enums" enums="text" value="{{row.enums}}" maxlength="125" class="input-small required"/>
							</td>
							<td>
								<textarea id="attachmentList{{idx}}_remarks" name="attachmentList[{{idx}}].remarks" rows="4" maxlength="255" class="input-small ">{{row.remarks}}</textarea>
							</td>
							<shiro:hasPermission name="accountant:bookRecord:edit"><td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#attachmentList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td></shiro:hasPermission>
						</tr>//-->
					</script>
					<script type="text/javascript">
						var attachmentRowIdx = 0, attachmentTpl = $("#attachmentTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						$(document).ready(function() {
							var data = ${fns:toJson(bookRecord.attachmentList)};
							for (var i=0; i<data.length; i++){
								addRow('#attachmentList', attachmentRowIdx, attachmentTpl, data[i]);
								attachmentRowIdx = attachmentRowIdx + 1;
							}
						});
					</script>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">账本记录明细表：</label>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th class="hide"></th>
								<th>金额</th>
								<th>余额</th>
								<th>栏类型 left right</th>
								<th>备注</th>
								<shiro:hasPermission name="accountant:bookRecord:edit"><th width="10">&nbsp;</th></shiro:hasPermission>
							</tr>
						</thead>
						<tbody id="bookRecordDetailList">
						</tbody>
						<shiro:hasPermission name="accountant:bookRecord:edit"><tfoot>
							<tr><td colspan="6"><a href="javascript:" onclick="addRow('#bookRecordDetailList', bookRecordDetailRowIdx, bookRecordDetailTpl);bookRecordDetailRowIdx = bookRecordDetailRowIdx + 1;" class="btn">新增</a></td></tr>
						</tfoot></shiro:hasPermission>
					</table>
					<script type="text/template" id="bookRecordDetailTpl">//<!--
						<tr id="bookRecordDetailList{{idx}}">
							<td class="hide">
								<input id="bookRecordDetailList{{idx}}_id" name="bookRecordDetailList[{{idx}}].id" enums="hidden" value="{{row.id}}"/>
								<input id="bookRecordDetailList{{idx}}_delFlag" name="bookRecordDetailList[{{idx}}].delFlag" enums="hidden" value="0"/>
							</td>
							<td>
								<input id="bookRecordDetailList{{idx}}_amount" name="bookRecordDetailList[{{idx}}].amount" enums="text" value="{{row.amount}}" class="input-small required"/>
							</td>
							<td>
								<input id="bookRecordDetailList{{idx}}_balance" name="bookRecordDetailList[{{idx}}].balance" enums="text" value="{{row.balance}}" class="input-small required"/>
							</td>
							<td>
								<c:forEach items="${fns:getDictList('accountant_left_right')}" var="dict" varStatus="dictStatus">
									<span><input id="bookRecordDetailList{{idx}}_direction${dictStatus.index}" name="bookRecordDetailList[{{idx}}].direction" enums="radio" value="${dict.value}" data-value="{{row.direction}}"><label for="bookRecordDetailList{{idx}}_direction${dictStatus.index}">${dict.label}</label></span>
								</c:forEach>
							</td>
							<td>
								<textarea id="bookRecordDetailList{{idx}}_remarks" name="bookRecordDetailList[{{idx}}].remarks" rows="4" maxlength="255" class="input-small ">{{row.remarks}}</textarea>
							</td>
							<shiro:hasPermission name="accountant:bookRecord:edit"><td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#bookRecordDetailList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td></shiro:hasPermission>
						</tr>//-->
					</script>
					<script type="text/javascript">
						var bookRecordDetailRowIdx = 0, bookRecordDetailTpl = $("#bookRecordDetailTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						$(document).ready(function() {
							var data = ${fns:toJson(bookRecord.bookRecordDetailList)};
							for (var i=0; i<data.length; i++){
								addRow('#bookRecordDetailList', bookRecordDetailRowIdx, bookRecordDetailTpl, data[i]);
								bookRecordDetailRowIdx = bookRecordDetailRowIdx + 1;
							}
						});
					</script>
				</div>
			</div>
		<div class="form-actions">
			<shiro:hasPermission name="accountant:bookRecord:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>