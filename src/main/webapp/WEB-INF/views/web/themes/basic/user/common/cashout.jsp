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
			var rechangePointDialogHtml = $("#cashout_dialog").html();

			var data = {};
			var states = {};
			states.state1 = {
			    content: rechangePointDialogHtml,
			    buttons: {'提交': 1, '取消': 0 },
			    buttonsFocus: 1, // focus on the second button
			    submit: function (v, o, f) {
			        if (v == 0) {
			            return true; // close the window
			        } 
			        else {
			        	
			        	o.find('.errorBlock').hide('fast', function () { $(this).remove(); });

			            data.pointCount = f.pointCount; //或 h.find('#amount').val();
			            data.totalPoints = o.find('#totalPoints').text(); //或 h.find('#amount').val();
			            
			            if (data.pointCount == '' || parseInt(data.pointCount) < 1) {
			                $('<div class="errorBlock" style="color:red;display: none;">请输入要兑换的积分！</div>').prependTo(o).show('fast');
			                return false;
			            }
			            if (parseInt(data.pointCount) > parseInt(data.totalPoints)) {
			                $('<div class="errorBlock" style="color:red;display: none;">您的积分不足!</div>').prependTo(o).show('fast');
			                return false;
			            }
			
			            // do ajax request here
					 $.ajax({
					            //提交数据的类型 POST GET
					            type:"POST",
					            //提交的网址
					            url:"${ctx}/user/point/rechange",
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
							            msg.push('<p>已成功兑换!</p>');
						            }else if(data == '-1'){
						            	msg.push('<p>登录超时，请重新登录！</p>');
						            }else if(data == '-2'){
						            	msg.push('<p>你传递的参数不正确！</p>');
						            }else if(data == '-3'){
						            	msg.push('<p>您的积分不足！</p>');
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
			    	
			    	window.location.href="${ctx}/user/point";
			    }
			};
			
			$.jBox.open(states, '积分兑换现金', 288, 'auto');
				
			});
		
		
		});
	
			function checkPointCount(){
		        var total=parseInt($('#jbox #totalPoints').text());
				var amount = parseInt($("#jbox #pointCount").val());
		         if(amount>total){
		        	 $("#jbox #pointCount").val(total);
		        	 $('#jbox #rechangeMoney').html((total/100).toFixed(2));
		             $('#jbox .checkPointWarn').show();
		         }else{
					 $("#jbox #pointCount").val(amount);
		          	 $('#jbox #rechangeMoney').html((amount/100).toFixed(2));
		             $('#jbox .errorBlock').hide();
		         }
		         
				}
	</script>
</head>
<body>

   <%-- state1 --%>
   <div id="cashout_dialog" style="display: none;">
		  <div class="row">
		      <div class="span10">
		             <form id="addBankForm" action="${ctx}/user/points/rechange" method="post" class="form-horizontal">
					<div class="alt-title-content">
						您的积分余额是：
						<span style="font:500 24px/24px '微软雅黑';color:#ff9600;" id="totalPoints">${webUser.points }</span>
					</div>
					<div class="control-group" style="margin-top: 10px;">
						<div class="controls controls-cus" >
						<input name="pointCount"   id="pointCount" onkeyup="checkPointCount();"   htmlEscape="false" maxlength="100" class="input-mini required"/>
						
						<span style="font:500 14px '微软雅黑';padding:0px 10px 0px 5px;">分</span> ==
						<span style="font:500 14px '微软雅黑';padding-left:15px;" id="rechangeMoney">0.00</span>
						<span style="font:500 14px '微软雅黑';">元</span>
						</div>
					</div>
					<div class="errorBlock" style="display: none;"></div>
				</form>
		      </div>
	      </div>
		</div>
   
</body>
</html>