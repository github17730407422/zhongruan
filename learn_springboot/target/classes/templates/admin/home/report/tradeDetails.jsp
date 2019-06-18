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
        <li class="active">用户交易明细查询</li>
    </ul>
</div>
<form class="form-inline tab-pane" role="form" id="listForm" name="listForm" action="<s:url value="/admin/tradeDetails.do" includeParams='none'/>" method="post">
<div class="block search">
    <div class="form-group">
        <label class="">用户名:</label>
        <input type="text" class="form-control" id="userName" name="userName" value="<s:property value="userName"/>">
    </div>
    <div class="form-group">
        <label class="">开始时间:</label>
        <input type="text" class="form-control" id="startTime" name="startTime" readonly="readonly" onfocus="WdatePicker({skin:'whyGreen'})"  value="<s:property value="startTime"/>">
    </div>
    <div class="form-group">
        <label class="">结束时间:</label>
        <input type="text" class="form-control" id="endTime" name="endTime" readonly="readonly" onfocus="WdatePicker({skin:'whyGreen'})"  value="<s:property value="endTime"/>">
    </div>
    <button type="button" class="btn btn-success" onclick="search()">搜 索</button>
</div>

<div class="block">
    <div class="datatable-tasks">
        <table class="table table-bordered">
            <thead>
            <tr>
                <th class="sq-city">序号</th>
                <th class="sq-center">用户名称</th>
                <th class="sq-center">操作</th>
            </tr>
            </thead>
            <tbody>
            <s:if test="pagination.hasData == true">
            <s:iterator value="pagination.dataList" status="status">
            <tr>
                <td class="task-desc">
                    <s:property value='#status.index + 1'/>
                </td>
                <td class="task-desc">
                    <s:property value="userName"/>
                </td>
                <td class="task-desc">
                    <a href="javascript:void(0)" onclick="viewDetailsByUser(<s:property value="userId"/>)">查看交易明细</a>
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
        $("#logId").val("");
        top.dialog_alert(message);
    }
});

function search() {
	if (!checkObjIsNull($("#userName"))) {
		top.dialog_alert("请输入用户名称");
		return false;
	}
	
	if (checkObjIsNull($("#startTime")) && checkObjIsNull($("#endTime"))) {
		var start1 = formatDate($("#startTime").val());
		var end1 = formatDate($("#endTime").val());
		
		//top.dialog_alert(" : " + start1 + " : " + end1 + " : " + (start1 > end1));
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

function viewDetailsByUser(userId) {
	var start1 = "";
	var end1 = "";
	
	if ($("#startTime") != null && $("#startTime").val() != '') {
		start1 = $("#startTime").val();
	}
	
	if ($("#endTime") != null && $("#endTime").val() != '') {
		end1 = $("#endTime").val();
	}
	
	location.href = "tradeDetailsByUser.do?userId=" + userId + "&&startTime=" + start1 + "&&endTime=" + end1;
}
</script>
</html>