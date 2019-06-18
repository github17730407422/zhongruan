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
        <li class="active">月总营业额，总商家数，总用户数</li>
    </ul>
</div>
<form class="form-inline tab-pane" role="form" id="reportForm" name="reportForm" action="<s:url value="/admin/monthlyTurnoverBusinessUser.do" includeParams='none'/>" method="post">
<div class="block search">
    <div class="form-group">
        <label class="">选择年份:</label>
        <select class="form-control" id="year" name="year">
            <option value="2014" <s:if test="year==2014">selected="selected"</s:if>>2014</option>
            <option value="2015" <s:if test="year==2015">selected="selected"</s:if>>2015</option>
            <option value="2016" <s:if test="year==2016">selected="selected"</s:if>>2016</option>
        </select>
    </div>
    <button type="button" class="btn btn-success" onclick="search()">搜 索</button>
</div>

<div class="block">
    <div class="datatable-tasks">
        <table class="table table-bordered">
            <thead>
            <tr>
                <th class="sq-city">年月份</th>
                <th class="sq-center">月总营业额</th>
                <th class="sq-center">商家总数</th>
                <th class="sq-center">用户总数</th>
            </tr>
            </thead>
            <tbody>
            <s:if test="pagination.hasData == true">
            <s:iterator value="pagination.dataList" status="rowstatus">
            <tr>
                <td class="task-desc">
                    <s:property value="strMonth"/>
                </td>
                <td class="task-desc">
                                                    ￥<s:property value="%{formatDouble(turnover)}" />
                </td>
                <td class="task-desc">
                    <s:property value="businessCount"/>
                </td>
                <td class="task-desc">
                    <s:property value="userCount"/>
                </td>
            </tr>
            </s:iterator>
            </s:if>
            <s:else>
                <tr>
                    <td colspan="4" align="center">没有搜索到符合条件的记录，请重新搜索！</td>
                </tr>
            </s:else>
            </tbody>
        </table>
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