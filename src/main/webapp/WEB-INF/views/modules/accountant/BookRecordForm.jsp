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
//                        console.log(reponse);
                        $('#select_suject_content').html("");
                        var data = reponse.data;
                        var sum = data.length;
                        var result = '';
                        if(sum == "0"){
                            result ='<p class="no_rankInfo">暂无账本数据~</p >';
                            $('.more_wrap').hide();
                        }else{
                            var  flag = false;
                            var  bookRecordDetailTpl = $("#bookRecordDetailTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
                            $("#bookRecordDetailList").html('');
                            bookRecordDetailRowIdx=0;
                            for(var i = 0; i < sum; i++){
                                addRow('#bookRecordDetailList', bookRecordDetailRowIdx, bookRecordDetailTpl, data[i]);
                                bookRecordDetailRowIdx = bookRecordDetailRowIdx + 1;
//console.log(bookRecordDetailRowIdx);
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
            $("#amount").blur(function(){
                var rowCount = $("#bookRecordDetailList").find("tr").size();
				console.log("=="+rowCount);
                for(var i = 0; i < rowCount; i++){
                    changeRowData('#bookRecordDetailList', i,"amount",$(this).val());
				}
			});
		});
		function changeRowData(list, idx,name,val) {
            $(list+idx+"_"+name).val(val);
        }
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
				<form:input path="amount" htmlEscape="false" class="input-xlarge required"/>
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
			<label class="control-label">摘要：</label>
			<div class="controls">
				<form:input path="digest" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>


		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>


		<div class="control-group" id="select_suject">
			<label class="control-label">账本选择说明：</label>
			<div class="controls" id="select_suject_content">

			</div>
		</div>
		<div class="control-group">
			<label class="control-label">账本记录明细表：</label>
			<div class="controls">
				<table id="contentTable" class="table table-striped table-bordered table-condensed">
					<thead>
					<tr>
						<th class="hide"></th>
						<th>账本</th>
						<th>金额</th>
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
								<input id="bookRecordDetailList{{idx}}_id" name="bookRecordDetailList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="bookRecordDetailList{{idx}}_delFlag" name="bookRecordDetailList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>
						<sys:treeselect id="bookRecordDetailList{{idx}}_book" name="bookRecordDetailList[{{idx}}].bookId" value="{{row.bookId}}" labelName="bookName" labelValue="{{row.bookName}}"
					title="选择账本" url="/accountant/book/treeData" extId="bookRecordDetailList[{{idx}}]._bookId" cssClass="" allowClear="true"/>
							</td>
							<td>
								<input id="bookRecordDetailList{{idx}}_amount" name="bookRecordDetailList[{{idx}}].amount" type="text" value="{{row.amount}}" class="input-small required"/>
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
                        console.log(data);
                        for (var i=0; i<data.length; i++){
                            addRow('#bookRecordDetailList', bookRecordDetailRowIdx, bookRecordDetailTpl, data[i]);
                            bookRecordDetailRowIdx = bookRecordDetailRowIdx + 1;
                        }
                    });
				</script>
			</div>
		</div>

			<div class="control-group">
				<label class="control-label">附件：</label>
				<div class="controls">
					<sys:ckfinder input="bookRecordAttachmentList_filesPath" type="images" uploadPath="/accountant" selectMultiple="true" maxWidth="100" maxHeight="100"/>
					<input id="bookRecordAttachmentList_filesPath" name="filesPath" type="hidden" value="" maxlength="200" class="input-small required"/>
				</div>
			</div>
		<div class="form-actions">
			<shiro:hasPermission name="accountant:bookRecord:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>