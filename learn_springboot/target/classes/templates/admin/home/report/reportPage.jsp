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
        <li><a class="active">报表管理</a></li>
    </ul>
</div>

<div class="block">
    <div class="datatable-tasks">
        <table class="table table-bordered">
            <thead>
            <tr>
                <th class="">报表名称</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td class=""><a href="monthlyTurnoverBusinessUser.do">月总营业额，总商家数，总用户数</a></td>
            </tr>
            <tr>
                <td class=""><a href="monthlyFreightOrder.do">月总配送费，总配送单数</a></td>
            </tr>
            <tr>
                <td class=""><a href="expressMember.do">各配送人员配送单数、配送费用</a></td>
            </tr>
            <tr>
                <td class=""><a href="monthlyMOByBusiness.do">各商家月销售额，销售单数</a></td>
            </tr>
            <tr>
                <td class=""><a href="monthlyOrderTrend.do">每日单数趋势图</a></td>
            </tr>
            <tr>
                <td class=""><a href="orderByArea.do">各区域点单数，各区域送单数</a></td>
            </tr>
            <tr>
                <td class=""><a href="tradeDetails.do">用户交易记录明细表</a></td>
            </tr>
            <tr>
                <td class=""><a href="couponUsage.do">抵用券使用商家的报表</a></td>
            </tr>
            <tr>
                <td class=""><a href="ownGoodsDetails.do">自营商品销售明细报表</a></td>
            </tr>
            <tr>
                <td class=""><a href="dailyTotalRevenue.do">每日总收入报表</a></td>
            </tr>
         <tr>
               <td class=""><a href="businessOrderDetail.do">订单明细报表</a></td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
<!-- /page tabs --> 

<!-- Footer -->
<s:include value="/pages/admin/common/footer.jsp"></s:include>
<!-- /Footer -->
</body>
</html>