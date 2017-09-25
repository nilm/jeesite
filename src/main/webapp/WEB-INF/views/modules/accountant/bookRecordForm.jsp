<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>账本记录管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript" src="${ctx}/static/accountant/accountant.css" charset="GBK"></script>
	
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
//                            <select name='targetBookName'>
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
	<div id="dNewShowTitle" style="width: 100%; margin: 0px 0px 0px 0px; font-weight: bold; font-size: large; color: #666666; text-align: center;">
                会计凭证
     </div><br><br>
     <form name="save" method="post" action="${ctx}/accountant/bookRecord/save" id="save">
	    <div class="control-group" align="center">
			<div class="controls" >
				记账时间：
				<input name="recordDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${bookRecord.recordDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
			<div class="divFormLineBox">
				<table>
					<thead>
						<tr id="TableRow2">
							<th id="TableHeaderCell1" style="width:20%;">摘要</th><th id="TableHeaderCell2" ondblclick="fun_GetTree(this, 'km1')" style="width:20%;">会计科目</th><th id="TableHeaderCell6" style="width:20%;">往来单位</th><th id="TableHeaderCell4" style="width:8%;">借方金额</th><th id="TableHeaderCell5" style="width:8%;">贷方金额</th>
						</tr>
						<tr></tr><tr></tr><tr></tr><tr></tr><tr></tr>
					</thead>
				</table>
			</div>
		</div>
	</form>
</body>
</html>