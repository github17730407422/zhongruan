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
        <h3>手机客户端分类导航管理
        </h3>
    </div>
</div>
<div class="breadcrumb-line">
    <ul class="breadcrumb">
        <li><a href="<s:url value="/admin/navList.do" includeParams='none'/>">手机客户端分类导航管理</a></li>
        <li class="active">添加导航分类</li>
    </ul>
</div>
<div class="block s-form">
    <form class="form-horizontal" id="navForm" action="<s:url value="/admin/navAdd.do" includeParams='none'/>" role="form" method="post" enctype="multipart/form-data">
        <div class="panel panel-default ">

            <div class="panel-body">
                <div class="form-group"><label class="col-sm-2 control-label text-right">商品类别:</label>

                    <div class="col-sm-10">
                    <select class="form-control" id="categoryId" name="navInfo.id">
		                <s:iterator value="navList">
		                <s:if test="isNav == 1">
		                <option value="<s:property value="id" />" disabled="disabled">
		                </s:if>
		                <s:else>
		                <option value="<s:property value="id" />">
		                </s:else>
		            		<s:property value="categoryName" />
		            	</option>
			            	<s:iterator value="list">
			            	<s:if test="isNav == 1">
			                <option value="<s:property value="id" />" disabled="disabled">
			                </s:if>
			                <s:else>
			                <option value="<s:property value="id" />">
			                </s:else>
			            		&nbsp;&nbsp;<s:property value="categoryName" />
			            	</option>
			            	</s:iterator>
		            	</s:iterator>
		            </select>
                    </div>

                </div>
                <div class="form-group "><label class="col-sm-2 control-label text-right">图片上传:</label>
					<div class="col-sm-10">
                        <div class="uploader">
                        <input type="file" class="styled" id="icon" name="icon">
                        <span class="filename" style="-webkit-user-select: none;">No file selected</span>
                        <span class="action" style="-webkit-user-select: none;">Choose File</span>
                        </div>
                    </div>
                </div>
                <div class="form-actions text-right">
                    <input type="button" value="取  消" class="btn btn-danger" onclick="resetNav()">
                    <input type="button" value="保  存" class="btn btn-primary" onclick="submitNav()">
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
		top.dialog_alert(message, function(){window.location="<s:url value='/admin/navList.do' />"});
	}

	var uploadItem = $('.uploader');
    uploadItem.find('input').on('change',function(){
        var file = uploadItem.find('input').val()
        uploadItem.find('.filename').text(file)
    })
});

function submitNav() {
	if(!checkObjIsNull($("#icon"))){
		top.dialog_alert("请选择上传的分类导航图片。");
		return false;
	}
	$('#navForm ').submit();
}

function resetNav() {
	location.href='<s:url value="/admin/navList.do" includeParams="none"/>';
}
</script>	
</html>
