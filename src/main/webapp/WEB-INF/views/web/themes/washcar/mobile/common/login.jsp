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
</head>
<body>
<!-- 标题START -->
<header>
    <a href="#" class="h_back"><img src="${ctxStatic}/washcar/common/img/wis_r1_c33.png" alt="后退按钮"></a>
    <h1>
    <c:choose>
    	<c:when test="${islogin }">
    		登录
    	</c:when>
    	<c:otherwise>
    		绑定手机
    	</c:otherwise>
    </c:choose>
    
    </h1>
</header>
<!-- 标题END -->

<form method="post" action="" id="loginForm" onsubmit="return false;">
	<input type="hidden" name="redirectUrl" id="redirectUrl" value="${redirectUrl}" />
	<input type="hidden" name="wxOpenId" value="${openId }" />
	<!-- 手机验证行START -->
	<div class="mv_row">
	    <div class="mv_label">手机号</div>
	    <button class="mv_vali_btn"  id='btn_send'>获取验证码</button>
<!-- 	    <button class="mv_vali_btn"  id='btn_send'  disabled>60s后重新获取</button> -->
	    <div class="mv_ipt_wr mv_ipt_3">
	    			<input class='mv_ipt' tiptext='手机号' type="text" placeholder="" value="" id="mobile" name="mobile">	
	    </div>
	</div>
	<div class="mv_row">
	    <div class="mv_label">验证码</div>
	    <div class="mv_ipt_wr mv_ipt_2">
	    <input class='mv_ipt' tiptext='手机验证码' type="text" placeholder="" value="" id="validateCode" name="validateCode">	
	    </div>
	</div>
	<!-- 手机验证行END -->
	
	<!-- 支付START -->
	<a href="Javascript:void(0)" id='btn_enter' class="sd_pay">确定</a>
	<!-- 支付END -->
</form>	

<script type='text/javascript'>
$(function(){
	$("#btn_enter").click(function(e){
		e.preventDefault();
		var mobile=$("input[name=mobile]").val();
		var validateCode=$("input[name=validateCode]").val();
		var wxOpenId=$("input[name=wxOpenId]").val();
		var redirectUrl=$("#redirectUrl").val();
		redirectUrl = redirectUrl==''?"${ctx}/wx/home":redirectUrl;
		
		if(mobile == $("input[name=mobile]").attr('tiptext') || mobile==''){
			alert("用户名/手机号不能为空");
			return false;
		}
		if(validePhone(mobile) == false){
			alert("请输入正确的手机号");
			return false;
		}
		if(validateCode == $("input[name=validateCode]").attr('tiptext') || validateCode==''){
			alert("密码不能为空");
			return false;
		}
		// $("#loginForm").submit();
		
		
		
 		$.post('${ctx}/m/u/login',{mobile:mobile,validateCode:validateCode,wxOpenId:wxOpenId},function(data){
			//判断注册
			if(data == "1"){
					window.location=$("#redirectUrl").val();
			}else if (parseInt(data) < 0){
				alert("验证码不正确，请重新获取");
			}else{
				alert("亲爱的用户，"+data);
			}
		},'JSON') 
	});
	$("#btn_send").click(function(){
		sendMobileCode();
	});
});

function sendMobileCode(){
	var mobile =  $("#mobile").val().trim();
	if(validePhone(mobile)){
		$.get('${ctx}/common/sendVildateCode4phone?phone='+mobile+'&rand='+Math.random(),function (data){
			
			if(data.result == 1){
				$("#validateCode").val(data.valideCode);
			}else if(data.result == 2){
				alert("请输入手机号!");
			}
		});
	}else{
		alert("请输入正确的手机号");
	}
}
function validePhone(sMobile){
	return (/^[1][3,4,5,7,8][0-9]{9}$/.test(sMobile));
}
		var global_loading=document.getElementById("global_loading");
		if(global_loading != null){
			global_loading.parentNode.removeChild(global_loading);
		}
</script>

<script type="text/javascript">
$(document).ready(function() { 
	$('.jxbtn').click(function (){
		$('#J_Shade').toggleClass('nones');
		$('.circle').toggleClass('shows');
		$('.circle').toggleClass('hides');
		$('.jxbtn').toggleClass('off');
		$('.jxbtn').toggleClass('on');
		return false; 
	});

	$('body').click(function (){
		var x = $('.circle').css('opacity');
		if(x==1){
			$('.circle').removeClass('shows').addClass('hides');
			$('.jxbtn').removeClass('on').addClass('off');
			$('#J_Shade').addClass('nones');
		}
	});
}); 
</script>
</body>
</html>

