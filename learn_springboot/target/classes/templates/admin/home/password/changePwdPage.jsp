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
        <h3>修改密码
        </h3>
    </div>
</div>
<div class="breadcrumb-line">
    <ul class="breadcrumb">
        <li><a href="<s:url value="/admin/changePwdPage.do" includeParams='none'/>">修改密码</a></li>
    </ul>
</div>
<div class="block s-form">
    <form class="form-horizontal" id="pwdForm" action="<s:url value="/admin/changePwd.do" includeParams='none'/>" role="form" method="post">
        <div class="panel panel-default ">
            <div class="panel-body">
                <div class="form-group "><label class="col-sm-2 control-label text-right">原密码:<font style="color: red;">*</font></label>
                    <div class="col-sm-10">
                        <input type="password" class="form-control" id="oldPwd" name="oldPwd">
                    </div>
                </div>
                <div class="form-group "><label class="col-sm-2 control-label text-right">新密码:<font style="color: red;">*</font></label>
                    <div class="col-sm-10">
                        <input type="password" class="form-control" id="newPwd" name="newPwd">
                    </div>
                </div>
                <div class="form-group "><label class="col-sm-2 control-label text-right">确认新密码:<font style="color: red;">*</font></label>
                    <div class="col-sm-10">
                        <input type="password" class="form-control" id="confirmedPassword" name="confirmedPassword">
                    </div>
                </div>

                <div class="form-actions text-right">
                    <input type="button" value="取  消" class="btn btn-danger" onclick="resetChangePwd()">
                    <input type="button" value="保  存" class="btn btn-primary" onclick="submitChangePwd()">
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
        top.dialog_alert(message, function(){window.location="<s:url value='/admin/changePwdPage.do' />"});
    }
});
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
function submitChangePwd() {
    if(!checkObjIsNull($("#oldPwd"))){
        top.dialog_alert("请输入用户的原登录密码。");
        return false;
    }
    if(!checkpwd($("#newPwd"))){
        top.dialog_alert("用户登录密码长度应为6~20位数字或字母!");
        return false;
        }else{
    
    var oldPwd = trim($("#oldPwd").val());
    var newPwd = trim($("#newPwd").val());
   
    var confirmedPassword = trim($("#confirmedPassword").val());
    
    if (newPwd != confirmedPassword) {
        top.dialog_alert("新密码和确认密码不同，请检查。");
        return false;
    }
    
    var param = {"oldPwd":oldPwd};
    var act = "<s:url value='/admin/checkOldPwd.do' includeParams='none'/>";
    $.ajax({
        type:"post",
        url:act,
        data:param,
        cache:false,
        success: function(msg) {
            if(msg == "ok"){
                var param = {"newPwd":newPwd};
                var act = "<s:url value='/admin/changePwd.do' includeParams='none'/>";
                $.ajax({
                    type:"post",
                    url:act,
                    data:param,
                    cache:false,
                    success: function(msg) {
                        if(msg == "success"){
                        	top.dialog_alert("密码更改成功！");
                        	location.href='<s:url value="/admin/changePwdPage.do" includeParams="none"/>';
                        } else {
                            top.dialog_alert(msg);
                            return false;
                        }
                    }
                });
            } else {
                top.dialog_alert("原密码不正确，请重新输入。");
                return false;
            }
        }
    });
    
    }
}

function resetChangePwd() {
    location.href='<s:url value="/admin/changePwdPage.do" includeParams="none"/>';
}
</script>   
</html>