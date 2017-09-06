<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>地图标记</title>
<script src="${ctxStatic}/washcar/map/js/json2.js" type="text/javascript"></script>
    <style type="text/css">
        body, html, #allmap {
            margin: 0;
            padding: 0;
            //width: 100%;
            //height: 100%;
            //overflow: hidden;
        }
        #bar {
        width:380px; position:absolute; background:#000000; left:50%; height:25px; border:solid 1px #808080; top:20px; background:#f5f5f5; padding:10px; margin-left:-195px;
        }
    </style>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=kq53sCGqFHXGrRIUUNaB2xuM"></script>
    <script>
        function addMarker(id, name, x, y) {
            var p = new BMap.Point(x, y);
            var marker = new BMap.Marker(p);//, px = map.pointToPixel(p);
            M.addOverlay(marker);
            marker.enableDragging();
            marker.setTitle(id);

            var label = new BMap.Label(name, { offset: new BMap.Size(25, 0) });
            label.setStyles({
                border: "solid 1px #00f",
                color: "#00f",
                padding: "0 5px"
            });
            marker.setLabel(label);

		

            
			
           /* var icon = new BMap.Icon('images/k.gif',  new BMap.Size(20, 20), {
                anchor: new BMap.Size(10, 22)
            });
            marker.setIcon(icon);
*/
            var markerMenu = new BMap.ContextMenu();
            var ci = config.marker.index;
			
			var win = new BMap.InfoWindow('<input type="text" value="' + label.getContent() + '" id="txt_rename_' + ci + '" maxlength="20" style="width:100px" /> <input type="button" onclick="rename(' + ci + ')" value="命名" />');
			marker.openInfoWindow(win);
			
            markerMenu.addItem(new BMap.MenuItem('重命名', function () {
                var win = new BMap.InfoWindow('<input type="text" value="' + label.getContent() + '" id="txt_rename_' + ci + '" maxlength="20" style="width:100px" /> <input type="button" onclick="rename(' + ci + ')" value="重命名" />');
                marker.openInfoWindow(win);
            }, 100));
            markerMenu.addItem(new BMap.MenuItem('移除', function () {
                //alert('AJAX移除操作');
                //config.save = false;
                if(parseInt(id)>0){
                    $.ajax({
                        url:'Delete.aspx',
                        type:"post",
                        data:"id="+id,
                        success:function(r){
                            if(r=="ok"){
                                config.marker.remove(ci);
                            }else{
                                alert(r);
                            }
                        }
                    });
                }else{
                    config.marker.remove(ci);
                }
            }, 100));
            marker.addContextMenu(markerMenu);

            config.marker.add(marker);
        }

        var config = {
            runn: false, //是否开始拾取坐标
            marker: {
                list: [],
                add: function (data) {
                    config.marker.index++;
                    config.marker.list.push(data);
                    config.save = false;
                },
                remove: function (i) {
                    config.marker.list[i].remove();
                    config.marker.list[i] = null;
                },
                index:0
            },
            save: true //当前设置是否已保存
        };

        function save() {
            var data = [];
            var html = '';
            for (var i = 0; i < config.marker.list.length; i++) {
                var marker = config.marker.list[i];
                if (marker) {
                    data.push({
                        id: parseInt(marker.getTitle()),
                        title: marker.getLabel().getContent(),
                        x: marker.getPosition().lng,
                        y: marker.getPosition().lat
                    });
                    html += '';
                }
				  console.log(data);
            }
          
            $.ajax({
                url:'Save.aspx',
                type:"post",
                data:"data="+escape(JSON.stringify(data)),
                success:function(r){
                    if(r=="ok"){
                        config.save = true;
                        alert('保存成功');
                    }else{
                        alert(r);
                    }
                }
            });
      
        }

        function rename(i) { //重命名
            if (config.marker.list[i]) {
                var t = $("#txt_rename_" + i).val();
                config.marker.list[i].getLabel().setContent(t);
                M.closeInfoWindow(M.getInfoWindow());
                config.save = false;
            }
        }

        $(function () {
            var w = $(window).width();
            var h = $(window).height();

            var map = new BMap.Map("allmap");                        // 创建Map实例
            map.centerAndZoom($("#city").val(), 13);     // 初始化地图,设置中心点坐标和地图级别
            map.addControl(new BMap.NavigationControl());               // 添加平移缩放控件
            map.addControl(new BMap.ScaleControl());                    // 添加比例尺控件
            map.addControl(new BMap.OverviewMapControl());              //添加缩略地图控件
            map.enableScrollWheelZoom();                            //启用滚轮放大缩小
            map.addControl(new BMap.MapTypeControl());          //添加地图类型控件
            var contextMenu = new BMap.ContextMenu();//添加右键菜单
            var txtMenuItem = [
              {
                  text: '放大',
                  callback: function () { map.zoomIn() }
              },
              {
                  text: '缩小',
                  callback: function () { map.zoomOut() }
              },
              {
                  text: '放置到最大级',
                  callback: function () { map.setZoom(18) }
              },
              {
                  text: '查看全国',
                  callback: function () { map.setZoom(4) }
              },
              {
                  text: '在此添加标注',
                  callback: function (p) {
                      addMarker('0', '未命名', p.lng, p.lat);
                  }
              }
            ];

            for (var i = 0; i < txtMenuItem.length; i++) {
                contextMenu.addItem(new BMap.MenuItem(txtMenuItem[i].text, txtMenuItem[i].callback, 100));
                if (i == 1 || i == 3) {
                    contextMenu.addSeparator();
                }
            }
            map.addContextMenu(contextMenu);//设置的

            $('#begin').click(function () {　//
                if (!document.getElementById('begin').disabled) {
                    map.centerAndZoom($("#city").val(), 13);
                }
            });


            window.M = map;
            
            //加载数据库中保存的数据
            $.ajax({
                url:'Output.aspx',
                type:"get",
                success:function(json){
                    for(var i=0;i<json.length;i++){
                        addMarker(json[i].id,json[i].title, json[i].x,json[i].y);
                    }
                }
            });

        });
    // 百度地图API功能
    </script>
</head>
<body>
    <div id="allmap"></div>
    <div id="bar">
        城市：<input type="text" id="city" value="北京" /> <input type="button" id="begin" value="定位" />
        <input type="button" id="save" value="保存" onclick="save()" />
        <input type="button" id="reset" value="复位" />
    </div>
</body>
</html>