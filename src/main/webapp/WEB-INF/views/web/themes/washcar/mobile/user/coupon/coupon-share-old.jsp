<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>

<html>

<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
	<meta name="format-detection" content="telephone=no,email=no,adress=no">
    <title>个人中心</title> 
    <link rel="stylesheet" href="${ctxStatic}/washcar/common/css/ch_base.css">
    <link rel="stylesheet" href="${ctxStatic}/washcar/user/css/couponDetail.css">
    <script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js" type="text/javascript"></script>
    <script src="${ctxStatic}/washcar/user/js/pingpp.js" type="text/javascript"></script>
	<script type="text/javascript">

	$(function(){
		$("#btn_enter").click(function(e){
			$.post('${ctx}/weixin/charge/toCharge',
				function(charge){
					alert("data"+charge);
					pingpp.createPayment(charge, function(result, err){
						alert(charge);						
						alert(result+"--"+err);
						});
				},json
			)
		});
	});

function tocharge(chanel){
	/* $.ajax({
		type:"post",
		async:false,
		url:"${ctx}/weixin/charge/toCharge",
		data:{"chanel":chanel},
		dataType:"json",
		success:function(charge){
			alert(charge);
			pingpp.createPayment(charge, function(result, err){
				alert(result+"--"+err);
				});
		}
		
	}) */
	alert(chanel);
	var xhr = new XMLHttpRequest();
    xhr.open("POST", "${ctx}/weixin/charge/toCharge?chanel="+chanel, true);
    xhr.setRequestHeader("Content-type", "application/json");
    xhr.send(JSON.stringify({
    	chanel: chanel
    }));

    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4 && xhr.status == 200) {
            alert(xhr.responseText);
            pingpp.createPayment(xhr.responseText, function(result, err) {
            	alert("");
            	alert(result+"--"+err.extra);
            });
        }
    }
}
	</script>
</head>
<body>
<!-- 标题START -->
<header>
    <h1>微信分享</h1>
</header>
<!-- 标题END -->


<!-- 订单详情下START -->
<div class="od_list">
    <div class="od_item">
        <div class="od_item_lb" onclick="sharefriends();">测分享给朋友</div>
    </div>
    <div class="od_item">
        <div class="od_item_lb" onclick="sendCoupon();">分享到朋友圈</div>
    </div>
    <div class="od_item">
        <input type="submit" onclick="tocharge('upacp_pc')" class="btn" value="电脑充值" />
         <input type="submit" onclick="tocharge('wx')" class="btn" value="微信充值" />
         <input type="submit" onclick="tocharge('alipay_wap')" class="btn" value="手机网页支付宝" />
         <input type="submit" onclick="tocharge('alipay')" class="btn" value="支付宝充值" />
    </div>
</div>
<!-- 订单详情下END -->
</body>
</html>


