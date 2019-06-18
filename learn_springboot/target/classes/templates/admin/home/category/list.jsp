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
        <h3>商品类别管理</h3>
    </div>

</div>
<div class="breadcrumb-line">
    <ul class="breadcrumb">
        <li><a class="active">类别管理</a></li>
    </ul>
</div>


    <div class="row " style="margin-bottom: 20px">
    <div class=" col-md-4 col-md-offset-8">
        <div class="input-group" align="right">
          <span class="input-group-btn">
            <button class="btn btn-default" type="button" onclick="addCategoryPage()">
                <i class="fa fa-plus fa-lg"></i> 添加类别
            </button>
          </span>
        </div>
    </div>
    </div>

<div class="block">
    <div class="datatable-tasks">
        <table class="table table-bordered">
            <thead>
            <tr>
                <th width="">类别名称</th>
                <th width="30%">操作</th>
            </tr>
            </thead>
            <tbody>
            
            <s:iterator value="categoryList" status="index">
	            <tr>
	            <!-- teng -->
	            	<td class="task-desc">
	            		
	            	    <s:property value="#index.Count"/>.
	            	    <span title="<s:property value="description" />">
	            		<s:property value="categoryName" />
	            		</span>
	            	
	            	</td>
	            	<td class="">
	                    <div class="btn-group">
	                        <button type="button" class="btn btn-default" onclick="updateCategory(<s:property value="id" />)">
	                        	<i class="fa fa-pencil fa-lg"></i> 修改
	                        </button>
	                        <button type="button" class="btn btn-default" onclick="deleteCategory(<s:property value="id" />, <s:property value="parentId" />, '<s:property value="code" />')">
	                        	<i class="fa fa-trash-o fa-lg"></i> 删除
	                        </button>
	                        <button type="button" class="btn btn-default" onclick="addSonCategoryPage(<s:property value="id" />)">
	                        	<i class="fa fa-plus-circle fa-lg"></i> 添加子类
	                        </button>
	                    </div>
	                </td>
	            </tr>
	            <s:iterator value="list" status="index2">
	            <tr>
	            	<td class="task-desc">
	            		&nbsp;&nbsp; &nbsp;&nbsp;
	            	    <s:property value="#index2.count"/>).
	            	    <span title="<s:property value="description" />">
	            		<s:property value="categoryName" />
	            		</span>
	            	</td>
	            	<td class="">
	                    <div class="btn-group">
	                        <button type="button" class="btn btn-default" onclick="updateCategory(<s:property value="id" />)">
	                        	<i class="fa fa-pencil fa-lg"></i> 修改
	                        </button>
	                        <button type="button" class="btn btn-default" onclick="deleteCategory(<s:property value="id" />, <s:property value="parentId" />, '<s:property value="code" />')">
	                        	<i class="fa fa-trash-o fa-lg"></i> 删除
	                        </button>
	                    </div>
	                </td>
	            </tr>
	            </s:iterator>
            </s:iterator>
            </tbody>
        </table>

    </div>
</div>
<form id="categoryForm" name="categoryForm" action="" method="post">
	<input type="hidden" id="parentId" name="categoryInfo.parentId" />
	<input type="hidden" id="categoryId" name="categoryInfo.id" />
	<input type="hidden" id="code" name="categoryInfo.code" />
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

	function addCategoryPage() {
		window.location="<s:url value='/admin/categoryAddPage.do' />";
	}

	function updateCategory(categoryId) {
		$("#categoryId").val(categoryId);
		$('#categoryForm').attr("action","<s:url value='/admin/categoryUpdatePage.do' />");
		$('#categoryForm').submit();
	}

	function addSonCategoryPage(parentId){
		$("#parentId").val(parentId);

		$('#categoryForm').attr("action","<s:url value='/admin/categoryAddPage.do' />");
		$('#categoryForm').submit();
	}
	
	function deleteCategory(categoryId, parentId, code){
		$("#categoryId").val(categoryId);
		$("#parentId").val(parentId);
		$("#code").val(code);

		$('#categoryForm').attr("action","<s:url value='/admin/categoryDelete.do' />");

		top.dialog_confirm("您确认删除商品分类吗？", function(){$('#categoryForm').submit();});
	}
	//teng
	$(function(){
		var act = "<s:url value='/miniCartPage.do' includeParams='none'/>";
	    $.ajax({
			type:"post",
			url:act,
			cache:false,
			success: function(data) {
				$("#accordion").html(data);
				var box = $('.container_main');
			    var h = box.height(), h2 = $('.mcart').height()+200;
			    var newHeight = Math.max(h,h2);
			    box.css('min-height',newHeight);
	        }
		});
	});
	
	
</script>

</html>
