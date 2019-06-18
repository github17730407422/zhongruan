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
        <h3>商圈管理
        </h3>
    </div>
</div>
<div class="breadcrumb-line">
    <ul class="breadcrumb">
        <li><a href="<s:url value="/admin/circleList.do" includeParams='none'/>">商圈管理</a></li>
        <li class="active">修改商圈</li>
    </ul>
</div>
<div class="block s-form">
    <form class="form-horizontal" id="circleForm" action="<s:url value="/admin/circleUpdate.do" includeParams='none'/>" role="form" method="post">
        <div class="panel panel-default ">

            <div class="panel-body">
                <div class="form-group"><label class="col-sm-2 control-label text-right">城市:<font style="color: red;">*</font></label>

                    <div class="col-sm-10">
                    <select class="form-control" id="cityId" name="circleInfo.cityId">
		                <s:iterator value="areaList">
		            	<option value="<s:property value="id" />"><s:property value="areaName" /></option>
		            	</s:iterator>
		            </select>
                    </div>

                </div>
                <div class="form-group "><label class="col-sm-2 control-label text-right">商圈名称:<font style="color: red;">*</font></label>
                    <div class="col-sm-10">
                    	<input type="text" class="form-control" id="circleName" name="circleInfo.circleName" value="<s:property value="circleInfo.circleName"/>">
                    </div>
                </div>

                <div class="form-group"><label class="col-sm-2 control-label text-right">中心点位置:<font style="color: red;">*</font></label>
                    <div class="col-sm-10">
                        <div class="input-group">
                            <input type="text" class="form-control" id="centerPoint" name="circleInfo.centerPoint" value="<s:property value="circleInfo.centerPoint"/>">
						      <span class="input-group-btn">
						        <button class="btn btn-default" type="button" onclick="showMap('<s:url value="/admin/showMap.do" includeParams='none'/>')">
						        	<i class="fa fa-map-marker"></i> 定 位
						        </button>
						        <input type="hidden" id="longitude" name="circleInfo.longitude" value="<s:property value="circleInfo.longitude"/>" />
						        <input type="hidden" id="latitude" name="circleInfo.latitude" value="<s:property value="circleInfo.latitude"/>" />
						      </span>
                        </div>
                    </div>
                </div>

                <div class="form-actions text-right">
                	<input type="hidden" id="circleId" name="circleInfo.id" value="<s:property value="circleInfo.id"/>"/>
                    <input type="button" value="取  消" class="btn btn-danger" onclick="resetCircle()">
                    <input type="button" value="保  存" class="btn btn-primary" onclick="submitCircle()">
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
		top.dialog_alert(message, function(){window.location="<s:url value='/admin/circleList.do' />"});
	}
	clearDialogData();
});

function submitCircle() {
	if(!checkObjIsNull($("#circleName"))) {
		top.dialog_alert("请完成所有必填项的输入。");
		return false;
	}
	if (!checkObjMinLength($("#circleName"), 4)) {
		top.dialog_alert("商圈名称不能小于4个字符。");
		return false;
	}
	if(!checkObjLength($("#circleName"), 20)){
		top.dialog_alert("商圈名称不能超过20个字符。");
		return false;
	}
	if(!checkObjLength($("#centerPoint"), 40)){
		top.dialog_alert("中心点位置不能超过40个字符。");
		return false;
	}
	
	var circleName = trim($("#circleName").val());
	var circleId = $("#circleId").val();
	var cityId = $("#cityId").val();
	var param = {"circleInfo.circleName":circleName, "circleInfo.id":circleId, "circleInfo.cityId":cityId};
	var act = "<s:url value='/admin/checkCircleName.do' includeParams='none'/>";
    $.ajax({
		type:"post",
		url:act,
		data:param,
		cache:false,
		success: function(msg) {
			if(msg == "noexist"){
				clearDialogData();
				$('#circleForm').submit();
        	} else {
        		top.dialog_alert(msg);
        	}
        }
	});
	
}

function resetCircle() {
	location.href='<s:url value="/admin/circleList.do" includeParams="none"/>';
}
</script>	
</html>
