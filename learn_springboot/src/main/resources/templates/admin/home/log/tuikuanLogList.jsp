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
        <h3>日志管理</h3>
    </div>
</div>
<div class="breadcrumb-line">
    <ul class="breadcrumb">
        <li>日志管理</li>
        <li class="active">退款日志</li>
    </ul>
</div>
<form class="form-inline tab-pane" role="form" id="listForm" name="listForm" action="<s:url value="/admin/tuikuanLogList.do" includeParams='none'/>" method="post">
<div class="block search">
    <div class="form-group">
        <label class="">订单编号:</label>
        <input type="text" class="form-control" id="searchOrderCode" name="searchOrderCode" value="<s:property value="searchOrderCode"/>">
    </div>
    <div class="form-group">
        <label class="">管理员帐号:</label>
        <input type="text" class="form-control" id="searchOpName" name="searchOpName" value="<s:property value="searchOpName"/>">
    </div>
    <div class="form-group">
        <label class="">退款时间从:</label>
        <input type="text" class="form-control" id="startTime" name="startTime" readonly="readonly" onfocus="WdatePicker({skin:'whyGreen'})"  value="<s:property value="startTime"/>">
    </div>
    <div class="form-group">
        <label class="">至:</label>
        <input type="text" class="form-control" id="endTime" name="endTime" readonly="readonly" onfocus="WdatePicker({skin:'whyGreen'})"  value="<s:property value="endTime"/>">
    </div>
    <input type="hidden" id="type" name=""type"" value="<s:property value="type"/>"/>
    <button type="button" class="btn btn-success" onclick="search()">搜 索</button>
</div>

<div class="block">
    <div class="datatable-tasks">
        <table class="table table-bordered">
            <thead>
            <tr>
                <th class="">订单编号</th>
                <th class="">管理员帐号</th>
                <th class="">退款时间</th>
                <th class="">退款原因</th>
            </tr>
            </thead>
            <tbody>
            <s:if test="pagination.hasData == true">
            <s:iterator value="pagination.dataList" status="rowstatus">
            <tr>
                <td class="task-desc">
                    <s:property value="order_code"/>
                </td>
                <td class="task-desc">
                    <s:property value="opName"/>
                </td>
                <td class="task-desc">
                    <s:property value="%{formatDateTime(creatTime)}" />
                </td>
                <td class="task-desc">
                    <s:property value="description"/>
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
    	if (checkObjIsNull($("#startTime")) && checkObjIsNull($("#endTime"))) {
    		var start1 = formatDate($("#startTime").val());
    		var end1 = formatDate($("#endTime").val());
    		
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
</script>
</html>