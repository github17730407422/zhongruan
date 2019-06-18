<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %> 
<%@ include file="/pages/admin/common/admin_meta.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
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
	        <li class="active">订单明细报表</li>
	    </ul>
	</div>
	
	<form id="form_order" name="listForm" role="form" action="<s:url value="/admin/businessOrderDetail.do"/>" method="post">
	 <div class="block search">
		<div style="margin-bottom: 5px">
			<div class="form-group">
				 <label class="">下单时间:</label>	 
				 <input type="text" class=""  id="searchOrderCreationTime" name="orderCreationTime" value="<s:date name="orderCreationTime" format="yyyy-MM-dd"/>" readonly="readonly" onfocus="WdatePicker({skin:'whyGreen'})"/>
				 ~<input type="text" class="" id="searchOrderCreationEndTime" name="orderCreationEndTime" value="<s:date name="orderCreationEndTime" format="yyyy-MM-dd"/>" readonly="readonly" onfocus="WdatePicker({skin:'whyGreen'})"/> 
	
				 <label class="">完成时间:</label>	 
				 <input type="text" class="" id="searchOrderFinishTime" name="orderFinishTime" value="<s:date name="orderFinishTime" format="yyyy-MM-dd"/>" readonly="readonly" onfocus="WdatePicker({skin:'whyGreen'})"/>
				 ~<input type="text" class="" id="searchOrderFinishEndTime" name="orderFinishEndTime" value="<s:date name="orderFinishEndTime" format="yyyy-MM-dd"/>" readonly="readonly" onfocus="WdatePicker({skin:'whyGreen'})"/> 
		
		        <label class="">商家名称:</label>
		        <input type="text" class="" id="searchBusinessName" name="searchBusinessName" value="<s:property value="businessName"/>"/>
		   
		         <label class="">订单状态</label>
		         <select id="searchOrderStatus" name="searchOrderStatus" >
		          <option value="-1" >全部 </option>
		          <option value="0" <s:if test="orderStatus == 0">selected="selected"</s:if>> 未支付</option>
		          <option value="1" <s:if test="orderStatus == 1">selected="selected"</s:if>> 已下单</option>
		          <option value="2" <s:if test="orderStatus == 2">selected="selected"</s:if>> 已派单</option>
		          <option value="4" <s:if test="orderStatus == 4">selected="selected"</s:if>> 派送中</option>
		          <option value="5" <s:if test="orderStatus == 5">selected="selected"</s:if>> 已完成</option>
		          <option value="6" <s:if test="orderStatus == 6">selected="selected"</s:if>> 已取消</option>
		         </select><br/>
		     </div>
		     
		     <div class="form-group">  
		         <label class="">预约时间:</label>	 
				 <input type="text" class="" id="searchOrderPresetTime" name="orderPresetTime" value="<s:date name="orderPresetTime" format="yyyy-MM-dd"/>" readonly="readonly" onfocus="WdatePicker({skin:'whyGreen'})"/>
				 ~<input type="text" class="" id="searchOrderPresetEndTime" name="orderPresetEndTime" value="<s:date name="orderPresetEndTime" format="yyyy-MM-dd"/>" readonly="readonly" onfocus="WdatePicker({skin:'whyGreen'})"/> 
			 
		         <label class="">买家账号</label>
		         <input type="text" class="" id="searchMobile" name="searchMobile" value="<s:property value="mobile"/>"/>
		    	   
			    <input type="button" onclick="search()" value="搜素"/>
			    <input type="button" onclick="excel()" value="导出excel"/>
		 </div>
       </div>
     </div>
    
     <!-- 这里添加表格信息 -->
     <div class="block">
     <div  class="datatable-tasks1" >
       <table class="table table-bordered">
          <thead>
            <tr>
              <th>订单编号</th>  
              <th>下单时间</th>  
              <th>完成时间</th>  
              <th>预约时间</th>  
              <th>预约类型</th>  
              <th>商家名称</th>  
              <th>订单状态</th>  
              <th>买家账号</th>
              <th>支付方式</th>  
              <th>商品总价</th>  
              <th>配送费</th>  
              <th>满减运费金额</th>  
              <th>折扣金额</th>  
              <th>抵用券金额</th>  
              <th>配送费调整</th>  
              <th>总价调整</th>  
              <th>电子钱包支付金额</th>  
              <th>支付宝支付金额</th>  
              <th>货到付款金额</th>  
            </tr>
          </thead>
          <tbody>
          <s:if test="pagination.hasData == true">
            <s:iterator value="pagination.dataList" status="rowstatus">
              <tr>
                <td><s:property value="order_code"/></td>
                <td><s:property value="%{formatDateTime(creat_time)}"/></td>
                <td><s:property value="%{formatDateTime(finish_time)}"/></td>
                <td><s:property value="%{formatDateTime(preset_time)}"/></td>
                <td>
                  <s:if test="order_type==0">即时订单</s:if>
                  <s:if test="order_type==1">预约外卖</s:if>
                  <s:if test="order_type==2">预约堂食</s:if>
                </td>
                <td><s:property value="business_name"/></td>
                <td>
                 <s:if test="status==0">未支付</s:if>
                 <s:if test="status==1">已下单</s:if>
                 <s:if test="status==2">已派单</s:if>
                 <s:if test="status==4">派送中</s:if>
                 <s:if test="status==5">已完成</s:if>
                 <s:if test="status==6">已取消</s:if>
                </td>
                <td><s:property value="mobile"/></td>
                <td>
                  <s:if test="pay_type==0">线上支付</s:if>
                  <s:if test="pay_type==1">货到付款</s:if>
                </td>
                <td>￥<s:property value="total_price-modify_price"/>元</td>
                <td>￥<s:property value="freight-modify_freight"/>元</td>
                <td>￥<s:property value="discount_freight"/>元</td>
                <td>￥<s:property value="discount_price"/>元</td>
                <td>￥<s:property value="money"/>元</td>
                <td>             
                   <s:if test="modify_freight > 0">
						￥+<s:property value="%{formatDouble(modify_freight)}"/>元
					</s:if>
					<s:if test="modify_freight < 0">
						￥<s:property value="%{formatDouble(modify_freight)}"/>元
					</s:if>
				</td>
                <td>
                  <s:if test="modify_price > 0">
						￥+<s:property value="%{formatDouble(modify_price)}"/>元
					</s:if>
					<s:if test="modify_price < 0">
						￥<s:property value="%{formatDouble(modify_price)}"/>元
				  </s:if>
                </td>
                <td>￥<s:property value="wallet"/>元</td>
                <s:if test="pay_type==0">
	                <td>￥<s:property value="total_price+freight- discount_freight-discount_price-money"/>元</td>
	                <td>￥0.0元</td>
	            </s:if>
	            <s:else>
	                <td>￥0.0元</td>
	                <td>￥<s:property value="total_price+freight- discount_freight-discount_price-money"/>元</td>  
	            </s:else>
              </tr>
            </s:iterator>
            </s:if>
            <s:else>
				<tr>
					<td colspan="19" align="center">没有搜索到符合条件的记录，请重新搜索！</td>
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
    
 </body>
</html>
<script language=javascript >
function search() { 
    $("#currentPage").val(1);
	$("#searchBusinessName").val(trim($("#searchBusinessName").val()));
	  var action="<s:url value="/admin/businessOrderDetail.do"/>";
	  $('#form_order').attr("action",action);
    $('#form_order').submit();  
}
function excel(){
    var action="<s:url value="/admin/exportOrderDetail.do"/>";
     $('#form_order').attr("action",action);
     $('#form_order').submit();
      $('#form_order').attr("action","<s:url value="/admin/businessOrderDetail.do"/>");
}
</script>