<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    
	<script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=kq53sCGqFHXGrRIUUNaB2xuM"></script>
	
	<link rel="stylesheet" href="${ctxStatic}/washcar/mobile/css/mui.css" />
	<link rel="stylesheet" href="${ctxStatic}/washcar/mobile/css/common.css" />


<style type="text/css">
.dialogWindow .dialogContent {
	text-align: center;
	padding: 10px 20px 20px;
}
.dialogWindow header,
.dialogWindow footer {
	width: 100%;
	padding: 0;
	height: 40px;
	line-height: 40px;
	border-radius: 5px 5px;
}
.box {
	border-top: solid 1px #ccc;
}
.dialogWindow .dialogBtn {
	display: block;
	border-left: solid 1px #ccc;
	border-right: none;
	border-top: none;
	border-bottom: none;
	width: 100%;
	line-height: 36px;
	text-align: center;
	margin: auto;
}
#mcover {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.7);
	display: none;
	z-index: 1000;
}
.ddxc_hdtbmk1{position: absolute;float: left; display: block; width: 40px;left: 53px;top: 0px; margin: -1px -1px 0 0;}
.ddxc_hdtbmk1 img{width: 100%;}
/* .list_star{float: left; display: block; width: 75px; height: 18px; background:#00A0E8;background: url(img/list_star.png) no-repeat -75px center; background-size: 150px;}
.star_1{background-position-x: -60px;}
.star_2{background-position-x: -45px;}
.star_3{background-position-x: -30px;}
.star_4{background-position-x: -15px;}
.star_5{background-position-x: 0px;} */

.shop_comment{
    background: none repeat scroll 0 0 #ffffff;
    height: 100%;
    width: 100%;
}
	.shop_comment h3 {
    color: #333333;
    font-size: 14px;
    font-weight: normal;
    padding: 5px 15px 0;
    width: 100%;
}
   
.shop_comment dl {
    border-top: 1px solid #dcdcdd;
    display: block;
    float: left;
    padding: 10px 15px;
    width: 100%;
}

.shop_comment h3 {
    color: #333333;
    font-size: 14px;
    font-weight: normal;
    padding: 5px 15px 0;
    width: 100%;
}
.shop_comment dl {
    border-top: 1px solid #dcdcdd;
    display: block;
    float: left;
    padding: 10px 15px;
    width: 100%;
}
.shop_comment dl dt {
    width: 100%;
}
.shop_comment dl dt span {
    display: block;
    float: left;
}
.shop_comment dl dt span img {
    width: 20px;
}
.shop_comment dl dt font {
    display: block;
    float: right;
    font-size: 12px;
}
.shop_comment dl dd {
    display: block;
    float: left;
    font-size: 12px;
    width: 100%;
}
   
</style>
</head>
<body style="background: #F1F3F2;">
<div class="shop_comment">
<h3>评价(139)</h3>
		<c:forEach items="${page.list}" var="comment">
			<dl>
				<dt>
					<font><fmt:formatDate value="${comment.createDate }" pattern="yyyy-MM-dd" /></font>
					<font style="padding-right:50px;">139****1705</font>
					<span class="list_star star_4"></span>
				</dt>
				<dd>
				${comment.comment }</dd>
			</dl>
		</c:forEach>
	<dl>
		<dt>
			<font>2015-04-17</font>
			<font style="padding-right:50px;">139****1705</font>
			<span class="list_star star_4"></span>
		</dt>
		<dd>
		这个师傅服务真不错，赞一个！</dd>
	</dl>
	<dl>
		<dt>
			<font>2015-04-17</font>
			<font style="padding-right:50px;">139****1705</font>
			<span class="list_star star_4"></span>
		</dt>
		<dd>
		这个师傅服务真不错，赞一个！</dd>
	</dl>
	<dl>
		<dt>
			<font>2015-04-17</font>
			<font style="padding-right:50px;">139****1705</font>
			<span class="list_star star_4"></span>
		</dt>
		<dd>
		这个师傅服务真不错，赞一个！</dd>
	</dl>
	<dl>
		<dt>
			<font>2015-04-17</font>
			<font style="padding-right:50px;">139****1705</font>
			<span class="list_star star_4"></span>
		</dt>
		<dd>
		这个师傅服务真不错，赞一个！</dd>
	</dl>
	<dl>
		<dt>
			<font>2015-04-17</font>
			<font style="padding-right:50px;">139****1705</font>
			<span class="list_star star_4"></span>
		</dt>
		<dd>
		这个师傅服务真不错，赞一个！</dd>
	</dl>


</div>
</body>