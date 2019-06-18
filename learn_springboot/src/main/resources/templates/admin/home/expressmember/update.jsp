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
        <h3>配送人员管理
        </h3>
    </div>
</div>
<div class="breadcrumb-line">
    <ul class="breadcrumb">
        <li><a href="<s:url value="/admin/memberList.do" includeParams='none'/>">配送人员管理</a></li>
        <li class="active">修改配送人员</li>
    </ul>
</div>
<div class="block s-form">
    <form class="form-horizontal" id="memberForm" action="<s:url value="/admin/memberUpdate.do" includeParams='none'/>" role="form" method="post">
        <div class="panel panel-default ">

            <div class="panel-body">
                <div class="form-group"><label class="col-sm-2 control-label text-right">城市:</label>
                    <div class="col-sm-10">
                    <select class="form-control" id="cityId" name="memberInfo.cityId">
		                <s:iterator value="areaList">
		            	<option value="<s:property value="id" />"><s:property value="areaName" /></option>
		            	</s:iterator>
		            </select>
                    </div>
                </div>
                <div class="form-group"><label class="col-sm-2 control-label text-right">配送中心名称:<font style="color: red;">*</font></label>
                    <div class="col-sm-10">
                    <select class="form-control" id="centerId" name="memberInfo.centerId">
                        <s:iterator value="centerList">
                            <option value="<s:property value="id" />" <s:if test="id==memberInfo.centerId">selected="selected"</s:if>><s:property value="centerName" /></option>
                        </s:iterator>
                    </select>
                    </div>
                </div>
                
                <div class="form-group "><label class="col-sm-2 control-label text-right">配送员姓名:<font style="color: red;">*</font></label>
                    <div class="col-sm-10">
                    	<input type="text" class="form-control" id="memberName" name="memberInfo.memberName" value="<s:property value="memberInfo.memberName"/>">
                    </div>
                </div>
                
                <div class="form-group "><label class="col-sm-2 control-label text-right">手机号码:<font style="color: red;">*</font></label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="mobilePhone" name="memberInfo.mobilePhone" value="<s:property value="memberInfo.mobilePhone"/>">
                    </div>
                </div>
                
                <div class="form-actions text-right">
                	<input type="hidden" id="memberId" name="memberInfo.id" value="<s:property value="memberInfo.id"/>"/>
                    <input type="button" value="取  消" class="btn btn-danger" onclick="resetMember()">
                    <input type="button" value="保  存" class="btn btn-primary" onclick="submitMember()">
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
		top.dialog_alert(message, function(){window.location="<s:url value='/admin/memberList.do' />"});
	}
});

function submitMember() {
	if (!checkObjIsNull($("#memberName"))) {
		top.dialog_alert("请输入配送人员姓名。");
		return false;
	}
	if (!checkObjMinLength($("#memberName"), 4) || !checkObjLength($("#memberName"), 10)){
		top.dialog_alert("配送人员姓名长度为2~5个字。");
		return false;
	}
	if(!checkObjIsNull($("#mobilePhone"))){
		top.dialog_alert("请输入配送人员的手机号码。");
		return false;
	}
	var reg = /^1\d{10}$/;
	if (!reg.test($("#mobilePhone").val())) {
		top.dialog_alert("请输入有效的配送人员手机号码。");
		return false;
	}
	
	var memberName = trim($("#memberName").val());
	var memberId = $("#memberId").val();
	var cityId = $("#cityId").val();
	var centerId = $("#centerId").val();
	var mobile = $("#mobilePhone").val();
	var param = {"memberInfo.memberName":memberName, "memberInfo.id":memberId, "memberInfo.cityId":cityId, "memberInfo.centerId":centerId, "memberInfo.mobilePhone":mobile};
	var act = "<s:url value='/admin/checkMobile.do' includeParams='none'/>";
    $.ajax({
		type:"post",
		url:act,
		data:param,
		cache:false,
		success: function(msg) {
			if(msg == "noexist"){
				$('#memberForm').submit();
        	} else {
        		top.dialog_alert(msg);
        	}
        }
	});
}

function resetMember() {
	location.href='<s:url value="/admin/memberList.do" includeParams="none"/>';
}
</script>	
</html>