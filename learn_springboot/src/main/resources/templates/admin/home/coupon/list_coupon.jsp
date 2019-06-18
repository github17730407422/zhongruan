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
        <h3>抵用券管理</h3>
    </div>
</div>
<div class="breadcrumb-line">
    <ul class="breadcrumb">
        <li><a href="<s:url value="/admin/couponIndex.do" includeParams='none'/>">抵用券管理</a></li>
        <li class="active">抵用券列表</li>
    </ul>
</div>
<form class="form-inline tab-pane" role="form" id="listForm" name="listForm" action="<s:url value="/admin/couponList.do" includeParams='none'/>" method="post">
<div class="block search">
        <div class="form-group">
            <label class="">抵用券号码:</label>
            <input type="text" class="form-control" id="code" name="couponInfo.code" value="<s:property value="couponInfo.code"/>">
        </div>
        <div class="form-group">
            <label class="">买家账号:</label>
            <input type="text" class="form-control" id="mobile" name="couponInfo.mobile" value="<s:property value="couponInfo.mobile"/>">
        </div>
        <div class="form-group">
            <label class="">商家名称:</label>
            <input type="text" class="form-control" id="businessName" name="couponInfo.businessName" value="<s:property value="couponInfo.businessName"/>">
        </div>
        <div class="form-group">
            <label class="">使用日期:</label>
            <input type="text" class="form-control" id="startDate" name="couponInfo.startDate" onClick="WdatePicker()" value="<s:property value="couponInfo.startDate"/>">
  			至
  			<input type="text" class="form-control" id="endDate" name="couponInfo.endDate" onClick="WdatePicker()" value="<s:property value="couponInfo.endDate"/>">
        </div>
		<div class="form-group">
            <label class="">状态:</label>
            <select class="form-control" id="status" name="couponInfo.status">
            	<option value="">全部</option>
            	<option value="1" <s:if test="couponInfo.status == 1">selected="selected"</s:if>>已使用</option>
            	<option value="0" <s:if test="couponInfo.status == 0">selected="selected"</s:if>>未使用</option>
            </select>
        </div>
        <button type="button" class="btn btn-success" onclick="search()">搜 索</button>
</div>
<div class="block">

    <div class="datatable-tasks">
        <table class="table table-bordered">
            <thead>
            <tr>
                <th class="sq-city">抵用券号码</th>
                <th class="sq-city">买家账户</th>
                <th class="sq-circle">发放时间</th>
                <th class="sq-center">使用状态</th>
                <th class="sq-center">商家名称</th>
                <th class="sq-center">使用时间</th>
                <th class="sq-action">使用金额</th>
                <th class="sq-action">优惠券金额</th>
                <th class="sq-action">限额</th>
                <th class="sq-center">开始时间</th>
                <th class="sq-center">截止时间</th>
            </tr>
            </thead>
            <tbody>
            <s:if test="pagination.hasData == true">
            <s:iterator value="pagination.dataList" status="rowstatus">
            <tr>
                <td class="text-center">
                	<s:property value="code"/>
                </td>
                <td class="text-center">
                	<s:if test="mobile == ''">
                		未绑定买家
                	</s:if>
                	<s:else>
                		<s:property value="mobile"/>
                	</s:else>
                </td>
                <td class="text-center">
                	<s:property value="%{formatDateTime(creatTime)}"/>
                </td>
                <td class="text-center">
                	<s:if test="status == 0">
                		未使用
                	</s:if>
                	<s:else>
                		已使用
                	</s:else>
                </td>
                <td class="text-center">
                    <s:property value="businessName"/>
                </td>
                <td class="text-center">
                	<s:property value="%{formatDateTime(useTime)}"/>
                </td>
                <td class="text-center">
                	<s:if test="couponMoney != 0.0">
                		￥<s:property value="%{formatDouble(couponMoney)}"/>
                	</s:if>
                </td>
                <td class="text-center">
                	<s:if test="money != 0.0">
                		￥<s:property value="%{formatDouble(money)}"/>
                	</s:if>
                </td>
                <td class="text-center">
                	<s:if test="limitMoney != 0.0">
                		￥<s:property value="%{formatDouble(limitMoney)}"/>
                	</s:if>
                </td>
                <td class="text-center">
                	<s:property value="%{formatDateTime(startTime)}"/>
                </td>
                <td class="text-center">
                	<s:property value="%{formatDateTime(endTime)}"/>
                </td>
            </tr>
            </s:iterator>
            </s:if>
            <s:else>
				<tr>
					<td colspan="7" align="center">没有搜索到符合条件的记录，请重新搜索！</td>
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
<div class="form-actions text-right">
        <input type="button" value="返  回" class="btn btn-danger" onclick="resetCoupon()">
    </div>
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
		var startDate = trim($("#startDate").val());
		var endDate = trim($("#endDate").val());
		if (checkObjIsNull($("#startDate")) && checkObjIsNull($("#endDate"))) {
			if (startDate > endDate) {
				top.dialog_alert("结束时间不能早于开始时间！");
				$("#endDate").val("");
				return false;
			}
		}
		$("#currentPage").val(1);
		$('#listForm').submit();
	}
	
	function resetCoupon() {
		location.href='<s:url value="/admin/couponIndex.do" includeParams="none"/>';
	}

</script>

</html>
