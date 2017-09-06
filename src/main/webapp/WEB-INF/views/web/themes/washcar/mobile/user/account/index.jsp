<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>

<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	

<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">

    <title>个人中心</title> 
	  <script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
 <script src="${ctxStatic}/washcar/mobile/images/user/m_code.js" type="text/javascript"></script> 
<script type="text/javascript" src="${ctxStatic}/washcar/mobile/css/mjava.js"></script>
<script type="text/javascript" src="${ctxStatic}/washcar/mobile/css/md5.js"></script>

    <link href="${ctxStatic}/washcar/mobile/css/user.css" rel="stylesheet" type="text/css">
    <script src="${ctxStatic}/washcar/mobile/css/usercenter.js" type="text/javascript"></script>
    
	<link href="${ctxStatic}/washcar/mobile/css/reset.css" rel="stylesheet" type="text/css" />
	<link href="${ctxStatic}/washcar/mobile/css/head.css" rel="stylesheet" type="text/css" />
    <script src="${ctxStatic}/washcar/user/js/pingpp.js" type="text/javascript"></script>
	<script type="text/javascript">
	function tocharge(chanel){
		 $.ajax({
			type:"post",
			async:false,
			url:"${ctx}/weixin/charge/toCharge",
			data:{"chanel":chanel,"money":$("#account").val()},
			dataType:"json",
			success:function(charge){
				pingpp.createPayment(charge, function(result, err){
					alert(result+"--"+err);
					});
			}
			
		}); 
	}
	</script>
</head>
<body>
    
		
		
		  
<div class="publicHead" id="head">
	    <div class="head clearfix">
			<a class="back" href="javascript:history.back();"></a>
			<h2 class="headTitle">我的钱包</h2>
            <a class="navBar" href="javascript:;"></a>
        </div>
	</div>
	<section class="walletFrame" id="topTitle">
        <div class="tabBar clearfix">
            <a class="tab tab3" href="javascript:;" type="3"><span>金币</span><span>50</span><span class="line"></span></a>
        </div>
        <div class="walletEmpty">
				     <span>充值金额:<input type="text" id="account" value="100"></span>
		</div>
		<input type="submit" onclick="tocharge('alipay_wap')" class="btn" value="支付宝支付" />
         <input type="submit" onclick="tocharge('upacp_wap')" class="btn" value="银联支付" />
         <input type="submit" onclick="tocharge('jdpay_wap')" class="btn" value="京东支付" />
         <input type="submit" onclick="tocharge('bfb_wap')" class="btn" value="百度钱宝" />
        <div class="contentFrame">
            <div class="content content1" id="cash">

           		<!--钱包空begin-->
				 <div class="walletEmpty">
				     <span></span>
				     <p class="tips">暂无相关记录</p>
				 </div>
				 <!--钱包空end-->
	       
	  

			</div>
        </div>
    </section>
    


</body></html>