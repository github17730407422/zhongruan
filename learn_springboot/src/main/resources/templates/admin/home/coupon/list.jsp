<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/pages/admin/common/admin_meta.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<style type="">
	.coupon-control {
    width: 80px;
}
</style>
    <title>易食客后台管理系统</title>
</head>
<body class="sub-page">
<div class="page-header">
    <div class="page-title">
        <h3>抵用券管理</h3>
    </div>
</div>
<div class="breadcrumb-line">
    <ul class="breadcrumb">
        <li><a class="active">抵用券管理</a></li>
    </ul>
</div>
<div class="block search">
	
    <a href="<s:url value="/admin/couponList.do" includeParams='none'/>" class="btn btn-default pull-right">
        <span class="fa fa-plus fa-lg"></span> 查看抵用券列表
    </a>
    <a href="<s:url value="/admin/addCouponPage.do" includeParams='none'/>" class="btn btn-default pull-right">
        <span class="fa fa-plus fa-lg"></span> 批量生成抵用券
    </a>
</div>
<hr />
<form class="form-inline tab-pane" role="form" >
<div class="block search">
	<div class="form-group" align="center">
            <label class="">注册成功用户立即核发</label>
            <input type="text" class="form-control" id="regCoupon" name="regCoupon" value="<s:property value="regCoupon"/>">
        	<label class="">元抵用券</label>
        	 <button type="button" class="btn btn-success" onclick="updateRegCoupon()">确认</button>
        </div>
        <br/>
		<div class="form-group">
            <label class="">给</label>
            <select class="form-control" id="cityId" name="circleInfo.cityId">
                <s:iterator value="areaList">
            	<option value="<s:property value="id" />"><s:property value="areaName" /></option>
            	</s:iterator>
            </select>
           	<label class="">的用户核发满</label>
           	<input type="text" class="form-control" id="limitMoney" name="limitMoney" value=""/>
           <label>元可用</label>
            <input type="text" class="form-control" id="city_money" name="city_money" value="<s:property value="circleInfo.circleName"/>">
        	<label class="">元抵用券</label>
        	<label class="">有效期：从</label>
        	<input type="text" class="form-control" id="startTime" name="startTime" readonly="readonly" onfocus="WdatePicker({skin:'whyGreen'})"/>
				<label> 截止到</label><input type="text" class="form-control" id="endTime" name="endTime"  readonly="readonly" onfocus="WdatePicker({skin:'whyGreen'})"/> 
             <button type="button" class="btn btn-success" onclick="sendCouponCity()">确认</button>
        </div>
</div>
</form>
<hr />
<form class="form-inline tab-pane" role="form" id="listForm" name="listForm" action="<s:url value="/admin/couponIndex.do" includeParams='none'/>" method="post">
<div class="block search">
        <div class="form-group">
        <label class="">买家账户:</label>
            <input type="text" class="form-control" id="usermob" name="usermob" value="<s:property value="usermob"/>">
            <label class="">累计充值金额:</label>
            <input type="text" class="form-control" id="czstart" name="czstart" value="<s:property value="czstart"/>">
            	 至
           	<input type="text" class="form-control" id="czend" name="czend" value="<s:property value="czend"/>">
        </div>
        <div class="form-group">
            <label class="">累计订单金额:</label>
            <input type="text" class="form-control" id="orderstart" name="orderstart" value="<s:property value="orderstart"/>">
            	 至
           	<input type="text" class="form-control" id="orderend" name="orderend" value="<s:property value="orderend"/>">
        </div>

        <button type="button" class="btn btn-success" onclick="search()">搜 索</button>


</div>
<div class="block">

    <div class="datatable-tasks">
        <table class="table table-bordered">
            <thead>
            <tr>
                <th class="sq-city">买家账户</th>
                <th class="sq-circle">累计充值金额</th>
                <th class="sq-center">累计订单金额</th>
                <th class="sq-center">累计已发放抵用劵金额</th>
                <th class="sq-action text-center" colspan="2" >操作</th>
            </tr>
            </thead>
            <tbody>
            <s:if test="pagination.hasData == true">
            <s:iterator value="pagination.dataList" status="rowstatus">
            <tr>
                <td class="task-desc">
                	<s:property value="mobile"/>
                </td>
                <td class="task-desc">
                	￥<s:property value="%{formatDouble(total_cz)}"/>
                </td>
                <td class="text-center">
                	￥<s:property value="%{formatDouble(total_order_pay)}"/>
                </td>
                <td class="text-center">
                	￥<s:property value="%{formatDouble(total_coupon)}"/>
                </td>
                <td class="text-center">
                									 	买满:<input type="text"  class="coupon-control "  id="limitMoney_<s:property value="id"/>">金额，
                                                      抵用券金额:<input type="text"  class="coupon-control "  id="money_<s:property value="id"/>">
                                                      有效期:开始时间<input type="text" class="coupon-control "  id="startTime_<s:property value="id"/>"  readonly="readonly" onfocus="WdatePicker({skin:'whyGreen'})"/>
                                                      截至到<input type="text" class="coupon-control " id="endTime_<s:property value="id"/>"  readonly="readonly" onfocus="WdatePicker({skin:'whyGreen'})"/> 
                </td>
                <td class="text-center">
                	<button type="button" class="btn btn-default" onclick="sendCoupon(<s:property value="id"/>, <s:property value="mobile"/>)">
                        	发放
                    </button>
                </td>
            </tr>
            </s:iterator>
            </s:if>
            <s:else>
				<tr>
					<td colspan="5" align="center">没有搜索到符合条件的记录，请重新搜索！</td>
				</tr>
			</s:else>
            </tbody>
        </table>
        <!-- 分页 [页数为1页时也显示] -->
		<s:if test="pagination.pageCount > 0">
		<div align="right">
			<s:include value="/pages/admin/common/pagination.jsp"></s:include>
		</div>
        </s:if>
    </div>
</div>
</form>
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

	function search() {
		var czstart = trim($("#czstart").val());
		var czend = trim($("#czend").val());
		var usermob = trim($("#usermob").val()) 

		if(checkObjIsNull($("#czstart"))) {
			if(!checkMoney($("#czstart"))){
				top.dialog_alert("请输入正确的搜索条件！");
				return false;
			}
		}
		if(checkObjIsNull($("#czend"))) {
			if(!checkMoney($("#czend"))){
				top.dialog_alert("请输入正确的搜索条件！");
				return false;
			}
		}
		if (checkObjIsNull($("#czstart")) && checkObjIsNull($("#czend"))) {
			if (parseFloat(czstart) > parseFloat(czend)) {
				top.dialog_alert("请输入正确的搜索条件！");
				return false;
			}
		}
		
		var orderstart = trim($("#orderstart").val());
		var orderend = trim($("#orderend").val());

		if(checkObjIsNull($("#orderstart"))) {
			if(!checkMoney($("#orderstart"))){
				top.dialog_alert("请输入正确的搜索条件！");
				return false;
			}
		}
		if(checkObjIsNull($("#orderend"))) {
			if(!checkMoney($("#orderend"))){
				top.dialog_alert("请输入正确的搜索条件！");
				return false;
			}
		}
		if (checkObjIsNull($("#orderstart")) && checkObjIsNull($("#orderend"))) {
			if (parseFloat(orderstart) > parseFloat(orderend)) {
				top.dialog_alert("请输入正确的搜索条件！");
				return false;
			}
		}
		
		$("#currentPage").val(1);
		$('#listForm').submit();
	}

	
	function updateRegCoupon() {
		var regCoupon = trim($("#regCoupon").val());
		if(!checkMoney($("#regCoupon"))){
			top.dialog_alert("请输入正确的抵用券金额！");
			return false;
		}
		
		top.dialog_confirm("您确定核发此次抵用劵吗？", function(){
			var param = {"configurationInfo.itemValue":regCoupon};
	    	var act = "<s:url value='/admin/updateRegCoupon.do' includeParams='none'/>";
	        $.ajax({
	    		type:"post",
	    		url:act,
	    		data:param,
	    		cache:false,
	    		success: function(msg) {
	        		top.dialog_alert(msg, function(){window.location="<s:url value='/admin/couponIndex.do' />"});       
	        	}
	    	});
		});
	}

	function sendCoupon(userId, mobile){
		var money = trim($("#money_" + userId).val());
		var limitMoney = trim($("#limitMoney_"+userId).val());
		var startTime = trim($("#startTime_"+userId).val());
		var endTime = trim($("#endTime_"+userId).val());
		if(!checkMoney($("#money_" + userId))){
			top.dialog_alert("请输入正确的抵用券金额！");
			return false;
		}
		if(!checkMoney($("#limitMoney_"+userId))){
			top.dialog_alert("请输入正确的限额金额！");
			return false;
		}
		if(!checkObjIsNull($("#startTime_"+userId))){
			top.dialog_alert("优惠券有效开始时间不能为空!");
			return false;
		}
		if(!checkObjIsNull($("#endTime_"+userId))){
			top.dialog_alert("优惠券有效截止时间不能为空!");
			return false;
		}
		if(checkObjIsNull($("#startTime_"+userId))&&checkObjIsNull($("#endTime_"+userId))){
			if(!checkBeginDateAndEndDate($("#startTime"),$("#endTime"))){
				top.dialog_alert("优惠券有效截止时间必须大于开始时间!");
				return false;
			}
		}
		if(parseInt(money) > 10000000){
			top.dialog_alert("抵用券金额过大，请重新输入！");
			return false;
		}
		
		top.dialog_confirm("您确定给" + mobile + "用户发放" + money + "元抵用劵吗", function(){
			var param = {"couponInfo.userId":userId, "couponInfo.money":money,"couponInfo.limitMoney":limitMoney,"couponInfo.startTime":startTime,"couponInfo.endTime":endTime};
	    	var act = "<s:url value='/admin/sendCoupon.do' includeParams='none'/>";
	        $.ajax({
	    		type:"post",
	    		url:act,
	    		data:param,
	    		cache:false,
	    		success: function(msg) {
	        	top.dialog_alert(msg, function(){window.location="<s:url value='/admin/couponIndex.do' />"});       
	        	}
	    	});
		});
	}

	function sendCouponCity(){
		var cityId = $("#cityId").val();
		var money = trim($("#city_money").val());
		var limitMoney = trim($("#limitMoney").val());
		var startTime = trim($("#startTime").val());
		var endTime = trim($("#endTime").val());
		if(!checkMoney($("#city_money"))){
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
		if(parseInt(money) > 10000000){
			top.dialog_alert("抵用券金额过大，请重新输入！");
			return false;
		}
		top.dialog_confirm("您确定核发此次抵用劵吗？", function(){
			// 显示load的对话框
			window.parent.showLoad("load_coupon", "正在生成抵用券，请稍等");

						
			var param = {"cityId":cityId, "money":money,"limitMoney":limitMoney,"startTime":startTime,"endTime":endTime};
	    	var act = "<s:url value='/admin/sendCouponAll.do' includeParams='none'/>";
	        $.ajax({
	    		type:"post",
	    		url:act,
	    		data:param,
	    		cache:false,
	    		success: function(msg) {
	        		// 关闭load的对话框
					window.parent.hideLoad("load_coupon");

	        		top.dialog_alert(msg, function(){window.location="<s:url value='/admin/couponIndex.do' />"});       
	        	}
	    	});
		});
	}
	
</script>

</html>
