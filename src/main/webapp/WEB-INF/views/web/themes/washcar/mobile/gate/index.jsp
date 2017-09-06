<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh_CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="initial-scale=1.0,user-scalable=no">
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
    <title>上门洗车</title>
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <link rel="stylesheet" href="${ctxStatic}/washcar/common/css/ch_base.css">
    <link rel="stylesheet" href="${ctxStatic}/washcar/common/css/zero.css">
    <link rel="stylesheet" href="${ctxStatic}/washcar/gate/css/washInHome.css">
    <script src="${ctxStatic}/washcar/gate/js/jquery-2.1.4.min.js"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=kq53sCGqFHXGrRIUUNaB2xuM"></script>
    <script type="text/javascript"src="http://webapi.amap.com/maps?v=1.3&key=4a2f20eb63859dc19c9db3dce5b47cb0"></script>
</head>
<body>
<!-- 标题START -->
<header>
    <a href="#" class="h_back"><img src="${ctxStatic}/washcar/common/img/wis_r1_c33.png" alt="后退按钮"></a>
    <h1>上门洗车</h1>
</header>
<!-- 标题END -->
<!-- 车主信息START -->
<div class="hi_list">
    <div class="hi_item_wrap">
        <a href="javascript:;" class="hi_item">
            <div class="hi_item_icon">
                <img src="${ctxStatic}/washcar/gate/img/wih_tel.png" alt="电话">
            </div>
            <c:if test="${empty currentUser}">
            	<div class="hi_item_info">
            		<input type="text" placeholder="请填写手机号" class="hi_item_ipt" onclick="goLogin()" id="phone">
				</div>
            </c:if>
             <c:if test="${!empty currentUser}">
            	<div class="hi_item_info">${currentUser.mobile }</div>
            </c:if>
            
        </a>
    </div>
    <div class="hi_item_wrap">
        <a href="javascript:;" class="hi_item">
            <div class="hi_item_icon">
                <img src="${ctxStatic}/washcar/gate/img/wih_info.png" alt="汽车">
            </div>
            <div class="hi_item_info"><input type="text" placeholder="请填写车辆信息" class="hi_item_ipt" onclick="goAddCar()"  id="carInfo"></div>
            <input type="text"   id="carNo" value="${carNo }">
            <input type="text"   id="carColor" value="${carColor }">
        </a>
    </div>  
    <div class="hi_item_wrap">
        <a href="javascript:;" class="hi_item bg_no">
            <div class="hi_item_icon">
                <img src="${ctxStatic}/washcar/gate/img/wih_loc.png" alt="定位">
            </div>
            <div class="hi_item_info"><input type="text" placeholder="请选择车辆位置" class="hi_item_ipt"  id="carLocation" onclick="toCarLocation()" value="${search_word }"> 
            <input type="text"   id="vehicleBrand" value="${vehicleBrand }">
			<input type="text"   id="vehicleModels" value="${vehicleModels}">
            </div>
        </a>
    </div>
    <div class="hi_item_wrap" id="jChooseDay">
        <a href="javascript:;" class="hi_item">
            <div class="hi_item_icon">
                <img src="${ctxStatic}/washcar/gate/img/wih_time.png" alt="日历">
            </div>
            <div class="hi_item_time">
                <div class="hi_item_day" id="jHiItemDay">今天(${nowDate }，${nowWeek })</div>
                <div class="hi_itme_stamp" id="jHiItemStamp">请预约上门洗车的时间</div>
            </div>
        </a>
    </div>

    <!-- 预约时间START -->
    <div class="od_time_md" id="jOdTimeMd">
        <div class="serv_tps serv_tps_tc" id="jOrderTime">
            <a href="javascript:;" class="od_time_btn" id="jOdTimeBtn">取消</a>
        </div>
        <div class="odtime_days">
            <div class="odtime_day active"><span class="up">今天</span><br><span class="md">${nowDate }</span><span class="dn">${nowWeek }</span></div>
            <div class="odtime_day "><span class="up">明天</span><br><span class="md">${tomorrowDate }</span><span class="dn">${tomorrowWeek }</span></div>
            <div class="odtime_day"><span class="up">后天</span><br><span class="md">${afterDate }</span><span class="dn">${afterWeek }</span></div>
        </div>
        <div class="odtime_time_grp">
            <div class="odtime_time active">
                <div class="odtime_unit"><span class="up">07:00-8:00 </span><br> <span class="dn"></span></div>
                <div class="odtime_unit"><span class="up">08:00-9:00 </span><br> <span class="dn"></span></div>
                <div class="odtime_unit"><span class="up">09:00-10:00 </span><br> <span class="dn"></span></div>
                <div class="odtime_unit"><span class="up">10:00-11:00</span> <br><span class="dn"> </span></div>
                <div class="odtime_unit"><span class="up">11:00-12:00</span> <br><span class="dn"> </span></div>
                <div class="odtime_unit"><span class="up">13:00-14:00</span> <br><span class="dn"> </span></div>
                <div class="odtime_unit"><span class="up">14:00-15:00</span> <br><span class="dn"> </span></div>
                <div class="odtime_unit"><span class="up">15:00-16:00</span> <br><span class="dn"> </span></div>
                <div class="odtime_unit"><span class="up">16:00-17:00 </span><br><span class="dn"> </span></div>
                <div class="odtime_unit"><span class="up">17:00-18:00</span> <br><span class="dn"> </span></div>
                <div class="odtime_unit"><span class="up">19:00-20:00 </span><br><span class="dn"> </span></div>
            </div>
        </div>
    </div>
    <!-- 预约时间END -->
</div>
<!-- 车主信息END -->
<div id="container"></div>

<!-- 选择服务START -->
<div class="mask" id="jMask" style="display: none;"></div>
<div class="choose_serv" id="jChooseServ" style="display: none;">
	<c:forEach items="${products }" var="product" varStatus="status">
		<label class="sd_serv_item">
	        <input type="radio" name="pro_radio" class="sd_ck" value="${product.actualamt }" id="pro_${product.id }" dataid="${product.id }"  <c:if test="${status.first }">checked="checked"</c:if>>
	        <div class="sd_fkck_wr">
	            <div class="sd_fkck"></div>
	        </div>
	        <div class="sd_price">￥${product.actualamt }</div>
	        <div class="serv_main">
	        	 <div class="serv_mtitle">${product.name }</div>
                 <div class="serv_summary ell">专业外观清洗，内饰、地板细致清洁。全套龟牌进口清洁剂。</div>
	        </div>
	 	</label>
	</c:forEach>
</div>
<!-- 选择服务END -->

<!-- 支付START -->
<div class="sd_pay_panel">
	<div class="sd_pay" onclick="doOrder()">洗完支付25元</div>
	<div class="sd_pay_list" id="jSdPayList">
		<div class="sd_pay_head">请选择支付方式　　</div>
		<div class="sd_pay_item" data-url="${ctx}/washcar/gate/doOrder"><span class="sd_pitem_tc"><img src="${ctxStatic}/washcar/gate/img/baidu_pay.jpg" class="sd_pay_icon">百付宝支付</span></div>
		<div class="sd_pay_item" data-url="${ctx}/washcar/gate/doOrder"><span class="sd_pitem_tc"><img src="${ctxStatic}/washcar/gate/img/wechat_pay.jpg" class="sd_pay_icon">微信支付</span></div>
		<div class="sd_pay_btn" onclick="$('#jSdPayList').slideUp('slow',function(){$('#jMask').hide()});">取消</div>
	</div>
</div>
<!-- 支付END -->
<script type="text/javascript">
$(document).ready(function(){
	var carInfo="${carNo}"+"-"+"${carColor}"+"-"+"${carName}"
	if(carInfo!="--"){
		$("#carInfo").val(carInfo)
	}
	checkDisable();
})
function toCarLocation(){
	window.location.href="${ctx}/washcar/gate/map"
}
function goLogin(){
	window.location.href="${ctx}/m/u/login"
}

function goAddCar(){
	window.location.href="${ctx}/washcar/gate/addcar"
}


function doOrder(){
	var flag=true;
	var phone="13912345678";
	var carInfo=$("#carInfo").val();
	var carLocation=$("#carLocation").val();
	var vehicleModels=$("#vehicleModels").val();
	var dateStr=$("#jHiItemDay").html();
	if(phone=="" || phone==null){
		alert("请输入手机号");
		flag=false;
	}else if(carInfo=="" || carInfo==null){
		alert("请填写车辆信息")
		flag=false;
	}else if(carLocation=="" || carLocation==null){
		alert("请选择车辆位置")
		flag=false;
	}else if(dateStr=="请预约上门洗车的时间"){
		alert("请预约上门洗车的时间")
		flag=false;		
	}else{
		flag=true;
	}
	
	if(flag==true){
		//弹出支付方式选择框
		$("#jMask").show();
		$("#jSdPayList").slideDown('slow');
	}
	
}

$("#jSdPayList>.sd_pay_item").click(function(){
	var proid=$("input[name='pro_radio']:checked").attr("dataid");
	var carInfo=$("#carInfo").val();
	var phone="13912345678";
	var carNo=$("#carNo").val();
	var carColor=$("#carColor").val();
	var carLocation=$("#carLocation").val();
	var vehicleBrand=$("#vehicleBrand").val();
	var dateStr=$("#jHiItemDay").html();
	var timeStr=$("#jHiItemStamp").html();
	var postUrl = this['data-url'];
	 $.ajax({
         type: "post",
         url: postUrl,//${ctx}/washcar/gate/doOrder
         data: {proid:proid,carInfo:carInfo,phone:phone,carNo:carNo,carColor:carColor,carLocation:carLocation,vehicleBrand:vehicleBrand,
         	vehicleModels:vehicleModels,dateStr:dateStr,timeStr:timeStr},
         success: function(data){

         }
     });
	 $("#jMask").hide();
	 $("#jSdPayList").slideUp('slow');
});

//关闭选择服务对话框
$("#jMask").click(function(){
	$("#jChooseServ").hide();
	if(!$("#jSdPayList").is(":hidden")){
		$("#jSdPayList").slideUp('slow',function(){
			$("#jMask").hide();
		});
	}else{
		$("#jMask").hide();
	}
});
</script>
<script src="${ctxStatic}/washcar/gate/js/washInHome.js"></script>
</body>
</html>