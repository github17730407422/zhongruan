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
        <h3>手机客户端分类导航管理</h3>
    </div>
</div>
<div class="breadcrumb-line">
    <ul class="breadcrumb">
        <li><a class="active">手机客户端分类导航管理</a></li>
    </ul>
</div>
<form class="form-inline tab-pane" role="form" id="listForm" name="listForm" action="<s:url value="/admin/circleList.do" includeParams='none'/>" method="post">
<div class="block search">

    <a href="javascript:void(0);" class="btn btn-default pull-right" onclick="addNav()">
        <span class="fa fa-plus fa-lg"></span> 添加
    </a>
</div>
<div class="block">

    <div class="datatable-tasks">


        <table class="table table-bordered">
            <thead>
            <tr>
                <th class="sq-city">序号</th>
                <th class="sq-city">图片</th>
                <th class="sq-circle">商品分类名称</th>
                <th class="sq-action">操作</th>
            </tr>
            </thead>
            <tbody>
            <s:if test="navList.size != 0">
            <s:iterator value="navList" status="index">
            <tr>
                <td class="task-desc">
                	<s:property value="#index.count"/>
                </td>
                <td class="task-desc">
                	<img src="<s:url value="/"/><s:property value='iconUrl'/>" width="40px;">
                </td>
                <td class="text-center">
                	<s:property value="categoryName"/>
                </td>
                <td class="text-center">
                    <div class="btn-group">
                        <button type="button" class="btn btn-default" onclick="delNav(<s:property value="id"/>)">
                        	<i class="fa fa-trash-o fa-lg"></i> 删除
                        </button>
                    </div>
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
<form id="delForm" name="delForm" action="<s:url value="/admin/navDel.do" includeParams='none'/>" method="post">
	<input type="hidden" id="categoryId" name="navInfo.id"/>
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

	function addNav(){
		var navCount = <s:property value='navCount'/>;
		if (navCount >= 8) {
			top.dialog_alert("分类导航只能添加8条记录，请删除后再进行添加！");
		} else {
			window.location="<s:url value='/admin/navAddPage.do' />";
		}
	}
	
	function delNav(categoryId){
		$("#categoryId").val(categoryId);

		top.dialog_confirm("您确认删除手机客户端分类导航吗？", function(){$('#delForm').submit();});
	}
</script>

</html>
