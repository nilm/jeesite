<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh_CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <meta name="decorator" content="${site.theme}_default_mobile"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta content="telephone=no" name="format-detection">
    <title>手机验证</title>
    <link rel="stylesheet" href="${ctxStatic}/washcar/common/css/ch_base.css">
    <link rel="stylesheet" href="${ctxStatic}/washcar/common/css/login.css">
    
    <meta name="decorator" content="${site.theme}_default_mobile"/>
	
	<script src="${ctxStatic}/washcar/mobile/js/common-input.js" type="text/javascript"></script>
			
	<script type="text/javascript">
		document.write('<div id="global_loading" style="width: 100%;height: 100%;position: fixed;top: 0;left: 0;background-color: #eee;z-index:999"><div style="width: 100px;height: 75px;margin:auto;top:50%;position:relative"><span style="display:block;float:left;width:32px;height:32px;margin-top:-5px;"></span>&nbsp;&nbsp;加载中...</div></div>');
	</script>
<script type="text/javascript">
	var global_loading=document.getElementById("global_loading");
	if(global_loading != null){
		global_loading.parentNode.removeChild(global_loading);
	}
	function doLogin(){
		var username=$("#username").val();
		var password=$("#password").val();
		if ($('#username').val() == ''){
			alert('请填写账号');
		}else if ($('#password').val() == ''){
			alert('请填写密码');
		}else{
	        $.ajax({
	            type: "post",
	            url: "${ctx}/washcar/distribute/login/do",
	            data: {username:username,password:password},
	            success: function(data){
	            	/* if(data=="1"){
	            		window.location.href="${ctx}/washcar/company/login/index";
	            	}else	 */if(data=="true"){
						window.location.href="${ctx}/washcar/distribute/login/index";
					}else{
						alert(data)
					}
	            }
	        });
		}
	}
</script>
</head>
<body>
<!-- 标题START -->
<header>
    <h1>洗车人登录</h1>
</header>

	<!-- 手机验证行START -->
	<div class="mv_row">
	    <div class="mv_label">账号</div>
	    <div class="mv_ipt_wr mv_ipt_2">
	   <input class='mv_ipt' type="text" name="username" id="username" placeholder="请填写登录账号">	
	    </div>
	</div>
	<div class="mv_row">
	    <div class="mv_label">密码</div>
	    <div class="mv_ipt_wr mv_ipt_2">
	   <input class='mv_ipt' type="password" name="password" id="password" placeholder="请填写登录密码">	
	    </div>
	</div>
	<!-- 手机验证行END -->
	
	<!-- 支付START -->
	<input  type="button"  onclick="doLogin()"   class="sd_pay" value="登录"/>
	<!-- 支付END -->
    
</body>
</html>