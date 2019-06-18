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
        <li class="active">修改类别</li>
    </ul>
</div>
<div class="block s-form">

    <div class="alert alert-danger fade in block-inner">
        <button type="button" class="close" data-dismiss="alert">×</button>
        	请输入正确的类别名称
    </div>
    <form class="form-horizontal" id="categoryForm" action="<s:url value="/admin/categoryUpdate.do" includeParams='none'/>" role="form" method="post" enctype="multipart/form-data">
        <div class="panel panel-default ">
            <div class="panel-body">
            	<s:if test="categoryInfo.parentId > 0">
	            	<div class="form-group"><label class="col-sm-2 control-label text-right">一级分类名称:</label>
	                    <div class="col-sm-10">
	                    	<input type="text" readonly value="<s:property value="categoryInfo.parentName" />" class="form-control" disabled="disabled">
	                    </div>
	                </div>
            	</s:if>
            	
            	<div class="form-group "><label class="col-sm-2 control-label text-right">商品类别名称:</label>
                    <div class="col-sm-10">
                    	<input type="text" class="form-control" id="categoryName" name="categoryInfo.categoryName" value="<s:property value="categoryInfo.categoryName" />">
                    </div>
                </div>
                <!-- 商品类别修改 -->
               <s:if test="categoryInfo.parentId == 0">
                <div class="form-group " id=<s:property value="list"/> ><label class="col-sm-2 control-label text-right">原商品类别Logo:</label>
                    <div class="col-sm-10">
                     	&nbsp;&nbsp;&nbsp;
                    	<s:if test="categoryInfo.categoryImageUrl == null || categoryInfo.categoryImageUrl == ''"><font style="color: red;">无</font></s:if>
                    	<s:else>
                    	<a href="javascript:void(0)" onclick="javascript:previewCategoryPicture('<s:property value="categoryInfo.categoryImageUrl"/>')">预 览</a>
                    	</s:else>
                    </div>
                </div>
                <div class="form-group "><label class="col-sm-2 control-label text-right">上传商品类别Logo:</label>
                    <div class="col-sm-10">
                        <div class="uploader">
                        <input type="file" class="styled" id="imageCategory" name="imageCategory">
                        <span class="filename" style="-webkit-user-select: none;">No file selected</span>
                        <span class="action" style="-webkit-user-select: none;">Choose File</span>
                        </div>
                        	<font color="red">图片尺寸建议110*100</font>
                    </div>
                </div>
              		</s:if>
                <div class="form-group">
                	<label class="col-sm-2 control-label text-right">类别说明:</label>
                    <div class="col-sm-10">
                        <textarea class="form-control" id="description" name="categoryInfo.description"><s:property value="categoryInfo.description" /></textarea>
                    </div>
                </div>
                <div class="form-actions text-right">
                	<input type="hidden" id="parentId" name="categoryInfo.parentId" value="<s:property value="categoryInfo.parentId" />" />
                	<input type="hidden" id="categoryId" name="categoryInfo.id" value="<s:property value="categoryInfo.id" />" />
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
	var uploadItem = $('.uploader');
    uploadItem.find('input').on('change',function(){
        var file = uploadItem.find('input').val();
        uploadItem.find('.filename').text(file);
    })
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
	if(checkObjIsNull($("#imageCategory"))) {
		var photoExt = $("#imageCategory").val().substr($("#imageCategory").val().lastIndexOf(".")).toLowerCase();//获得文件后缀名
		if(photoExt!='.jpg' && photoExt!='.png' && photoExt!='.bmp' && photoExt!='.gif'){
	        alert("请上传后缀名为jpg、bmp、gif、png的照片!");
	        return false;
	    }
	}
	var categoryId = $("#categoryId").val();
	var parentId = $("#parentId").val();
	var categoryName = trim($("#categoryName").val());
	var param = {"categoryInfo.categoryName":categoryName, "categoryInfo.id":categoryId, "categoryInfo.parentId":parentId};
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
	})
}


function resetCategory() {
	location.href='<s:url value="/admin/categoryList.do" includeParams="none"/>';
}

function previewCategoryPicture(categoryImageUrl) {
	var content = '<img src="<s:url value="/"/>' + categoryImageUrl + '" width="300px" height="300px"/>';
	top.art.dialog({
		id: 'categoryImage',
		fixed: true,
		lock: true,
		title : '商品图片预览',
		width : '300px',
		height : '300px',
		content: content
	});
}
</script>	
</html>
