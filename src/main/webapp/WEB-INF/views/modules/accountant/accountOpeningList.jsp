<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>账本记录管理</title>
<%-- <link href="${ctxStatic }/accountant/accountant.css" rel="stylesheet" enums="text/css" /> --%>
<style type="text/css">
table{width:95%; border-collapse:collapse; border:1px solid #c5c5c5; }
table th{color:#211f1f; border:1px solid #c5c5c5; background-color:#f8f9f8; }
td,
th{font-family:Verdana; font-size:12px; font-weight:bold; line-height:36px; position:relative; }
td{color:#000; border:1px solid #c5c5c5;}
input{padding:0 0; border-width:0; }
.red{color:#fd583c; }
.fb{font-weight:bold; }
.btn-control{border-color:#f9f9f9; }
#addLine:before{position:absolute; margin:0 0 0 -12px; content:"+"; }
.post_mao:after{position:absolute; content:":"; }
#form input[type="text"]{line-height:36px; width:100%; height:36px; margin:0 0 0 0; padding:0; border:0 none;outline:0 none;-webkit-box-shadow:none;-moz-box-shadow:none;-box-shadow:none;  text-indent:8px;}
#form input.input-small{width:50%;}
#form .input-append{    display: block;    margin: 0 72px 0 0;}
#form .input-append input[type="text"]{background:none;}
 #form .input-append .btn:last-child{    width: 34px;    height: 34px;    line-height: 34px;    padding: 0;}
 .ml-8{margin:0 0 0 8px;}
.close,
.close:hover{   line-height: 36px;    width: 36px;    text-align: center;    background: #f00;    color: #fff;    font-weight: normal; opacity:1;    filter: alpha(opacity=100);margin:-36px 0 0 0;}
#form label.error{background-position: 0 center;line-height: 36px;}
</style>

<!-- Table goes in the document BODY -->

<meta name="decorator" content="default" />
<script type="text/javascript">
	
	$(document).ready(function() {
		var idStr=$("#id").val();
		var id=parseInt(idStr);
	    if(isNaN(id)){
		    initTable();
	    }
		$(document).on('keyup', 'input', function(){
            console.log($(this).val());
			var _index = $(this).parent().index();
			var tempTotal = 0, rowNum = $('#form tr').size()-3;
			$('#form tr').each(function(item, index){
				if(item !== 0 && item < rowNum && item > 1){
                    var currentNum = $(index).find('td').eq(_index).find('input').val();
                    currentNum = currentNum === ''?0:currentNum;
					tempTotal += parseFloat(currentNum);
				}
				
			});
			console.log(tempTotal);
			document.getElementById("sum"+(_index-1)).innerHTML = tempTotal.toFixed(2);
		});
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
	    	if(bizId==""){
	    		initTable();
	    		return;
	    	}
	        initFirstSelectItem($(this).val());
	    });
	    $("#saveBtn").click(function(){
	    	var sum1=parseFloat($("#sum1").text());
	    	var sum2=parseFloat($("#sum2").text());
	    	if(sum1==0 && sum2==0){
                alert("没有录入金额，请检查核对！");
			}else {
                if(sum1==sum2){
                    document.getElementById("amount").value=sum1+"";
                    $("#inputForm").submit();
                }else{
                    alert("左右金额总额不相等，请检查平衡！");
                }
            }
	    });
	    //alert($("#bizId").val());
        if(isNaN(id)){
        	initFirstSelectItem($("#bizId").val());
        }
	});
	function calcu(){
	    debugger;
		var amount=$("#amount").val();
		if(amount=="") amount=parseFloat(0.00).toFixed(2) ;
		document.getElementById("sum1").innerHTML = amount;
		document.getElementById("sum2").innerHTML = amount;
	} 
	function initTable() {
		clearTable();
		$("#addBtn").click();
		$("#addBtn").click();
		$("#addBtn").click();
		$("#addBtn").click();
	}
	function clearTable() {
		var  flag = false;
	    var bookRecordDetailRowIdx = 0, bookRecordDetailTpl = $("#bookRecordDetailTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
	    $("#bookRecordDetailList").html('');
	}
	
	function changeRowData(list, idx,name,val) {
	    $(list+idx+"_"+name).val(val);
	}
	function viewRow(list, idx, tpl, row){
		$(list).append(Mustache.render(tpl, {
			idx: idx, delBtn: true, row: row, direction:(row.book.category=='left')
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

	function initFirstSelectItem(selectValue){
    	var getBizBooksURL ="${ctx}/accountant/bookRecord/getBizBooks?biz.id="+selectValue;
    	$.ajax({
            url:getBizBooksURL,
            dataType: 'json',
            success:function(reponse){
                //处理账本选择
//              console.log(reponse);
                clearTable();
                $('#select_suject_content').html("");
                var data = reponse.data;
                if(typeof(data)=="undefined"){
                    result ='<p class="no_rankInfo">暂无账本数据~</p >';
                    $('.more_wrap').hide();
                }else{
               	    var sum = data.length;
                    var result = '';
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
                }
                $('#select_suject_content').append(result);
                var length = $("#form tbody tr").length-3;
                if(length<4){
                	num=4-length;
                	 for(var i = 0; i < num; i++){
                		 $("#addBtn").click();
                	 }
                }
            }
        });
    }
</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/accountant/opening/">期初预览</a></li>
		<li ><a
				href="${ctx}/accountant/opening/form?id=${bookRecord.id}">期初<shiro:hasPermission
				name="accountant:bookRecord:edit">${not empty bookRecord.id?'修改':'添加'}</shiro:hasPermission>
			<shiro:lacksPermission name="accountant:bookRecord:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<br />
	
	<div id="dNewShowTitle"
		style="width: 100%; margin: 0px 0px 0px 0px; font-weight: bold; font-size: large; color: #666666; text-align: center;">
		科目期初</div>
	<br>
	<br>
	<form:form  id="inputForm" modelAttribute="bookRecord" action="${ctx}/accountant/opening/save" method="post"  class="form-horizontal">
		<input type="hidden" id="id" name="id" value="${bookRecord.id }">
		<input id="amount" type="hidden" value="${bookRecord.amount }" name="amount" >
		<sys:message content="${message}"/>	
		<div class="control-group" >
			<div id="dNewShowTitle"
				style="width: 100%; margin: 0px 0px 0px 0px; font-weight: bold; font-size: large; color: #666666; text-align: center;">
				记录时间： <input name="recordDate" type="text" readonly="readonly" style="align-self: center;"
					maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${bookRecord.recordDate}" pattern="yyyy-MM-dd"/>"
					 />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
			<div class="control-group" align="left">
				<div style="align-self: auto;">
				&nbsp;&nbsp;业务：
					<form:select path="bizId" class="input-xlarge required" disabled="true">
						<%--<form:option value="" label=""/>--%>
						<form:options items="${businesses}" itemLabel="name" itemValue="id" htmlEscape=" "/>
					</form:select>
					<span class="help-inline"><font lor="red">*</font> </span>
				</div>
			</div>
			<table id="form" style="width: 100%;">
				<!-- Replace "table-1" with any of the design numbers -->
				<thead>
					<tr>
						<th style="width: 30%;" rowspan="2">会计账本</th>
						<th style="width: 36%;" colspan="2">期初余额</th>
						<th style="width: 20%;" rowspan="2">备注</th>
					</tr>
					<tr>
						<th style="width: 18%;">左方金额</th>
						<th style="width: 18%;">右方金额</th>
					</tr>
				</thead>
				<tbody id="bookRecordDetailList">
				</tbody>
					<tr>
						<th class="post_mao">合　　计</th>
						<td id="sum1" align="center"></td>
						<td id="sum2" align="center"></td>
						<td ></td>
					</tr>
					<tr>
						<th>备注:</th>
						<td colspan="5" >&nbsp;&nbsp;&nbsp;&nbsp;${bookRecord.remarks}</td>
					</tr>
					<tr id="TableRow1" class="fb red t_left" hidden>
						<th id="addLine">增行&nbsp;</th>
                        <td colspan="4"><button id="addBtn" type="button" class="btn btn-primary ml-8" onclick="addRow('#bookRecordDetailList', bookRecordDetailRowIdx, bookRecordDetailTpl);bookRecordDetailRowIdx = bookRecordDetailRowIdx + 1;">增加一行</button></td>
					</tr>
			</table>
			<%-- <c:if test="{{row.book.category=='left'}}">value="{{row.amount}}</c:if> --%>
			<script type="text/x-jquery-tmpl" id="bookRecordDetailTpl">//<!--
						<tr id="bookRecordDetailList{{idx}}">
							<td class="hide">
								<input id="bookRecordDetailList{{idx}}_id" name="bookRecordDetailList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="bookRecordDetailList{{idx}}_delFlag" name="bookRecordDetailList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td align="center">
								{{row.book.code}} &nbsp;{{row.bookName}}
							</td>

							<td align="center">
								{{#direction}}
									{{row.amount}}
								{{/direction}}
								{{^direction}}
								{{/direction}}
							</td>
							<td align="center">
								{{#direction}}
								{{/direction}}
								{{^direction}}
									{{row.amount}}
								{{/direction}}
							</td>
							<td align="center" >
								{{row.remarks}}
							</td>
						</tr>//-->
				</script>
				<script type="text/javascript">
                    var bookRecordDetailRowIdx = 0, bookRecordDetailTpl = $("#bookRecordDetailTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
                    $(document).ready(function() {
                        var data = ${fns:toJson(bookRecord.bookRecordDetailList)};
                        for (var i=0; i<data.length; i++){
                            viewRow('#bookRecordDetailList', bookRecordDetailRowIdx, bookRecordDetailTpl, data[i]);
                            bookRecordDetailRowIdx = bookRecordDetailRowIdx + 1;
                        }
                        var length = $("#form tbody tr").length-3;
                        if(length<4){
                        	num=4-length;
                        	 for(var i = 0; i < num; i++){
                        		 $("#addBtn").click();
                        	 }
                        }
                        calcu();
                    });
				</script>
		</div>
	</form:form>
</body>
</html>