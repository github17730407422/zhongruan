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
        <h3>商家活动管理
        </h3>
    </div>
</div>
<div class="breadcrumb-line">
    <ul class="breadcrumb">

        <li class="active">商家活动管理</li>
    </ul>
</div>
<div class="block s-form">
    <form class="form-inline" action="<s:url value="/admin/updateBusinessActive.do" includeParams='none'/>" method="post" role="form">
        <div class="panel panel-default ">
		<input type="hidden" id="businessActiveInfo_id" name="businessActiveInfo.id" value="<s:property value="businessActiveInfo.id"/>"/>
		<input type="hidden" id="businessActiveInfo_business_id" name="businessActiveInfo.business_id" value="<s:property value="businessActiveInfo.business_id"/>"/>
            <div class="panel-body">
                                        商&nbsp;&nbsp;家：<s:property value="businessActiveInfo.business_name"/><br><br>
                                        活动一：
                                        满 <input id="activity1_price" type="text" class="form-control" name="businessActiveInfo.activity1_price" value="<s:property value="%{formatDouble(businessActiveInfo.activity1_price)}" />" onkeyup="clearNoNum(this)" /> 元，
                                        减免 <input type="text" id="activity1_jian" class="form-control  "name="businessActiveInfo.activity1_jian" value="<s:property value="%{formatDouble(businessActiveInfo.activity1_jian)}" />" onkeyup="clearNoNum(this)" /> 元配送费。
	           <br><br>
                                        活动二：
                                        满 <input id="activity2_price" type="text" class="form-control "name="businessActiveInfo.activity2_price" value="<s:property value="%{formatDouble(businessActiveInfo.activity2_price)}" />" onkeyup="clearNoNum(this)" /> 元，
                                        减免 <input type="text" id="activity2_jian" class="form-control  "name="businessActiveInfo.activity2_jian" value="<s:property value="%{formatDouble(businessActiveInfo.activity2_jian)}" />" onkeyup="clearNoNum(this)" /> 商品款。
                <input type="submit" value="保  存" class="btn btn-primary" onclick="return check()"/>
            </div>
        </div>
    </form>
</div>

<!-- Footer -->
<s:include value="/pages/admin/common/footer.jsp"></s:include>
<!-- /Footer -->
<script>
function clearNoNum(obj) {
	obj.value = obj.value.replace(/[^\d.]/g,"");  //清除“数字”和“.”以外的字符  
	obj.value = obj.value.replace(/^\./g,"");  //验证第一个字符是数字而不是. 
	obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的.   
	obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
}

function check() {
	if (!checkObjIsNumOrDecimals($("#activity1_price")) || !checkObjIsNumOrDecimals($("#activity1_jian")) 
			|| !checkObjIsNumOrDecimals($("#activity2_price")) || !checkObjIsNumOrDecimals($("#activity2_jian"))) {
		top.dialog_alert("金额必须为数字格式。");
		return false;
	}
	
	if ($("#activity1_price").val() < 0 || $("#activity1_price").val() > 10000
			|| $("#activity1_jian").val() < 0 || $("#activity1_jian").val() > 10000
			|| $("#activity2_price").val() < 0 || $("#activity2_price").val() > 10000
			|| $("#activity2_jian").val() < 0 || $("#activity2_jian").val() > 10000) {
		top.dialog_alert("金额超出有效范围，请重新输入。");
		return false;
	}
	
	if ($("#activity1_price").val() < 0 || $("#activity1_price").val() > 10000
			|| $("#activity1_jian").val() < 0 || $("#activity1_jian").val() > 10000
			|| $("#activity2_price").val() < 0 || $("#activity2_price").val() > 10000
			|| $("#activity2_jian").val() < 0 || $("#activity2_jian").val() > 10000) {
		top.dialog_alert("金额超出有效范围，请重新输入。");
		return false;
	}
	
	if (parseInt($("#activity1_jian").val(), 10) > parseInt($("#activity1_price").val(), 10)) {
		top.dialog_alert("活动1减免金额应不能超出购物金额");
		return false;
	}
	
	if (parseInt($("#activity2_jian").val(), 10) > parseInt($("#activity2_price").val(), 10)) {
		top.dialog_alert("活动2减免金额应不能超出购物金额");
		return false;
	}
	
	return true;
}

/**
 * 检查输入对像是否为数字或小数,供JS使用
 * 
 * @param {}
 *            obj 要检查的对像
 * @return {Boolean}
 */
function checkObjIsNumOrDecimals(obj)
{
	if (obj == null || obj.val() == '') {
		obj.val(0);
	}
	var re = /^-?[1-9]+(\.\d+)?$|^-?0(\.\d+)?$|^-?[1-9]+[0-9]*(\.\d+)?$/;
	if (!re.test(obj.val())) {
		return false;
	}
	return true;
}
</script>
</body>
</html>