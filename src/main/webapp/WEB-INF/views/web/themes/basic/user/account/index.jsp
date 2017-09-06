<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>${site.title} </title>
	<meta name="decorator" content="cms_default_${site.theme}"/>
	<meta name="description" content="${article.description} ${category.description}" />
	<meta name="keywords" content="${article.keywords} ${category.keywords}" />
<link href="${ctxStatic}/jquery-jbox/2.3/Skins/Bootstrap/jbox.min.css" rel="stylesheet">
<script type="text/javascript" src="${ctxStatic}/jquery-validation/1.11.0/lib/jquery.form.js"></script>
<style type="text/css">
	.form-horizontal  .control-label-cus{
	 width: 178px;
	}
	.form-horizontal .controls-cus{ margin-left:18px}
	.form-horizontal .form-actions-cus{padding-left: 0px; margin-left: -10px;}
	.alt-title{
		width: 426px;
		border-bottom: 1px solid #CCC;
		float: left;
		margin: 0 20px;
		font: 500 16px/18px 微软雅黑;
		color: #666;
		padding-bottom: 8px;
		display: inline;
	}
	.alt-title-content{
		color: #999;
		font: 400 12px/24px 微软雅黑;
		padding: 10px 20px 0px 20px;
		float: left;
		width: 460px;
	}
	
	.errorBlock {
	    background-color: #ffc6a5;
	    border: 1px solid #ff0000;
	    color: #ff0000;
	    font-weight: bold;
	    margin: 10px 10px 0;
	    padding: 7px;
	}
	
	.detail-content{
		width: 100%;
		background-color: #FFF;
		border: 1px solid #d2d2d2;
		float: left;
		margin-bottom: 15px;
	}
</style>
	<script type="text/javascript">
	$(document).ready(function() {
		$("#btnSubmit").click(function(){
			var selectBankTypeHtml = $("#selectBankType").html();

			var addBankHtml = $("#add_bank_card").html();
			var addAlipayHtml = $("#add_alipay").html();
			
			var data = {};
			var states = {};
			states.state1 = {
			    content: selectBankTypeHtml,
			    buttons: { '下一步': 1, '取消': 0 },
			    submit: function (v, h, f) {
			    	//v button 定义的数字
			    	//h  jbox-content
			    	//f 表单数据  { amount="1", address="", message=""}
			        if (v == 0) {
			            return true; // close the window
			        }
			        else {
			            h.find('.errorBlock').hide('fast', function () { $(this).remove(); });
			
			            data.bankType = f.bankType; //或 h.find('#bankType').val();
			           
			            if (data.bankType == '' || data.bankType == 'undefined') {
			                $('<div class="errorBlock" style="display: none;">请选择添加类型！</div>').prependTo(h).show('fast');
			                return false;
			            }
			            if(data.bankType == 'bank'){
			             $.jBox.goToState('state2')
			            }else if(data.bankType == 'alipay'){
			            	
			             $.jBox.goToState('state3')
			            }
			            //$.jBox.nextState(); //go forward
			            // 或 $.jBox.goToState('state2')
			        }
			
			        return false;
			    }
			};
			states.state2 = {
			    content: addBankHtml,
			    buttons: { '上一步': -1, '提交': 1, '取消': 0 },
			    buttonsFocus: 1, // focus on the second button
			    submit: function (v, o, f) {
			        if (v == 0) {
			            return true; // close the window
			        } else if (v == -1) {
			        	$.jBox.goToState('state1');
			        	// $.jBox.prevState() //go back
			        }
			        else {
			        	
			        	o.find('.errorBlock').hide('fast', function () { $(this).remove(); });

			            data.bankCardOwner = f.bankCardOwner; //或 h.find('#amount').val();
			            data.bankCode = f.bankCode; 
			            data.bankBranchName = f.bankBranchName; 
			            data.bankNO = f.bankNO; 
			            data.reBankNO = f.reBankNO; 
			            
			            if (data.bankCardOwner == '' || /^[\u4e00-\u9fa5]{2,30}$/.test(data.bankCardOwner) == false) {
			                $('<div class="errorBlock" style="display: none;">请输入正确的开户名！</div>').prependTo(o).show('fast');
			                return false;
			            }
			            if (data.bankCode == '') {
			                $('<div class="errorBlock" style="display: none;">请选择的开户行！</div>').prependTo(o).show('fast');
			                return false;
			            }
			            if (data.bankBranchName == '') {
			                $('<div class="errorBlock" style="display: none;">请输入开户支行！</div>').prependTo(o).show('fast');
			                return false;
			            }
			            if (data.bankNO == ''||data.bankNO.length <16) {
			                $('<div class="errorBlock" style="display: none;">请输入正确的银行卡号！</div>').prependTo(o).show('fast');
			                return false;
			            }
			            if (data.reBankNO == ''||data.reBankNO.length < 16) {
			                $('<div class="errorBlock" style="display: none;">请再次输入正确的银行卡号！</div>').prependTo(o).show('fast');
			                return false;
			            }
			            if (data.bankNO != data.reBankNO) {
			                $('<div class="errorBlock" style="display: none;">两次输入的卡号不一致！</div>').prependTo(o).show('fast');
			                return false;
			            }
			            
			
			            // do ajax request here
					 $.ajax({
					            //提交数据的类型 POST GET
					            type:"POST",
					            //提交的网址
					            url:"${ctx}/user/account/bankAdd",
					            //提交的数据
					            data:data,
					            //返回数据的格式
					            datatype: "html",//"xml", "html", "script", "json", "jsonp", "text".
					            //在请求之前调用的函数
					            //beforeSend:function(){$("#msg").html("logining");},
					            //成功返回之后调用的函数             
					            success:function(data){
						            // asume that the ajax is done, than show the result
						            var msg = [];
						            msg.push('<div class="msg-div">');
						            if(data == '1'){
							            msg.push('<p>已成功添加!</p>');
						            }else if(data == '-1'){
						            	msg.push('<p>登录超时，请重新登录！</p>');
						            }else if (data == '12'){
						            	msg.push('<p>卡号不一致!</p>');
						            }
						            msg.push('</div>');
						            window.setTimeout(function () {  $.jBox.goToState('state5', msg.join('')); }, 2000);
					            }   ,
					            //调用执行后调用的函数
					            complete: function(XMLHttpRequest, textStatus){
					            	//$.jBox.nextState('<div class="msg-div">正在提交...</div>');
					                //HideLoading();
						            $.jBox.goToState('state4', '<div class="msg-div">正在提交...</div>')
						
					            },
					            //调用出错执行的函数
					            error: function(){
					                //请求出错处理
					            	 $.jBox.goToState('state4', '<div class="msg-div">服务器异常，请稍后再试！</div>');
					            }         
					         });
			        }

	        return false;
	    }
	};
	states.state3 = {
			content: addAlipayHtml,
		    buttons: { '上一步': -1, '提交': 1, '取消': 0 },
		    buttonsFocus: 1, // focus on the second button
		    submit: function (v, o, f) {
		        if (v == 0) {
		            return true; // close the window
		        } else if (v == -1) {
		        	$.jBox.goToState('state1');
		        	// $.jBox.prevState() //go back
		        }
		        else {
		        	
		        	o.find('.errorBlock').hide('fast', function () { $(this).remove(); });

		            data.owner = f.owner; //或 h.find('#amount').val();
		            data.alipayNO = f.alipayNO; 
		            data.reAlipayNO = f.reAlipayNO; 
		            
		            if (data.owner == '' || /^[\u4e00-\u9fa5]{2,30}$/.test(data.owner) == false) {
		                $('<div class="errorBlock" style="display: none;">请输入正确的持有人姓名！</div>').prependTo(o).show('fast');
		                return false;
		            }
		            if (data.alipayNO == ''||data.alipayNO.length <5) {
		                $('<div class="errorBlock" style="display: none;">请输入正确的支付宝账号！</div>').prependTo(o).show('fast');
		                return false;
		            }
		            if (data.reAlipayNO == ''||data.reAlipayNO.length < 5) {
		                $('<div class="errorBlock" style="display: none;">请再次输入正确的支付宝账号！</div>').prependTo(o).show('fast');
		                return false;
		            }
		            if (data.alipayNO != data.reAlipayNO) {
		                $('<div class="errorBlock" style="display: none;">两次输入的支付宝账号不一致！</div>').prependTo(o).show('fast');
		                return false;
		            }
		            
		
		            // do ajax request here
				 $.ajax({
				            //提交数据的类型 POST GET
				            type:"POST",
				            //提交的网址
				            url:"${ctx}/user/account/bankAdd",
				            //提交的数据
				            data:data,
				            //返回数据的格式
				            datatype: "html",//"xml", "html", "script", "json", "jsonp", "text".
				            //在请求之前调用的函数
				            //beforeSend:function(){$("#msg").html("logining");},
				            //成功返回之后调用的函数             
				            success:function(data){
					            // asume that the ajax is done, than show the result
					            var msg = [];
					            msg.push('<div class="msg-div">');
					            if(data == '1'){
						            msg.push('<p>已成功添加!</p>');
					            }else if(data == '-1'){
					            	msg.push('<p>登录超时，请重新登录！</p>');
					            } else if (data == '12'){
					            	msg.push('<p>账号不一致!</p>');
					            }else if (data = '-3'){
					            	msg.push('<p>您已经添加过支付宝账号！</p>');
					            	
					            }else{
					            	msg.push('<p>服务器异常，请稍后再试！</p>');
					            }
					            msg.push('</div>');
					            window.setTimeout(function () { $.jBox.nextState(msg.join('')); }, 2000);
				            }   ,
				            //调用执行后调用的函数
				            complete: function(XMLHttpRequest, textStatus){
				            	$.jBox.nextState('<div class="msg-div">正在提交...</div>');
				                //HideLoading();
					            // 或 $.jBox.goToState('state4', '<div class="msg-div">正在提交...</div>')
					
				            },
				            //调用出错执行的函数
				            error: function(){
				                //请求出错处理
				            	$.jBox.nextState('<div class="msg-div">服务器异常，请稍后再试！</div>');
				            }         
				         });
		          }

        		return false;
		    }
			};
			states.state4 = {
				    content: '',
				    buttons: {} // no buttons
			};
			states.state5 = {
			    content: '',
			    buttons: { '确定': 0 },
			    buttonsFocus: 0, 
			    submit: function (v, o, f) {
			    	
			    	window.location.href="${ctx}/user/account";
			    }
			};
			
			$.jBox.open(states, '请选择添加类型', 488, 'auto');
				
			});
		});
	</script>
</head>
<body>

	<div class="row">
	<user:centerNav />
	   
   			<div class="span10">
   				<div class="detail-content" >
   				<div style="padding: 30px;height: 27px">
					<input id="btnSubmit" class="btn btn-primary" type="button" value="增加银行卡"/>
   				</div>
				</div>
			</div>
	   	
	   	<div class="span10">
	   			
	   			 <!--收支明细begin-->
            <div class="detail-content">
            <div style="padding: 10px;">
            
            	<span>账户收支明细</span><a style="display:none;" href="#">导出</a>
                
                <form action="${ctx}/user/account" method="get" id="searchForm" class="breadcrumb form-search">
               		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
					<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
					
                <span class="l">起止时间：</span>
                <select id="timeRange" name="timeRange" class="input-mini">
	                <option value="1"  ${fundDetail.timeRange eq '1' ?'selected="selected"' : ''}>全部</option>
	                <option value="2" ${fundDetail.timeRange eq '2' ?'selected="selected"' : ''}>近一周</option>
	                <option value="3"  ${fundDetail.timeRange eq '3' ?'selected="selected"' : ''}>近一月</option>
	                <option value="4"  ${fundDetail.timeRange eq '4' ?'selected="selected"' : ''}>最近三个月</option>
	                <option value="5"  ${fundDetail.timeRange eq '5' ?'selected="selected"' : ''}>最近半年</option>
                </select>
                
               <span class="l">选择明细分类：</span>
               <select id="fundDirection" name="fundDirection"class="input-mini">
               	<option value=""  ${fundDetail.fundDirection == '' ?'selected="selected"' : ''}>全部 </option>
               <option value="IN"  ${fundDetail.fundDirection == 'IN' ?'selected="selected"' : ''}>收入明细</option>
               <option value="OUT" ${fundDetail.fundDirection == 'OUT' ?'selected="selected"' : ''}>支出明细</option>
               </select>
               <input class="btn btn-primary" value="查 询" type="submit">
               
               </form>
               <style type="text/css">
               .normal-table{ margin:10px 20px 11px 2px; border:1px solid #e6e6e6;}
				.normal-table th{ background-color:#f5f5f5; text-align:left; padding:8px 20px;font:500 14px/1.5 微软雅黑; color:#b5b5b5;}
				.normal-table td{padding:8px 0px 8px 20px;font:500 12px/1.5 微软雅黑; color:#666; border-bottom:1px dashed #e6e6e6;}
               </style>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="normal-table" >
				  <tr>
				    <th width="149">创建时间</th>
				    <th width="248">变化金额(元)</th>
				    <th width="248">总余额(元)</th>
				    <th width="102">交易类型</th>
				    <th width="149">备注</th>
				  </tr>
				  <c:forEach items="${page.list}" var="fundDetail">
				   <tr>
					    <td><fmt:formatDate value="${fundDetail.createDate }" pattern="yyyy-MM-dd hh:mm:ss"/> </td>
					    <td>${fundDetail.operate }</td>
					    <td>${fundDetail.balance }</td>
					    <td>${fns:getDictLabel(fundDetail.changeType, 'base_user_event', '')}</td>
					    <td>${fundDetail.changeDesc }</td>
					</tr> 
				  
				  </c:forEach>
				  						
				</table>
				<c:choose>
					<c:when test="${fn:length(page.list) eq 0}">
							<div style="margin: 0 auto;">暂时还没有记录！</div>
					</c:when>
					<c:otherwise>
					
						<!--分页begin-->
						<div class="pagination">${page}</div>
						<script type="text/javascript">
							function page(n,s){
								$("#pageNo").val(n);
								$("#pageSize").val(s);
								$("#searchForm").submit();
						    	return false;
						    }
						</script>
		
					<!--分页end-->
					
					</c:otherwise>
				</c:choose>
				</div>
            </div>
            <!--收支明细end-->
        </div>
   </div>
   
   <div id="addBankStates" style="display: none;">
   
	   <div id="selectBankType" style="display: none;">
		<div class="add_bank_card">
		  <div class="row">
		      <div class="span10">
				      <div class="control-group">
							<div class="controls" style="margin-left:18px">
								<span>
									<input id="bank" name="bankType" class="required" type="radio" value="bank" checked="checked">
									<label for="bank">
									<img src="${ctxStatic}/web/user/account/images/bank.png" width="170" height="65" align="middle">
									</label>
								</span>
								<span>
									<input id="alipay" name="bankType" class="required" type="radio" value="alipay">
									
									<label for="alipay">
											<img src="${ctxStatic}/web/user/account/images/alipay.png" width="170" height="65" align="middle">
									</label>
								</span>
							</div>
							<div class="errorBlock" style="display: none;"></div>
						</div>
		      </div>
	      </div>
		</div>
		</div>
		<%--state2 --%>
		<div id="add_bank_card" style="display: none;">
		  <div class="row">
		      <div class="span10">
		             <form id="addBankForm" action="${ctx}/user/account/addbankcard" method="post" class="form-horizontal">
					<div class="control-group" style="margin-top: 10px;">
						<label class="control-label control-label-cus">开户名：</label>
						<div class="controls controls-cus" >
						<input name="bankCardOwner"   id="bankCardOwner"   htmlEscape="false" maxlength="100" class="input-large required"/>
						<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label control-label-cus">选择银行：</label>
						<div class="controls controls-cus" >
					
						<select id="bankCode" name="bankCode" class="input-small" >
							<option value="" label="请选择"/>
							<c:forEach items="${fns:getDictList('base_bank')}" var="bank">
								<option value="${bank.value }" label="${bank.label }" htmlEscape="false"/>
							</c:forEach>
						</select>
				
						<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label control-label-cus">开户支行：</label>
						<div class="controls controls-cus" >
						<input name="bankBranchName"   id="bankBranchName"   htmlEscape="false" maxlength="100" class="input-large required"/>
						<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label control-label-cus">银行卡号：</label>
						<div class="controls controls-cus" >
						<input name="bankNO"   id="bankNO"   htmlEscape="false" maxlength="100" class="input-large required"/>
						<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label control-label-cus">确定卡号：</label>
						<div class="controls controls-cus" >
						<input name="reBankNO"   id="reBankNO"   htmlEscape="false" maxlength="100" class="input-large required"/>
						<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					<div class="errorBlock" style="display: none;"></div>
					<div class="form-actions form-actions-cus">
						<div class="alt-title"> 温馨提示</div>
						<ol class="alt-title-content">
							<li> 如果您填写的开户行支行不正确，可能将无法成功提现。</li>
							<li> 如果您不确定开户行支行名称，可以打电话到当地所在银行的 营业网点询问或者上网查询。</li>
							<li> 不支持提现至信用卡账户。</li>
						</ol>
					</div>
				</form>
		      </div>
	      </div>
		</div>
		<%--state2 --%>
		<div id="add_alipay" style="display: none;">
		  <div class="row">
             <form id="alipayForm" action="#" method="post" class="form-horizontal">
		      <div class="span10">
					<div class="control-group" style="margin-top: 10px;">
						<label class="control-label control-label-cus">支付宝持有人：</label>
						<div class="controls controls-cus"  style="margin-left:18px">
						<input name="owner" id="owner" htmlEscape="false" maxlength="100" class="input-large required"/>
						<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label control-label-cus">支付宝账号：</label>
						<div class="controls controls-cus" >
						<input name="alipayNO" id="alipayNO" htmlEscape="false" maxlength="100" class="input-large required"/>
						<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label control-label-cus">确认支付宝账号：</label>
						<div class="controls controls-cus"  >
						<input name="reAlipayNO" id="reAlipayNO" htmlEscape="false" maxlength="100" class="input-large required"/>
						<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					<div class="errorBlock" style="display: none;"></div>
					<div class="form-actions form-actions-cus">
						<div class="alt-title"> 温馨提示</div>
						<ol class="alt-title-content">
							<li> 如果您填写的支付宝账号不正确，可能将无法成功提现。</li>
						</ol>
					</div>
		      </div>
			</form>
	      </div>
		</div>
   
   </div>
</body>
</html>