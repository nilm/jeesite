<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>账本记录管理</title>
<%-- <link href="${ctxStatic }/accountant/accountant.css" rel="stylesheet" type="text/css" /> --%>
<style type="text/css">
/* Table Head */
    table td{
	border: 1px solid #c5c5c5;
	}
	thead th {
	height: 36px;
    line-height: 36px;
    border: 1px solid #e9e9e9;
	background-color: #f8f9f8;
	color: #211f1f;
	border-bottom-width: 0;
	border-top: 2px solid #dd4b39;
	border-bottom: 1px solid #dd4b39;
	border-left:1px solid #dd4b39;
	border-right:1px solid #dd4b39;
	font-weight: bold;
	}
	/* Column Style */
	 td {
	color: #000;
	}
	/* Heading and Column Style */
	 tr, th {
		border-width: 1px;
		border-style: solid;
		border-color: rgb(81, 130, 187);
	}
	
	/* Padding and font style */
	 td, th {
		padding: 5px 10px;
		font-size: 12px;
		font-family: Verdana;
		font-weight: bold;
	} 
	input{
		border-width:0px;
		padding: 0px 0px;
	}
	.red {
    color: #fd583c;
	}
	.fb {
	    font-weight: bold;
	}
	#tfootbj {
	    background-color: #e9e9e9;
	    border: 1px solid #e9e9e9;
	    border-bottom: 1px solid #ca7e75;
	}
	.btn-control{
		border-color:#f9f9f9;
	}
</style>

<!-- Table goes in the document BODY -->

<meta name="decorator" content="default" />
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
	    	var bizId=$(this).val();
	    	if(bizId=''){
	    		return;
	    	}
	        var getBizBooksURL ="${ctx}/accountant/bookRecord/getBizBooks?biz.id="+$(this).val();
	        $.ajax({
	            url:getBizBooksURL,
	            dataType: 'json',
	            success:function(reponse){
	                //处理账本选择
	//                console.log(reponse);
	                $('#select_suject_content').html("");
	                var data = reponse.data;
	                var sum = data.length;
	                var result = '';
	                if(sum == "0"){
	                    result ='<p class="no_rankInfo">暂无账本数据~</p >';
	                    $('.more_wrap').hide();
	                }else{
	                    var  flag = false;
	//                    <select name='targetBookName'>
	                    var bookRecordDetailRowIdx = 0, bookRecordDetailTpl = $("#bookRecordDetailTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
	                    $("#bookRecordDetailList").html('');
	                    for(var i = 0; i < sum; i++){
	                        addRow('#bookRecordDetailList', bookRecordDetailRowIdx, bookRecordDetailTpl, data[i]);
	                        bookRecordDetailRowIdx = bookRecordDetailRowIdx + 1;
	
	                        if (data[i].fixed == "1" ){
	                            result += "定选<b>"+ data[i].bookName +"</b>";
	                            result +=  data[i].direction =="1" ?"增加 ; ":"减少 ; ";
	                        }else{
	                            result +="挑选<b>"+ data[i].bookName +"</b>"
	                            result += data[i].direction =="1" ?"增加 ; ":"减少 ; ";
	                        }
	                    }
	                    $(".digest").html($(this).val())
	//                        $('.select_suject').show();
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
		var length = $("#form tbody tr").length-3;
		if(length<=1){
			 alert("至少保留一行");
			 return;
		}
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
		<li class="active"><a
			href="${ctx}/accountant/bookRecord/accountForm?id=${bookRecord.id}">会计凭证<shiro:hasPermission
					name="accountant:bookRecord:edit">${not empty bookRecord.id?'修改':'添加'}</shiro:hasPermission>
				<shiro:lacksPermission name="accountant:bookRecord:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<br />
	
	<div id="dNewShowTitle"
		style="width: 100%; margin: 0px 0px 0px 0px; font-weight: bold; font-size: large; color: #666666; text-align: center;">
		会计凭证</div>
	<table class="tableComboBox" >
		<tbody><tr>
			<td style="display:none;"><a class="btn btn-primary" >首页</a></td>
			<td style="display:none;"><a class="btn btn-primary" >前页</a></td>
			<td style="display:none;"><a class="btn btn-primary" >下页</a></td>
			<td style="display:none;"><a class="btn btn-primary" >末页</a></td>
			<td class="btn-control"><a class="btn btn-primary" >查询</a></td>
			<td class="btn-control"><a class="btn btn-primary ">删除</a></td>
			<td class="btn-control"><a class="btn btn-primary " >增加</a></td>
			<td class="btn-control"><a class="btn btn-primary" >修改</a></td>
			<td class="btn-control"><a class="btn btn-primary" >保存</a></td>
			<td class="btn-control"><a class="btn btn-primary" >撤销</a></td>
			<td class="btn-control"><a class="btn btn-primary" >刷新</a></td>
			<td class="btn-control"><a class="btn btn-primary" >打印</a></td>
			<td class="btn-control"><a class="btn btn-primary" >关闭</a></td>
		</tr>
	</tbody></table>
	<br>
	<br>
	<form:form  id="inputForm" modelAttribute="bookRecord" method="post"
		action="${ctx}/accountant/bookRecord/save" >
		<div class="control-group" align="center">
			<div class="controls">
				记账时间： <input name="recordDate" type="text" readonly="readonly"
					maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${bookRecord.recordDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
			<div class="control-group" align="left">
			业务：<%-- <form:select path="bizId" class="input-xlarge required" >
					<form:option value="" label=""/>
					<form:options items="${businesses}" itemLabel="name" itemValue="id" htmlEscape="false"/>
				</form:select> --%>
				<select name="bizId" id="bizId" style="width: 200px;">
					<option value=""></option>
					<c:forEach items="${businesses}" var="biz">
						<option value="${biz.id}" >${biz.name}</option>
					</c:forEach>
				</select>
			</div>
			<table id="form">
				<!-- Replace "table-1" with any of the design numbers -->
				<thead>
					<th style="width: 20%;">摘要</th>
					<th style="width: 20%;">会计账本</th>
					<th style="width: 20%;">往来单位</th>
					<th style="width: 8%;">左方金额</th>
					<th style="width: 8%;">右方金额</th>
				</thead>
				<tbody id="bookRecordDetailList">
					<tr >
						<td><input name="digest" ></td>
						<td><input name="digest"></td>
						<td><input name="digest"></td>
						<td><input name="digest"></td>
						<td><input name="digest"></td>
					</tr>
				</tbody>
					<tr>
						<td align="center">附件:</td>
						<td ></td>
						<td align="center">合计:</td>
						<td ></td>
						<td ></td>
					</tr>
					<tr>
						<td align="center">备注:</td>
						<td colspan="5" ></td>
					</tr>
					<tr id="TableRow1" class="fb red t_left">
						<td id="tfootbj" class="fb red" colspan="5">
                        	&nbsp;<a id="addLine" class="red inline_block addRow" isreadonly="true" onclick="addRow('#bookRecordDetailList', bookRecordDetailRowIdx, bookRecordDetailTpl);bookRecordDetailRowIdx = bookRecordDetailRowIdx + 1;">+ 增行</a> &nbsp;
                            </td>
					</tr>
			</table>
			<script type="text/template" id="bookRecordDetailTpl">//<!--
						<tr id="bookRecordDetailList{{idx}}">
							<td class="hide">
								<input id="bookRecordDetailList{{idx}}_id" name="bookRecordDetailList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="bookRecordDetailList{{idx}}_delFlag" name="bookRecordDetailList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>
								<input id="bookRecordDetailList{{idx}}_digest" name="bookRecordDetailList[{{idx}}].digest" type="text" style="border-width:0px;" value="{{row.digest}}" />
							</td>
							<td>
						<sys:treeselect id="bookRecordDetailList{{idx}}_book" name="bookRecordDetailList[{{idx}}].bookId" value="{{row.bookId}}" labelName="bookName" labelValue="{{row.bookName}}"
					title="选择账本" url="/accountant/book/treeData" extId="bookRecordDetailList[{{idx}}]._bookId" cssClass="" allowClear="true"/>
							<shiro:hasPermission name="accountant:bookRecord:edit">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#bookRecordDetailList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</shiro:hasPermission>
							</td>
							<td>
								<input id="bookRecordDetailList{{idx}}_customer" name="bookRecordDetailList[{{idx}}].customer" type="text" value="{{row.customer}}" />
							</td>
							<td>
								<input id="bookRecordDetailList{{idx}}_leftAmount" name="bookRecordDetailList[{{idx}}].amount" type="text" value="{{row.amount}}" class="input-small required"/>
							</td>
							<td>
								<input id="bookRecordDetailList{{idx}}_rightAmount" name="bookRecordDetailList[{{idx}}].amount" type="text" value="{{row.amount}}" class="input-small required"/>
							</td>
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
	</form:form>
</body>
</html>