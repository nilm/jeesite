<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>${article.title} - ${category.name}</title>
	<meta name="decorator" content="cms_default_${site.theme}"/>
	<meta name="description" content="${article.description} ${category.description}" />
	<meta name="keywords" content="${article.keywords} ${category.keywords}" />
	
	<script type="text/javascript">
		$(document).ready(function() {
			if ("${category.allowComment}"=="1" && "${article.articleData.allowComment}"=="1"){
				$("#comment").show();
				page(1);
			}
		});
		function page(n,s){
			$.get("${ctx}/comment",{theme: '${site.theme}', 'category.id': '${category.id}',
				contentId: '${article.id}', title: '${article.title}', pageNo: n, pageSize: s, date: new Date().getTime()
			},function(data){
				$("#comment").html(data);
			});
		}
	</script>
	
	<style type="text/css">
		.detail-content{
			float: left;
			width: 100%;
			border: 1px solid #d2d2d2;
			margin-bottom: 15px;
			background-color: #FFF;
		}
		.user-website-left{ float:left; width:115px; padding:20px 0px 20px 20px;}
		.user-website-right{ float:left; width:645px;}
		
		.website-rate{ float:left; width:625px; text-align:right; border-bottom:1px solid #efefef; padding:15px 30px 10px 30px;font:500 16px/1.3 微软雅黑; color:#333;}
		.website-rate em,.account-balance em{font:500 24px/24px 微软雅黑; color:#ff9600;}
		.website-info{ float:left; width:605px; }
		.website-info dd{ float:left; width:540px;}
		.website-info dd ul{ float:left; width:540px;}
		.website-info dd ul li{ float:left; width:25px; padding-left:20px;}
		.website-info dt{ float: right; width:130px; padding:13px 35px 0 10px;}
		
		.account-balance{ float:left; width:520px;font:500 16px/1.5 微软雅黑; color:#333; height:40px; padding:20px 0 0 20px ;}


	</style>
</head>
<body>
	<div class="row">
		<user:centerNav />
		
		
		<div class="span10">
		
		<div class="detail-content">
        		<div class="user-website-left">
                  <a href="${ctx}/user/userinfo"><img src="http://www.shengcai18.com/upload/img/mrhead/tx-5.png" width="113" height="113"></a>
                </div>
                   <div class="user-website-right">
                    <dl class="website-info">
                        <dd>
                           <div class="account-balance">账户余额：<em>${webUser.balance }</em>元 　
                           	　积分：<em> ${webUser.points }</em>积分
                           	　累计返利金额：<em> 10</em>元
                           	
                           	</div>
<!--                             <ul>
                                <li><a href="/default/user/userinfo"><img alt="基础信息" src="/static/img/shouji_09.jpg" width="15" height="21"></a></li>
                                <li><a href="/default/user/account"><img alt="账户信息" src="/static/img/yinhangka_11.jpg" width="19" height="21"></a></li>
                                
                            </ul>
 -->                        </dd>
                        <dt>
                        <input id="applyCashOutBtn" class="btn btn-primary" type="button" value="提现申请"/>
                        </dt>
                    </dl>
                </div>
       		</div>
		
		</div>
   </div>
   <user:cashout></user:cashout>
</body>
</html>