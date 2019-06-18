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
        <h3>消息管理</h3>
    </div>
</div>
<div class="breadcrumb-line">
    <ul class="breadcrumb">
        <li><a class="active">消息管理</a></li>
    </ul>
</div>
<div class="block s-form">


    <form id="messageForm" class="form-horizontal" action="<s:url value="/admin/sendMessage.do" includeParams='none'/>" role="form" method="post">
        <div class="panel panel-default ">
            <div class="panel-body">
                <div class="form-group"><label class="col-sm-4 control-label text-right">&nbsp;&nbsp;&nbsp;&nbsp;向手机客户端用户进行消息推送:（推送信息长度不超过70个中文字）</label>
                    <div class="col-sm-8"><textarea id="messageText" name="messageText" class="form-control" onkeyup=""></textarea>
                       </div>
                </div>
                <!-- <span class="text-right">111</span> -->
                <div class="form-actions text-right">
                    <button type="button" class="btn btn-primary" onclick="check()">发  送</button>
                </div>
            </div>
        </div>
    </form>
</div>
<!-- /page tabs --> 

<!-- Footer -->
<s:include value="/pages/admin/common/footer.jsp"></s:include>
<!-- /Footer -->
</body>
<script language=javascript>
	$(function(){
		var message = "<s:property value='message'/>";
		if(message != null && message != ""){
			top.dialog_alert(message);
		}
		
	});
	
	//提交和校验
function check() {
	if (!checkObjIsNull($("#messageText"))) {
		top.dialog_alert("请输入要发送的信息内容！");
		return false;
	}
	
	if (!checkObjLength($("#messageText"), 140)){
		top.dialog_alert("消息的长度不得超过70个中文字符。");
		return false;
	}
	top.dialog_confirm("您确定想手机客户端用户推送该条信息？", function(){
		$('#messageForm').submit();
	});
}
</script>
</html>