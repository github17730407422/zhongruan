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
        <h3>广告管理</h3>
    </div>
</div>
<div class="breadcrumb-line">
    <ul class="breadcrumb">
        <li><a class="active">广告管理</a></li>
    </ul>
</div>
<form class="form-inline tab-pane" role="form" id="listForm" name="listForm" action="<s:url value="/admin/adList.do" includeParams='none'/>" method="post">
<div class="block search">
	<a href="#" class="btn btn-default pull-right" onclick="addAdPage()">
        <span class="fa fa-plus fa-lg"></span> 添加广告<s:property value='adCount'/>
    </a>
</div>

<div class="block">
    <div class="datatable-tasks">
        <table class="table table-bordered">
            <thead>
            <tr>
                <th class="sq-city">序号</th>
                <th class="sq-center">广告名称</th>
                <th class="sq-action">操作</th>
            </tr>
            </thead>
            <tbody>
            <s:if test="pagination.hasData == true">
            <s:iterator value="pagination.dataList" status="rowstatus">
            <tr>
                <td class="task-desc">
                	<!--<s:property value="id"/>-->
                    <select class="form-control" id="adSort_<s:property value="id"/>" name="adSort_<s:property value="id"/>" onchange='javascript:changeSort(<s:property value="id"/>, <s:property value="sort"/>);'>
                        <s:iterator value="adSortList" var="v">
                            <option value="<s:property value="#v"/>" <s:if test="sort==#v">selected="selected"</s:if>><s:property value="#v" /></option>
                        </s:iterator>
                    </select>
                </td>
                <td class="task-desc">
                    <s:property value="adName"/>
                </td>
                <td class="text-ad">
                    <div class="btn-group">
                        <button type="button" class="btn btn-default" onclick="updateAd(<s:property value="id"/>)">
                        	<i class="fa fa-pencil fa-lg"></i> 修改
                        </button>
                        <button type="button" class="btn btn-default" onclick="delAd(<s:property value="id"/>)">
                        	<i class="fa fa-trash-o fa-lg"></i> 删除
                        </button>
                    </div>
                </td>
            </tr>
            </s:iterator>
            </s:if>
            <s:else>
				<tr>
					<td colspan="5" align="center">没有搜索到符合条件的记录，请重新搜索！</td>
				</tr>
			</s:else>
            </tbody>
        </table>
    </div>
</div>
</form>
<form id="delForm" name="delForm" action="<s:url value="/admin/adDelete.do" includeParams='none'/>" method="post">
	<input type="hidden" id="adId" name="adInfo.id"/>
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
			$("#adId").val("");
			top.dialog_alert(message);
		}
	});
	
	function search() {
		var centerName = trim($("#centerName").val());
		var adName = trim($("#adName").val());
		var mobilePhone = trim($("#mobilePhone").val());
		
		if (checkObjIsNull($("#centerName")) && !checkObjLength($("#centerName"), 40)) {
			top.dialog_alert("查询配送中心名称长度为1~20个字。");
			return false;
		}
		if (checkObjIsNull($("#adName")) && !checkObjLength($("#adName"), 10)) {
			top.dialog_alert("查询广告姓名长度为1~5个字。");
			return false;
		}
		
		var reg = /^1\d{0,10}$/;
		//alert("checkObjIsNull: " + checkObjIsNull($("#mobilePhone")));
		//alert("checkObjLength: " + checkObjLength($("#mobilePhone"), 11));
		//alert("reg.test: " + reg.test(mobilePhone));
		if (checkObjIsNull($("#mobilePhone")) && (!checkObjLength($("#mobilePhone"), 11) || !reg.test(mobilePhone))) {
			top.dialog_alert("查询广告电话，格式为1开头的数字，长度不能超过11。");
			return false;
		}

		$('#listForm').submit();
	}

	function updateAd(adId){
		window.location="<s:url value='/admin/adUpdatePage.do' />?adInfo.id=" + adId;
	}
	
	function delAd(adId){
		top.dialog_confirm("您确认删除该广告吗？", 
			function(){
			var param = {"id":adId};
			var act = "<s:url value='/admin/adDelete.do' includeParams='none'/>";
		    $.ajax({
				type:"post",
				url:act,
				data:param,
				cache:false,
				success: function(msg) {
					if (msg == "success"){
						location.href='<s:url value="/admin/adList.do" includeParams="none"/>';
		        	} else {
		        		top.dialog_alert(msg);
		        	}
		        }
			});
		});
	}
	
	function changeSort(adId, oldSort) {
		var newSort = document.getElementById("adSort_" + adId).options[document.getElementById("adSort_" + adId).selectedIndex].value;
		
		top.dialog_confirm("您确认调整该广告的排序吗？", 
			function(){
			var param = {"id":adId, "oldSort":oldSort, "newSort":newSort};
			var act = "<s:url value='/admin/adSortUpdate.do' includeParams='none'/>";
		    $.ajax({
				type:"post",
				url:act,
				data:param,
				cache:false,
				success: function(msg) {
					if (msg == "success"){
						location.href='<s:url value="/admin/adList.do" includeParams="none"/>';
		        	} else {
		        		top.dialog_alert(msg);
		        	}
		        }
			});
		});
	}
	
	function addAdPage() {
		
		if (<s:property value="pagination.dataList.size"/> == 8) {
			top.dialog_alert("广告信息最多为8条。");
			return false;
		}
		
		location.href='<s:url value="/admin/adAddPage.do" includeParams="none"/>';
	}
</script>
</html>