<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"  %>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=KHWy6XGZo9vPDphmy8pApcfr"></script>
		
	<script type="text/javascript" src="<s:url value="/pages/admin/js/jquery.min.js"/>"></script>
	<!--引入弹窗组件start-->
	<script type="text/javascript" src="<s:url value="/js/artDialog/jquery.artDialog.source.js?skin=chrome" />"></script>
	<script type="text/javascript" src="<s:url value="/js/artDialog/artDialog.iframeTools.js" />"></script>
	<script type="text/javascript" src="<s:url value="/js/dialog.js" />"></script>
	<!--引入弹窗组件end-->

	<title>百度地图的Hello, World</title>
	<style type="text/css">
body,html,#allmap {
	width: 100%;
	height: 100%;
	overflow: hidden;
	margin: 0;
}
</style>
</head>
<body>
	<div>
	<input type="text" id="po" name="po" size="20" />
	<input type="button" id="serBtn" value="定位" onclick="searchArea()" />
	<input type="button" id="saveBtn" value="保存位置信息" onclick="setLngLat()" />
	</div>
	<div id="allmap"></div>
</body>

<script type="text/javascript">
	var map = new BMap.Map("allmap"); // 创建Map实例
	map.enableScrollWheelZoom();                            //启用滚轮放大缩小

	var newLng;
	var newLat;

	var centerCityName = art.dialog.data("centerCityName");
	var centerName = art.dialog.data("centerName");
	$("#po").val(centerName);
	
	initArea();
	
	function notFoundArea(){
		map.centerAndZoom(centerCityName, 15); // 初始化地图,设置中心点坐标和地图级别。
		map.enableScrollWheelZoom(); //启用滚轮放大缩小

		var marker;
		
		map.addEventListener('click', function (e) {
	        if (marker == null) {
	        	 var point = e.point;
	        	marker = new BMap.Marker(point); // 创建标注
		     	map.addOverlay(marker); // 将标注添加到地图中
		     	marker.enableDragging(); //可拖拽

		     	var circle = new BMap.Circle(point,1000);
		     	circle.setFillOpacity(0.2);
		     	map.addOverlay(circle);
		     	
		     	newLng = e.point.lng;
		        newLat = e.point.lat;

		      //标注拖拽后的位置
			    marker.addEventListener("dragend", function (ee) {
			    	var pointNew = ee.point;  // 拖动后的坐标点
			    	if (map.getDistance(point, pointNew) > 1000) {
			    		top.dialog_alert("拖动范围不能超过1公里，如果找不到自己的地点，可以试试在上方搜索框中输入地址定位！");

			    		var pointOld = new BMap.Point(newLng,newLat);  
			    		marker.setPosition(pointOld);
				    } else {
			    		newLng = ee.point.lng;
				        newLat = ee.point.lat;
			    	}
			    });
	        }
		});
	}

	function searchArea(){
		var po = $("#po").val();
		var myGeo = new BMap.Geocoder();

		// 新增页面
		if (po != "") {
			// 输入了中心点位置，地图定位
			// 将地址解析结果显示在地图上,并调整地图视野
			myGeo.getPoint(po, function(point) {
				if (point) {
					map.clearOverlays();
					map.setCenter(point);
					map.setZoom(16);
					var marker = new BMap.Marker(point); // 创建标注
					map.addOverlay(marker); // 将标注添加到地图中
					marker.enableDragging(); //可拖拽

					map.addOverlay(marker);

					var circle = new BMap.Circle(point,1000);
			     	map.addOverlay(circle);

					// 获得当前的中心点的经纬度，把值传入父页面的隐藏表单中供需要的模块调用
					var newPoint = marker.getPosition();
					newLng = point.lng;
			        newLat = point.lat;

					//标注拖拽后的位置
				    marker.addEventListener("dragend", function (e) {
				        var pointNew = new BMap.Point(e.point.lng,e.point.lat);  // 拖动后的坐标点
				    	if (map.getDistance(point,pointNew) > 1000) {
				    		top.dialog_alert("拖动范围不能超过1公里，如果找不到自己的地点，可以试试在上方搜索框中输入地址定位！");

				    		var pointOld = new BMap.Point(newLng,newLat);  
				    		marker.setPosition(pointOld);
					    } else {
				    		newLng = e.point.lng;
					        newLat = e.point.lat;
				    	}
				    });
				} else {
					// 输入了中心点位置，地图定位失败
					notFoundArea();
				}
			}, centerCityName);
		} else {
			top.dialog_alert("请输入中心点位置。");
		}
	}
		
	function initArea(){
		var lng = art.dialog.data("lng");
		var lat = art.dialog.data("lat");
		var pointName = $("#po").val();

		var myGeo = new BMap.Geocoder();

		if (lng > 0) {
			// 已经定位过一次，显示上一次选择的坐标点
			var point = new BMap.Point(lng, lat);    // 创建点坐标
			map.centerAndZoom(point, 16);

			var marker = new BMap.Marker(point); // 创建标注
			map.addOverlay(marker); // 将标注添加到地图中
			marker.enableDragging(); //可拖拽

			map.addOverlay(marker);

			var circle = new BMap.Circle(point,1000);
	     	map.addOverlay(circle);

	     	
			newLng = lng;
	        newLat = lat;

			//标注拖拽后的位置
		    marker.addEventListener("dragend", function (e) {
		    	var pointNew = new BMap.Point(e.point.lng,e.point.lat);  // 拖动后的坐标点
		    	if (map.getDistance(point,pointNew) > 1000) {
		    		top.dialog_alert("拖动范围不能超过1公里，如果找不到自己的地点，可以试试在上方搜索框中输入地址定位！");
		    		var pointOld = new BMap.Point(newLng,newLat); 
		    		marker.setPosition(pointOld);
			    } else {
		    		newLng = e.point.lng;
			        newLat = e.point.lat;
		    	}
		    });
		} else {
			// 新增页面
			if (pointName != "") {
				// 输入了中心点位置，地图定位
				// 将地址解析结果显示在地图上,并调整地图视野
				myGeo.getPoint(pointName, function(point) {
					if (point) {
						map.centerAndZoom(point, 16);
						var marker = new BMap.Marker(point); // 创建标注
						map.addOverlay(marker); // 将标注添加到地图中
						marker.enableDragging(); //可拖拽
	
						map.addOverlay(marker);

						var circle = new BMap.Circle(point,1000);
				     	map.addOverlay(circle);
	
						// 获得当前的中心点的经纬度
						var newPoint = marker.getPosition();
						newLng = point.lng;
				        newLat = point.lat;
	
						//标注拖拽后的位置
					    marker.addEventListener("dragend", function (e) {
					    	var pointNew = new BMap.Point(e.point.lng,e.point.lat);  // 拖动后的坐标点
					    	if (map.getDistance(point,pointNew) > 1000) {
					    		top.dialog_alert("拖动范围不能超过1公里，如果找不到自己的地点，可以试试在上方搜索框中输入地址定位！");
					    		var pointOld = new BMap.Point(newLng,newLat);  
					    		marker.setPosition(pointOld);
						    } else {
					    		newLng = e.point.lng;
						        newLat = e.point.lat;
					    	}
					    });
					} else {
						// 输入了中心点位置，地图定位失败
						notFoundArea();
					}
				}, centerCityName);
			}else {
				// 没有输入中心点位置，直接显示该城市中心点位置
				notFoundArea();
			}
		}
	}

	function setLngLat(){
        art.dialog.data("lng", newLng);
		art.dialog.data("lat", newLat);
		
		var point = new BMap.Point(newLng, newLat);    // 创建点坐标
		var gc = new BMap.Geocoder();    
		gc.getLocation(point, function(rs){
	        var addComp = rs.addressComponents;
	        var address = addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber;
	       window.parent.setCenterPoint(address);
	        $("#po").val("");
	        art.dialog.close();
		}); 
	}
</script>
