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
        <h3>配送人员管理</h3>
    </div>
</div>
<div class="breadcrumb-line">
    <ul class="breadcrumb">
        <li><a class="active">配送人员管理</a></li>
    </ul>
</div>
<form class="form-inline tab-pane" role="form" id="listForm" name="listForm" action="<s:url value="/admin/memberList.do" includeParams='none'/>" method="post">
<div class="block search">

    <a href="<s:url value="/admin/memberAddPage.do" includeParams='none'/>" class="btn btn-default pull-right">
        <span class="fa fa-plus fa-lg"></span> 添加配送人员
    </a>
    
    <div class="form-group">
        <label class="">城市:</label>
        <select class="form-control" id="cityId" name="memberInfo.cityId">
            <s:iterator value="areaList">
        	<option value="<s:property value="id" />"><s:property value="areaName" /></option>
        	</s:iterator>
        </select>
    </div>
    <div class="form-group">
        <label class="">配送中心名称:</label>
        <input type="text" class="form-control" id="centerName" name="memberInfo.centerName" value="<s:property value="memberInfo.centerName"/>">
    </div>
    <div class="form-group">
        <label class="">姓名:</label>
        <input type="text" class="form-control" id="memberName" name="memberInfo.memberName" value="<s:property value="memberInfo.memberName"/>">
    </div>
    <div class="form-group">
        <label class="">电话:</label>
        <input type="text" class="form-control" id="mobilePhone" name="memberInfo.mobilePhone" value="<s:property value="memberInfo.mobilePhone"/>">
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
                <th class="sq-center">姓名</th>
                <th class="sq-center">电话</th>
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
                <td class="task-desc">
                	<s:property value="memberName"/>
                </td>
                <td class="text-member">
                	<s:property value="mobilePhone"/>
                </td>
                <td class="text-member">
                    <div class="btn-group">
                        <button type="button" class="btn btn-default" onclick="updateMember(<s:property value="id"/>)">
                        	<i class="fa fa-pencil fa-lg"></i> 修改
                        </button>
                        <button type="button" class="btn btn-default" onclick="delMember(<s:property value="id"/>)">
                        	<i class="fa fa-trash-o fa-lg"></i> 删除
                        </button>
                        <button type="button" class="btn btn-default" onclick="resetPwd(<s:property value="id"/>)">
                            <i class="fa fa-gear fa-lg"></i> 重置密码
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
        <!-- 分页 [页数为1页时也显示] -->
		<s:if test="pagination.pageCount > 0">
		<div align="right">
			<s:include value="/pages/admin/common/pagination.jsp"></s:include>
		</div>
        </s:if>
    </div>
</div>
</form>
<form id="delForm" name="delForm" action="<s:url value="/admin/memberDelete.do" includeParams='none'/>" method="post">
	<input type="hidden" id="memberId" name="memberInfo.id"/>
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
			$("#memberId").val("");
			top.dialog_alert(message);
		}
	});
	
	function search() {
		var centerName = trim($("#centerName").val());
		var memberName = trim($("#memberName").val());
		var mobilePhone = trim($("#mobilePhone").val());
		
		if (checkObjIsNull($("#centerName")) && !checkObjLength($("#centerName"), 40)) {
			top.dialog_alert("查询配送中心名称长度为1~20个字。");
			return false;
		}
		if (checkObjIsNull($("#memberName")) && !checkObjLength($("#memberName"), 10)) {
			top.dialog_alert("查询配送人员姓名长度为1~5个字。");
			return false;
		}
		
		var reg = /^1\d{0,10}$/;
		//alert("checkObjIsNull: " + checkObjIsNull($("#mobilePhone")));
		//alert("checkObjLength: " + checkObjLength($("#mobilePhone"), 11));
		//alert("reg.test: " + reg.test(mobilePhone));
		if (checkObjIsNull($("#mobilePhone")) && (!checkObjLength($("#mobilePhone"), 11) || !reg.test(mobilePhone))) {
			top.dialog_alert("查询配送人员电话，格式为1开头的数字，长度不能超过11。");
			return false;
		}
		$("#currentPage").val(1);
		$('#listForm').submit();
	}

	function updateMember(memberId){
		window.location="<s:url value='/admin/memberUpdatePage.do' />?memberInfo.id=" + memberId;
	}
	
	function delMember(memberId){
		top.dialog_confirm("您确认删除该配送人员吗？", 
			function(){
			var param = {"id":memberId};
			var act = "<s:url value='/admin/memberDelete.do' includeParams='none'/>";
		    $.ajax({
				type:"post",
				url:act,
				data:param,
				cache:false,
				success: function(msg) {
					if (msg == "success"){
						location.href='<s:url value="/admin/memberList.do" includeParams="none"/>';
		        	} else {
		        		top.dialog_alert(msg);
		        	}
		        }
			});
		});
	}
	
	function resetPwd(memberId){
		top.dialog_confirm("您确认要重置此配送人员的密码吗？", 
				function(){
				var param = {"id":memberId};
				var act = "<s:url value='/admin/memberUpdatePwd.do' includeParams='none'/>";
			    $.ajax({
					type:"post",
					url:act,
					data:param,
					cache:false,
					success: function(msg) {
						if (msg == "success"){
							location.href='<s:url value="/admin/memberList.do" includeParams="none"/>';
			        	} else {
			        		top.dialog_alert(msg);
			        	}
			        }
				});
			});
	}
</script>
</html>