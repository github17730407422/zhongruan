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
			<h3>在线支付退款管理</h3>
		</div>

	</div>
	<div class="breadcrumb-line">
		<ul class="breadcrumb">
			<li><a class="active">在线支付退款管理</a>
			</li>
		</ul>

	</div>
	
	<form class="form-inline tab-pane" role="form" id="listForm"
		name="listForm"
		action="<s:url value="/admin/orderCancelList.do" includeParams='none'/>"
		method="post">

		<div class="block search">
			<div style="margin-bottom: 5px">
				<div class="form-group">
					<label class="">订单编号:</label> <input type="text"
						class="form-control" id="searchOrderCode" name="searchOrderCode"
						value="<s:property value="searchOrderCode"/>" />
				</div>
				<div class="form-group">
					<label class="">商家名称:</label> <input type="text"
						class="form-control" id="searchBusinessName"
						name="searchBusinessName"
						value="<s:property value="searchBusinessName"/>" />
				</div>
				<div class="form-group">
					<label class="">买家账号:</label> <input type="text"
						class="form-control" id="searchUserName" name="searchUserName"
						value="<s:property value="searchUserName"/>" />
				</div>
				<div class="form-group">
					<label class="">下单时间:</label> <input type="text"
						class="form-control" id="searchOrderCreationTime"
						name="searchOrderCreationTime"
						value="<s:date name="searchOrderCreationTime" format="yyyy-MM-dd"/>"
						readonly="readonly" onfocus="WdatePicker({skin:'whyGreen'})" />
				</div>
				<div class="form-group">
					<label class="">取消时间:</label> <input type="text"
						class="form-control" id="searchOrderCancelTime"
						name="searchOrderCancelTime"
						value="<s:date name="searchOrderCancelTime" format="yyyy-MM-dd"/>"
						readonly="readonly" onfocus="WdatePicker({skin:'whyGreen'})" />
				</div>
				<div class="form-group">
					<label class="">支付时间:</label> <input type="text"
						class="form-control" id="searchOrderPayTime"
						name="searchOrderPayTime"
						value="<s:date name="searchOrderPayTime" format="yyyy-MM-dd"/>"
						readonly="readonly" onfocus="WdatePicker({skin:'whyGreen'})" />
				</div>
				<div class="form-group">
					<label class="">预约时间:</label> <input type="text"
						class="form-control" id="searchOrderPresetTime"
						name="searchOrderPresetTime"
						value="<s:date name="searchOrderPresetTime" format="yyyy-MM-dd"/>"
						readonly="readonly" onfocus="WdatePicker({skin:'whyGreen'})" />
				</div>
				<div class="form-group">
					<label class="">退款状态:</label> <select class="form-control"
						name="searchTuiStatus" id="searchTuiStatus">
						<option value="-1">请选择</option>
						<option value="1"
							<s:if test="searchTuiStatus == 1">selected="selected"</s:if>>
							未退款</option>
						<option value="2"
							<s:if test="searchTuiStatus == 2">selected="selected"</s:if>>
							已退款</option>
					</select>
				</div>
				<button type="button" class="btn btn-success" onclick="search()">搜
					索</button>
			</div>
		</div>
		<div class="block">
			<div class="datatable-tasks">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th class="">订单编号</th>
							<th class="">商家名称</th>
							<th class="">买家账号</th>
							<th class="">下单时间</th>
							<th class="">取消时间</th>
							<th class="">支付时间</th>
							<th class="">退款金额</th>
							<th class="">退款状态</th>
							<th class="">操作</th>
						</tr>
					</thead>
					<tbody>
						<s:if test="pagination.hasData == true">
							<s:iterator value="pagination.dataList" status="rowstatus">
								<tr>
									<td class="task-desc"><a href="javascript:void(0)"
										onclick="viewOrder(<s:property value="id"/>)"><s:property
												value="order_code" /> </a>
									</td>
									<td class="task-desc"><s:property value="business_name" />
									</td>
									<td class="text-center"><s:property value="user_name" />
									</td>
									<td class="task-desc"><s:property
											value="%{formatDateTime(creat_time)}" />
									</td>
									<td class="task-desc"><s:property
											value="%{formatDateTime(cancel_time)}" />
									</td>
									<td class="task-desc"><s:property
											value="%{formatDateTime(pay_time)}" />
									</td>
									<td class="text-center" style="color: red">
                						￥<s:property value="%{formatDouble(alipay_price+modify_freight+modify_price)}"/>
               						</td>																		
									<td class="text-center">
										<s:if test="tui_status==1 || tui_status==0"><strong>未退款</strong></s:if>
										<s:elseif test="tui_status==2"><strong>已退款</strong></s:elseif> 
									</td>
									<td class="text-center">
                    					<div class="btn-group">
                    					<s:if test="tui_status==1 || tui_status==0"><button type="button" class="btn btn-default" data-toggle="modal" data-target="#tuikuan" onclick="showTuikuanBox(<s:property value="id"/>)">
                        				<strong>退款</strong></button>
                        				</s:if>
                        				<s:elseif test="tui_status==2"><button type="button" class="btn btn-default" disabled="disabled">
                        				<strong>退款</strong></button>
                        				</s:elseif>
					                    </div>
					                </td>
								</tr>
							</s:iterator>
						</s:if>
						<s:else>
							<tr>
								<td colspan="9" align="center">没有搜索到符合条件的记录，请重新搜索！</td>
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

	<div class="modal fade" id="tuikuan">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title">订单退款</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label>输入退款原因：</label>
						<textarea class="form-control" name="tuikuan_reason"
							id="tuikuan_reason"></textarea>
					</div>(输入最多不超过30个字)
					<div class="modal-footer">
						<button type="button" class="btn btn-primary"
							onclick="tuikuanOrder()">确定</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
	</div>

	<form id="tuikuanOrderForm" name="tuikuanOrderForm"
		action="<s:url value="/admin/tuikuanOrder.do" includeParams='none'/>"
		method="post">
		<input type="hidden" id="tuikuanOrderId" name="tuikuanOrderId" value="" />
		<input type="hidden" id="tuikuanReason" name="tuikuanReason" value="" />
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
	$("#searchOrderCode").val(trim($("#searchOrderCode").val()));
	$("#searchBusinessName").val(trim($("#searchBusinessName").val()));
	$("#searchUserName").val(trim($("#searchUserName").val()));
	$("#currentPage").val(1);
    $('#listForm').submit();
}

function viewOrder(orderId){
	location.href = "<s:url value='/admin/orderView.do' includeParams='none'/>?orderId=" + orderId;
}
 	

//提示信息
$(function(){
	var message = "<s:property value='message'/>";
	if(message != null && message != ""){
		top.dialog_alert(message);
	}
});

function showTuikuanBox(orderId) {
	document.getElementById("tuikuanOrderId").value = orderId;
}

function tuikuanOrder(orderId){
	
	if (!checkObjLength($("#tuikuan_reason"), 60)){
		top.dialog_alert("退款原因长度最多为30个字。");
		return false;
	}
	$("#tuikuanReason").val($("#tuikuan_reason").val());
	$("#tuikuanOrderForm").submit();
}
</script>
</body>
</html>