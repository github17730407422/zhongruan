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
        <h3>商品类别管理
        </h3>
    </div>
</div>
<div class="breadcrumb-line">
    <ul class="breadcrumb">
        <li><a href="<s:url value="/admin/categoryList.do" includeParams='none'/>">商品类别管理</a></li>
        <li class="active">添加类别</li>
    </ul>
</div>
<div class="block s-form">
    <form class="form-horizontal" id="categoryForm" action="<s:url value="/admin/categoryAdd.do" includeParams='none'/>" role="form" method="post">
        <div class="panel panel-default ">
            <div class="panel-body">
            	<div class="form-group"><label class="col-sm-2 control-label text-right">一级分类名称:</label>
                    <div class="col-sm-10">
                    <s:property value="categoryInfo.parentName" />
                    <input type="hidden" id="parentId" name="categoryInfo.parentId" value="<s:property value="categoryInfo.parentId" />" />
                    </div>
                </div>
            	<div class="form-group "><label class="col-sm-2 control-label text-right">商品类别名称:</label>
                    <div class="col-sm-10">
                    	<input type="text" class="form-control" id="categoryName" name="categoryInfo.categoryName">
                    </div>
                </div>
                <div class="form-group">
                	<label class="col-sm-2 control-label text-right">类别说明:</label>
                    <div class="col-sm-10">
                        <textarea class="form-control" id="description" name="categoryInfo.description"></textarea>
                    </div>
                </div>
                <div class="form-actions text-right">
                    <input type="button" value="取  消" class="btn btn-danger" onclick="resetCategory()">
                    <input type="button" value="保  存" class="btn btn-primary" onclick="submitCategory()">
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
		top.dialog_alert(message, function(){window.location="<s:url value='/admin/categoryList.do' />"});
	}
});

function submitCategory() {
	if(!checkObjIsNull($("#categoryName"))) {
		top.dialog_alert("请完成所有必填项的输入");
		return false;
	}
	if(!checkObjLength($("#categoryName"), 20)){
		top.dialog_alert("商品类别名称不能超过20个字符");
		return false;
	}
	if(checkObjIsNull($("#description"))) {
		if(!checkObjLength($("#description"), 200)){
			top.dialog_alert("类别说明不能超过200个字符");
			return false;
		}
	}
	
	var parentId = $("#parentId").val();

	var categoryName = trim($("#categoryName").val());
	var param = {"categoryInfo.categoryName":categoryName, "categoryInfo.id":0, "categoryInfo.parentId":parentId};
	var act = "<s:url value='/admin/checkCategoryName.do' includeParams='none'/>";
    $.ajax({
		type:"post",
		url:act,
		data:param,
		cache:false,
		success: function(msg) {
			if(msg == "noexist"){
				$('#categoryForm').submit();
        	} else {
        		top.dialog_alert(msg);
        	}
        }
	});
}

function resetCategory() {
	location.href='<s:url value="/admin/categoryList.do" includeParams="none"/>';
}
</script>	
</html>
