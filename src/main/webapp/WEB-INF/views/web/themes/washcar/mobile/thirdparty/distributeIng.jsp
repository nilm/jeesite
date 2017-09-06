<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>登录</title>
	<meta name="decorator" content="cms_default_${site.theme}"/>
	<meta name="description" content="JeeSite ${site.description}" />
	<meta name="keywords" content="JeeSite ${site.keywords}" />
	<script src="${ctxStatic}/washcar/gate/js/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	function doLogin(){
		var username=$("#username").val();
		var password=$("#password").val();
		if ($('#username').val() == ''){
			alert('请填写账号');
		}else if ($('#password').val() == ''){
			alert('请填写密码');
		}else{
	        $.ajax({
	            type: "post",
	            url: "${ctx}/washcar/distribute/login/do",
	            data: {username:username,password:password},
	            success: function(data){
					if(data=="true"){
						window.location.href="${ctx}/washcar/distribute/login/index";
					}else{
						alert(data)
					}
	            }
	        });
		}
	}
</script>
</head>
<body>
    <div class="row">
        <h4>派送中订单</h4>
           	<div >
           		<form action="${ctx}/washcar/distribute/doSent" method="post">
           		<input type="hidden" value="${backOrder.id }" name="id">
           		<table>
           			<tr>
           				<td>订单号</td>
           				<td>${backOrder. orderNo}
           				</td>
           			</tr>
           			<tr>
           				<td>联系人手机号</td>
           				<td>${backOrder.mobilePhone }</td>
           			</tr>
           			<tr>
           				<td>服务名称</td>
           				<td>${backOrder.product.name }</td>
           			</tr>
           			<tr>
           				<td>车辆品牌</td>
           				<td>${backOrder.carBrand.brandmodelname }</td>
           			</tr>
           			<tr>
           				<td>车辆颜色</td>
           				<td></td>
           			</tr>
           			<tr>
           				<td>车辆地址</td>
           				<td>${backOrder.carLocation}</td>
           			</tr>
           			<tr>
           				<td>预约时间</td>
           				<td>${backOrder.bookTime}</td>
           			</tr>
           			<tr>
           				<td><button  type="submit">完成</button></td>
           			</tr>
           		</table>
           		</form>
            </div>
    </div>
</body>
</html>