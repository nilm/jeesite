<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
	<meta name="format-detection" content="telephone=no,email=no,adress=no">
    <title>个人中心</title> 
    <link rel="stylesheet" href="${ctxStatic}/washcar/common/css/ch_base.css">
    <link rel="stylesheet" href="${ctxStatic}/washcar/user/css/couponDetail.css">
    <script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
	
</head>
<body>
<!-- 标题START -->
<header>
    <a href="javascript:window.history.go(-1);" class="h_back"><img src="${ctxStatic}/washcar/common/img/wis_r1_c33.png" alt="后退按钮"></a>
    <h1>优惠券详情</h1>
</header>
<!-- 标题END -->

<!-- 订单详情上START -->
<div class="cd_price">￥${coupon.amount }</div>
<div class="od_item od_item_h1"><c:if test="${coupon.model.type=='0' }" >到店</c:if><c:if test="${coupon.model.type=='1' }" >上门</c:if>洗车优惠券</div>
<!-- 订单详情上END -->

<!-- 订单详情下START -->
<div class="od_list">
    <div class="od_item">
        <div class="od_item_lb">有效期</div>
        <div class="od_item_rb"><fmt:formatDate value="${coupon.startDate }" pattern="yyyy-MM-dd" />至<fmt:formatDate value="${coupon.endDate }" pattern="yyyy-MM-dd" /></div>
    </div>
    <div class="od_item">
        <div class="od_item_lb">使用条件</div>
        <div class="od_item_rb">满${coupon.model.limitAmount }元可用</div>
    </div>
    <div class="od_item">
        <div class="od_item_lb">获取方式</div>
        <div class="od_item_rb">${coupon.getMethod }</div>
    </div>
    <div class="od_item">
        <div class="od_item_lb">获得时间</div>
        <div class="od_item_rb"><fmt:formatDate value="${coupon.createDate }" pattern="yyyy-MM-dd" /></div>
    </div>
    <div class="od_item">
        <div class="od_item_lb" ><span onclick="sendCoupon();">测分享给朋友</span></div>
        <div class="od_item_rb">${coupon.num }</div>
    </div>
</div>
<!-- 订单详情下END -->

<section data-role="page" id="pageSeeHouseTeamList">
         
        <script>
        
        
        wx.config({
    	    debug: true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
    	    appId: 'wxa8e4cd22da9cf17f', // 必填，公众号的唯一标识
    	    timestamp: 1442223888064, // 必填，生成签名的时间戳
    	    nonceStr: 'binger', // 必填，生成签名的随机串
    	    signature: 'jxjJQSEbWVZQetS0uhklDiWIgZ0=',// 必填，签名，见附录1
    	    jsApiList: ['onMenuShareAppMessage'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
    	});
        function sendCoupon(){
        	alert(11);
        	wx.onMenuShareAppMessage({
                title: '哈哈', // 分享标题
                desc: '嘿嘿嘿嘿嘿嘿', // 分享描述
                link:  'http://login.helloan.cn/test/wx/user/coupon/home', // 分享链接
                imgUrl:  , // 分享图标
                type: 'link', // 分享类型,music、video或link，不填默认为link
                dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
                success: function (res) {
                    alert("分享给微信朋友成功");// 用户确认分享后执行的回调函数
                },
                cancel: function () {
                    // 用户取消分享后执行的回调函数
                },
                fail: function (res) {
                    alert(res);
                }
            });
        }
            wx.error(function (res) {
                alert(res);
            });
           
            wx.ready(function () {
                $("img[src$='share_03.gif']").on("click", function () {
                    var isOk = true;
                    wx.checkJsApi({
                        jsApiList: ['onMenuShareQQ'],
                        fail: function (res) {
                            alert("微信版本太低，不支持分享给朋友的功能！");
                            isOk = false;
                        },
                        success: function (res) {
                            alert("支持QQ分享。");
                        }
                    });
                    if (!isOk)
                        return;
                    var $div = $(this).closest("li").children("div");
                    wx.onMenuShareQQ({
                        title: $div.eq(0).children("a").text(), // 分享标题
                        desc: $div.eq(1).find("dt").text() + "," + $div.eq(1).find("dd").text(), // 分享描述
                        link:  $div.eq(0).children("a").attr("href"), // 分享链接
                        imgUrl: $div.eq(1).children("a").css("background").replace("url(", "").replace(")", ""), // 分享图标
                        success: function (res) {
                            alert("分享给QQ好友成功");// 用户确认分享后执行的回调函数
                        },
                        cancel: function () {
                            // 用户取消分享后执行的回调函数
                        },
                        fail: function (res) {
                            alert(res);//$.parseJSON(res).errMsg
                        }
                    });
                });
 
                $("img[src$='share_05.gif']").on("click", function () {
 
                    var $div = $(this).closest("li").children("div");
                    wx.onMenuShareTimeline({
                        title: $div.eq(0).children("a").text(), // 分享标题
                        link:  $div.eq(0).children("a").attr("href"), // 分享链接
                        imgUrl: $div.eq(1).children("a").css("background").replace("url(", "").replace(")", ""), // 分享图标
                        success: function (res) {
                            alert("分享到朋友圈成功");// 用户确认分享后执行的回调函数
                        },
                        cancel: function () {
                            // 用户取消分享后执行的回调函数
                        },
                        fail: function (res) {
                            alert(res);
                        }
                    });
                });
 
                $("img[src$='share_07.gif']").on("click", function () {
                         
                    var $div = $(this).closest("li").children("div");
                    wx.onMenuShareWeibo({
                        title: $div.eq(0).children("a").text(), // 分享标题
                        link:  $div.eq(0).children("a").attr("href"), // 分享链接
                        imgUrl: $div.eq(1).children("a").css("background").replace("url(", "").replace(")", ""), // 分享图标
                        success: function (res) {
                            alert("分享到腾讯微博成功");// 用户确认分享后执行的回调函数
                        },
                        cancel: function () {
                            // 用户取消分享后执行的回调函数
                        },
                        fail: function (res) {
                            alert(res);
                        }
                    });
                });
 
                $("img[src$='share_16.gif']").on("click", function () {
                         
                    var $div = $(this).closest("li").children("div");
                    wx.onMenuShareAppMessage({
                        title: $div.eq(0).children("a").text(), // 分享标题
                        desc: $div.eq(1).find("dt").text() + "," + $div.eq(1).find("dd").text(), // 分享描述
                        link:  $div.eq(0).children("a").attr("href"), // 分享链接
                        imgUrl:  $div.eq(1).children("a").css("background").replace("url(", "").replace(")", ""), // 分享图标
                        type: 'link', // 分享类型,music、video或link，不填默认为link
                        dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
                        success: function (res) {
                            alert("分享给微信朋友成功");// 用户确认分享后执行的回调函数
                        },
                        cancel: function () {
                            // 用户取消分享后执行的回调函数
                        },
                        fail: function (res) {
                            alert(res);
                        }
                    });
                });
            });
 
 
    </script>
        
 
        <div data-role="content" style="padding:0px;background:#FFF;">
            <input id="hdfAppId" type="hidden" runat="server" />
            <input id="hdfTimestamp" type="hidden" runat="server" />
            <input id="hdfNonce" type="hidden" runat="server" />
            <input id="hdfSignature" type="hidden" runat="server" />
            <input id="temp" type="hidden" runat="server" />
            <ul class="ul-seeHouseTeamList">
            <FC:RepeaterPlusNone ID="rptSeeHouseTeam" runat="server">
                <ItemTemplate>
                <li>
                    <div>
                        <a id="lnkTeamTitle" runat="server" href="/teamBuy/seeHouseTeamView-{0}.aspx" data-transition="slide"></a>
                    </div>
                    <div>
                        <a id="lnkHouse" runat="server" href="/teamBuy/seeHouseTeamView-{0}.aspx" data-transition="slide"></a>
                        <dl><dt><asp:Literal ID="ltlPrice" runat="server"></asp:Literal>元/平米</dt><dd><asp:Literal ID="ltlTeamInfo" runat="server"></asp:Literal></dd></dl>
                    </div>
                     
                    <div>
                        <p>已报名<span style="color:#ff6600;"><asp:Literal ID="ltlJoinCount" runat="server"></asp:Literal></span>人</p>
                        <p>
                            分享
                            <img src="/themes/default/images/share_03.gif" />
                            <img src="/themes/default/images/share_05.gif" />
                            <img src="/themes/default/images/share_07.gif" />
                            <img src="/themes/default/images/share_16.gif" />
                        </p>
                    </div>
                    <div>
                        <a id="lnkJoin" runat="server" href="/userCenter/teamBuyJoin.aspx?tbid={0}" data-transition="slide">报 名</a>
                    </div>
                </li>
                </ItemTemplate>
                <NoneTemplate><li style="text-align:center;height:100px;line-height:100px;">对不起，没找到数据！</li></NoneTemplate>
            </FC:RepeaterPlusNone>
                 
            </ul>
        </div>
         
    </section>
</body>
</html>


