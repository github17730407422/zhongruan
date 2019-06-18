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
        <h3>商家管理</h3>
    </div>

</div>
<div class="breadcrumb-line">
    <ul class="breadcrumb">
        <li><a class="active">商家管理</a></li>
    </ul>

</div>
<form class="form-inline tab-pane" role="form" id="listForm" name="listForm" action="<s:url value="/admin/businessList.do" includeParams='none'/>" method="post">    

<div class="block search">

    <a href="<s:url value="/admin/businessAddPage.do" includeParams='none'/>" class="btn btn-default pull-right">
        <span class="fa fa-plus fa-lg"></span> 添加商家
    </a>

        <div style="margin-bottom: 5px">
        <div class="form-group">
            <label class="">城&nbsp;&nbsp;&nbsp;&nbsp;市:</label>
            <input type="text" readonly value="芜湖" class="form-control"/>
        </div>
        <div class="form-group">
            <label class="">商家名称:</label>
            <input type="text" class="form-control" id="businessName" name="businessInfo.name" value="<s:property value="businessInfo.name"/>"/>
        </div>
        <div class="form-group">
            <label class="">商圈名称:</label>
            <select class="form-control"  id="circle_id" name="businessInfo.circle_id">
            	<option value=0>请选择</option>
                <s:iterator value="circleInfoList" >
            	<option value="<s:property value='id' />" <s:if test="id == businessInfo.circle_id">selected="selected"</s:if>><s:property value="circleName" /></option>
            	</s:iterator>
            </select>
        </div>
        <div class="form-group">
            <label class="">配送中心名称:</label>
            <select class="form-control" id="center_id" name="businessInfo.center_id">
            <option value=0>请选择</option>
                <s:iterator value="centerInfoList">
            	<option value="<s:property value="id" />" <s:if test="id == businessInfo.center_id">selected="selected"</s:if>><s:property value="centerName" /></option>
            	</s:iterator>
            </select>
        </div>
            <button type="button" onclick="search()" class="btn btn-success">搜 索</button>
        </div>
        <div>
        <div class="form-group">
            <label class="">商家地址:</label>
            <input type="text" class="form-control" id="address" name="businessInfo.address" value="<s:property value="businessInfo.address"/>"/>
        </div>
        <div class="form-group">
            <label class="">联系电话:</label>
            <input type="text" class="form-control" id="telphone" name="businessInfo.telphone" value="<s:property value="businessInfo.telphone"/>"/>
        </div>
        <div class="form-group">
            <label class="">法人代表姓名:</label>
            <input type="text" class="form-control" id="legal_person_name" name="businessInfo.legal_person_name" value="<s:property value="businessInfo.legal_person_name"/>"/>
        </div>
        <div class="form-group">
            <label class="">商家状态:</label>
          <select class="form-control" name="businessInfo.status">
          	  <option value=-1> 请选择</option>
              <option value=0 <s:if test="0 == businessInfo.status">selected="selected"</s:if>> 未审核</option>
              <option value=1 <s:if test="1 == businessInfo.status">selected="selected"</s:if>> 已审核</option>
              <option value=2 <s:if test="2 == businessInfo.status">selected="selected"</s:if>> 已冻结</option>
          </select>
        </div>
        </div>
</div>
<div class="block">
    <div class="datatable-tasks">
        <table class="table table-bordered">
            <thead>
            <tr>
                <th class="">商家名称</th>
                <th class="">商圈</th>
                <th class="">配送中心</th>
                <th class="">联系电话</th>
                <th class="">商家状态</th>
                <th class="">操作</th>
            </tr>
            </thead>
            <tbody>
           		<s:if test="pagination.hasData == true">
            <s:iterator value="pagination.dataList" status="rowstatus">
            <tr>
                <td class="task-desc">
                    <a href="#" onclick="editBusiness(<s:property value="id"/>)"><s:property value="name"/></a>
                </td>
                <td class="task-desc">
                	<s:property value="circle_name"/>
                </td>
                <td class="text-center">
                	<s:property value="center_name"/>
                </td>
                <td class="task-desc">
                	<s:property value="telphone"/>
                </td>
                <td class="text-center">
                <s:if test="status==0">
                	未审核
                </s:if>
                <s:elseif test="status==1">
                	已审核
                </s:elseif>
                <s:else>
                   	已冻结
                </s:else>
                </td>
                <td class="text-center">
                    <div class="btn-group">
                        <button type="button" class="btn btn-default" 
                        onclick="auditBusiness(<s:property value="id"/>, <s:property value="status"/>, <s:if test="points!=null"><s:property value="points"/></s:if><s:else>0.00</s:else>)">
                        		<s:if test="status == 0">
                        		<i class="fa  fa-check-square-o fa-lg"></i> 审核
                        		</s:if>
                        		<s:elseif test="status == 1">
                				<i class="fa  fa-check-square-o fa-lg"></i> 冻结
                				</s:elseif>
                				<s:else>
                   				<i class="fa  fa-check-square-o fa-lg"></i> 解冻	
               					</s:else>
                        </button>
                        <button type="button" class="btn btn-default" onclick="activeBusiness(<s:property value="id"/>)">
                        		<i class="fa fa-pencil fa-lg"></i> 活动
                        </button>
                        <button type="button" class="btn btn-default" onclick="delBusiness(<s:property value="id"/>)">
                        	<i class="fa fa-trash-o fa-lg"></i> 删除
                        </button>
                        <s:if test="status==1">
                        <button type="button" class="btn btn-default" onclick="passwordBusiness(<s:property value="id"/>)">
                        		<i class="fa fa-pencil fa-lg"></i>重置密码
                        </button>
                        </s:if>	
                    </div>
                </td>
            </tr>
            </s:iterator>
            </s:if>
           		<s:else>
				<tr>
					<td colspan="6" align="center">没有搜索到符合条件的记录，请重新搜索！</td>
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
<form id="delForm" name="delForm" action="<s:url value="/admin/businessDelete.do" includeParams='none'/>" method="post">
	<input type="hidden" id="businessId_del" name="businessInfo.id"/>
</form>
<form id="editForm" name="editForm" action="<s:url value="/admin/businessEdit.do" includeParams='none'/>" method="post">
	<input type="hidden" id="businessId_edit" name="businessInfo.id"/>
</form>
<form id="auditForm" name="auditForm" action="<s:url value="/admin/businessAudit.do" includeParams='none'/>" method="post">
	<input type="hidden" id="businessId_audit" name="businessInfo.id"/>
	<input type="hidden" id="businessStatus" name="businessInfo.status"/>
</form>
<form id="activeForm" name="activeForm" action="<s:url value="/admin/getBusinessActive.do" includeParams='none'/>" method="post">
	<input type="hidden" id="businessId_active" name="businessInfo.id"/>
</form>
<form id="passwordForm" name="passwordForm" action="<s:url value="/admin/passwordBusiness.do" includeParams='none'/>" method="post">
	<input type="hidden" id="businessId_password" name="businessInfo.id"/>
</form>
<!-- /page tabs --> 

<!-- Footer -->
<s:include value="/pages/admin/common/footer.jsp"></s:include>
<!-- /Footer -->
<script>
function search() {
	$("#currentPage").val(1);
	$('#listForm').submit();
}
function passwordBusiness(businessId){
	top.dialog_confirm("您确认要重置密码吗？", function(){
		var param = {"businessInfo.id":businessId};
		var act = "<s:url value='/admin/passwordBusiness.do' includeParams='none'/>";
		$.ajax({
			type:"post",
			url:act,
			data:param,
			cache:false,
			success: function(msg) {
				if(msg == "yes")
    			top.dialog_alert("密码更新成功,已发送到客户手机中。");
    			else
    			top.dialog_alert("密码更新失败,请联系管理员。");
    		}
		});
	});
}

function activeBusiness(businessId){
	$("#businessId_active").val(businessId);
	$('#activeForm').submit();
}
	
function delBusiness(businessId){
	$("#businessId_del").val(businessId);

	top.dialog_confirm("您确认删除该商家吗？", function(){
	var param = {"businessInfo.id":businessId};
		var act = "<s:url value='/admin/businessDelete.do' includeParams='none'/>";
		$.ajax({
			type:"post",
			url:act,
			data:param,
			cache:false,
			success: function(msg) {
				if(msg == "yes") {
    				top.dialog_alert("商家删除成功。",function(){resetBusiness();});
    			}
    			else {
    				top.dialog_alert("商家下存在商品，不允许删除此商家");
    			}
    		}
		});
	});
}

function editBusiness(businessId){
	$("#businessId_edit").val(businessId);
	$('#editForm').submit();
}
	
function auditBusiness(businessId, oldStatus, points) {
	$("#businessId_audit").val(businessId);
	
	 var newStatus;
	 if (oldStatus == 0)
		 newStatus = 1;
	 else if (oldStatus == 1)
		 newStatus = 2;
	 else if (oldStatus == 2)
		 newStatus = 1;
	
	if (newStatus == 1) {
		if (points == '' || points == 0) {
			top.dialog_alert("此商家必须输入提成点！");
			return false;
		}
	}
	
	var param = {"businessInfo.status":newStatus,"businessInfo.id":businessId};
	var act = "<s:url value='/admin/businessAudit.do' includeParams='none'/>";
	if  (oldStatus == 0) {
		act = "<s:url value='/admin/businessAudit.do?isAudit=1' includeParams='none'/>";
	}
	$.ajax({
		type:"post",
		url:act,
		data:param,
		cache:false,
		success: function(msg) {
			var message;
			
			if (oldStatus == 0)
				message = "商家审核通过，用户名与密码已发送到客户手机中。";
			else if (oldStatus == 1)
				message = "商家冻结成功。";
			else if (oldStatus == 2)
				message = "商家解冻成功。";
			
			top.dialog_alert(message, function(){resetBusiness();});
		}
	});
}

function resetBusiness() {
	location.href='<s:url value="/admin/businessList.do" includeParams="none"/>';
}
</script>
</body>
</html>