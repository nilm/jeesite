<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>${site.title} </title>
	<meta name="decorator" content="cms_default_${site.theme}"/>
	<meta name="description" content="${article.description} ${category.description}" />
	<meta name="keywords" content="${article.keywords} ${category.keywords}" />
</head>
<body>
	<div class="row">
	<user:centerNav />
	   <div class="span10">
	     <div class="row">
	       <div class="span10 form-horizontal">
			
					<div class="control-group">
						<label class="control-label">用户名：</label>
						<div class="controls">
							 ${sessionScope.WEB_USER.userName }
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">真实姓名：</label>
						<div class="controls">
						${sessionScope.WEB_USER.realName }
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">身份证号：</label>
						<div class="controls">
							${sessionScope.WEB_USER.idCard }
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">手机号：</label>
						<div class="controls">
							${sessionScope.WEB_USER.mobile }
						<span> 已绑定</span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">邮箱：</label>
						<div class="controls">
							${sessionScope.WEB_USER.email }
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">性别：</label>
						<div class="controls">
							${sessionScope.WEB_USER.sex eq '1'?'男':'女'}
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">地址：</label>
						<div class="controls">
						${sessionScope.WEB_USER.province }
						${sessionScope.WEB_USER.city }
						${sessionScope.WEB_USER.region }
						${sessionScope.WEB_USER.address }
						</div>
					</div>
					
				<div class="form-actions">
			       <a href="${ctx}/user/baseinfo/update"  class="btn btn-primary">修改信息</a>
				</div>
  	       </div>
  	     </div>
	     <div class="row">
	       <div class="span10">
	  	  </div>
  	    </div>
  	  </div>
   </div>
</body>
</html>