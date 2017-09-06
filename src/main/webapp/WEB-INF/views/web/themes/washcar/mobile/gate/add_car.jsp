<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=kq53sCGqFHXGrRIUUNaB2xuM"></script>
	 <link rel="stylesheet" href="${ctxStatic}/washcar/common/css/ch_base.css">
	 <script src="${ctxStatic}/washcar/mobile/js/gate/util.js"></script>
     <link rel="stylesheet" href="${ctxStatic}/washcar/gate/css/carInfo.css?v=4">
<script type="text/javascript">
function doOrder(){
	var flag=true;
	var carNo=$("#jCiBrand").html()+$("#carNo").val();
	var carName=$("#carName").html();
	var carColor=$("#carColor").html();
	var vehicleBrand=$("#vehicleBrand").val();
	var vehicleModels=$("#vehicleModels").val();
	if(!isLicensePlateNumber(carNo)){
		alert("车牌格式不正确");
		flag=false;
	}else if(carName=="" || carName==null){
		alert("请选择品牌型号")
		flag=false;
	}else if(carColor=="" || carColor==null){
		alert("车辆颜色不能为空。")
		flag=false;
	}else{
		flag=true;
	}
	
	if(flag==true){
        $.ajax({
            type: "post",
            url: "${ctx}/washcar/gate/map/car/add",
            data: {carNo:carNo,carName:carName,carColor:carColor,vehicleBrand:vehicleBrand,vehicleModels:vehicleModels},
	        success: function(data){
	        	window.location.href="${ctx}/washcar/gate"
	        }
        });
	}
	
}
</script>
</head>
<body >
<!-- 标题START -->
<header>
    <a href="javascript:;"  onclick="toggleCarType();" class="h_back"><img src="${ctxStatic}/washcar/common/img/wis_r1_c33.png" alt="后退按钮"></a>
    <h1>填写车辆信息</h1>
</header>
<!-- 标题END -->


<div id="main">
	<div class="clxx_layout">
		<div class="clxx_cphxx">
			<!-- 车牌号START -->
			<div class="ci_row_wr">
			    <div class="ci_row ci_rbg_no">
			        <div class="ci_brand_wr">
			            <div class="ci_brand" id="jCiBrand">京</div>
			        </div>
			        <div class="ci_ipt_wr">
			            <input type="text" class="ci_ipt" placeholder="请输入车牌号" id="carNo" maxlength="6">
			        </div>
			    </div>
			    <div class="ci_sel_wr">
			        <ul class="ci_sel" id="jCiSel">
			            <li>京</li>
			            <li>津</li>
			            <li>沪</li>
			            <li>渝</li>
			            <li>冀</li>
			            <li>豫</li>
			            <li>云</li>
			            <li>辽</li>
			            <li>黑</li>
			            <li>湘</li>
			            <li>皖</li>
			            <li>鲁</li>
			            <li>新</li>
			            <li>苏</li>
			            <li>浙</li>
			            <li>赣</li>
			            <li>鄂</li>
			            <li>桂</li>
			            <li>甘</li>
			            <li>晋</li>
			            <li>蒙</li>
			            <li>陕</li>
			            <li>吉</li>
			            <li>闽</li>
			            <li>粤</li>
			            <li>贵</li>
			            <li>青</li>
			            <li>藏</li>
			            <li>川</li>
			            <li>宁</li>
			            <li>琼</li>
			        </ul>
			    </div>
			</div>
			<!-- 车牌号END -->
			<div class="ci_row_wr" id="choosecar">
				<div class="ci_row" id="carName">请选择品牌和车型</div>
			</div>
			<div class="ci_row_wr">
			    <div class="ci_row" id="carColor">请选择车身颜色</div>
			    <div class="ci_sel_wr">
			        <ul class="ci_sel" id="carColorSel">
			            <li>黑色</li>
			            <li>白色</li>
			            <li>红色</li>
			            <li>蓝色</li>
			            <li>银灰色</li>
			            <li>深灰色</li>
			            <li>黄色</li>
			            <li>绿色</li>
			            <li>香槟色</li>
			            <li>巧克力色</li>
			            <li>橙色</li>
			            <li>粉色</li>
			            <li>紫色</li>
			            <li>其他</li>
			        </ul>
			    </div>
			</div> 			
		</div>
	</div>
	<div class="clxx-main-btn">
		<input type="hidden"   id="vehicleBrand" >
		<input type="hidden"   id="vehicleModels" >
		<a class="sd_pay"  onclick="doOrder()">确定</a>
	</div>
</div>
	<div id="carType">
		<div id="carbrand">
			<div id="letter">
				<ul id="car1"></ul>
			</div>
			<div id="brand">
				<ul id="A">
					<li brand="AC宝马" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/12116520130511160657_50.png"><span>AC宝马</span></li>
					<li brand="阿尔法·罗米欧" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/61798120130428140745_50.png"><span>阿尔法·罗米欧</span></li>
					<li brand="阿斯顿·马丁" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/78064520130428140754_50.png"><span>阿斯顿·马丁</span></li>
					<li brand="安驰" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/78008020130428140808_50.png"><span>安驰</span></li>
					<li brand="奥迪" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/20307020130428140823_50.png"><span>奥迪</span></li>
					<li brand="奥兹莫比尔" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/62340720130428140834_50.png"><span>奥兹莫比尔</span></li>
				</ul>
				<ul id="B">
					<li brand="巴博斯" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/8187920130428140846_50.png"><span>巴博斯</span></li>
					<li brand="宝骏" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/32678420130428140857_50.png"><span>宝骏</span></li>
					<li brand="宝龙" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/37057920130428140907_50.png"><span>宝龙</span></li>
					<li brand="宝马" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/53926020130428140922_50.png"><span>宝马</span></li>
					<li brand="保时捷" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/2804320130428140942_50.png"><span>保时捷</span></li>
					<li brand="北京汽车" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/20027720130517192204_50.png"><span>北京汽车</span></li>
					<li brand="北汽" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/20122320130428141022_50.png"><span>北汽</span></li>
					<li brand="奔驰" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/55897020130428141108_50.png"><span>奔驰</span></li>
					<li brand="奔腾" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/76222920130428141205_50.png"><span>奔腾</span></li>
					<li brand="本田" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/47173120130428141139_50.png"><span>本田</span></li>
					<li brand="比亚迪" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/12481920130428141224_50.png"><span>比亚迪</span></li>
					<li brand="标致" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/70092620130428141312_50.png"><span>标致</span></li>
					<li brand="别克" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/13362320130428141325_50.png"><span>别克</span></li>
					<li brand="宾利" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/33334920130428141703_50.png"><span>宾利</span></li>
					<li brand="布加迪" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/75773920130428141713_50.png"><span>布加迪</span></li>
				</ul>
				<ul id="C">
					<li brand="昌河" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/14661420130511170715_50.png"><span>昌河</span></li>
					<li brand="长安" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/89232720130511170626_50.png"><span>长安</span></li>
					<li brand="长城" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/24615420130511170647_50.png"><span>长城</span></li>
					<li brand="川汽野马" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/83209320130428143354_50.png"><span>川汽野马</span></li>
				</ul>
				<ul id="D">
					<li brand="DS雪铁龙" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/35055620130510211412_50.png"><span>DS雪铁龙</span></li>
					<li brand="达契亚" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/4555620130428143407_50.png"><span>达契亚</span></li>
					<li brand="大迪" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/28751720130428143446_50.png"><span>大迪</span></li>
					<li brand="大发" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/11507020130428143456_50.png"><span>大发</span></li>
					<li brand="大宇" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/19787620130428143508_50.png"><span>大宇</span></li>
					<li brand="大众" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/19506320130428143519_50.png"><span>大众</span></li>
					<li brand="道奇" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/19708420130428143530_50.png"><span>道奇</span></li>
					<li brand="帝豪" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/30338820130428143615_50.png"><span>帝豪</span></li>
					<li brand="东风" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/62620920130428143811_50.png"><span>东风</span></li>
					<li brand="东南汽车" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/85205620130428143822_50.png"><span>东南汽车</span></li>
				</ul>
				<ul id="F">
					<li brand="Fisker" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/13238320130511161155_50.png"><span>Fisker</span></li>
					<li brand="FM Auto" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/30988420130511161446_50.png"><span>FM
							Auto</span></li>
					<li brand="法拉利" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/30299720130428143833_50.png"><span>法拉利</span></li>
					<li brand="菲亚特" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/70738620130428143844_50.png"><span>菲亚特</span></li>
					<li brand="丰田" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/48572820130428143855_50.png"><span>丰田</span></li>
					<li brand="福迪" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/78234020130511172006_50.png"><span>福迪</span></li>
					<li brand="福特" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/60883720130428144106_50.png"><span>福特</span></li>
					<li brand="福田" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/16499320130428144115_50.png"><span>福田</span></li>
				</ul>
				<ul id="G">
					<li brand="GMC" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/23678620130428140709_50.png"><span>GMC</span></li>
					<li brand="观致汽车" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/64973920130511172259_50.png"><span>观致汽车</span></li>
					<li brand="光冈" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/54491020130428144123_50.png"><span>光冈</span></li>
					<li brand="广汽" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/34915520130511172329_50.png"><span>广汽</span></li>
				</ul>
				<ul id="H">
					<li brand="哈飞" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/56257920130428144139_50.png"><span>哈飞</span></li>
					<li brand="哈弗" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/61338920130511172606_50.png"><span>哈弗</span></li>
					<li brand="海格" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/42860320130511172844_50.png"><span>海格</span></li>
					<li brand="海马" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/6358720130428144147_50.png"><span>海马</span></li>
					<li brand="悍马" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/13979420130428144155_50.png"><span>悍马</span></li>
					<li brand="黑豹" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/53767720130428144206_50.png"><span>黑豹</span></li>
					<li brand="恒天" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/9314120130428144214_50.png"><span>恒天</span></li>
					<li brand="红旗" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/83152120130428144224_50.png"><span>红旗</span></li>
					<li brand="华普" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/17599820130428144232_50.png"><span>华普</span></li>
					<li brand="华泰" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/61572720130428144240_50.png"><span>华泰</span></li>
					<li brand="华翔" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/58960720130428144250_50.png"><span>华翔</span></li>
					<li brand="黄海" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/89595420130428144258_50.png"><span>黄海</span></li>
					<li brand="霍顿" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/71041220130428144433_50.png"><span>霍顿</span></li>
				</ul>
				<ul id="J">
					<li brand="JEEP" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/58817320130510211908_50.png"><span>JEEP</span></li>
					<li brand="吉奥" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/35365520130428144442_50.png"><span>吉奥</span></li>
					<li brand="吉利" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/78048820130428144451_50.png"><span>吉利</span></li>
					<li brand="江淮" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/19485420130428144503_50.png"><span>江淮</span></li>
					<li brand="江铃" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/76138520130428144513_50.png"><span>江铃</span></li>
					<li brand="江南" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/54437520130428144521_50.png"><span>江南</span></li>
					<li brand="捷豹" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/65748920130428144534_50.png"><span>捷豹</span></li>
					<li brand="金杯" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/2144120130428144600_50.png"><span>金杯</span></li>
					<li brand="金旅" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/5564920130517154243_50.png"><span>金旅</span></li>
					<li brand="九龙" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/67645720130428144609_50.png"><span>九龙</span></li>
				</ul>
				<ul id="K">
					<li brand="卡尔森" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/23301020130517155658_50.png"><span>卡尔森</span></li>
					<li brand="开瑞" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/60674920130428144617_50.png"><span>开瑞</span></li>
					<li brand="凯迪拉克" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/27499020130428144625_50.png"><span>凯迪拉克</span></li>
					<li brand="科尼赛克" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/84520520130517170818_50.png"><span>科尼赛克</span></li>
					<li brand="克莱斯勒" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/79595920130428144643_50.png"><span>克莱斯勒</span></li>
				</ul>
				<ul id="L">
					<li brand="拉达" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/29651720130428144651_50.png"><span>拉达</span></li>
					<li brand="兰博基尼" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/85303520130428144659_50.png"><span>兰博基尼</span></li>
					<li brand="蓝旗亚" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/69159820130428144709_50.png"><span>蓝旗亚</span></li>
					<li brand="劳伦士" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/12861120130428144717_50.png"><span>劳伦士</span></li>
					<li brand="劳斯莱斯" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/9672320130428144724_50.png"><span>劳斯莱斯</span></li>
					<li brand="雷克萨斯" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/54473920130428144731_50.png"><span>雷克萨斯</span></li>
					<li brand="雷诺" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/58632320130428144742_50.png"><span>雷诺</span></li>
					<li brand="理念" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/34070620130428144750_50.png"><span>理念</span></li>
					<li brand="力帆" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/73631920130428144758_50.png"><span>力帆</span></li>
					<li brand="莲花" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/84829820130428144805_50.png"><span>莲花</span></li>
					<li brand="猎豹" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/64716720130517172524_50.png"><span>猎豹</span></li>
					<li brand="林肯" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/30857720130428144812_50.png"><span>林肯</span></li>
					<li brand="铃木" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/18787420130428144820_50.png"><span>铃木</span></li>
					<li brand="陆风" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/15845520130428144827_50.png"><span>陆风</span></li>
					<li brand="路虎" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/81899620130428144835_50.png"><span>路虎</span></li>
					<li brand="路特斯" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/26639620130428144845_50.png"><span>路特斯</span></li>
					<li brand="罗孚" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/42570720130428144852_50.png"><span>罗孚</span></li>
				</ul>
				<ul id="M">
					<li brand="马自达" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/9277620130428144901_50.png"><span>马自达</span></li>
					<li brand="玛莎拉蒂" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/70285420130428144913_50.png"><span>玛莎拉蒂</span></li>
					<li brand="迈巴赫" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/71340120130428144930_50.png"><span>迈巴赫</span></li>
					<li brand="迈凯伦" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/25825220130428144937_50.png"><span>迈凯伦</span></li>
					<li brand="迷你" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/38966520130428144946_50.png"><span>迷你</span></li>
					<li brand="名爵" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/6714920130428144953_50.png"><span>名爵</span></li>
				</ul>
				<ul id="N">
					<li brand="纳智捷" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/47700020130428145000_50.png"><span>纳智捷</span></li>
				</ul>
				<ul id="O">
					<li brand="讴歌" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/77252820130428145008_50.png"><span>讴歌</span></li>
					<li brand="欧宝" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/35637920130428145015_50.png"><span>欧宝</span></li>
					<li brand="欧朗" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/43549620130517172629_50.png"><span>欧朗</span></li>
				</ul>
				<ul id="P">
					<li brand="帕加尼" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/4613820130428145127_50.png"><span>帕加尼</span></li>
					<li brand="庞蒂克" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/67926020130428145135_50.png"><span>庞蒂克</span></li>
				</ul>
				<ul id="Q">
					<li brand="奇瑞" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/4764720130428145143_50.png"><span>奇瑞</span></li>
					<li brand="启辰" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/86267620130428145150_50.png"><span>启辰</span></li>
					<li brand="起亚" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/80801420130428145209_50.png"><span>起亚</span></li>
					<li brand="庆铃" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/36312220130428145228_50.png"><span>庆铃</span></li>
				</ul>
				<ul id="R">
					<li brand="Rossion" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/36882220130511165651_50.png"><span>Rossion</span></li>
					<li brand="日产" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/62632920130428145238_50.png"><span>日产</span></li>
					<li brand="荣威" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/20452820130428145334_50.png"><span>荣威</span></li>
					<li brand="如虎" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/10603420130517173053_50.png"><span>如虎</span></li>
					<li brand="瑞麒" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/42244320130428145414_50.png"><span>瑞麒</span></li>
				</ul>
				<ul id="S">
					<li brand="Smart" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/41814420130428140726_50.png"><span>Smart</span></li>
					<li brand="SPIRRA" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/2950520130428140736_50.png"><span>SPIRRA</span></li>
					<li brand="萨博" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/1176420130428145430_50.png"><span>萨博</span></li>
					<li brand="三菱" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/45295420130428145438_50.png"><span>三菱</span></li>
					<li brand="陕汽通家" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/7584820130517174848_50.png"><span>陕汽通家</span></li>
					<li brand="上汽大通" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/67630820130511171826_50.png"><span>上汽大通</span></li>
					<li brand="世爵" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/79986920130428145445_50.png"><span>世爵</span></li>
					<li brand="双环" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/82210320130428145452_50.png"><span>双环</span></li>
					<li brand="双龙" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/47831620130428145459_50.png"><span>双龙</span></li>
					<li brand="水星" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/18804920130428145507_50.png"><span>水星</span></li>
					<li brand="思铭" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/43871420130517192908_50.png"><span>思铭</span></li>
					<li brand="斯巴鲁" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/85738720130428145515_50.png"><span>斯巴鲁</span></li>
					<li brand="斯柯达" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/84967220130428145522_50.png"><span>斯柯达</span></li>
				</ul>
				<ul id="T">
					<li brand="塔塔" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/6924020130428145529_50.png"><span>塔塔</span></li>
					<li brand="特斯拉" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/70491220130517193209_50.png"><span>特斯拉</span></li>
					<li brand="腾势" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/77213920130428145537_50.png"><span>腾势</span></li>
					<li brand="天马" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/81567320130428145544_50.png"><span>天马</span></li>
					<li brand="土星" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/22386420130428145551_50.png"><span>土星</span></li>
				</ul>
				<ul id="W">
					<li brand="威麟" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/53856620130428145601_50.png"><span>威麟</span></li>
					<li brand="威旺" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/60696520130428145608_50.png"><span>威旺</span></li>
					<li brand="威兹曼" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/44852720130428145617_50.png"><span>威兹曼</span></li>
					<li brand="沃尔沃" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/21898220130428145823_50.png"><span>沃尔沃</span></li>
					<li brand="沃克斯豪尔" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/7831520130517193429_50.png"><span>沃克斯豪尔</span></li>
					<li brand="五菱" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/51954220130428145831_50.png"><span>五菱</span></li>
					<li brand="五十铃" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/9226720130428145838_50.png"><span>五十铃</span></li>
				</ul>
				<ul id="X">
					<li brand="西雅特" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/34806620130517193510_50.png"><span>西雅特</span></li>
					<li brand="夏利" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/11680020130428145853_50.png"><span>夏利</span></li>
					<li brand="现代" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/39285320130428145901_50.png"><span>现代</span></li>
					<li brand="雪佛兰" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/49358820130428145910_50.png"><span>雪佛兰</span></li>
					<li brand="雪铁龙" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/59871820130428145917_50.png"><span>雪铁龙</span></li>
				</ul>
				<ul id="Y">
					<li brand="一汽" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/22051420130428145926_50.png"><span>一汽</span></li>
					<li brand="依维柯" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/68974520130428145939_50.png"><span>依维柯</span></li>
					<li brand="英菲尼迪" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/75148220130428145945_50.png"><span>英菲尼迪</span></li>
					<li brand="英伦汽车" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/20697020130428145952_50.png"><span>英伦汽车</span></li>
					<li brand="永源" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/9109020130428150006_50.png"><span>永源</span></li>
				</ul>
				<ul id="Z">
					<li brand="长丰汽车" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/42063120130428143336_50.png"><span>长丰汽车</span></li>
					<li brand="中华" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/56251620130428150013_50.png"><span>中华</span></li>
					<li brand="中欧" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/2597220130517194116_50.png"><span>中欧</span></li>
					<li brand="中兴" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/47941320130428150022_50.png"><span>中兴</span></li>
					<li brand="众泰" onclick="clickImg(this)"><img
						src="http://www.exc118.com/resources/vehidleBrandPic/69981720130428150030_50.png"><span>众泰</span></li>
				</ul>
			</div>
			<div id="cars">
				<ul class="clearfix" id="car3"></ul>
			</div>
		</div>
	</div>
	<div id="cars">
<div class="header">
<div class="left" onclick="toggleCarType();">
<img src="${ctxStatic}/washcar/common/img/wis_r1_c33.png" height="30" width="48">
</div>
</div>
<ul id="car3" class="clearfix"></ul>
</div>
</div>
</div>
<input id="form_submit" name="form_submit" value="true" type="hidden">
<input id="form_hash" name="formhash" value="ae097c84" type="hidden">
<div id="userId" style="display: none">FS140831854126446355</div>

<script type="text/javascript">
</script>


<!--品牌信息-->
<script type="text/javascript" src="${ctxStatic}/washcar/mobile/js/gate/jquery.js"></script>
<script type="text/javascript" src="${ctxStatic}/washcar/mobile/js/gate/util.js"></script>
<script type="text/javascript" src="${ctxStatic}/washcar/mobile/js/gate/toPinYin.js"></script>
<script type="text/javascript" src="${ctxStatic}/washcar/mobile/js/gate/xinghao.js"></script>
<script type="text/javascript" src="${ctxStatic}/washcar/mobile/js/gate/cartype.js"></script>
<script type="text/javascript" src="${ctxStatic}/washcar/mobile/js/gate/custom.js"></script>
<script type="text/javascript" src="${ctxStatic}/washcar/mobile/js/gate/vehicleInspection.js"></script>
<script src="${ctxStatic}/washcar/gate/js/carInfo.js?v=1"></script>
</body>