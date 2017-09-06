<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>${site.title} </title>
	<meta name="decorator" content="${site.theme}_default_mobile"/>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		
	<link href="${ctxStatic}/washcar/mobile/css/reset.css" rel="stylesheet" type="text/css" />
	<link href="${ctxStatic}/washcar/mobile/css/head.css" rel="stylesheet" type="text/css" />
	<link rel='stylesheet' type='text/css' href='${ctxStatic}/washcar/mobile/css/signup.css' />	
	
	<script src="${ctxStatic}/washcar/mobile/js/common-input.js" type="text/javascript"></script>
<%-- 		<script src="${ctxStatic}/jquery-autocomplete/jquery.autocomplete.js" type="text/javascript"></script>
	<script src="${ctxStatic}/jquery/jquery-touchScroll/jquery.touchScroll.js" type="text/javascript"></script> --%>
			
	<script type="text/javascript">
	
	document.write('<div id="global_loading" style="width: 100%;height: 100%;position: fixed;top: 0;left: 0;background-color: #eee;z-index:999"><div style="width: 100px;height: 75px;margin:auto;top:50%;position:relative"><span style="display:block;float:left;width:32px;height:32px;margin-top:-5px;"></span>&nbsp;&nbsp;加载中...</div></div>');
	
	</script>
	

</head>
<body> 
	<div class="header" id="header">
		<span class="headline">绑定手机</span>
	</div>
	<section class="signup">
	<div class="form">
		<form method="post" action="" onsubmit="return false;">
			<input type="hidden" name="redirectUrl" id="redirectUrl" value="${redirectUrl}" />
			<input type="hidden" name="wxId" value="u02aadldcl5mdv9v836vatlgb5" />
		<ul>
			<li>
			<input class='tipInput mobile-input' tiptext='手机号' type="text" placeholder="" value="" id="mobile" name="mobile">	
				<span class="signup"> <input id='btn_send' type="button" class="btn validateCode_btn" value="发送验证码" /></span>
			</li>
			<li>
			<input class='tipInput' tiptext='手机验证码' type="text" placeholder="" value="" id="validateCode" name="validateCode">	
			</li>

						<li><input id='btn_enter' type="submit" class="btn" value="注册" /></li>

		
	
	</ul>
		</form>	
	</div>

<script type='text/javascript'>
$(function(){
	$("#btn_enter").click(function(e){
		e.preventDefault();
		var mobile=$("input[name=mobile]").val();
		var validateCode=$("input[name=validateCode]").val();
		var wxId=$("input[name=wxId]").val();
		var redirectUrl=$("#redirectUrl").val();
		redirectUrl = redirectUrl==''?"/wx/home":redirectUrl;
		
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
		if(wxId==''){
			alert("请在微信中完成注册!");
			return false;
		}
		
		$.post('${ctx}/wx/register',{mobile:mobile,validateCode:validateCode,wxId:wxId},function(data){
			//判断注册
			if(data.result == "1"){
					window.location=$("#redirectUrl").val();
			}else{
				alert("亲爱的用户，"+data.error);
			}
		},'JSON')
	});
	$("#btn_send").click(function(){
		sendMobileCode();
	});
});
</script>
</section>
<script type='text/javascript'>
function sendMobileCode(){
	var mobile =  $("#mobile").val().trim();
	if(validePhone(mobile)){
		$.get('${ctx}/common/sendVildateCode?phone='+mobile+'&rand='+Math.random(),function (data){
			
			if(data.result == 1){
				$("#validateCode").val(data.valideCode);
			}else if(data.result == 0){
				alert("手机号已经存在!");
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
</script>


	<script type="text/javascript">
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

