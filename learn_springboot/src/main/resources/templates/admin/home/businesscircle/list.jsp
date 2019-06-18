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
        <h3>商圈管理</h3>
    </div>
</div>
<div class="breadcrumb-line">
    <ul class="breadcrumb">
        <li><a class="active">商圈管理</a></li>
    </ul>
</div>
<form class="form-inline tab-pane" role="form" id="listForm" name="listForm" action="<s:url value="/admin/circleList.do" includeParams='none'/>" method="post">
<div class="block search">

    <a href="<s:url value="/admin/circleAddPage.do" includeParams='none'/>" class="btn btn-default pull-right">
        <span class="fa fa-plus fa-lg"></span> 添加商圈
    </a>

    
        <div class="form-group">
            <label class="">城市:</label>
            <select class="form-control" id="cityId" name="circleInfo.cityId">
                <s:iterator value="areaList">
            	<option value="<s:property value="id" />"><s:property value="areaName" /></option>
            	</s:iterator>
            </select>
        </div>
        <div class="form-group">
            <label class="">商圈名称:</label>
            <input type="text" class="form-control" id="circleName" name="circleInfo.circleName" value="<s:property value="circleInfo.circleName"/>">
        </div>

        <button type="button" class="btn btn-success" onclick="search()">搜 索</button>


</div>
<div class="block">

    <div class="datatable-tasks">


        <table class="table table-bordered">
            <thead>
            <tr>
                <th class="sq-city">城市</th>
                <th class="sq-circle">商圈名称</th>
                <th class="sq-center">中心点位置</th>
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
                	<s:property value="circleName"/>
                </td>
                <td class="text-center">
                	<s:property value="centerPoint"/>
                </td>
                <td class="text-center">
                    <div class="btn-group">
                        <button type="button" class="btn btn-default" onclick="updateCircle(<s:property value="id"/>)">
                        	<i class="fa fa-pencil fa-lg"></i> 修改
                        </button>
                        <button type="button" class="btn btn-default" onclick="delCircle(<s:property value="id"/>, <s:property value="cityId"/>)">
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
<form id="delForm" name="delForm" action="<s:url value="/admin/circleDelete.do" includeParams='none'/>" method="post">
	<input type="hidden" id="circleIdDel" name="circleInfo.id"/>
	<input type="hidden" id="cityIdDel" name="circleInfo.cityId"/>
	<input type="hidden" id="count" name="count" value="<s:property value="count" />"/>
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
			$("#circleId").val("");
			top.dialog_alert(message);
		}
	});
	function search() {
		var circleName = trim($("#circleName").val());
// 		if(circleName == ""){
// 			top.dialog_alert("已显示全部商家！");
// 			return false;
// 		}
		$("#currentPage").val(1);
		$('#listForm').submit();
	}

	function updateCircle(circleId){
		window.location="<s:url value='/admin/circleUpdatePage.do' />?circleInfo.id=" + circleId;
	}
	
	function delCircle(circleId, cityId){
		$("#circleIdDel").val(circleId);
		$("#cityIdDel").val(cityId);
		
		top.dialog_confirm("您确认删除商圈吗？", function(){$('#delForm').submit();});
	}
</script>

</html>
