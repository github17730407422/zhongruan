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
        <li class="active">各区域点单数，各区域送单数</li>
    </ul>
</div>
<form class="form-inline tab-pane" role="form" id="listForm" name="listForm" action="<s:url value="/admin/orderByArea.do" includeParams='none'/>" method="post">
<div class="block search">
    <div class="form-group">
        <select class="form-control" id="year" name="year">
            <option value="2014" <s:if test="year==2014">selected="selected"</s:if>>2014</option>
            <option value="2015" <s:if test="year==2015">selected="selected"</s:if>>2015</option>
            <option value="2016" <s:if test="year==2016">selected="selected"</s:if>>2016</option>
        </select>
        <label class="">年</label>
    </div>
    <div class="form-group">
        <select class="form-control" id="month" name="month">
            <option value="1" <s:if test="month==1">selected="selected"</s:if>>1</option>
            <option value="2" <s:if test="month==2">selected="selected"</s:if>>2</option>
            <option value="3" <s:if test="month==3">selected="selected"</s:if>>3</option>
            <option value="4" <s:if test="month==4">selected="selected"</s:if>>4</option>
            <option value="5" <s:if test="month==5">selected="selected"</s:if>>5</option>
            <option value="6" <s:if test="month==6">selected="selected"</s:if>>6</option>
            <option value="7" <s:if test="month==7">selected="selected"</s:if>>7</option>
            <option value="8" <s:if test="month==8">selected="selected"</s:if>>8</option>
            <option value="9" <s:if test="month==9">selected="selected"</s:if>>9</option>
            <option value="10" <s:if test="month==10">selected="selected"</s:if>>10</option>
            <option value="11" <s:if test="month==11">selected="selected"</s:if>>11</option>
            <option value="12" <s:if test="month==12">selected="selected"</s:if>>12</option>
        </select>
        <label class="">月</label>
    </div>
    <button type="button" class="btn btn-success" onclick="search()">搜 索</button>
</div>

<div class="block">
    <div class="datatable-tasks">
        <table class="table table-bordered">
            <thead>
            <tr>
                <th class="sq-city">年月份</th>
                <th class="sq-center">配送中心</th>
                <th class="sq-center">订单总数</th>
                <th class="sq-center">配送单数</th>
            </tr>
            </thead>
            <tbody>
            <s:if test="pagination.hasData == true">
            <s:iterator value="pagination.dataList" status="rowstatus">
            <tr>
                <td class="task-desc">
                    <s:property value="year"/>-<s:property value="month"/>
                </td>
                <td class="task-desc">
                    <s:property value="centerName"/>
                </td>
                <td class="task-desc">
                    <s:property value="orderCount"/>
                </td>
                <td class="task-desc">
                    <s:property value="deliveryCount"/>
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
	$("#currentPage").val(1);
    $('#listForm').submit();
}
</script>
</html>