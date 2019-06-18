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
        <h3>抵用券管理
        </h3>
    </div>
</div>
<div class="breadcrumb-line">
    <ul class="breadcrumb">
        <li><a href="<s:url value="/admin/couponIndex.do" includeParams='none'/>">抵用券管理</a></li>
        <li class="active">生成抵用券</li>
    </ul>
</div>
<div class="block s-form">
    <form class="form-horizontal" id="circleForm" action="<s:url value="/admin/circleAdd.do" includeParams='none'/>" role="form" method="post">
        <div class="panel panel-default ">

            <div class="panel-body">
                <div class="form-group "><label class="col-sm-2 control-label text-right">抵用券数量:<font style="color: red;">*</font></label>
                    <div class="col-sm-5">
                    	<input type="text" class="form-control" id="number" name="number">
                    </div>

                </div>
                <div class="form-group"><label class="col-sm-2 control-label text-right">抵用券金额:<font style="color: red;">*</font></label>

                    <div class="col-sm-5">
                    	<input type="text" class="form-control" id="money" name="money">
                    </div>
                </div>
                 <div class="form-group"><label class="col-sm-2 control-label text-right">消费满:<font style="color: red;">*</font></label>

                    <div class="col-sm-5">
                    	<input type="text" class="form-control" id="limitMoney" name="limitMoney">
                    </div>
                    <label class="col-sm-2 control-label text-left" style="text-align: left">可用</label>
                </div>
                <div class="form-group"><label class="col-sm-2 control-label text-right">有效开始时期:<font style="color: red;">*</font></label>

                    <div class="col-sm-5">
                    	<input type="text" class="form-control" id="startTime" name="startTime" readonly="readonly" onfocus="WdatePicker({skin:'whyGreen'})"/>
                    </div>
                </div>
                <div class="form-group"><label class="col-sm-2 control-label text-right">有效截止日期:<font style="color: red;">*</font></label>

                    <div class="col-sm-5">
                    	<input type="text" class="form-control" id="endTime" name="endTime"  readonly="readonly" onfocus="WdatePicker({skin:'whyGreen'})"/> 
                    </div>
                </div>
                <div class="form-actions text-right">
                    <input type="button" value="取  消" class="btn btn-danger" onclick="resetCoupon()">
                    <input type="button" value="生  成" class="btn btn-primary" onclick="submitCoupon()">
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
		top.dialog_alert(message, function(){window.location="<s:url value='/admin/couponIndex.do' />"});
	}
});

function submitCoupon() {
	var number = trim($("#number").val());
	if(!checkObjIsNum($("#number"))){
		top.dialog_alert("请输入正确的抵用券数量！");
		return false;
	}
	if(number <= 0){
		top.dialog_alert("请输入正确的抵用券数量！");
		return false;
	}
	if(number > 10000){
		top.dialog_alert("最大只能生成10000张抵用券！");
		return false;
	}
	var money = trim($("#money").val());
	var limitMoney = trim($("#limitMoney").val());
	var startTime = trim($("#startTime").val());
	var endTime = trim($("#endTime").val());
	if(!checkMoney($("#money"))){
		top.dialog_alert("请输入正确的抵用券金额！");
		return false;
	}
	if(money <= 0){
		top.dialog_alert("请输入正确的抵用券金额！");
		return false;
	}
	if(!checkMoney($("#limitMoney"))){
		top.dialog_alert("请输入正确的限额金额！");
		return false;
	}
	if(!checkObjIsNull($("#startTime"))){
		top.dialog_alert("优惠券有效开始时间不能为空!");
		return false;
	}
	if(!checkObjIsNull($("#endTime"))){
		top.dialog_alert("优惠券有效截止时间不能为空!");
		return false;
	}
	if(checkObjIsNull($("#startTime"))&&checkObjIsNull($("#endTime"))){
		if(!checkBeginDateAndEndDate($("#startTime"),$("#endTime"))){
			top.dialog_alert("优惠券有效截止时间必须大于开始时间!");
			return false;
		}
	}
	// 显示load的对话框
	window.parent.showLoad("load_coupon", "正在生成抵用券，请稍等")

	var param = {"number":number, "money":money,"limitMoney":limitMoney,"startTime":startTime,"endTime":endTime};
   	var act = "<s:url value='/admin/sendCouponBatch.do' includeParams='none'/>";
       $.ajax({
   		type:"post",
   		url:act,
   		data:param,
   		cache:false,
   		success: function(msg) {
    		// 关闭load的对话框
			window.parent.hideLoad("load_coupon");
			
			top.art.dialog({
				fixed: true,
				lock: true,
				title: "提示消息",
				content: msg,
				button:[{
					name: "下载",
					callback: exportCoupon
				},{
					name: "取消"
				}]
			});
       	}
   	});
}

function resetCoupon() {
	location.href='<s:url value="/admin/couponIndex.do" includeParams="none"/>';
}

function exportCoupon(){
	window.open('<s:url value="/admin/exportCoupon.do" includeParams="none"/>');
	window.location="<s:url value='/admin/couponIndex.do' />";
}
</script>	
</html>
