<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>可选订单</title>
	<meta name="decorator" content="cms_default_${site.theme}"/>
	<meta name="description" content="JeeSite ${site.description}" />
	<meta name="keywords" content="JeeSite ${site.keywords}" />
	<script src="${ctxStatic}/washcar/gate/js/jquery-2.1.4.min.js"></script>
<script type="text/javascript">


	function getOrder(){
		var orderId=$("#orderId").val();
        $.post({
            type: "post",
            url: "${ctx}/washcar/distribute/doDistribute",
            data: {id:orderId},
            success: function(data){
				if(data=="true"){
					window.location.href="${ctx}/washcar/distribute/login/index";
				}else{
					alert(data)
				}
            }
        });
	}
</script>
</head>
<body>
    <div class="row">
        <h4>可选订单</h4>
           	<div >
           		<form action="${ctx}/washcar/distribute/doDistribute" method="post">
           		<table>
           			<c:forEach items="${returnList }" var="dto">
           			<input type="hidden" value="${dto.id }" name="id">
           			<tr>
           				<td>订单号</td>
           				<td>${dto. orderNo}
           				</td>
           			</tr>
           			<tr>
           				<td>联系人手机号</td>
           				<td>${dto.mobilePhone }</td>
           			</tr>
           			<tr>
           				<td>服务名称</td>
           				<td>${dto.product.name }</td>
           			</tr>
           			<tr>
           				<td>车辆品牌</td>
           				<td>${dto.carBrand.brandmodelname }</td>
           			</tr>
           			<tr>
           				<td>车辆颜色</td>
           				<td></td>
           			</tr>
           			<tr>
           				<td>车辆地址</td>
           				<td>${dto.carLocation}</td>
           			</tr>
           			<tr>
           				<td>预约时间</td>
           				<td>${dto.bookTime}</td>
           			</tr>
           			<tr>
           				<td><button  type="submit">接单</button></td>
           			</tr>
           			</c:forEach>
           		</table>
           		</form>
            </div>
    </div>
</body>
</html>