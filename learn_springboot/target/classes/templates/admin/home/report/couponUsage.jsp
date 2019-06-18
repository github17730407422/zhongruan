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
        <h3>报表管理</h3>
    </div>
</div>
<div class="breadcrumb-line">
    <ul class="breadcrumb">
        <li><a href="<s:url value="/admin/reportPage.do" includeParams='none'/>">报表管理</a></li>
        <li class="active">抵用券用于商家的报表</li>
    </ul>
</div>
<form class="form-inline tab-pane" role="form" id="listForm" name="listForm" action="<s:url value="/admin/couponUsage.do" includeParams='none'/>" method="post">
<div class="block search">
    <div class="form-group">
        <label class="">城市:</label>
        <select class="form-control" id="city_id" name="city_id">
            <s:iterator value="areaList">
            <option value="<s:property value="id" />"><s:property value="areaName" /></option>
            </s:iterator>
        </select>
    </div>
    <div class="form-group">
        <label class="">商家名称:</label>
        <input type="text" class="form-control" id="businessName" name="businessName" value="<s:property value="businessName"/>">
    </div>
    <div class="form-group">
        <label class="">使用时间:</label>
        <input type="text" class="form-control" id="startTime" name="startTime" readonly="readonly" onfocus="WdatePicker({skin:'whyGreen'})" value="<s:property value="%{formatDate(startTime)}"/>">
        <label class="">至</label>
        <input type="text" class="form-control" id="endTime" name="endTime" readonly="readonly" onfocus="WdatePicker({skin:'whyGreen'})" value="<s:property value="%{formatDate(endTime)}"/>">
    </div>
    <button type="button" class="btn btn-success" onclick="search()">搜 索</button>
     <input type="button" onclick="excel()" class="btn btn-success" value="导出excel"/>
</div>

<div class="block">
    <div class="datatable-tasks">
        <table class="table table-bordered">
            <thead>
            <tr>
                <th class="sq-city">起始时间</th>
                <th class="sq-center">商家名称</th>
                <th class="sq-center">抵用券使用总金额</th>
            </tr>
            </thead>
            <tbody>
            <s:if test="pagination.hasData == true">
            <s:iterator value="pagination.dataList" status="status">
            <tr>
                <td class="task-desc" nowrap>
                    <s:property value="%{formatDate(startTime1)}" /> 至 <s:if test="endTime1 == null">今</s:if><s:else><s:property value="%{formatDate(endTime1)}" /></s:else>
                </td>
                <td class="task-desc">
                    <s:property value="business_name"/>
                </td>
                <td class="task-desc">
                                                    ￥<s:property value="%{formatDouble(totalCouponAmount)}" />
                </td>
            </tr>
            </s:iterator>
            </s:if>
            <s:else>
                <tr>
                    <td colspan="3" align="center">没有搜索到符合条件的记录，请重新搜索！</td>
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
    var start_time = "";
    var end_time = "";
    
    if ($("#startTime") != null) {
        start_time = $("#startTime").val();
    }
    if ($("#endTime") != null) {
        end_time = $("#endTime").val();
    }
    
    if (start_time != '' && end_time != '') {
        var start1 = formatDate(start_time);
        var end1 = formatDate(end_time);
        if (start1 > end1) {
            top.dialog_alert("开始时间不能晚于结束时间");
            return false;
        }
    }
    $("#currentPage").val(1);
    $('#listForm').submit();
}

function formatDate(strDate) {
    var str = strDate.replace("/", "-");
    dateArray = str.split("-");
    
    var year = dateArray[0].length == 2 ? "20" + dateArray[0] : dateArray[0];
    var month = dateArray[1].length == 1 ? "0" + dateArray[1] : dateArray[1];
    var day = dateArray[2].length == 1 ? "0" + dateArray[2] : dateArray[2];
    
    return year + month + day;
}

function excel(){
    var action="<s:url value="/admin/exportCouponUsage.do"/>";
     $('#listForm').attr("action",action);
     $('#listForm').submit();
      $('#listForm').attr("action","<s:url value="/admin/couponUsage.do"/>");
}
</script>
</html>