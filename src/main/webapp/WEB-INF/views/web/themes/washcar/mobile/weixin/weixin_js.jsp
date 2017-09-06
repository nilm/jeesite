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
	<script type="text/javascript">
	wx.config({
	    debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
	    appId: 'wxa8e4cd22da9cf17f', // 必填，公众号的唯一标识
	    timestamp: '${config.timestamp}', // 必填，生成签名的时间戳
	    nonceStr: '${config.noncestr}', // 必填，生成签名的随机串
	    signature: '${config.signature}',// 必填，签名，见附录1
	    jsApiList: [
        'checkJsApi',
        'onMenuShareTimeline',
        'onMenuShareAppMessage',
        'onMenuShareQQ',
        'onMenuShareWeibo',
        'onMenuShareQZone',
        'hideMenuItems',
        'showMenuItems',
        'hideAllNonBaseMenuItem',
        'showAllNonBaseMenuItem',
        'translateVoice',
        'startRecord',
        'stopRecord',
        'onVoiceRecordEnd',
        'playVoice',
        'onVoicePlayEnd',
        'pauseVoice',
        'stopVoice',
        'uploadVoice',
        'downloadVoice',
        'chooseImage',
        'previewImage',
        'uploadImage',
        'downloadImage',
        'getNetworkType',
        'openLocation',
        'getLocation',
        'hideOptionMenu',
        'showOptionMenu',
        'closeWindow',
        'scanQRCode',
        'chooseWXPay',
        'openProductSpecificView',
        'addCard',
        'chooseCard',
        'openCard'
      ] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
	});
	function sendCoupon(){
		wx.chooseImage({
		    count: 1, // 默认9
		    sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
		    sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
		    success: function (res) {
		        var localIds = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
		    }
		});
		//alert("asdfsda");
	}
	function sharefriends(){
		
		wx.onMenuShareTimeline({
			  title: '互联网之子',
			  link: 'http://movie.douban.com/subject/25785114/',
			  imgUrl: 'http://demo.open.weixin.qq.com/jssdk/images/p2166127561.jpg',
			  trigger: function (res) {
				// 不要尝试在trigger中使用ajax异步请求修改本次分享的内容，因为客户端分享操作是一个同步操作，这时候使用ajax的回包会还没有返回
				alert('用户点击分享到朋友圈');
			  },
			  success: function (res) {
				alert('已分享');
			  },
			  cancel: function (res) {
				alert('已取消');
			  },
			  fail: function (res) {
				alert(JSON.stringify(res));
			  }
			});
			alert('已注册获取“分享到朋友圈”状态事件');
		
		 }
wx.checkJsApi({
    jsApiList: ['chooseImage'], // 需要检测的JS接口列表，所有JS接口列表见附录2,
    success: function(res) {
        // 以键值对的形式返回，可用的api值true，不可用为false
        // 如：{"checkResult":{"chooseImage":true},"errMsg":"checkJsApi:ok"}
		alert(res);
    }
});
	wx.ready(function(){
		alert(000);
		/* wx.checkJsApi({
		    jsApiList: ['onMenuShareAppMessage'], // 需要检测的JS接口列表，所有JS接口列表见附录2,
		    success: function (res) { 
		        alert('success');
		    },
		    fail:function () {
		    	alert('fail');
		    },
		    complete:function () {
		    	alert("complete");
		    },
		    cancel: function () { 
		    	alert('cancel');
		        // 用户取消分享后执行的回调函数
		    }
		}); */
		/* wx.onMenuShareAppMessage({
		    title: '哇哈哈', // 分享标题
		    desc: '哇哈哈哈啊哇哈哈', // 分享描述
		    link: 'www.baidu.com', // 分享链接
		    imgUrl: '', // 分享图标
		    type: '', // 分享类型,music、video或link，不填默认为link
		    dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
		    success: function () { 
		        alert('success');
		    },
		    fail:function () {
		    	alert('fail');
		    },
		    complete:function () {
		    	alert("complete");
		    },
		    cancel: function () { 
		    	alert('cancel');
		        // 用户取消分享后执行的回调函数
		    }
		}); */
		
		/* wx.onMenuShareAppMessage({
	    title: '哇哈哈', // 分享标题
	    desc: '哇哈哈哈啊哇哈哈', // 分享描述
	    link: 'www.baidu.com', // 分享链接
	    imgUrl: '', // 分享图标
	    type: '', // 分享类型,music、video或link，不填默认为link
	    dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
	    success: function () { 
	        alert('success');
	    },
	    fail:function () {
	    	alert('fail');
	    },
	    complete:function () {
	    	alert("complete");
	    },
	    cancel: function () { 
	    	alert('cancel');
	        // 用户取消分享后执行的回调函数
	    }
	}); */
	
	});
	
	wx.error(function(res){
		alert("error");
	});
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
        <div class="od_item_lb" onclick="sendCoupon();">测分享给朋友</div>
    </div>
    <div class="od_item">
        <div class="od_item_lb" onclick="sharefriends();">分享给朋友圈</div>
    </div>
</div>
<!-- 订单详情下END -->
</body>
</html>


