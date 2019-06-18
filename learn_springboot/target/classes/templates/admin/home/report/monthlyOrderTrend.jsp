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
        <li class="active">订单数趋势图</li>
    </ul>
</div>
<form class="form-inline tab-pane" role="form" id="reportForm" name="reportForm" action="<s:url value="/admin/monthlyOrderTrend.do" includeParams='none'/>" method="post">
<div class="block search">
    <div class="form-group">
        <select class="form-control" id="year" name="year">
            <option value="2013" <s:if test="year==2013">selected="selected"</s:if>>2013</option>
            <option value="2014" <s:if test="year==2014">selected="selected"</s:if>>2014</option>
            <option value="2015" <s:if test="year==2015">selected="selected"</s:if>>2015</option>
            <option value="2016" <s:if test="year==2016">selected="selected"</s:if>>2016</option>
        </select>
        <label class="">年</label>
    </div>
    <button type="button" class="btn btn-success" onclick="search()">搜 索</button>
</div>

<div class="block">
    <div class="datatable-tasks">
        <center><img src="admin/monthlyOrderTrendChart.do?year=<s:property value="year"/>"></center>  
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
    $('#reportForm').submit();
}
</script>
</html>