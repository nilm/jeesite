<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>个人中心</title> 
    <link rel="stylesheet" href="${ctxStatic}/washcar/common/css/ch_base.css">
    <link rel="stylesheet" href="${ctxStatic}/washcar/user/css/home.css">
    <script src="${ctxStatic}/washcar/mobile/css/usercenter.js" type="text/javascript"></script>

</head>
<body>
<!-- 标题START -->
<header>
    <a href="javascript:window.history.go(-1);" class="h_back"><img src="${ctxStatic}/washcar/common/img/wis_r1_c33.png" alt="后退按钮"></a>
    <h1>我的洗车家</h1>
</header>
<!-- 标题END -->

<!-- 洗车家Banner START -->
<img src="${ctxStatic}/washcar/user/img/banner.png" alt="洗车家" class="mwh_ban">
<!-- 洗车家Banner END -->

<!-- 个人信息资料START -->
<div class="mwh_list">
    <div class="mwh_item_wr">
        <a href="${ctx }/wx/user/order" class="mwh_item">
            <img src="${ctxStatic}/washcar/user/img/mwh_form.png" alt="我的订单" class="mwh_icon">
            <span class="mwh_info">我的订单</span>
        </a>
    </div>
    <div class="mwh_item_wr">
        <a href="${ctx }/wx/user/coupon" class="mwh_item">
            <img src="${ctxStatic}/washcar/user/img/mwh_coupon.png" alt="我的优惠券" class="mwh_icon">
            <span class="mwh_info">我的优惠券</span>
        </a>
    </div>
    <div class="mwh_item_wr">
        <a href="${ctx }/wx/user/account" class="mwh_item">
            <img src="${ctxStatic}/washcar/user/img/mwh_balance.png" alt="我的余额" class="mwh_icon">
            <span class="mwh_info">我的余额</span>
        </a>
    </div>
    <div class="mwh_item_wr">
        <a href="#" class="mwh_item">
            <img src="${ctxStatic}/washcar/user/img/wih_resource.png" alt="我的资料" class="mwh_icon">
            <span class="mwh_info">我的资料</span>
        </a>
    </div>
    <div class="mwh_item_wr">
        <a href="${ctx }/m/u/loginout" class="mwh_item">
            <img src="${ctxStatic}/washcar/user/img/wih_resource.png" alt="退出登录" class="mwh_icon">
            <span class="mwh_info">退出登录</span>
        </a>
    </div>
</div>
<!-- 个人信息资料END -->
</body>
</html>