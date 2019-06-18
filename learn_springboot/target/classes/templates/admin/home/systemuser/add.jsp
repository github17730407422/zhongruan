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
        <h3>用户管理
        </h3>
    </div>
</div>
<div class="breadcrumb-line">
    <ul class="breadcrumb">
        <li><a href="<s:url value="/admin/systemUserList.do" includeParams='none'/>">用户管理</a></li>
        <li class="active">添加用户</li>
    </ul>
</div>
<div class="block s-form">
    <form class="form-horizontal" id="systemUserForm" action="<s:url value="/admin/systemUserAdd.do" includeParams='none'/>" role="form" method="post">
        <div class="panel panel-default ">
            <div class="panel-body">
                <div class="form-group "><label class="col-sm-2 control-label text-right">用户名:<font style="color: red;">*</font></label>
                    <div class="col-sm-10">
                    	<input type="text" class="form-control" id="userName" name="systemUserInfo.userName">
                    </div>
                </div>
                <div class="form-group "><label class="col-sm-2 control-label text-right">输入密码:<font style="color: red;">*</font></label>
                    <div class="col-sm-10">
                    	<input type="password" class="form-control" id="password" name="systemUserInfo.password">
                    </div>
                </div>
                <div class="form-group "><label class="col-sm-2 control-label text-right">确认密码:<font style="color: red;">*</font></label>
                    <div class="col-sm-10">
                        <input type="password" class="form-control" id="confirmedPassword" name="confirmedPassword">
                    </div>
                </div>
                <div class="form-group"><label class="col-sm-2 control-label text-right">用户角色:</label>
                    <div class="col-sm-10">
                        <select onchange="userChange(this.value)" class="form-control" id="type" name="systemUserInfo.type">
                            <option value="0">超级管理员</option>
                            <option value="1">一般管理员</option>
                            <option value="2">财务</option>
                        </select>
                    </div>
                </div>
                <div class="form-group" id="allow"><label class="col-sm-2 control-label text-right"></label>
                	<div class="col-sm-10">
                		<input type="checkbox" id="modifyType" name="modifyType" />
                		&nbsp;&nbsp;&nbsp;
						<strong>允许修改价格</strong>    
						<input type="hidden" id="hidden_modifyType" name="systemUserInfo.modifyType" value="0"/>            		
                	</div>
                </div>				
                <div class="form-actions text-right">
                    <input type="button" value="取  消" class="btn btn-danger" onclick="resetSystemUser()">
                    <input type="button" value="保  存" class="btn btn-primary" onclick="submitSystemUser()">
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
		top.dialog_alert(message, function(){window.location="<s:url value='/admin/systemUserList.do' />"});
	}
	$("#modifyType").click(function(){
		$("#hidden_modifyType").val(1-$("#hidden_modifyType").val());
	});	
});
function userChange(value){
	if(value==2){
		$("#allow").hide();
	}else{
		$("#allow").show();
	}
}
function checkpwd(obj){
	if (checkCharOrNum(trim(obj.val())) == 0) {
		return false;
	}
	
	if (!checkObjMinLength(obj, 6)) {
		return false;
	}
	if (!checkObjLength(obj, 20)) {
		return false;
	}
	return true;
}

function submitSystemUser() {
	if (!checkObjIsNull($("#userName"))) {
		top.dialog_alert("请输入用户姓名。");
		return false;
	}
	if (!checkObjMinLength($("#userName"), 4) || !checkObjLength($("#userName"), 20)){
		top.dialog_alert("用户姓名长度为2~10个字。");
		return false;
	}
	if(!checkObjIsNull($("#password"))){
		top.dialog_alert("请输入用户的登录密码。");
		return false;
	}
	if (!checkpwd($("#password"))){
		top.dialog_alert("用户登录密码长度为6~20位数字或字母。");
		return false;
	}
	
	var userName = trim($("#userName").val());
	var password = trim($("#password").val());
	var confirmedPassword = trim($("#confirmedPassword").val());
	
	if (password != confirmedPassword) {
		top.dialog_alert("用户的登录密码和确认密码不同，请检查。");
		return false;
	}
	
	var param = {"systemUserInfo.userName":userName, "systemUserInfo.id":0};
	var act = "<s:url value='/admin/checkSystemUserName.do' includeParams='none'/>";
    $.ajax({
		type:"post",
		url:act,
		data:param,
		cache:false,
		success: function(msg) {
			if(msg == "noexist"){
				if($("#hidden_modifyType").val()==1){
					top.dialog_confirm("您确定赋予此管理员修改订单价格权限？",function(){
						$('#systemUserForm').submit();
					});
				}else{
					$('#systemUserForm').submit();
				}
        	} else {
        		top.dialog_alert(msg);
        	}
        }
	});
}

function resetSystemUser() {
	location.href='<s:url value="/admin/systemUserList.do" includeParams="none"/>';
}
</script>	
</html>