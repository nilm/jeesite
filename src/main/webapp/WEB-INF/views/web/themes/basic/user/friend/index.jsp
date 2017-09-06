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
<%-- 记得  ZeroClipboard.js 中的/ZeroClipboard.swf 需要修改地址--%>
<script type="text/javascript" src="${ctxStatic}/zeroclipboard/ZeroClipboard.js"></script>
<style type="text/css">
	.detail-content{
		width: 100%;
		background-color: #FFF;
		border: 1px solid #d2d2d2;
		float: left;
		margin-bottom: 15px;
	}
	
	.invite-box{
		float: left;
		width: 625px;
		padding: 20px;
	}
	.invite-box dl {
		float: left;
		width: 740px;
	}
	.invite-box dl dd {
		float: left;
		width: 348px;
	}
	.invite-box dl dd h3 {
		font: bold 15px/24px 微软雅黑;
		color: #ff8500;
		}
	.invite-box dl dd h3 {
		font: bold 15px/24px 微软雅黑;
		color: #ff8500;
		}
	.invite-box dl dd ul {
		padding-top: 10px;
		}
	.invite-box  dl dd ul li {
		font: 300 12px/24px 宋体;
		color: #999;
	}
	.invite-box  dl dd .invite-rule {
		width: 280px;
		padding: 0px 0 0 40px;
	}
	.invite-box dl dd table {
		margin-top: 15px;
		}
	.invite-box dl dd table tr th {
		text-align: center;
		font: bold 12px/24px 宋体;
		background-color: #ff8500;
		color: #fff;
		border-right: 1px solid #FFF;
	}
	.invite-box dl dd table tr td {
		font: 100 12px/24px 宋体;
		color: #666;
		text-align: center;
		border-right: 1px solid #FFF;
	}
	.invite-box dl dd table tr td em {
		font-style: normal;
		color: #ff8500;
		font-weight: bold;
		}
	.tbl-s {
		background-color: #f3f3f3;
	}	
	.box-tab{
		float: left;
		cursor: pointer;
		font: 500 16px/50px 微软雅黑;
		border-bottom: 1px solid #FFF;
		background-color: #fff;
		color: #333;
		text-align: center;
		border: 1px solid #eee;
		margin-right: 6px;
	}
	.qq-invite{
		height: 117px;
	}
	.qcShareQQ {
		background: url(${ctxStatic}/web/user/friend/images/qq_share.png);
		width: 135px;
		height: 32px;
		text-align: right;
		display: block;
		float: left;
		text-decoration: none;
		font: bold 18px/24px Arial, 微软雅黑;
		color: #333;
		padding: 8px 25px 0 0;
	}
	.qq-invite-box {
		background-color: #fffde8;
		width: 538px;
		margin: 20px 30px;
		float: left;
		padding: 25px 30px;
	}
	.qq-invite-box-content {
		background-color: #FFF;
		padding: 10px 20px;
		font: 400 14px/24px 宋体;
		border: 1px solid #CCC;
		-moz-border-radius: 8px;
		-webkit-border-radius: 8px;
		border-radius: 8px;
	}
	.invite-btn-copy{
		float: left;
		margin: 0 auto;
		display: block;
		padding: 10px 40px 6px 40px;
		text-align: center;
		background-color: #ff8500;
		color: #fff;
		text-decoration: none;
		font: 500 16px/20px 微软雅黑;
		border-bottom: 3px solid #C63;
		margin-right: 80px;
		-moz-border-radius: 5px;
		-webkit-border-radius: 5px;
		border-radius: 5px;
		white-space: nowrap;
	}
	
	.kong {
	clear: both;
	height: 1px;
	overflow: hidden;
	}
</style>
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
		   			<script type="text/javascript">
						function changeBox(cur) {
						  var len = 2;
						  for(i=1;i<=len;++i){
							  if(i == cur){
									$("#inviteBox"+i).show();
									$("#tab"+i).addClass("active");
							  }else{
									$("#inviteBox"+i).hide();
									$("#tab"+i).removeClass("active");
							  }
						  }
						} 
					</script>
						<ul class="nav nav-tabs">
							<li id="tab1" class="active" onclick="changeBox(1);"><a href="javascript:void(0);">通过链接邀请</a></li>
							<li id="tab2" onclick="changeBox(2);"><a href="javascript:void(0);">通过QQ邀请</a></li>
<!-- 							<li id="tab3" onclick="changeBox(3);"><a href="javascript:void(0);">通过短信邀请</a></li>
							<li id="tab4" onclick="changeBox(4);"><a href="javascript:void(0);">通过邮箱邀请</a></li> -->
						</ul>
						<div class="kong"></div>
						<div id="inviteBox1" class="box-tab">
						
						<div style=" padding: 10px 0 0 0px;">
		                      <div class="qq-invite-box">
		                          <textarea style=" width:500px; height: 54px; float: left;resize:none;" 
		                          	disabled="disabled" name="cardid" id="cardid" class="qq-invite-box-content">我注册了${site.title}，已经得到好多返利了，强烈推荐你来啊http://localhost:8080/jeesite/${cxt}/u/sign-in/${sessionScope.WEB_USER.inviteCode }</textarea>
		                       </div>
				               <div style=" padding: 0 0 0 50px;">
				                  <button id="copycardid" class="invite-btn-copy">点击复制</button>
			                  </div>
                   		 </div>
						<script type="text/javascript">
							$(function(){
								init();
							});
							function init() {
								var clip = new ZeroClipboard.Client(); // 新建一个对象
								clip.setHandCursor( true );
								clip.setText($('#cardid').val()); // 设置要复制的文本。
								clip.addEventListener( "mouseUp", function(client) {
									alert("复制成功,快去邀请好友!");
								});
								// 注册一个 button，参数为 id。点击这个 button 就会复制。
								//这个 button 不一定要求是一个 input 按钮，也可以是其他 DOM 元素。
								clip.glue("copycardid"); // 和上一句位置不可调换
							}
							</script>
							<div class="kong" style="height:20px;"></div>
						</div>
						<div id="inviteBox2" class="box-tab qq-invite" style="display: none;">
							<div class="invite-box">
							      <h2>QQ邀请好友-记得改链接哦</h2>
							<script type="text/javascript">
							(function(){
								var p = {
									url:'http://localhost/${cxt}/u/sign-in/${sessionScope.WEB_USER.inviteCode }', /*获取URL，可加上来自分享到QQ标识，方便统计*/
									desc:'我注册了${site.title}，已经得到好多返利了，强烈推荐你来啊 ', /*分享理由(风格应模拟用户对话),支持多分享语随机展现（使用|分隔）*/
									title:'${site.title}邀请好友', /*分享标题(可选)*/
									summary:'诚挚推荐${site.title}，P2P返利的好网站！...', /*分享摘要(可选)*/
									pics:'', /*分享图片(可选)*/
									flash: '', /*视频地址(可选)*/
									site:'', /*分享来源(可选) 如：QQ分享*/
									style:'201',
									width:32,
									height:32
								};
								
								var s = [];
								for(var i in p){
									s.push(i + '=' + encodeURIComponent(p[i]||''));
								}
							
								document.write(['<a class="qcShareQQ" href="http://connect.qq.com/widget/shareqq/index.html?',s.join('&'),'" target="_blank">点击邀请</a>'].join(''));
							}
							)();
							</script>
               			 </div>
						
						</div>
						<div id="inviteBox3" class="box-tab" style="display: none;">
							3
						
						</div>
						<div id="inviteBox4" class="box-tab" style="display: none;">
							
							4
						</div>
						
					</div>
	   				<div class="span10">
					<div class="invite-box">
	                	<dl>
	                    	<dd>
	                            <h3 style="float: left;">邀请活动规则</h3>
	                            <div class="kong"></div>
	                            <ul>
	                            	<li>1.每成功邀请一位好友加入${site.title}并成功投标（新手标区）获得返利后，可获得奖励。</li>
	                                <li>2.活动中如果发现通过作弊手段获得奖励的，将取消奖励。</li>
	                                <li>3.邀请好友新规则从2015年4月22日起生效。</li>
	                                <li>4.每名受邀者必须为独立用户，即受邀用户真实姓名、手机号、邮箱、身份证、银行账户均唯一。</li>
	                                <li>5.本活动解释权归${site.title}所有。</li>
	                            </ul>
	                        </dd> 
	                    	<dd class="invite-rule">
	                        	<h3>邀请活动机制</h3>
	                        	<table width="280" border="0" cellspacing="0" cellpadding="0">
									  <tbody><tr>
									    <th>邀请人数</th>
									    <th>奖励</th>
									  </tr>
									  <tr>
									    <td>1-20人</td>
									    <td><em>10元/人</em></td>
									  </tr>
									  <tr class="tbl-s">
									    <td>21-40人</td>
									    <td><em>12元/人</em></td>
									  </tr>
									  <tr>
									    <td>41-60人</td>
									    <td><em>15元/人</em></td>
									  </tr>
									  <tr class="tbl-s">
									    <td>61-80人</td>
									    <td><em>18元/人</em></td>
									  </tr>
									  <tr>
									    <td>81人以上</td>
									    <td><em>20元/人</em></td>
									  </tr>
									</tbody>
								</table>
	                        </dd>
                    </dl>
   
                </div>
					</div>
				</div>
				</div>
				</div>
			</div>
	   <div class="row">
	   	<div class="span10">
	   			
               <style type="text/css">
               .normal-table{ margin:10px 20px 11px 2px; border:1px solid #e6e6e6;}
				.normal-table th{ background-color:#f5f5f5; text-align:left; padding:8px 20px;font:500 14px/1.5 微软雅黑; color:#b5b5b5;}
				.normal-table td{padding:8px 0px 8px 20px;font:500 12px/1.5 微软雅黑; color:#666; border-bottom:1px dashed #e6e6e6;}
				.total-friend{float: right;}
				.total-friend em{font-style: normal;color: #ff9600;font: 400 16px/18px Arial;}
               </style>
	   		<!--收支明细begin-->
            <div class="detail-content">
            <div style="padding: 10px;">
            	<span>邀请到的好友记录</span><span class="total-friend">您共邀请好友<em>${fn:length(page.list) }</em>人，获得奖励<em>${sumAwardUser.sumAwardMoney }</em>元</span>
                
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="normal-table" >
				  <tr>
				    <th width="180">创建时间</th>
				    <th width="148">用户手机</th>
				    <th width="180">绑定邮箱</th>
				    <th width="122">身份证</th>
				    <th width="100">奖励</th>
				  </tr>
				  <c:forEach items="${page.list}" var="webUser">
				   <tr>
					    <td><fmt:formatDate value="${webUser.createDate }" pattern="yyyy-MM-dd hh:mm:ss"/> </td>
					    <td>${webUser.mobile }</td>
					    <td>${webUser.email }</td>
					    <td>${webUser.idCard }</td>
					    <td>${webUser.awardMoney }</td>
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
   

</body>
</html>