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
        <li><a href="javascript:void(0);" onclick="history.back();">用户交易明细查询</a></li>
        <li class="active">用户交易明细报表</li>
    </ul>
</div>
<form class="form-inline tab-pane" role="form" id="reportForm" name="reportForm" action="<s:url value="/admin/tradeDetails.do" includeParams='none'/>" method="post">

<div class="block">
    <div class="datatable-tasks">
        <table class="table table-bordered">
            <thead>
            <tr>
                <th class="sq-city">日期</th>
                <th class="sq-center">订单号</th>
                <th class="sq-center">商家名称</th>
                <th class="sq-center">活动折扣</th>
                <th class="sq-center">运费折扣</th>
                <th class="sq-center">抵用劵金额</th>
                <th class="sq-center">手机钱包金额</th>
                <th class="sq-center">在线支付金额</th>
                <th class="sq-center">货到付款金额</th>
                <th class="sq-center">订单总价</th>
            </tr>
            </thead>
            <tbody>
            <s:if test="pagination.hasData == true">
            <s:iterator value="pagination.dataList">
            <tr>
                <td class="task-desc">
                    <s:property value="%{formatDateTime(creat_time)}" /> - <s:property value="%{formatDateTime(finish_time)}" />
                </td>
                <td class="task-desc"><s:property value="order_code"/></td>
                <td class="task-desc"><s:property value="business_name"/></td>
                <td class="task-desc">满￥<s:property value="%{formatDouble(activity1_price)}" />减￥<s:property value="%{formatDouble(discount_price)}" /></td>
                <td class="task-desc">满￥<s:property value="%{formatDouble(activity2_price)}" />减￥<s:property value="%{formatDouble(discount_freight)}" /></td>
                <td class="task-desc">￥<s:property value="%{formatDouble(coupon)}" /></td>
                <td class="task-desc">￥<s:property value="%{formatDouble(wallet)}" /></td>
                <s:if test="payType == 0">
                <td class="task-desc">￥<s:property value="%{formatDouble(alipay_price+modify_price+modify_freight)}" /></td>
                <td class="task-desc">￥<s:property value="%{formatDouble(cash)}" /></td>
                <td class="task-desc">￥<s:property value="%{formatDouble(wallet + alipay_price+modify_price+modify_freight)}" /></td>
                </s:if>
                <s:elseif test="payType == 1">
                <td class="task-desc">￥<s:property value="%{formatDouble(alipay_price)}" /></td>
                <td class="task-desc">￥<s:property value="%{formatDouble(cash+modify_price+modify_freight)}" /></td>
                <td class="task-desc">￥<s:property value="%{formatDouble(cash+modify_price+modify_freight)}" /></td>
                </s:elseif>
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
</script>
</html>