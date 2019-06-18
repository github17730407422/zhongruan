<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/pages/admin/common/admin_meta_index.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>易食客后台管理系统</title>
    <style>
        html,body{
            overflow: hidden;
        }
    </style>
    <script language=javascript>
    //刷新页面时回到最后访问的页面
		$(function(){
			var url='<s:property value="%{#session.lastAccessUrl}"/>';
			if(url!=""){
				var accessUrl='<s:url value="%{#session.lastAccessUrl}" />';
				$("#subpage").attr("src",accessUrl);
				$(".navigation li").each(function() {
					var accessLi=$(this);
					accessLi.find("a").each(function() {
						var href=($(this).attr("href"));
						if(href==accessUrl){
							accessLi.addClass("active").siblings().removeClass("active");
						}
					})
				})
			}
		})
	</script>
</head>
<body class="sidebar-wide"><!-- Navbar -->
<div class="navbar navbar-inverse" role="navigation">
    <div class="navbar-header">
        <span class="navbar-brand">
            易食客管理系统 </span>

    </div>
    <ul class="nav navbar-nav navbar-right collapse" id="navbar-icons">

        <li class="user " style="cursor:default;">
            <a> 
            	欢迎
            	<s:if test="systemUserInfo.type == 0">
            		超级管理员 
            	</s:if>
            	<s:elseif test="systemUserInfo.type == 1">
            		管理员 
            	</s:elseif>
            	<s:else>
            		财务
            	</s:else>
            	<s:property value="systemUserInfo.userName" />
            </a>
        </li>
        <li>
            <a href="javascript:adminLogout();" class="btn btn-link">
            	<i class="icon-exit3"></i>退出
            </a>
        </li>
    </ul>
</div>
<!-- /navbar -->
<!-- Page container -->
<div class="page-container"><!-- Sidebar -->
    <div class="sidebar collapse" style="height:600px; overflow:scroll">
        <div class="sidebar-content"><!-- User dropdown -->

            <!-- Main navigation -->
            <ul class="navigation">
                <s:if test="systemUserInfo.type != 2">
                <li class="active">
                	<a href="<s:url value="/admin/circleList.do" includeParams='none'/>" target="subpage">
                		<span>商圈管理</span> <i class="icon-screen2"></i>
                	</a>
                </li>
                </s:if>
                <s:if test="systemUserInfo.type != 2">
                <li >
                	<a href="#" class="expand">
                		<span>配送管理</span> <i class="icon-paragraph-justify2"></i>
                	</a>
                    <ul>
                        <li>
                            <a href="<s:url value="/admin/centerList.do" includeParams='none'/>" target="subpage">配送中心管理</a>
                        </li>
                        <li>
                            <a href="<s:url value="/admin/memberList.do" includeParams='none'/>" target="subpage">配送人员管理</a>
                        </li>
                    </ul>
                </li>
                </s:if>
                <s:if test="systemUserInfo.type != 2">
                <li>
                	<a href="<s:url value="/admin/businessList.do" includeParams='none'/>" target="subpage">
                		<span>商家管理</span> <i class="icon-drawer3"></i>
                	</a>
                </li>
                </s:if>
                <s:if test="systemUserInfo.type != 2">
                <li>
                	<a href="#" class="expand">
                		<span>商品管理</span> <i class="icon-grid"></i>
                	</a>
                    <ul>
                        <li>
                        	<a href="<s:url value="/admin/goodsList.do" includeParams='none'/>" target="subpage">商家商品管理</a>
                        </li>
                        <li>
                        	<a href="<s:url value="/admin/goodsOwnList.do" includeParams='none'/>" target="subpage">自营商品管理</a>
                        </li>
                        <li>
                        	<a href="<s:url value="/admin/categoryList.do" includeParams='none'/>" target="subpage">
                        		商品类别管理
                        	</a>
                        </li>
                    </ul>
                </li>
                </s:if>
                <s:if test="systemUserInfo.type != 2">
                <li>
                	<a href="#"  class="expand" >
                		<span>订单管理</span> 
                		<i class="icon-numbered-list"></i>
                	</a>
                	<ul>
                        <li>
                        	<a href="<s:url value="/admin/orderList.do" includeParams='none'/>" target="subpage">即时订单</a>
                        </li>
                        <li>
                        	<a href="<s:url value="/admin/orderList2.do" includeParams='none'/>" target="subpage">预约订单</a>
                        </li>
                    </ul>
                </li>
                </s:if>
                <s:if test="systemUserInfo.type != 1">
                <li>
                	<a href="<s:url value="/admin/orderCancelList.do" includeParams='none'/>" target="subpage">
                		<span>在线支付退款管理</span> 
                		<i class="icon-coin"></i>
                	</a>
                </li>
                </s:if>
                <s:if test="systemUserInfo.type != 2">
                <li>
                    <a href="<s:url value="/admin/adList.do" includeParams='none'/>" target="subpage">
                        <span>广告定制</span> 
                        <i class="icon-insert-template"></i>
                    </a>
                </li>
                </s:if>
                <s:if test="systemUserInfo.type == 0">
                <li>
                	<a href="<s:url value="/admin/systemUserList.do" includeParams='none'/>" target="subpage">
                		<span>用户管理</span> <i class="icon-user"></i>
                	</a>
                </li>
                </s:if>
                <s:if test="systemUserInfo.type == 0">
                <li>
                	<a href="<s:url value="/admin/couponIndex.do" includeParams='none'/>"  target="subpage" >
                		<span>抵用券管理</span> <i class="icon-coin"></i>
                	</a>
                </li>
                </s:if>
                <s:if test="systemUserInfo.type == 0">
                <li>
                	<a href="<s:url value="/admin/freightList.do" includeParams='none'/>" target="subpage">
                		<span>运费定制</span> <i class="icon-coin"></i>
                	</a>
                </li>
                </s:if>
                <s:if test="systemUserInfo.type != 2">
                <li>
                	<a href="<s:url value="/admin/navList.do" includeParams='none'/>" target="subpage">
                		<span>手机客户端分类导航管理</span> <i class="icon-cog"></i>
                	</a>
                </li>
                </s:if>
                <s:if test="systemUserInfo.type != 1">
                <li>
                	<a href="<s:url value="/admin/reportPage.do" includeParams='none'/>" target="subpage">
                		<span>报表管理</span> <i class="icon-bars"></i>
                	</a>
                </li>
                </s:if>
                <s:if test="systemUserInfo.type == 0">
                <li>
                	<a href="<s:url value="/admin/message.do" includeParams='none'/>" target="subpage">
                		<i class="icon-cog"></i> 消息管理
                	</a>
                </li>
                </s:if>
                <li>
                	<a href="<s:url value="/admin/changePwdPage.do" includeParams='none'/>" target="subpage">
                		<i class="icon-cog"></i> 密码管理
                	</a>
                </li>
                <s:if test="systemUserInfo.type != 2">
                <li>
                	<a href="#" class="expand">
                		<span>日志管理</span> <i class="icon-search3"></i>
                	</a>
                    <ul>
                        <li>
                        	<a href="<s:url value="/admin/orderLogList.do" includeParams='none'/>" target="subpage">取消订单日志</a>
                        </li>
                        <li>
                        	<a href="<s:url value="/admin/businessLogList.do?type=1" includeParams='none'/>" target="subpage">商家录入日志</a>
                        </li>
                        <li>
                        	<a href="<s:url value="/admin/businessLogList.do?type=2" includeParams='none'/>" target="subpage">商户审批日志</a>
                        </li>
                        <li>
                        	<a href="<s:url value="/admin/tuikuanLogList.do" includeParams='none'/>" target="subpage">退款日志</a>
                        </li>
                        <li>
                        	<a href="<s:url value="/admin/modifyOrderLogList.do" includeParams='none'/>" target="subpage">修改订单日志</a>
                        </li>                     
                    </ul>
                </li>
                </s:if>
            </ul>
            <!-- /main navigation -->
		</div>
    </div>
    <!-- /sidebar -->
    <!-- Page content -->
    <div class="page-content" style="position: fixed;right: 0px;left: 250px;bottom: 0px;top: 53px;">
        <iframe width="100%" height="100%" id="subpage" name="subpage" frameborder="0" src="<s:if test="systemUserInfo.type != 2"><s:url value="/admin/circleList.do" includeParams='none'/></s:if><s:if test="systemUserInfo.type == 2"><s:url value="/admin/reportPage.do" includeParams='none'/></s:if>"></iframe>
    </div>
    <!-- /page content -->
    <!-- /page container -->
</body>
<script language=javascript>
function adminLogout() {
	top.dialog_confirm("确认退出吗？", function(){window.location="<s:url value='/admin/logout.do' />"});
}

function setCenterPoint(centerPoint) {
	var address = $('#subpage').contents().find("#centerPoint").val();
	//if (trim(address) == '') {
		// 如果在添加页面没有输入中心点位置，则将地图上标注点的位置回写到中心点
		$('#subpage').contents().find("#centerPoint").val(centerPoint);
	//}
	
	var lng = art.dialog.data("lng");
	var lat = art.dialog.data("lat");
	if (lng >0 && lat > 0) {
		$('#subpage').contents().find("#longitude").val(lng);
		$('#subpage').contents().find("#latitude").val(lat);
	}
}

function showLoad(id,  title){
	var content = '<img src="<s:url value="/pages/admin/images/interface/2897814_144722712129_2.gif"/>"/>';
	top.dialog_coupon(id, content, title);
	$(".aui_close").hide();
}

function hideLoad(id){
	art.dialog({id:id}).close();
}


</script>		
</html>
