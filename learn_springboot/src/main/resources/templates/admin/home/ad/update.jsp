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
        <h3>广告管理
        </h3>
    </div>
</div>
<div class="breadcrumb-line">
    <ul class="breadcrumb">
        <li><a href="<s:url value="/admin/adList.do" includeParams='none'/>">广告管理</a></li>
        <li class="active">修改广告</li>
    </ul>
</div>
<div class="block s-form">
    <form class="form-horizontal" id="adForm" action="<s:url value="/admin/adUpdate.do" includeParams='none'/>" role="form" method="post" enctype="multipart/form-data">
        <div class="panel panel-default ">

            <div class="panel-body">
                <div class="form-group "><label class="col-sm-2 control-label text-right">广告名称:<font style="color: red;">*</font></label>
                    <div class="col-sm-10">
                    	<input type="text" class="form-control" id="adName" name="adInfo.adName" value="<s:property value="adInfo.adName"/>">
                    </div>
                </div>
                <div class="form-group "><label class="col-sm-2 control-label text-right" value="">当前广告图片:</label>
                    <div class="col-sm-10">
                        <a href="#" onclick="javascript:previewAdPicture('<s:property value="adInfo.adPicture"/>')">预 览</a>
                    </div>
                </div>
                <div class="form-group "><label class="col-sm-2 control-label text-right" value="">新广告图片:</label>
                    <div class="col-sm-10">
                        <div class="uploader">
                            <input type="file" class="styled" id="ad_picture_file" name="ad_picture_file" value="<s:property value="adInfo.adPicture"/>"/>
                            <span class="filename" style="-webkit-user-select: none;">No file selected</span>
                            <span class="action" style="-webkit-user-select: none;">Choose File</span>
                        </div>
                        <font color="red">图片尺寸建议1070*270</font>
                    </div>
                </div>
                </div>
                <div class="form-group "><label class="col-sm-2 control-label text-right">广告地址:<font style="color: red;">*</font></label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="adUrl" name="adInfo.adUrl" value="<s:property value="adInfo.adUrl"/>">
                    </div>
                </div>
                <div class="form-actions text-right">
                	<input type="hidden" id="adId" name="adInfo.id" value="<s:property value="adInfo.id"/>"/>
                    <input type="button" value="取  消" class="btn btn-danger" onclick="resetAd()">
                    <input type="button" value="保  存" class="btn btn-primary" onclick="submitAd()">
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
		top.dialog_alert(message, function(){window.location="<s:url value='/admin/adList.do' />";});
	}
	
	var uploadItem = $('.uploader');
    uploadItem.find('input').on('change',function(){
	var file = uploadItem.find('input').val();
	uploadItem.find('.filename').text(file);
    });
});

function submitAd() {
	if (!checkObjIsNull($("#adName"))) {
		top.dialog_alert("请输入广告名称。");
		return false;
	}
	if (!checkObjMinLength($("#adName"), 4) || !checkObjLength($("#adName"), 60)){
		top.dialog_alert("广告名称长度为2~30个字。");
		return false;
	}
	if (!checkObjIsNull($("#adUrl"))) {
		top.dialog_alert("请输入广告地址。");
		return false;
	}
	
	if (!checkObjLength($("#adUrl"), 200)) {
		top.dialog_alert("广告地址长度不能超过200个字符。");
		return false;
	}
	
	if (!checkURL($("#adUrl").val())) {
		top.dialog_alert("请输入正确的广告地址。");
		return false;
	}
	
	var fileName = $("#ad_picture_file").val();

	if (fileName != '') {
		fileName = fileName.toLowerCase();
		var patten = /(.jpg|.png|.gif)$/;
		if (fileName.search(patten) <= -1) {
			top.dialog_alert("只允许上传 jpeg/gif/png 格式的文件");
			return false;
		}
	}
	
	var adName = trim($("#adName").val());
	var param = {"adInfo.adName":adName, "adInfo.id":<s:property value="adInfo.id"/>};
	var act = "<s:url value='/admin/checkAdName.do' includeParams='none'/>";
	$.ajax({
		type:"post",
		url:act,
		data:param,
		cache:false,
		success: function(msg) {
			if(msg == "noexist"){
				$('#adForm').submit();
        	} else {
        		top.dialog_alert(msg);
        	}
        }
	});
}

function resetAd() {
	location.href='<s:url value="/admin/adList.do" includeParams="none"/>';
}

function previewAdPicture(adUrl) {
	var url = '<s:url value="/"/>' + adUrl;
	top.dialog_open(url, {
		id : 'adPic',
		esc : false,
		lock : true,
		title : '广告图片预览',
		width : '1000px',
		height : '500px'
	}, false);
}
</script>	
</html>