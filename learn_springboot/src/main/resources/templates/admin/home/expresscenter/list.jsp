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
        <h3>配送中心管理</h3>
    </div>
</div>
<div class="breadcrumb-line">
    <ul class="breadcrumb">
        <li><a class="active">配送中心管理</a></li>
    </ul>
</div>
<form class="form-inline tab-pane" role="form" id="listForm" name="listForm" action="<s:url value="/admin/centerList.do" includeParams='none'/>" method="post">
<div class="block search">

    <a href="<s:url value="/admin/centerAddPage.do" includeParams='none'/>" class="btn btn-default pull-right">
        <span class="fa fa-plus fa-lg"></span> 添加配送中心
    </a>
    
    <div class="form-group">
        <label class="">城市:</label>
        <select class="form-control" id="cityId" name="centerInfo.cityId">
            <s:iterator value="areaList">
        	<option value="<s:property value="id" />"><s:property value="areaName" /></option>
        	</s:iterator>
        </select>
    </div>
    <div class="form-group">
        <label class="">配送中心名称:</label>
        <input type="text" class="form-control" id="centerName" name="centerInfo.centerName" value="<s:property value="centerInfo.centerName"/>">
    </div>

    <button type="button" class="btn btn-success" onclick="search()">搜 索</button>
</div>

<div class="block">
    <div class="datatable-tasks">
        <table class="table table-bordered">
            <thead>
            <tr>
                <th class="sq-city">城市</th>
                <th class="sq-center">配送中心名称</th>
                <th class="sq-center">配送中心位置</th>
                <th class="sq-action">操作</th>
            </tr>
            </thead>
            <tbody>
            <s:if test="pagination.hasData == true">
            <s:iterator value="pagination.dataList" status="rowstatus">
            <tr>
                <td class="task-desc">
                	<s:property value="cityName"/>
                </td>
                <td class="task-desc">
                	<s:property value="centerName"/>
                </td>
                <td class="text-center">
                	<s:property value="centerPoint"/>
                </td>
                <td class="text-center">
                    <div class="btn-group">
                        <button type="button" class="btn btn-default" onclick="updateCenter(<s:property value="id"/>)">
                        	<i class="fa fa-pencil fa-lg"></i> 修改
                        </button>
                        <button type="button" class="btn btn-default" onclick="delCenter('<s:property value="id"/>', '<s:property value="cityId"/>')">
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
        <!-- 分页 [页数为1页时也显示] -->
		<s:if test="pagination.pageCount > 0">
		<div align="right">
			<s:include value="/pages/admin/common/pagination.jsp"></s:include>
		</div>
        </s:if>
    </div>
</div>
</form>
<form id="delForm" name="delForm" action="<s:url value="/admin/centerDelete.do" includeParams='none'/>" method="post">
	<input type="hidden" id="centerId" name="centerInfo.id"/>
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
			$("#centerId").val("");
			top.dialog_alert(message);
		}
	});
	function search() {
		var centerName = trim($("#centerName").val());
		//if(centerName == ""){
			//top.dialog_alert("请输入搜索条件！");
			//return false;
		//}
		$("#currentPage").val(1);
		$('#listForm').submit();
	}

	function updateCenter(centerId){
		window.location="<s:url value='/admin/centerUpdatePage.do' />?centerInfo.id=" + centerId;
	}
	
	function delCenter(centerId, cityId){
		//$("#centerId").val(centerId);
		//top.dialog_confirm("您确认删除该配送中心吗？", function(){$('#delForm').submit();});
		
		top.dialog_confirm("您确认删除该配送中心吗？", 
			function(){
			var param = {"id":centerId, "cityId":cityId};
			var act = "<s:url value='/admin/centerDelete.do' includeParams='none'/>";
		    $.ajax({
				type:"post",
				url:act,
				data:param,
				cache:false,
				success: function(msg) {
					if (msg == "success"){
						location.href='<s:url value="/admin/centerList.do" includeParams="none"/>';
		        	} else {
		        		top.dialog_alert(msg);
		        	}
		        }
			});
		});
	}
</script>
</html>