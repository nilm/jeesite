<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>会计国标账本(科目)管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			var tpl = $("#treeTableTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
			var data = ${fns:toJson(list)}, ids = [], rootIds = [];
			for (var i=0; i<data.length; i++){
				ids.push(data[i].id);
			}
			ids = ',' + ids.join(',') + ',';
			for (var i=0; i<data.length; i++){
				if (ids.indexOf(','+data[i].parentId+',') == -1){
					if ((','+rootIds.join(',')+',').indexOf(','+data[i].parentId+',') == -1){
						rootIds.push(data[i].parentId);
					}
				}
			}
			for (var i=0; i<rootIds.length; i++){
				addRow("#treeTableList", tpl, data, rootIds[i], true);
			}
			$("#treeTable").treeTable({expandLevel : 5});
		});
		function addRow(list, tpl, data, pid, root){
			for (var i=0; i<data.length; i++){
				var row = data[i];
				if ((${fns:jsGetVal('row.parentId')}) == pid){
					$(list).append(Mustache.render(tpl, {
						dict: {
							property: getDictLabel(${fns:toJson(fns:getDictList('accountant_book_property'))}, row.property),
							type: getDictLabel(${fns:toJson(fns:getDictList('accountant_type'))}, row.type),
						blank123:0}, pid: (root?0:pid), row: row
					}));
					addRow(list, tpl, data, row.id);
				}
			}
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/accountant/book/">会计国标账本(科目)列表</a></li>
		<shiro:hasPermission name="accountant:book:edit"><li><a href="${ctx}/accountant/book/form">会计国标账本(科目)添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="book" action="${ctx}/accountant/book/" method="post" class="breadcrumb form-search">
		<ul class="ul-form">
			<li><label>科目编码：</label>
				<form:input path="code" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>用户id：</label>
				<form:input path="user.id" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>商户id：</label>
				<form:input path="companyId" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>账本名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="125" class="input-medium"/>
			</li>
			<li><label>辅助码：</label>
				<form:input path="assistCode" htmlEscape="false" maxlength="128" class="input-medium"/>
			</li>
			<li><label>账本方向：</label>
				<form:radiobuttons path="category" items="${fns:getDictList('accountant_left_right')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</li>
			<li><label>账本性质：</label>
				<form:select path="accountantCategory" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('accountant_category')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>账本属性：</label>
				<form:select path="property" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('accountant_book_property')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>账本类型：</label>
				<form:radiobuttons path="type" items="${fns:getDictList('accountant_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>科目编码</th>
				<th>排序</th>
				<th>用户id</th>
				<th>商户id</th>
				<th>账本名称</th>
				<th>账本属性</th>
				<th>账本类型</th>
				<th>备注</th>
				<shiro:hasPermission name="accountant:book:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody id="treeTableList"></tbody>
	</table>
	<script type="text/template" id="treeTableTpl">
		<tr id="{{row.id}}" pId="{{pid}}">
			<td><a href="${ctx}/accountant/book/form?id={{row.id}}">
				{{row.code}}
			</a></td>
			<td>
				{{row.sort}}
			</td>
			<td>
				{{row.user.id}}
			</td>
			<td>
				{{row.companyId}}
			</td>
			<td>
				{{row.name}}
			</td>
			<td>
				{{dict.property}}
			</td>
			<td>
				{{dict.type}}
			</td>
			<td>
				{{row.remarks}}
			</td>
			<shiro:hasPermission name="accountant:book:edit"><td>
   				<a href="${ctx}/accountant/book/form?id={{row.id}}">修改</a>
				<a href="${ctx}/accountant/book/delete?id={{row.id}}" onclick="return confirmx('确认要删除该账本(科目)及所有子账本(科目)吗？', this.href)">删除</a>
				<a href="${ctx}/accountant/book/form?parent.id={{row.id}}">添加下级账本(科目)</a>
			</td></shiro:hasPermission>
		</tr>
	</script>
</body>
</html>