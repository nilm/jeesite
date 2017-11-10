<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet" href="http://www.ztree.me/v3/css/common.css?2013031101" type="text/css">
<link rel='stylesheet' href='http://www.ztree.me/v3/css/zTreeStyle/zTreeStyleForDemo.css?2013031101' type='text/css'> 
<script type="text/javascript" src="http://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
<script type="text/javascript" src="http://www.ztree.me/v3/js/jquery.ztree.core.js?2013031101"></script>
<style type="text/css">
.level{background: #54b4eb}
</style>
</head>
<body style="width:600px;background: white;">

<div class="content_wrap">
    <div class="zTreeDemoBackground left">
        <ul id="treeDemo" class="ztree"></ul>
    </div>
    <shiro:hasPermission name="accountant:book:import:edit">
        <button id="toRight">添加</button>
        <button id="toLeft">删除</button>
        <button id="show">保存</button>
        </shiro:hasPermission>
    <div class="right">
        <ul id="treeDemo2" class="ztree"></ul>
    </div>
</div>
</body>
<script type="text/javascript">
        var zTreeObj1;
        var zTreeObj2;
        var leftDivStr = "[";
        var rightDivStr = "[";
        var setting = {
            edit: {
                enable: false,
                showRemoveBtn: false,
                showRenameBtn: false
            },
            data: {
                simpleData: {
                    enable: true
                }
            },
            callback: {
                //onClick : menuOnClick
            }
        };
        function menuOnClick(event, treeId, treeNode, clickFlag) {
             
        }
        //注册toSource函数，解决ie不支持Array的toSource()方法的问题
        Array.prototype.toSource = function (){
             var str = "[";
             for(var i = 0 ;i<this.length;i++){
                 str+="{id:\""+this[i].id+
                         "\",pId:\""+this[i].pId
                         +"\",name:\""+this[i].name
                         +"\",isParent:\""+this[i].isParent
                         +"\",file:\""+this[i].file
                         +"\",icon:\""+this[i].icon
                         +"\",open:\""+this[i].open
                         +"\"},";
             }
             if(this.length != 0){
                 str = str.substring(0, str.length-1);
             }
             str +="]";
            return str;
        } ;
        //注册unique函数，去掉array中重复的对象（id相同即为同一对象）
        Array.prototype.unique = function (){
             var r = new Array();
            label:for(var i = 0, n = this.length; i < n; i++) {
                for(var x = 0, y = r.length; x < y; x++) {
                    if(r[x].id == this[i].id) {
                        continue label;
                    }
                }
                r[r.length] = this[i];
            }
            return r;
        } ;
        var books = '${list}';
        var dataobj = eval(books); //转换为json对象
        var nodesStr="";
        var zNodes =[];
        for(var i = 0;i<dataobj.length;i++){
        	nodesStr="{\"id\":"+dataobj[i].id+",\"pId\":"+dataobj[i].pId+",\"name\":\""+ dataobj[i].name+"\",\"open\":true}"
            var nn = JSON.parse(nodesStr)
            	zNodes[i]=nn;
        }
        for(var i=0;i<zNodes.length;i++){
            leftDivStr+="{id:"+zNodes[i].id+",pId:"+zNodes[i].pId+",name:\""+zNodes[i].name+"\",open:"+zNodes[i].open+"},";
           }
        leftDivStr = leftDivStr.substring(0,leftDivStr.length-1);
        leftDivStr+="]";
        rightDivStr += "]";
         
        //查找被移动节点的所有父节点
        function findParentNodes(treeNode, parentNodes){
            parentNodes += "{id:"+treeNode.id+",pId:"+treeNode.pId+
            ",name:\""+treeNode.name+"\",open:"+treeNode.open+"},";
            if(treeNode != null && treeNode.getParentNode()!= null){
                parentNodes =findParentNodes(treeNode.getParentNode(),parentNodes);
                 
            }
            return parentNodes;
        }        
        //移动节点
        function moveNodes(zTreeFrom,treeNode,zTreeTo,divStrFrom,divStrTo){
            /////////////////////////////////treeNode的所有父节点
            var parentNodes ="[";
            if(treeNode.pId != null){
                parentNodes = findParentNodes(treeNode,parentNodes);
                parentNodes = parentNodes.substring(0,parentNodes.length-1);
            }
             
            parentNodes +="]";
            //alert(parentNodes);
            var parentNodesArray = eval(parentNodes);
            ///////////////////////////////
            var nodes = "[";
            nodes+= "{id:"+treeNode.id+",pId:"+treeNode.pId+",name:\""+treeNode.name+"\",open:"+treeNode.open+"},";
            nodes = operChildrenNodes(treeNode,nodes);
            nodes = nodes.substring(0,nodes.length-1);
            nodes+="]";
            var nodesArray = eval(nodes);
            var divFromArray = eval(divStrFrom);
            var divToArray = eval(divStrTo);
            for(var i = 0;i<nodesArray.length;i++){//删除节点
                for(var j = 0;j<divFromArray.length;j++){
                    if(divFromArray[j].id == nodesArray[i].id){
                        divFromArray.splice(j,1);
                    }
                }
            }
             
            divToArray = divToArray.concat(nodesArray);//增加节点
            divToArray = divToArray.concat(parentNodesArray);
             
            ///////////////////////////////////////////////////////////////////////////////////////去重复
            divFromArray = divFromArray.unique();
            divToArray = divToArray.unique();
            ///////////////////////////////////////////////////////////////////////////////////////////去重复
             
            if(zTreeFrom.setting.treeId == "treeDemo"){
                leftDivStr = divFromArray.toSource();
                rightDivStr =divToArray.toSource();
                $.fn.zTree.init($("#treeDemo"), setting, divFromArray);
                $.fn.zTree.init($("#treeDemo2"), setting,divToArray);
                 
            }else{
                leftDivStr = divToArray.toSource();
                rightDivStr =divFromArray.toSource();
                $.fn.zTree.init($("#treeDemo2"), setting, divFromArray);
                $.fn.zTree.init($("#treeDemo"), setting,divToArray);
            }
        }
         
          
        //查找指定节点下的所有子节点
        function operChildrenNodes(treeNode,nodes){
            if(treeNode.children!= undefined){//是父节点，有子节点
                for(var j = 0;j<treeNode.children.length;j++){
                    var childNode = treeNode.children[j];
                    nodes+="{id:"+childNode.id+",pId:"+childNode.pId+",name:\""+childNode.name+"\",open:"+childNode.open+"},";
                    nodes = operChildrenNodes(childNode,nodes);
                }
            }else{//没子节点
            }
            return nodes;
        }
         
         
        $(document).ready(function(){
            zTreeObj1 = $.fn.zTree.init($("#treeDemo"), setting, zNodes);
            zTreeObj2 = $.fn.zTree.init($("#treeDemo2"), setting);
            $(function() {
                $("#toRight").click(function() {
                    moveNodes(zTreeObj1,zTreeObj1.getSelectedNodes()[0],zTreeObj2,leftDivStr,rightDivStr);
                });
                $("#toLeft").click(function(){
                    moveNodes(zTreeObj2,zTreeObj2.getSelectedNodes()[0],zTreeObj1,rightDivStr,leftDivStr);
                 
                });    
                    $("#show").click(function(){
                        var leftDiv = new Array();
                        var leftDivStrArray = eval(leftDivStr);
                        for(var i = 0;i<leftDivStrArray.length;i++){
                            leftDiv[i] = leftDivStrArray[i].id;
                        }
                        var rightDivStrArray = eval(rightDivStr);
                        var rightDiv = new Array();
                        for(var i = 0;i<rightDivStrArray.length;i++){
                            rightDiv[i] = rightDivStrArray[i].id;
                        }
                   if(rightDiv.length>0){
                    alert(rightDiv);
                    $.ajax({
                    	type:"post",
                    	url:"${ctx}/accountant/book/add/",
                    	data:"ids="+rightDiv,
                    	success:function(data){
                    		alert(data);
                    	}
                    })
                   }else{
                	   alert("请先选择节点");
                   }
                });    
            });
        });
         
         
    </script>
 
    </html>