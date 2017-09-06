<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>

<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	

<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">


 <script src="${ctxStatic}/washcar/mobile/images/user/m_code.js" type="text/javascript"></script> 

    <title>个人中心</title> 
<script type="text/javascript" src="${ctxStatic}/washcar/mobile/css/mjava.js"></script>
<script type="text/javascript" src="${ctxStatic}/washcar/mobile/css/md5.js"></script>

    <link href="${ctxStatic}/washcar/mobile/css/user.css" rel="stylesheet" type="text/css">
    <script src="${ctxStatic}/washcar/mobile/css/usercenter.js" type="text/javascript"></script>
    
	<link href="${ctxStatic}/washcar/mobile/css/reset.css" rel="stylesheet" type="text/css" />
	<link href="${ctxStatic}/washcar/mobile/css/head.css" rel="stylesheet" type="text/css" />
</head>
<body>
    
		
		
		  
<div class="publicHead" id="head">
	    <div class="head clearfix">
			<a class="back" href="javascript:history.back();"></a>
			<h2 class="headTitle">个人中心</h2>
            <a class="navBar" href="javascript:;"></a>
        </div>
	</div>
    <section class="userCenter clearfix" id="top">
        <div class="userInfo clearfix">
            <img class="bg" src="${ctxStatic}/washcar/mobile/images/user/topBg.jpg">
            <div class="userDetail">
                <div class="userPhoto">
                    <div class="mask"></div>
                    <img src="${ctxStatic}/washcar/mobile/images/user/userPhoto.png">
                </div>
                <div class="info">
                    <p class="userName">${webUser.userName }</p>
                    <p class="ad">关注洗车家，随时随地洗刷刷</p>
                </div>
            </div>
            <div class="order">
                <p class="grade">LV1 小洁癖</p>
<!--                 <div class="orderStatus">
                    <a href="http://m.jiuxian.com/m_v1/order/index/1"><strong>0</strong><span>待付款</span></a>
                    <a href="http://m.jiuxian.com/m_v1/order/index/7"><strong>0</strong><span>待发货</span></a>
                    <a href="http://m.jiuxian.com/m_v1/order/index/8"><strong>0</strong><span>待收货</span></a>
                    <a href="http://m.jiuxian.com/m_v1/order/index/4"><strong>0</strong><span>已完成</span></a>
                    <span class="line line1"></span>
                    <span class="line line2"></span>
                    <span class="line line3"></span>
                </div> -->
            </div>
        </div>
        <div class="contentFrame">
            <ul class="list clearfix">
                
            	<li><a class="orderList" href="http://m.jiuxian.com/m_v1/order/index/0"><img src="${ctxStatic}/washcar/mobile/images/user/order.png"><span>我的订单</span></a></li>
                <li><a class="wallet" href="${ctx }/wx/user/account"><img src="${ctxStatic}/washcar/mobile/images/user/wallet.png"><span>我的钱包</span></a></li>
                <li><a class="coupon" href="http://m.jiuxian.com/m_v1/user/bonus_list"><img src="${ctxStatic}/washcar/mobile/images/user/coupon.png"><span>我的优惠券</span></a></li>
                
                <li><a class="exchange" href="http://m.jiuxian.com/m_v1/user/exchangecode"><img src="${ctxStatic}/washcar/mobile/images/user/exchange.png"><span>我要兑换</span></a></li>
                <li><a class="safe" href="http://m.jiuxian.com/m_v1/usersafe/index"><img src="${ctxStatic}/washcar/mobile/images/user/safe.png"><span>当前洗车</span></a></li>
                <li><a class="address" href="http://m.jiuxian.com/m_v1/address/index?from=1"><img src="${ctxStatic}/washcar/mobile/images/user/address.png"><span>汽车管理</span></a></li>
                <li><a class="collect" href="http://m.jiuxian.com/m_v1/collect/init"><img src="${ctxStatic}/washcar/mobile/images/user/collect.png"><span>我的收藏</span></a></li>
                <li><a class="history" href="http://m.jiuxian.com/m_v1/user/history"><img src="${ctxStatic}/washcar/mobile/images/user/history.png"><span>浏览历史</span></a></li>
                
            </ul>
        </div>
        
        <!-- <a href="http://m.jiuxian.com/m_v1/user#" class="btn">退出登录</a> -->
        
        
    </section>

</body></html>