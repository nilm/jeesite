<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>

<!DOCTYPE html>
<html>
    <head>
        
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" media="(device-height: 568px)">
<meta name="viewport" content="width=320,maximum-scale=1.3,user-scalable=no">
<meta name="format-detection" content="telephone=no"/>

	<link rel="stylesheet" href="${ctxStatic}/washcar/paycode/css/paycode.css" />
<script type="text/javascript">
    var ctx = '';
</script>
        <title>支付码</title>
    </head>
    <body>
        <div class="swiper-container">
            <div class="swiper-wrapper">
                <div class="swiper-slide">
                    <div class="topBg"> </div>
                    <div  class="h45">请将6位支付码告知网点</div>
                    <div class="title h45" id="num">${code }</div>
                    <div class="con1 h45">支付码有效期<span id="expire" class="color_o" style="padding: 0 10px;"></span>秒</div>
                </div>
            </div>
        </div>
        <div class="errorTs">获取验证码失败，请稍后重试。</div>
        <!--<script src="/js/zepto.min.js"></script>--> 
        <script>
            var remailSeconds = parseInt(120.917);
            document.getElementById("expire").innerHTML = remailSeconds;
            window.setInterval(function () {
                if (0 >= remailSeconds) {
                    window.location.reload();
                } else {
                    remailSeconds--;
                    document.getElementById("expire").innerHTML = remailSeconds;
                }
            }, 1000);
        </script>
    </body>
</html>
