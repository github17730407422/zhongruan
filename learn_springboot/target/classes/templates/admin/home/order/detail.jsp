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
        <h3>订单详情
        </h3>
    </div>
</div>
<div class="breadcrumb-line">
    <ul class="breadcrumb">
    	<s:if test="orderInfo.order_type == 0">
    	<li><a href="<s:url value="/admin/orderList.do" includeParams='none'/>">订单管理</a></li>
    	</s:if>
    	<s:else>
    	<li><a href="<s:url value="/admin/orderList2.do" includeParams='none'/>">订单管理</a></li>
    	</s:else>
        <li class="active">订单详情</li>
    </ul>
</div>
<div class="car-panel">

    <div class="panel-body ">
        <table class="dot-line table">
            <tr>
                <td>订单编号：<s:property value="orderInfo.order_code" /></td>
                <td>商家名称：<s:property value="orderInfo.business_name" /></td>
                <td>买家账号：<s:property value="orderInfo.user_name" /></td>
            </tr>
            <tr>
                <td>下单时间：<s:property value="%{formatDateTime(orderInfo.creat_time)}" /></td>
                <td>
                	支付方式：
                	<s:if test="orderInfo.pay_type == 0">在线支付</s:if>
                    <s:if test="orderInfo.pay_type == 1">货到付款</s:if>
                </td>
                <td>
                	订单状态： 
                	<s:if test="orderInfo.status == 0">未支付</s:if>
                	<s:if test="orderInfo.status == 1">已下单</s:if>
                    <s:if test="orderInfo.status == 2">已派单</s:if>
                    <s:if test="orderInfo.status == 3">已取餐</s:if>
                    <s:if test="orderInfo.status == 4">派送中</s:if>
                    <s:if test="orderInfo.status == 5">已完成</s:if>
                    <s:if test="orderInfo.status == 6">已取消</s:if>
                </td>
            </tr>
            <s:if test="orderInfo.status == 6">
                <tr>
                    <td>取消时间：<s:property value="%{formatDateTime(orderInfo.cancel_time)}" /></td>
                    <td>取消原因：<s:property value="orderInfo.cancel_reason" /></td>
                    <s:if test="orderInfo.pay_time != null && orderInfo.alipay_price+orderInfo.modify_freight+orderInfo.modify_price >0"><td>退款状态：<s:if test="orderInfo.tui_status == 1 || orderInfo.tui_status ==0">未退款</s:if><s:if test="orderInfo.tui_status == 2">已退款</s:if></td></s:if>
                    <s:else><td></td></s:else>
                </tr>
            </s:if>
            
            <s:if test="orderInfo.order_type == 0">
            <tr>
                <td>完成时间：<s:if test="orderInfo.finish_time != null"><s:property value="%{formatDateTime(orderInfo.finish_time)}" /></s:if></td>
                <td></td>
                <td></td>
            </tr>
            </s:if>
            <s:elseif test="orderInfo.order_type == 1">
            <tr>
                <td>预约时间：<s:property value="%{formatDateTime(orderInfo.preset_time)}" /></td>
                <td>预约类型：外卖</td>
                <td>完成时间：<s:if test="orderInfo.finish_time != null"><s:property value="%{formatDateTime(orderInfo.finish_time)}" /></s:if></td>
            </tr>
            </s:elseif>
            <s:else>
            <tr>
                <td>预约堂食时间：<s:property value="%{formatDateTime(orderInfo.preset_time)}" /></td>
                <td>预约类型：堂食</td>
                <td></td>
            </tr>
            </s:else>
        </table>
        <br/>
        <table class="table table-bordered"  style="table-layout:fixed;">
            <thead>
            <th>商品</th>
            <th>名称</th>
            <th>价格</th>
            <th>数量</th>
            <th>运费</th>
            <th>商品总计</th>
            </thead>
            <tbody>
            <s:iterator value="orderDetailInfoList" status="index">
            <s:if test="number > 0">
            <tr>
                <td><img src="<s:url value="/"/><s:property value="imageUrl" />" height="36px;"/> </td>
                <td title=" <s:property value="goods_name"/> <s:property value="spec_names.replaceAll(',',' ')"/>" style="overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" >
                <s:property value="goods_name"/> <s:property value="spec_names.replaceAll(',',' ')"/>
                </td>
                <td>￥<s:property value="%{formatDouble(preferential_price+spec_total_price)}" /></td>
                <td><s:property value="number"/></td>
                <s:if test="#index.count == 1">
                <td rowspan="<s:property value='orderDetailInfoList.size'/>">￥<s:property value="%{formatDouble(orderInfo.freight-orderInfo.modify_freight)}" /></td>
                <td rowspan="<s:property value='orderDetailInfoList.size'/>">￥<s:property value="%{formatDouble(orderInfo.total_price_business+orderInfo.total_price_own)}" /></td>
           		</s:if>
            </tr>
            </s:if>
            </s:iterator>
            </tbody>
        </table>
        <div class="" style="margin-top: 5px; margin-right: 20px;float: right">
            <b>易食客配送</b>
            <ul >
                <li>
					配送费
					<span class="count">￥
						<s:property value="%{formatDouble(orderInfo.freight-orderInfo.modify_freight)}" />
						<s:if test="orderInfo.discount_freight > 0">
						（优惠后 ￥<s:property value="%{formatDouble(orderInfo.freight - orderInfo.modify_freight - orderInfo.discount_freight)}" />）
						</s:if>
					</span>元
                </li>
                <li>
					商家商品总价
					<span class="count">￥
						<s:property value="%{formatDouble(orderInfo.total_price_business)}" />
						<s:if test="orderInfo.discount_price > 0">
						（优惠后 ￥<s:property value="%{formatDouble(orderInfo.total_price_business - orderInfo.discount_price)}" />）
						</s:if>
					</span>元
                </li>
                <s:if test="orderInfo.total_price_own > 0">
                <li>
					自营商品总价
					<span class="count">
						￥<s:property value="%{formatDouble(orderInfo.total_price_own)}" />
					</span>元
                </li>
                </s:if>
                <s:if test="orderInfo.coupon > 0">
                <li>
					抵用券
					<span class="count">
						￥-<s:property value="%{formatDouble(orderInfo.coupon)}" />
					</span>元
                </li>
                </s:if>
				<hr/>
				<s:if test="orderInfo.modify_freight != 0">
				<li>
					<strong>配送费：易食客调整</strong>
					<span class="count">
					<s:if test="orderInfo.modify_freight > 0">
						￥+<s:property value="%{formatDouble(orderInfo.modify_freight)}"/>
					</s:if>
					<s:if test="orderInfo.modify_freight < 0">
						￥<s:property value="%{formatDouble(orderInfo.modify_freight)}"/>
					</s:if>
					</span>元
				</li>
				</s:if>
				<s:if test="orderInfo.modify_price != 0">
				<li>
					<strong>商品总价：易食客调整</strong>
					<span class="count">
					<s:if test="orderInfo.modify_price > 0">
						￥+<s:property value="%{formatDouble(orderInfo.modify_price)}"/>
					</s:if>
					<s:else>
						￥<s:property value="%{formatDouble(orderInfo.modify_price)}"/>
					</s:else>
					</span>元					
				</li>
				</s:if>
				<s:if test="orderInfo.modify_freight !=0 || orderInfo.modify_price !=0">
				<hr/>
				</s:if>
                <li>
					小计
					<span class="count">
						￥<s:property value="%{formatDouble(orderInfo.total)}" />
					</span>元
                </li>	
                <hr/>			
                <s:if test="orderInfo.pay_type == 0">
                <s:if test="orderInfo.wallet > 0">
                <li>
					电子钱包支付金额
					<span class="count">
						￥<s:property value="%{formatDouble(orderInfo.wallet)}" />
					</span>元
                </li>
                </s:if>
                <s:if test="orderInfo.alipay_price > 0">
                <li>
					支付宝支付金额
					<span class="count">
					<s:if test="orderInfo.status==0">
						￥<s:property value="%{formatDouble(orderInfo.alipay_price+orderInfo.modify_freight+orderInfo.modify_price)}" />
					</s:if>
					<s:else>
						￥<s:property value="%{formatDouble(orderInfo.alipay_price+orderInfo.modify_freight+orderInfo.modify_price)}" />
					</s:else>	
					</span>元
                </li>
                </s:if>
                </s:if>
                <s:else>
                <li>
					货到付款金额
					<span class="count">
					<s:if test="orderInfo.status==1 || orderInfo.status==2 || orderInfo.status==4">
						￥<s:property value="%{formatDouble(orderInfo.total)}" />
					</s:if>
					<s:else>
						￥<s:property value="%{formatDouble(orderInfo.cash+orderInfo.modify_price+orderInfo.modify_freight)}" />
					</s:else>
					</span>元
                </li>
                </s:else>
            </ul>
        </div>
        <div class="margin60"></div>
    </div>
    <div class="clear"></div>
</div>
<div class="car-panel">
    <div class="panel-title">买家信息</div>

    <table class="table dot-line">
        <tr>
            <td>
				收货地址：<s:property value="orderInfo.user_address" />
            </td>
            <td>
				 联系人：<s:property value="orderInfo.name" />
            </td>
            <td >
				联系电话：<s:property value="orderInfo.mobile" />
            </td>
        </tr>
        <tr>
            <td colspan="3">
               	 留言信息：<s:property value="orderInfo.remark" />
            </td>
        </tr>
        <tr>
            <td colspan="1">订单评分：<s:if test="orderInfo.score == null">尚未评价</s:if><s:else><s:property value="orderInfo.score" /></s:else></td>
            <td colspan="2">订单评价：<s:property value="orderInfo.score_description" /></td>
        </tr>
    </table>
</div>
</div>
<br>
<div class="form-actions text-right">
    <input type="button" value="返回" class="btn btn-danger" onclick="Javascript:history.go(-1)" />
</div>
                        
<!-- Footer -->
<s:include value="/pages/admin/common/footer.jsp"></s:include>
<!-- /Footer -->
<script>
    $(".maximum-select").select2({
        maximumSelectionSize: 1,
        width: "100%"
    });
    function back(){
    	location.href = "<s:url value='/admin/orderList.do' includeParams='none'/>";
    }

</script>
</body>
</html>