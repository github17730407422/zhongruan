<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/pages/admin/common/admin_meta.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>易食客后台管理系统</title>
</head>
<body class="sub-page">
<div class="page-header">
    <div class="page-title">
        <h3>配送中心管理
        </h3>
    </div>
</div>
<div class="breadcrumb-line">
    <ul class="breadcrumb">
        <li><a href="<s:url value="/admin/centerList.do" includeParams='none'/>">配送中心管理</a></li>
        <li class="active">添加配送中心</li>
    </ul>
</div>
<div class="block s-form">
    <form class="form-horizontal" id="centerForm" action="<s:url value="/admin/centerAdd.do" includeParams='none'/>" role="form" method="post">
        <div class="panel panel-default ">

            <div class="panel-body">
                <div class="form-group"><label class="col-sm-2 control-label text-right">城市:</label>

                    <div class="col-sm-10">
                    <select class="form-control" id="cityId" name="centerInfo.cityId">
		                <s:iterator value="areaList">
		            	<option value="<s:property value="id" />"><s:property value="areaName" /></option>
		            	</s:iterator>
		            </select>
                    </div>

                </div>
                <div class="form-group "><label class="col-sm-2 control-label text-right">配送中心名称:<font style="color: red;">*</font></label>
                    <div class="col-sm-10">
                    	<input type="text" class="form-control" id="centerName" name="centerInfo.centerName">
                    </div>
                </div>

                <div class="form-group"><label class="col-sm-2 control-label text-right">配送中心位置:<font style="color: red;">*</font></label>
                    <div class="col-sm-10">
                        <div class="input-group">
                            <input type="text" class="form-control" id="centerPoint" name="centerInfo.centerPoint">
                            <span class="input-group-btn">
                                <button class="btn btn-default" type="button" onclick="showMap('<s:url value="/admin/showMap.do" includeParams='none'/>')">
                                	<i class="fa fa-map-marker"></i> 定 位
                                </button>
                                <input type="hidden" id="longitude" name="centerInfo.longitude" value="0" />
                                <input type="hidden" id="latitude" name="centerInfo.latitude" value="0" />
                            </span>
                        </div>
                    </div>
                </div>

                <div class="form-actions text-right">
                	<input type="hidden" id="circleId" name="centerInfo.circleId" value="0" />
                    <input type="button" value="取  消" class="btn btn-danger" onclick="resetCenter()">
                    <input type="button" value="保  存" class="btn btn-primary" onclick="submitCenter()">
                </div>
            </div>
        </div>
    </form>
</div>


<!-- Footer -->
<s:include value="/pages/admin/common/footer.jsp"></s:include>
<!-- /Footer -->
</body>
<script language=javascript>
$(function(){
	var message = "<s:property value='message'/>";
	if(message != null && message != ""){
		top.dialog_alert(message, function(){window.location="<s:url value='/admin/centerList.do' />"});
	}
	clearDialogData();
});

function submitCenter() {
	if(!checkObjIsNull($("#centerName"))) {
		top.dialog_alert("请输入配送中心名称。");
		return false;
	}
	if(!checkObjMinLength($("#centerName"), 4)){
		top.dialog_alert("配送中心名称不能少于2个字。");
		return false;
	}
	if(!checkObjLength($("#centerName"), 40)){
		top.dialog_alert("配送中心名称不能超过20个字。");
		return false;
	}
	if(!checkObjIsNull($("#centerPoint"))) {
		top.dialog_alert("请输入配送中心位置。");
		return false;
	}
	if(!checkObjLength($("#centerPoint"), 200)){
		top.dialog_alert("配送中心位置不能超过100个字。");
		return false;
	}
	if(!checkObjIsNull($("#longitude")) || $("#longitude").val() == 0){
		top.dialog_alert("请完成所有必填项的输入。");
		return false;
	}

	var circleId = art.dialog.data("circleId");
	$("#circleId").val(circleId);
	
	var centerName = trim($("#centerName").val());
	var cityId = $("#cityId").val();
	var param = {"centerInfo.centerName":centerName, "centerInfo.id":0, "centerInfo.cityId":cityId};
	var act = "<s:url value='/admin/checkCenterName.do' includeParams='none'/>";
    $.ajax({
		type:"post",
		url:act,
		data:param,
		cache:false,
		success: function(msg) {
			if(msg == "noexist"){
				clearDialogData();
				$('#centerForm').submit();
        	} else {
        		top.dialog_alert(msg);
        	}
        }
	});
}

function resetCenter() {
	location.href='<s:url value="/admin/centerList.do" includeParams="none"/>';
}
</script>	
</html>