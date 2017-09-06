<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>

	   <div class="span2">
	   	 <h4>会员中心</h4>
		 <ol>
			<li class="${requestScope.mymenu == 'home' ?'menu_activ':''}" style="line-height:16px;padding-top:3px;"><a href="${ctx}/user/home">我的${site.title}</a></li>
            <li class="${requestScope.mymenu == 'baseinfo' ?'menu_activ':''}"><a href="${ctx}/user/baseinfo">基础信息</a></li>
            <li class="${requestScope.mymenu == 'account' ?'menu_activ':''}"><a href="${ctx}/user/account">账户管理</a></li>
            <li class="${requestScope.mymenu == 'point' ?'menu_activ':''}"><a href="${ctx}/user/point">积分管理</a></li>
            <li class="${requestScope.mymenu == 'friend' ?'menu_activ':''}"><a href="${ctx}/user/friend">邀请好友</a></li>
		 </ol>
	   </div>
	   <div class="span10">
		 <ul class="breadcrumb">
		 <li>
		  <a href="${ctx}">${site.title}</a> >>
		  </li>
		 <li>
		   <a href="${ctx}/user/${requestScope.mymenu }">
		   <c:choose>
		   	<c:when test="${requestScope.mymenu == 'home' }">
		   	  我的${site.title}
		   	</c:when>
		   	<c:when test="${requestScope.mymenu == 'baseinfo' }">
		   	基础信息
		   	</c:when>
		   	<c:when test="${requestScope.mymenu == 'account' }">
		   	账户管理
		   	</c:when>
		   	<c:when test="${requestScope.mymenu == 'point' }">
		 	  积分管理
		   	</c:when>
		   	<c:when test="${requestScope.mymenu == 'friend' }">
		   	邀请好友
		   	</c:when>
		   </c:choose>
		 
		   </a>
		 </li>
		 </ul>
	   </div>