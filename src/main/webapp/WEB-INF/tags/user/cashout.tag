<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<link href="${ctxStatic}/jquery-jbox/2.3/Skins/Bootstrap/jbox.min.css" rel="stylesheet">
<script type="text/javascript" src="${ctxStatic}/jquery-validation/1.11.0/lib/jquery.form.js"></script>

<style type="text/css">
	.form-horizontal  .control-label-cus{
	 width: 178px;
	}
	.form-horizontal .controls-cus{ margin-left:18px}
	.form-horizontal .form-actions-cus{padding-left: 0px; margin-left: -10px;}
	.alt-title-content{
		color: #999;
		font: 400 12px/24px 微软雅黑;
		padding: 12px 20px 0px 20px;
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
	.points-balance {
		float: left;
		width: 520px;
		font: 500 16px/1.5 微软雅黑;
		color: #333;
		height: 40px;
		padding: 0px 0 0 20px;
	}
	.points-balance  em {
		font: 500 24px/24px 微软雅黑;
		color: #ff9600;
	}
	.points-balance  font {
		font: 400 13px/1.5 微软雅黑;
		color: #aaa;
		padding-left: 30px;
	}
	 .points-sum{
		font: 400 14px/1.5 微软雅黑;
		color: #555;
		float: left;
		width: 540px;
		padding-bottom: 16px;
	}
	.points-sum span {
		padding-left: 20px;
	}
	.points-sum span em{
		font-style: normal;
		color: #ff9600;
		font: 400 16px/18px Arial;
	}
</style>
	<script type="text/javascript">
	
	$(document).ready(function() {
		$("#applyCashOutBtn").click(function(){
			 $.ajax({
			            //提交数据的类型 POST GET
			            type:"GET",
			            //提交的网址
			            url:"${ctx}/user/account/cashout/checkStatus",
			            //返回数据的格式
			            datatype: "json",//"xml", "html", "script", "json", "jsonp", "text".
			            //在请求之前调用的函数
			            //beforeSend:function(){$("#msg").html("logining");},
			            //成功返回之后调用的函数             
			            success:function(data){
			            	
				           if(data.status == '1'){	
				        	$("#useMoneyAble").html(data.balance);
				        	$("#userMobile").html(data.mobile);
			            	//bank
			            	var str  ="";
			            	if(data.bankType == 'alipay'){
								str += '<font>支付宝</font><div><input name="rdocard" type="hidden" value="'+data.alipayId+'" /> 姓名：';
								str += data.alipayOwner+'  <i>支付宝号：'+data.alipayNO+'</i></div>';
			            	}else{
			            		str += '<font>银行卡</font><div><input name="bankId" type="hidden" value="'+data.bankId+'"> '+ data.bankName+' <i>尾号：'+data.bankNO+'</i></div>';
			            	}
			            	$("#cardInfo").html(str);
			            	
			            	
			            	showApplyCashOutDialog(data);
			            	
				        	   
							}else if(data.status == '-1'){
								alert("登录超时，请重新登录！");
								location.href = "${ctx}/u/login";
							}else if(data.status == '-2'){
								alert("请先完善基础信息！");
								location.href = "${ctx}/user/baseinfo/update";
							}else if(data.status == '-3'){
								alert("您可以提现的资金不足50元,不能提现！");		
								location.href = "${ctx}/user/home";
							}else if(data.status == '-4'){
								alert("请先去添加银行卡！");				
								location.href = "${ctx}/user/account";
							}
						
			            }   ,
			            //调用出错执行的函数
			            error: function(){
			                //请求出错处理
			            	 alert('服务器异常，请稍后再试！');
			            		location.href = "${ctx}/user/home";
			            }         
			         });
			});
		});
	
	
			function showApplyCashOutDialog(data){
				var cashoutDialogHtml = $("#cashout_dialog").html();

				var states = {};
				states.state1 = {
				    content: cashoutDialogHtml,
				    buttons: {'申请提现': 1, '取消': 0 },
				    buttonsFocus: 1, // focus on the second button
				    submit: function (v, o, f) {
				        if (v == 0) {
				            return true; // close the window
				        } 
				        else {
				        	
				        	o.find('.errorBlock').hide('fast', function () { $(this).remove(); });

				        	data.applyCashoutAmount = f.applyCashoutAmount; //或 h.find('#amount').val();
				            data.captcha = o.find('#imgValidateCode').val(); 
				            data.validateCode = o.find('#validateCode').val(); 
				            
				            if (data.applyCashoutAmount == '' || parseInt(data.applyCashoutAmount) < 50) {
				                $('<div class="errorBlock" style="color:red;display: none;">请输入正确的提现金额！</div>').prependTo(o).show('fast');
				                return false;
				            }
				            if (parseInt(data.applyCashoutAmount) > parseInt(data.balance)) {
				                $('<div class="errorBlock" style="color:red;display: none;">提现金额不能大于账户余额!</div>').prependTo(o).show('fast');
				                return false;
				            }
				            if (parseInt(data.applyCashoutAmount) < 50) {
				                $('<div class="errorBlock" style="color:red;display: none;">提现金额不得低于50元!</div>').prependTo(o).show('fast');
				                return false;
				            }
				            if (data.captcha =='' || data.captcha.length != 4) {
				                $('<div class="errorBlock" style="color:red;display: none;">请输入正确的图片验证码!</div>').prependTo(o).show('fast');
				                return false;
				            }
				            if (data.validateCode =='' || data.validateCode.length != 6) {
				                $('<div class="errorBlock" style="color:red;display: none;">请输入正确的手机验证码!</div>').prependTo(o).show('fast');
				                return false;
				            }
				
				            // do ajax request here
						 $.ajax({
						            //提交数据的类型 POST GET
						            type:"POST",
						            //提交的网址
						            url:"${ctx}/user/account/cashout/apply",
						            //提交的数据
						            data:data,
						            //返回数据的格式
						            datatype: "json",//"xml", "html", "script", "json", "jsonp", "text".
						            //在请求之前调用的函数
						            //beforeSend:function(){$("#msg").html("logining");},
						            //成功返回之后调用的函数             
						            success:function(data){
							            // asume that the ajax is done, than show the result
							            var msg = [];
							            msg.push('<div class="msg-div">');
							            if(data.status == '1'){
								            msg.push('<p>申请成功!</p>');
							            }else if(data.status == '-1'){
							            	msg.push('<p>登录超时，请重新登录！</p>');
											location.href = "${ctx}/u/login";
										}else if(data.status == '-2'){
											msg.push('<p>请先完善基础信息！</p>');
											location.href = "${ctx}/user/baseinfo/update";
										}else if(data.status == '-3'){
											msg.push('<p>您可以提现的资金不足50元,不能提现！</p>');
											location.href = "${ctx}/user/home";
										}else if(data.status == '-4'){
											msg.push('<p>请先去添加银行卡！</p>');
											location.href = "${ctx}/user/account";
										}else if(data.status == '-5'){
							            	msg.push('<p>你传递的参数不正确！</p>');
							            }else if(data.status == '-6'){
							            	msg.push('<p>图片验证码不正确！</p>');
							            }else if(data.status == '21'){
							            	msg.push('<p>手机验证码超时或不正确！</p>');
							            }else if(data.status == '22'){
							            	msg.push('<p>接受验证码的手机号与现在的手机号不一致！</p>');
							            }else if(data.status == '23'){
							            	msg.push('<p>手机验证码不正确！</p>');
							            }
							            msg.push('</div>');
							            window.setTimeout(function () {  $.jBox.goToState('state4', msg.join('')); }, 2000);
						            }   ,
						            //调用执行后调用的函数
						            complete: function(XMLHttpRequest, textStatus){
						            	//$.jBox.nextState('<div class="msg-div">正在提交...</div>');
						                //HideLoading();
							            $.jBox.goToState('state3', '<div class="msg-div">正在提交...</div>')
							
						            },
						            //调用出错执行的函数
						            error: function(){
						                //请求出错处理
						            	 $.jBox.goToState('state3', '<div class="msg-div">服务器异常，请稍后再试！</div>');
						            }         
						         });
				        	}
				        return false;
				    }
				};
				states.state3 = {
					    content: '',
					    buttons: {} // no buttons
				};
				states.state4 = {
				    content: '',
				    buttons: { '确定': 0 },
				    buttonsFocus: 0, 
				    submit: function (v, o, f) {
				    	
				    	window.location.href="${ctx}/user";
				    }
				};
				
				$.jBox.open(states, '提现申请', 688, 'auto');
		         
				}
			
			function sendMobileCode(){
					$.get('${ctx}/user/account/cashout/sendVildateCode?rand='+Math.random(),function (data){
						
						if(data.result == 1){
							$("#validateCode").val(data.cashoutValideCode);
						}else if(data.result == "-1"){
							alert("你还未登录或登录超时!");
						}
					});
			}
			
			function checkCashAmount(){
		        var useMoneyAble=parseInt($('#jbox #useMoneyAble').text());
				var amount = parseInt($("#jbox #applyCashoutAmount").val()) ||0;
		         if(amount>useMoneyAble){
		        	 $("#jbox #applyCashoutAmount").val(useMoneyAble);
		         }else{
		        	 $("#jbox #applyCashoutAmount").val(amount);
		             $('#jbox .errorBlock').hide();
		         }
		         
				}
			
			 $(function() {
				    $('#refreshImg').click(
				        function() {
				          $(this).hide().attr('src',
				              '${ctx}/common/captcha.jpg?' + Math.floor(Math.random() * 100)).fadeIn();
				        });
				  });
	</script>

<style type="text/css">

	.tixian-top{ width:610px; margin:10px 20px 0 20px; display:inline; float:left; border-bottom:1px solid #CCC; position:relative; height:36px; padding-left:40px;}
	.tixian-top p{ position:absolute; padding:8px 15px; border:1px solid #CCC; background-color:#FFF; bottom:-1px; border-bottom:1px solid #FFF; font-weight:bold;}
	.cashout_content{ width:660px; float:left; padding-top:20px;}
	.cashout_content li{ list-style: none; width:660px; float:left; padding:10px 0; font:400 14px/24px 宋体; color:#333;}
	.cashout_content li font{ float:left; width:180px; padding-right:20px; text-align:right;}
	.cashout_content li p{ color:red; font-size:12px;}
	.cashout_content i{
			margin-left:3px;
			font-style: normal;
			}
	
	.cashout_content input{border:1px solid #ddd; height:24px;  padding: 0 5px; float:left; display:inline;}
		
</style>
   <%-- state1 --%>
   <div id="cashout_dialog" style="display: none;">
		  <div class="row">
		      <div class="span10">
		          <ul class="cashout_content">
			    	<li><font>可用金额</font><span id="useMoneyAble">0.00</span>元</li>
			        <li id="cardInfo">
			        </li>
			        <li>
			        <font>提现金额</font>
			        <input name="applyCashoutAmount" id="applyCashoutAmount" onkeyup="checkCashAmount();" type="text" maxlength="15" class="input-mini">
			        <i>元 *（最低提现金额为50元）</i>
			        </li>
			        <li><font>手机号</font><span id="userMobile"></span></li>
			                
			         <li>
			         <font>输入图片验证码</font>
			         <input name="imgValidateCode" id="imgValidateCode" type="text" maxlength="6" class="input-mini" placeholder="图片验证码">            
			            <img style=" width: 105px;height: 24px;padding:0 0 0 3px;; position:absolute;z-index:10;" src="${ctx}/servlet/validateCodeServlet" id="refreshImg1" name="refreshImg1">            
			          </li>
			        
			        <li>
			        <font>输入验证码</font>
			        <input name="validateCode" id="validateCode" type="text" maxlength="6" class="input-mini">
			        <button type="button" onclick="sendMobileCode()" style="margin-left: 5px;" >免费获取验证码</button>
			        </li>
    			</ul>
		      </div>
	      </div>
		</div>
