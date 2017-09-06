//手机获取验证码倒计时代码――忘记密码页面

var wait=120;
function time(oname) {
	obj = $("#"+oname);
	if (wait == 0) {	   
	    obj.attr("disabled",false);
	    obj.html("免费获取验证码");
	    wait = 120;
	} else {    
	    obj.attr("disabled",true);
	    obj.html("重新发送(" + wait + ")");
	    wait--;
	    setTimeout(function() {
	        time(oname)
	    },
	    1000)
	}
} 
//手机获取验证码倒计时代码――注册页面

var waitReg=120;
function timeReg(oname) {
	obj = $("#"+oname);
	if (waitReg == 0) {	   
	    obj.attr("disabled",false);
	    obj.html("免费获取验证码");
	    waitReg = 120;
	} else {    
	    obj.attr("disabled",true);
	    obj.html("重新发送(" + waitReg + ")");
	    waitReg--;
	    setTimeout(function() {
	        timeReg(oname)
	    },
	    1000)
	}
}  
//手机获取验证码倒计时代码――申请提现页面

var waitApply=120;
function timeApply(oname) {
	obj = $("#"+oname);
	if (waitApply == 0) {	   
	    obj.attr("disabled",false);
	    obj.html("免费获取验证码");
	    waitApply = 120;
	} else {    
	    obj.attr("disabled",true);
	    obj.html("重新发送(" + waitApply + ")");
	    waitApply--;
	    setTimeout(function() {
	        timeApply(oname)
	    },
	    1000)
	}
}
