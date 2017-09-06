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
		$("#btnSubmit").click(function(){
			var rechangePointDialogHtml = $("#rechange_point_dialog").html();

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

			            data.pointCount = f.pointCount; //或o.find('#amount').val();
			            data.totalPoints = o.find('#totalPoints').text(); //或 o.find('#amount').val();
			            
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

	<div class="row">
	<user:centerNav />
	   
	   <div class="span10">
	   <div class="row">
   		<div class="span10">
	        <div class="detail-content">
           		 <div style="padding: 10px;">
		   			<div class="span6">
		   				<div class="ponit_detail">
		   					<div style="padding: 10px;">
		   					<dl>
		                   	 	<dd>
			                        <div class="points-balance">
			                        	积分余额：<em>${webUser.points }</em> 分<font>"积分"价值兑换标准：100积分=1元</font> </div>
			                           
			                         <div class="points-sum">
			                             <span>累计返利积分：<em>${inSumPoints } </em>分</span>
			                             <span>已使用的积分：<em>${outSumPoints }  </em>分</span>
			                         </div>
		                        </dd>
		                    </dl>
		   					</div>
		   				</div>
					</div>
	   				<div class="span3">
		   				<div style="margin: 40px 20px 10px 10px;">
						<input id="btnSubmit" class="btn btn-primary" type="button" value="积分兑换 现金"/>
						</div>
					</div>
				</div>
				</div>
				</div>
			</div>
	   <div class="row">
	   	<div class="span10">
	   			
	   		<!--收支明细begin-->
            <div class="detail-content">
            <div style="padding: 10px;">
            	<span>账户收支明细</span><a style="display:none;" href="/default/user/dctrans">导出</a>
                
                <form action="${ctx}/user/point" method="get" id="searchForm" class="breadcrumb form-search">
               		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
					<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
					
                <span class="l">起止时间：</span>
                <select id="timeRange" name="timeRange" class="input-mini">
	                <option value="1"  ${pointDetail.timeRange eq '1' ?'selected="selected"' : ''}>全部</option>
	                <option value="2" ${pointDetail.timeRange eq '2' ?'selected="selected"' : ''}>近一周</option>
	                <option value="3"  ${pointDetail.timeRange eq '3' ?'selected="selected"' : ''}>近一月</option>
	                <option value="4"  ${pointDetail.timeRange eq '4' ?'selected="selected"' : ''}>最近三个月</option>
	                <option value="5"  ${pointDetail.timeRange eq '5' ?'selected="selected"' : ''}>最近半年</option>
                </select>
                
               <span class="l">选择明细分类：</span>
               <select id="fundDirection" name="fundDirection"class="input-mini">
               	<option value=""  ${pointDetail.fundDirection == '' ?'selected="selected"' : ''}>全部 </option>
               <option value="IN"  ${pointDetail.fundDirection == 'IN' ?'selected="selected"' : ''}>收入明细</option>
               <option value="OUT" ${pointDetail.fundDirection == 'OUT' ?'selected="selected"' : ''}>支出明细</option>
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
				    <th width="248">变化积分</th>
				    <th width="248">总积分</th>
				    <th width="102">交易类型</th>
				    <th width="149">备注</th>
				  </tr>
				  <c:forEach items="${page.list}" var="pointDetail">
				   <tr>
					    <td><fmt:formatDate value="${pointDetail.createDate }" pattern="yyyy-MM-dd hh:mm:ss"/> </td>
					    <td>${pointDetail.operate }</td>
					    <td>${pointDetail.balance }</td>
					    <td>${fns:getDictLabel(pointDetail.changeType, 'base_user_event', '')}</td>
					    <td>${pointDetail.changeDesc }</td>
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
            <!--收支明细end-->
            
				</div>
			</div>
  	  </div>
  	  </div>
   </div>
   <%-- state1 --%>
   <div id="rechange_point_dialog" style="display: none;">
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