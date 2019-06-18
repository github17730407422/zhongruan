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
        <h3>添加自营商品
        </h3>
    </div>
</div>
<div class="breadcrumb-line">
    <ul class="breadcrumb">
        <li><a href="<s:url value="/admin/goodsOwnList.do" includeParams='none'/>">自营商品管理</a></li>
        <li class="active">添加自营商品</li>
    </ul>
</div>
<div class="block s-form">
    <form class="form-horizontal" id="goodsForm" action="<s:url value="/admin/goodsOwnAdd.do" includeParams='none'/>" role="form" method="post" enctype="multipart/form-data">
        <div class="panel panel-default ">

            <div class="panel-body">
            	<div class="form-group"><label class="col-sm-2 control-label text-right">城市:<font style="color: red;">*</font></label>
                    <div class="col-sm-10">
                    <select class="form-control" id="cityId" name="goodsInfo.cityId">
		                <s:iterator value="areaList">
		            	<option value="<s:property value="id" />"><s:property value="areaName" /></option>
		            	</s:iterator>
		            </select>
                    </div>
                </div>
                <div class="form-group "><label class="col-sm-2 control-label text-right">商品名称:<font style="color: red;">*</font></label>

                    <div class="col-sm-10">
                    	<input type="text" class="form-control" id="goodsName" name="goodsInfo.goodsName">
                    </div>

                </div>
                <div class="form-group "><label class="col-sm-2 control-label text-right">商品Logo:<font style="color: red;">*</font></label>
                    <div class="col-sm-10">
                        <div class="uploader">
                        <input type="file" class="styled" id="image" name="image" >
                        <span class="filename" style="-webkit-user-select: none;">No file selected</span>
                        <span class="action" style="-webkit-user-select: none;">Choose File</span>
                        </div>
                        <font color="red">图片尺寸建议195*160</font>
                    </div>

                </div>
                <div class="form-group"><label class="col-sm-2 control-label text-right">分类:<font style="color: red;">*</font></label>
                    <div class="col-sm-10">
                    	<select class="form-control" id="categoryId" name="goodsInfo.categoryCode">
			                <s:iterator value="simpList">
			                <option value="<s:property value="code" />" disabled="disabled">
			            		<s:property value="name" />
			            	</option>
				            	<s:iterator value="list">
				                <option value="<s:property value="code" />">
				            		&nbsp;&nbsp;<s:property value="name" />
				            	</option>
				            	</s:iterator>
			            	</s:iterator>
			            </select>
                    </div>
                </div>
                <div class="form-group "><label class="col-sm-2 control-label text-right">价格:<font style="color: red;">*</font></label>

                    <div class="col-sm-10">
                    	<input type="text" class="form-control" id="oldPrice" name="goodsInfo.oldPrice">
                    </div>

                </div>
                <div class="form-group "><label class="col-sm-2 control-label text-right">优惠价:</label>

                    <div class="col-sm-10">
                    	<input type="text" class="form-control" id="preferentialPrice" name="goodsInfo.preferentialPrice">
                    </div>

                </div>
                <div class="form-actions text-right">
                    <input type="button" value="取消" class="btn btn-danger" onclick="resetGoods()">
                    <input type="button" value="保  存" class="btn btn-primary" onclick="submitGoods()">
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
		top.dialog_alert(message, function(){window.location="<s:url value='/admin/goodsOwnList.do' />"});
	}
    var uploadItem = $('.uploader');
    uploadItem.find('input').on('change',function(){
        var file = uploadItem.find('input').val()
        uploadItem.find('.filename').text(file)
    })
	
});

function submitGoods() {
	if(!checkObjIsNull($("#goodsName"))) {
		top.dialog_alert("请完成所有必填项的输入。");
		return false;
	}
	if(!checkObjLength($("#goodsName"), 20)){
		top.dialog_alert("商品名称不能超过20个字符。");
		return false;
	}
	
	if(!checkObjIsNull($("#image"))) { 
		top.dialog_alert("请选择商品Logo。");
		return false; 
	} 

	var photoExt = $("#image").val().substr($("#image").val().lastIndexOf(".")).toLowerCase();//获得文件后缀名
	if(photoExt!='.jpg' && photoExt!='.png' && photoExt!='.bmp' && photoExt!='.gif'){
        alert("请上传后缀名为jpg、bmp、gif、png的照片!");
        return false;
    }

    
	if(!checkObjIsNull($("#oldPrice"))) {
		top.dialog_alert("请输入原价。");
		return false;
	}

	var oldPrice = $("#oldPrice").val();
	var preferentialPrice = $("#preferentialPrice").val();
	if(!checkMoney($("#oldPrice"))){
		top.dialog_alert("请输入正确的原价！");
		return false;
	}
	if(oldPrice <= 0){
		top.dialog_alert("请输入正确的原价！");
		return false;
	}

	if(checkObjIsNull($("#preferentialPrice"))) {
		if(!checkMoney($("#preferentialPrice"))){
			top.dialog_alert("请输入正确的优惠价！");
			return false;
		}
		if(preferentialPrice <= 0){
			top.dialog_alert("请输入正确的优惠价！");
			return false;
		}
		
		if(parseFloat(preferentialPrice) > parseFloat(oldPrice)) {
			top.dialog_alert("优惠价不能高于原价。");
			return false;
		}
	}
	
	var goodsName = trim($("#goodsName").val());
	var businessId = trim($("#businessId").val());
	var param = {"goodsInfo.goodsName":goodsName, "goodsInfo.id":0};
	var act = "<s:url value='/admin/checkGoodsOwnName.do' includeParams='none'/>";
    $.ajax({
		type:"post",
		url:act,
		data:param,
		cache:false,
		success: function(msg) {
			if(msg == "noexist"){
				$('#goodsForm').submit();
        	} else {
        		top.dialog_alert(msg);
        	}
        }
	});
	
}

function resetGoods() {
	location.href='<s:url value="/admin/goodsOwnList.do" includeParams="none"/>';
}
</script>	
</html>
