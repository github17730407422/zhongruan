<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/pages/admin/common/admin_meta.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>易食客后台管理系统</title>
</head>
<body class="sub-page">
<div class="page-header">
    <div class="page-title">
        <h3>订单管理</h3>
    </div>

</div>
<div class="breadcrumb-line">
    <ul class="breadcrumb">
        <li><a class="active">预约订单</a></li>
    </ul>

</div>
	<s:iterator value="centerList" id="centerId" >
		<input type="hidden" id="c_<s:property value='#centerId.id'/>"  value="<s:property value="#centerId.centerName"/>"/>
	</s:iterator>
<form class="form-inline tab-pane" role="form" id="listForm" name="listForm" action="<s:url value="/admin/orderList2.do" includeParams='none'/>" method="post">    

<div class="block search">
    <div style="margin-bottom: 5px">
    <div class="form-group">
        <label class="">订单编号:</label>
        <input type="text" class="form-control" id="searchOrderCode" name="searchOrderCode" value="<s:property value="searchOrderCode"/>"/>
    </div>
    <div class="form-group">
        <label class="">收货地址:</label>
        <input type="text" class="form-control" id="searchOrderaddr" name="searchOrderaddr" value="<s:property value="searchOrderaddr"/>"/>
    </div>
    <div class="form-group">
        <label class="">商家名称:</label>
        <input type="text" class="form-control" id="searchBusinessName" name="searchBusinessName" value="<s:property value="searchBusinessName"/>"/>
    </div>
    <div class="form-group">
        <label class="">买家账号:</label>
        <input type="text" class="form-control" id="searchUserName" name="searchUserName" value="<s:property value="searchUserName"/>"/>
    </div>
    <div class="form-group">
        <label class="">下单时间:</label>
        <input type="text" class="form-control" id="searchOrderCreationTime" name="searchOrderCreationTime" value="<s:date name="searchOrderCreationTime" format="yyyy-MM-dd"/>" readonly="readonly" onfocus="WdatePicker({skin:'whyGreen'})"/>
    </div>
    <div class="form-group">
        <label class="">预约时间:</label>
        <input type="text" class="form-control" id="searchOrderPresetTime" name="searchOrderPresetTime" value="<s:date name="searchOrderPresetTime" format="yyyy-MM-dd"/>" readonly="readonly" onfocus="WdatePicker({skin:'whyGreen'})"/>
    </div>
    <div class="form-group">
        <label class="">配送方式:</label>
        <select class="form-control" name="searchOrderType" id="searchOrderType">
      	  <option value="-1"> 请选择</option>
          <option value="1" <s:if test="searchOrderType == 1">selected="selected"</s:if>> 配送</option>
          <option value="2" <s:if test="searchOrderType == 2">selected="selected"</s:if>> 堂食</option>
      </select>
    </div>
    <div class="form-group">
        <label class="">状态:</label>
      <select class="form-control" name="searchOrderStatus" id="searchOrderStatus">
      	  <option value="-1"> 请选择</option>
          <option value="0" <s:if test="searchOrderStatus == 0">selected="selected"</s:if>> 未支付</option>
          <option value="1" <s:if test="searchOrderStatus == 1">selected="selected"</s:if>> 已下单</option>
          <option value="2" <s:if test="searchOrderStatus == 2">selected="selected"</s:if>> 已派单</option>
          <option value="4" <s:if test="searchOrderStatus == 4">selected="selected"</s:if>> 派送中</option>
          <option value="5" <s:if test="searchOrderStatus == 5">selected="selected"</s:if>> 已完成</option>
          <option value="6" <s:if test="searchOrderStatus == 6">selected="selected"</s:if>> 已取消</option>
      </select>
      <div class="form-group">
        <label class="">配送员:</label>
        <input type="text" class="form-control" id="searchSendName" name="searchSendName" value="<s:property value="searchSendName"/>"/>
    </div>
    </div>
        <button type="button" class="btn btn-success" onclick="search()">搜 索</button>
    </div>
</div>
<div class="block">
    <div  class="datatable-tasks1" >
        <table class="table table-bordered">
            <thead>
            <tr>
                <th class="">订单编号</th>
                <th class="">商家名称</th>
                <th class="">买家账号</th>
                <th class="">下单时间</th>
                <th class="">预约时间</th>
                <th class="">收货地址</th>
                <th class="">状态</th>
                <th class="">配送方式</th>
                <th class="">配送员</th>
                <th class="">操作</th>
            </tr>
            </thead>
            <tbody>
           		<s:if test="pagination.hasData == true">
            <s:iterator value="pagination.dataList" status="rowstatus">
            <tr>
                <td class="task-desc"><a href="javascript:void(0)" onclick="viewOrder(<s:property value="id"/>)"><s:property value="order_code"/></a></td>
                <td class="task-desc" ><s:property value="business_name"/></td>
                <td class="text-center"><s:property value="user_name"/></td>
                <td class="task-desc"><s:property value="%{formatDateTime(creat_time)}" /></td>
                <td class="task-desc"><s:property value="%{formatDateTime(preset_time)}" /></td>
                 <td class="task-desc" ><s:if test="order_type==1" ><p title="<s:property value="user_address"/>"><s:property value="%{formatName(user_address,17)}"/></p></s:if><s:else>无</s:else></td>
                <td class="text-center">
                    <s:if test="status==0">未支付</s:if>
                    <s:elseif test="status==1">已下单</s:elseif>
                    <s:elseif test="status==2">已派单</s:elseif>
                    <s:elseif test="status==3">已取餐</s:elseif>
                    <s:elseif test="status==4">派送中</s:elseif>
                    <s:elseif test="status==5">已完成</s:elseif>
                    <s:elseif test="status==6">已取消</s:elseif>
                </td>
                <td class="text-center">
                	<s:if test="order_type==1">配送</s:if>
                	<s:elseif test="order_type==2">堂食</s:elseif>
                </td>
                <td class="task-desc">
                	取餐员：<s:if test="take_name==null">无 </s:if><s:else><s:property value="take_name"/></s:else><br>
                                                     送餐员：<s:if test="send_name==null">无 </s:if><s:else><s:property value="send_name"/></s:else><br>
                </td>
                <td class="text-center">
                    <div class="btn-group">
                    <s:if test="order_type == 1">
                        <s:if test="status != 0 && status != 5 && status != 6">
                        <button type="button" class="btn btn-default" data-toggle="modal" data-target="#peisong" onclick="showDeliveryBox('<s:property value="id"/>', '<s:property value="take_id"/>', '<s:property value="send_id"/>', '<s:property value="take_center_id"/>', '<s:property value="send_center_id"/>', '<s:property value="status"/>','<s:property value="%{formatDateTime(preset_time)}" />')"><i class="fa fa-pencil fa-lg"></i>配送</button>
                        </s:if>
                        <s:if test="status != 5 && status != 6">
                        <button type="button" class="btn btn-default" data-toggle="modal" data-target="#cancelOrder" onclick="showCancelBox(<s:property value="id"/>)"><i class="fa fa-trash-o fa-lg"></i>取消</button>
                   		</s:if>
						<s:if test="status != 5 && status != 6 && sysUserModifyType == 1">
							<button type="button" class="btn btn-default"
								data-toggle="modal" data-target="#updatePrice"
								onclick="showPriceBox('<s:property value="id"/>', '<s:property value="total_price"/>', '<s:property value="modify_price"/>','<s:property value="freight"/>', '<s:property value="modify_freight"/>','<s:property value="discount_price"/>','<s:property value="discount_freight"/>','<s:property value="coupon"/>')">
								<i class="fa fa-pencil fa-lg"></i>修改价格
							</button>
						</s:if>    
                    </s:if>
                    <s:elseif test="order_type==2">
                    	<s:if test="status == 1">
                    	<button type="button" class="btn btn-default" onclick="finishOrder(<s:property value="id"/>)"><i class="fa fa-pencil fa-lg"></i>完成</button>
                    	</s:if>
                    	<s:if test="status == 0 || status == 1">
                    	<button type="button" class="btn btn-default" data-toggle="modal" data-target="#cancelOrder" onclick="showCancelBox(<s:property value="id"/>)"><i class="fa fa-trash-o fa-lg"></i>取消</button>
                    	</s:if>
						<s:if test="status != 5 && status != 6 && sysUserModifyType == 1">
							<button type="button" class="btn btn-default"
								data-toggle="modal" data-target="#updatePrice"
								onclick="showPriceBox('<s:property value="id"/>', '<s:property value="total_price"/>', '<s:property value="modify_price"/>','<s:property value="freight"/>', '<s:property value="modify_freight"/>','<s:property value="discount_price"/>','<s:property value="discount_freight"/>','<s:property value="coupon"/>')">
								<i class="fa fa-pencil fa-lg"></i>修改价格
							</button>
						</s:if>                    	
                    </s:elseif>
                    </div>
                </td>
            </tr>
            </s:iterator>
            </s:if>
           		<s:else>
				<tr>
					<td colspan="10" align="center">没有搜索到符合条件的记录，请重新搜索！</td>
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

	<div class="modal fade" id="peisong">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title">配送管理</h4>
				</div>
				<div class="modal-body">
					<form role="form">
						<div class="form-group" id="take_div">
							取餐：<select data-placeholder="请选择配送中心" tabindex="2"
								class="maximum-select" name="takeCenterName" id="takeCenterName"
								style="padding:10px;" onchange="setTakeMemberList()">
								</select><br/>
								取餐人：<select data-placeholder="请选择配送员" tabindex="2"
								class="maximum-select" name="take_member_id" id="take_member_id"
								style="padding:10px;" onchange="setTakeMember()">
							</select>
						</div>
						
						<div class="form-group" id="send_div">
							送餐：<select data-placeholder="请选择配送中心" tabindex="2"
								class="maximum-select" name="sendCenterName" id="sendCenterName"
								style="padding:10px;" onchange="setSendMemberList()">
								</select><br/>
								送餐人：<select data-placeholder="请选择配送员" tabindex="2"
								class="maximum-select" name="send_member_id" id="send_member_id"
								style="padding:10px;" onchange="setSendMember()">
							</select>
						</div>
						
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" onclick="dealOrder()">保存</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>

<div class="modal fade" id="cancelOrder">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">取消订单</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label >请填写取消原因：</label>
                    <textarea class="form-control" name="cancel_reason" id="cancel_reason"></textarea>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" onclick="cancelOrder()">保存</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>
</div>

	<div class="modal fade" id="updatePrice">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title">修改订单价格</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label>配送费用：</label>
						￥<span id="original_freight"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<select id="freight_option">
							<option value="0">-</option>
							<option value="1">+</option>
						</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="text" value="0.00" id="freight_change" style="width: 50px;"/>&nbsp;元
					</div>
					<div class="form-group">
						<label>商品总价：</label>
						￥<span id="original_price"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<select id="price_option">
							<option value="0">-</option>
							<option value="1">+</option>
						</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="text" value="0.00" id="price_change" style="width: 50px;"/>&nbsp;元
					</div>
					<div class="form-group">
						<label>请填写修改订单价格原因：</label>
						<textarea class="form-control" name="updatePrice_reason"
							id="updatePrice_reason"></textarea>
						<span style="color: #989898">(输入字符最多不得超过30个中文字符)</span>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
						<button type="button" class="btn btn-primary"
							onclick="updatePrice()">保存</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
	</div>

<form id="assignMemberForm" name="assignMemberForm" action="<s:url value="/admin/orderDeal2.do" includeParams='none'/>" method="post">
    <input type="hidden" id="orderId" name="orderId" value=""/>
    <input type="hidden" id="takeId" name="takeId" value=""/>
    <input type="hidden" id="takeCenterId" name="takeCenterId" value=""/>
    <input type="hidden" id="sendId" name="sendId" value=""/>
    <input type="hidden" id="sendCenterId" name="sendCenterId" value=""/>
    <input type="hidden" id="orderStatus" name="orderStatus" value=""/>
    <input type="hidden" id="ordertTime" name="ordertTime" value=""/>
</form>

<form id="cancelOrderForm" name="cancelOrderForm" action="<s:url value="/admin/orderCancel2.do" includeParams='none'/>" method="post">
    <input type="hidden" id="cancelOrderId" name="cancelOrderId" value=""/>
    <input type="hidden" id="orderCancelReason" name="orderCancelReason" value=""/>
</form>

<form id="finishOrderForm" name="finishOrderForm" action="<s:url value="/admin/orderFinish.do" includeParams='none'/>" method="post">
    <input type="hidden" id="orderId2" name="orderId2" value=""/>
</form>
	<form id="updatePriceForm" name="updatePriceForm" 
		action="<s:url value="/admin/updatePrice2.do" includeParams='none'/>"
		method="post">
		<input type="hidden" id="updatePriceId" name="updatePriceId" value=""/>
		<input type="hidden" id="modify_freight" name="modify_freight" value=""/>
		<input type="hidden" id="modify_price" name="modify_price" value=""/>
		<input type="hidden" id="updatePriceReason" name="updatePriceReason" value=""/>
	</form>
<!-- Footer -->
<s:include value="/pages/admin/common/footer.jsp"></s:include>
<!-- /Footer -->

<script>
$(".maximum-select").select2({
    maximumSelectionSize: 1,
    width: "100%"
});

function search() {
    $("#currentPage").val(1);
	$("#searchOrderCode").val(trim($("#searchOrderCode").val()));
	$("#searchBusinessName").val(trim($("#searchBusinessName").val()));
	$("#searchUserName").val(trim($("#searchUserName").val()));
	$("#searchOrderaddr").val(trim($("#searchOrderaddr").val()));
	$("#searchSendName").val(trim($("#searchSendName").val()));
    $('#listForm').submit();
    
    
}

function viewOrder(orderId){
	location.href = "<s:url value='/admin/orderView.do' includeParams='none'/>?orderId=" + orderId;
}

function hideButton(){
	$("#peisong .modal-dialog .modal-content .modal-footer .btn.btn-primary").hide();
}

function showButton(){
	$("#peisong .modal-dialog .modal-content .modal-footer .btn.btn-primary").show();
}

//提示信息
$(function(){
	var message = "<s:property value='message'/>";
	if(message != null && message != ""){
		top.dialog_alert(message);
	}
});

function fmoney(s, n) {
	n = n > 0 && n <= 20 ? n : 2;
	s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";
	var l = s.split(".")[0].split("").reverse(), r = s.split(".")[1];
	t = "";
	for (i = 0; i < l.length; i++) {
		t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");
	}
	return t.split("").reverse().join("") + "." + r;
} 

function showPriceBox(id,total_price,modify_price,freight,modify_freight,discount_price,discount_freight,coupon){
	var price;
	var freight;
	
	//alert("total_price:"+total_price+"\nmodify_price:"+modify_price+"\ndiscount_price:"+discount_price+"\ncoupon:"+coupon);
	price = fmoney(parseFloat(total_price)-parseFloat(modify_price)-parseFloat(discount_price)-parseFloat(coupon),2);
	freight = fmoney(parseFloat(freight)-parseFloat(discount_freight)-parseFloat(modify_freight),2);

	//alert(price+"商品总价,"+freight+"配送费");
	$("#original_price").text(price);
	$("#original_freight").text(freight);
	$("#updatePriceId").val(id);
}

function updatePrice(){
	if(!checkMoney($("#freight_change"))){
		top.dialog_alert("修改配送费的金额输入有误！");
		return false;
	}
	if(!checkMoney($("#price_change"))){
		top.dialog_alert("修改商品总价的金额输入有误！");
		return false;		
	}
	
	if($("#freight_option").val()==0){
		if($("#original_freight").text() - $("#freight_change").val()<0){
			top.dialog_alert("减掉的配送费已超配送费总价！");
			return false;
		}
	}
	if($("#price_option").val()==0){
		if($("#original_price").text() - $("#price_change").val()<0){
			top.dialog_alert("减掉的商品总价已超原商品总价！");
			return false;
		}
	}
	if (!checkObjLength($("#updatePrice_reason"), 60)){
		top.dialog_alert("修改订单价格原因长度最多为30个字。");
		return false;
	}
//	if($("#freight_option").val()==0){
//		$("#modify_freight").val("-"+$("#freight_change").val());
//	}else{
//		$("#modify_freight").val($("#freight_change").val());
//	}
//	if($("#price_option").val()==0){
//		$("#modify_price").val("-"+$("#price_change").val());
//	}else{
//		$("#modify_price").val($("#price_change").val());
//	}
//	$("#updatePriceReason").val($("#updatePrice_reason").val());
//	$('#updatePriceForm').submit();
	var updatePriceId;
	var modify_freight;
	var modify_price;
	var updatePriceReason;
	if($("#freight_option").val()==0){
		modify_freight = "-"+$("#freight_change").val();
	}else{
		modify_freight = $("#freight_change").val();
	}
	if($("#price_option").val()==0){
		modify_price = "-"+$("#price_change").val();
	}else{
		modify_price = $("#price_change").val();
	}
	updatePriceReason = $("#updatePrice_reason").val();
	updatePriceId = $("#updatePriceId").val();
	var act = "<s:url value='/admin/updatePrice2.do' includeParams='none'/>";
	var param = {"updatePriceId" : updatePriceId, "modify_freight" : modify_freight, "modify_price" : modify_price, "updatePriceReason" : updatePriceReason};
	$.ajax({
		type : "post",
		dataType:"json",
		data : param,
		url : act,
		cache : false,
		success: function(data) {
			top.dialog_alert(eval(data).message);
			search();
		}
	})
}

function showDeliveryBox(orderId, take_id, send_id, take_center_id, send_center_id, status, preset_time) {
	$("#ordertTime").val(preset_time);
	$("#orderId").val(orderId);
	
	var take_center_name = $("#c_"+take_center_id).val();
	var send_center_name = $("#c_"+send_center_id).val();
	
	$("#takeCenterId").val(take_center_id);
	$("#s2id_takeCenterName .select2-choice .select2-chosen").text(take_center_name);
	
	$("#sendCenterId").val(send_center_id);
	$("#s2id_sendCenterName .select2-choice .select2-chosen").text(send_center_name);
	
	document.getElementById("takeId").value=take_id>0 ? take_id:null;
	document.getElementById("sendId").value=send_id>0 ? send_id:null;

	if((!$("#takeId").val() && !$("#sendId").val() && take_center_id != send_center_id)
			||(take_center_id==send_center_id && $("#takeId").val())){ //跨配送中心
		document.getElementById("take_div").style.display = '';
		document.getElementById("send_div").style.display = 'none';
	}else{
		//同一配送中心，不需要显示取餐信息
		document.getElementById("take_div").style.display = 'none';
		document.getElementById("send_div").style.display = '';
	}
	
	var act1 = "<s:url value='/admin/getAllCenterListByCityId.do' includeParams='none'/>";
	$.ajax({
		type : "post",
		dataType : "json",
		url : act1,
		cache : false,
		success : function(data) {
			var json = eval(data);
			$("#takeCenterName").empty();
			$("#sendCenterName").empty();
			if(status>2)
				hideButton();
			else
				showButton();
			for(var i = 0; i < json.length; i++){
				if ((!$("#takeId").val() && !$("#sendId").val() && take_center_id != send_center_id)
						||(take_center_id==send_center_id && $("#takeId").val())) { // 跨配送中心 只有取餐 没有送餐
					$("<option></option>").val(json[i].id).text(json[i].centerName).appendTo("#takeCenterName");	
					if(take_center_name == json[i].centerName){
						$("#takeCenterName").val(json[i].id);
						setTakeMemberList();
					}
				}else{ //同一配送中心 只有送餐 没有取餐
					$("<option></option>").val(json[i].id).text(json[i].centerName).appendTo("#sendCenterName");
					if(send_center_name == json[i].centerName){
						$("#sendCenterName").val(json[i].id);
						setSendMemberList();
					}
				}
			}
		}
	});
}
function setTakeMember() {
	$("#takeId").val($("#take_member_id").val());
}

function setTakeMemberList(){
	var act = "<s:url value='/admin/memberListByCenter.do' includeParams='none'/>";
	var take_center_id = $("#takeCenterName").val();
	if(take_center_id != null){
		var param = {"center_id" : take_center_id};
		$.ajax({
			type : "post",
			dataType:"json",
			data : param,
			url : act,
			cache : false,
			success: function(data) {
				var json = eval(data);
				$("#s2id_take_member_id .select2-choice .select2-chosen").empty();
	           	document.getElementById("take_member_id").innerHTML = "<option value=\"\">请指定配送人员</option>";
	           	var minOrderNum = json.length>0?json[0].oNum:"";
	   			var jsonIndex=0;
	   			var flag = false;
	           	for (var i = 0; i < json.length; i++) {
	           		var selected = "";
	           		if($("#takeId").val() == json[i].id){
	           			$("#s2id_take_member_id .select2-choice .select2-chosen").text(json[i].name+ " (" + json[i].oNum + "份订单)");
	           			flag = true;
	           			selected = " selected=\"selected\"";
	           			if(status==4){//派送中
	           				$("#take_member_id").empty();
	           				document.getElementById("take_member_id").innerHTML += "<option value=\"" + json[i].id + "\"" + selected + ">" + json[i].name + " (" + json[i].oNum + "份订单)" + "</option>";
	           				break;
	           			}else if(status==3){//已取餐
	           				$("#take_member_id").empty();
	           				document.getElementById("take_member_id").innerHTML += "<option value=\"" + json[i].id + "\"" + selected + ">" + json[i].name + " (" + json[i].oNum + "份订单)" + "</option>";
	               				$("#orderStatus").val(status);
	               				break;
	               			}
	               		}else{
	               			if(minOrderNum > json[i].oNum){
	               				minOrderNum = json[i].oNum;
	               				jsonIndex = i;
	               			}
	               		}
	               		document.getElementById("take_member_id").innerHTML += "<option value=\"" + json[i].id + "\"" + selected + ">" + json[i].name + " (" + json[i].oNum + "份订单)" + "</option>";
	                }
	                if(json.length>0 && flag==false){
	                	$("#s2id_take_member_id .select2-choice .select2-chosen").text(json[jsonIndex].name+ " (" + json[jsonIndex].oNum + "份订单)");
	                	$("#take_member_id").find("option[value=\""+json[jsonIndex].id+"\"]").attr("selected",true);
	                	$("#takeId").val(json[jsonIndex].id);
	                	//document.getElementById("take_member_id").innerHTML += "<option value=\"" + json[jsonIndex].id + "\" selected=\"selected\">" + json[jsonIndex].name + " (" + json[jsonIndex].oNum + "份订单)" + "</option>";
	                }
				} 
			});
	}
}

function setSendMember() {
	$("#sendId").val($("#send_member_id").val());
}

function setSendMemberList(){
	var act = "<s:url value='/admin/memberListByCenter.do' includeParams='none'/>";
	var send_center_id = $("#sendCenterName").val();
	if(send_center_id != null){
		var param = {"center_id" : send_center_id};
		$.ajax({
			type : "post",
			dataType:"json",
			data : param,
			url : act,
			cache : false,
			success: function(data) {
				$("#s2id_send_member_id .select2-choice .select2-chosen").empty();
				document.getElementById("send_member_id").innerHTML = "<option value=\"\">请指定配送人员</option>";
	            var json = eval(data);
	            var minOrderNum = json.length>0?json[0].oNum:"";
	      		var jsonIndex=0;
	      		var flag = false;
	            for (var i = 0; i < json.length; i++) {
	            	var selected = "";
	               	if($("#sendId").val() == json[i].id){
	               		flag = true;
	               		selected = " selected=\"selected\"";
	               		$("#s2id_send_member_id .select2-choice .select2-chosen").text(json[i].name+ " (" + json[i].oNum + "份订单)");
	               		if(status==4){
	               			$("#send_member_id").empty();
	               			document.getElementById("send_member_id").innerHTML += "<option value=\"" + json[i].id + "\"" + selected + ">" + json[i].name + " (" + json[i].oNum + "份订单)" + "</option>";
	               			break;
	               		}
	               	}else{
	               		//var selected = send_id == json[i].id ? " selected=\"selected\"" : "";
	               		if(minOrderNum > json[i].oNum){
	               			minOrderNum = json[i].oNum;
	               			jsonIndex = i;
	               		}
	               	}
	               	document.getElementById("send_member_id").innerHTML += "<option value=\"" + json[i].id + "\"" + selected + ">" + json[i].name + " (" + json[i].oNum + "份订单)" + "</option>";
	            }
	            if(json.length>0 && flag==false){
	            	$("#s2id_send_member_id .select2-choice .select2-chosen").text(json[jsonIndex].name+ " (" + json[jsonIndex].oNum + "份订单)");
	            	$("#send_member_id").find("option[value=\""+json[jsonIndex].id+"\"]").attr("selected",true);
	            	$("#sendId").val(json[jsonIndex].id);
	            	//document.getElementById("send_member_id").innerHTML += "<option value=\"" + json[jsonIndex].id + "\" selected=\"selected\">" + json[jsonIndex].name + " (" + json[jsonIndex].oNum + "份订单)" + "</option>";
	            }
	        }
		});
	}
}

function dealOrder(orderId){
	if($("#takeId").val() != ""){
		$("#sendId").val($("#takeId").val());
	}
	if ($("#sendId").val() == "") {
		top.dialog_alert("请选择送餐人员");
		return false;
	}
	if (!$("#takeId").val() && !$("#sendId").val()) {
		top.dialog_alert("请选择取餐（送餐）人员");
		return false;
	}
	if($("#take_div").css("display")=="block" &&$("#s2id_take_member_id .select2-choice .select2-chosen").text()==""){
		top.dialog_alert("请选择取餐人员");
		return false;
	}
	if($("#send_div").css("display")=="block" &&$("#s2id_send_member_id .select2-choice .select2-chosen").text()==""){
		top.dialog_alert("请选择送餐人员");
		return false;
	}
	top.dialog_confirm("您确认该配送人员吗？", function(){
		$('#assignMemberForm').submit();
	});
}

function showCancelBox(orderId) {
	document.getElementById("cancelOrderId").value = orderId;
}

function cancelOrder(orderId){
	
	if (!checkObjLength($("#cancel_reason"), 60)){
		top.dialog_alert("订单取消原因长度最多为30个字。");
		return false;
	}
	
	var confirm_message = "您确认取消该订单吗？取消后，手机钱包的费用将直接返还至手机钱包；在线支付和货到付款的款项线下与用户进行结算；若使用抵用券，则不返还！";
	
	top.dialog_confirm(confirm_message, function() {
		document.getElementById("orderCancelReason").value = document.getElementById("cancel_reason").value;
		$("#cancelOrderForm").submit();
	});
}

function finishOrder(orderId){
	var confirm_message = "您确认完成该订单吗？";
	top.dialog_confirm(confirm_message, function() {
		$("#orderId2").val(orderId);
		$("#finishOrderForm").submit();
	});
}
</script>
</body>
</html>