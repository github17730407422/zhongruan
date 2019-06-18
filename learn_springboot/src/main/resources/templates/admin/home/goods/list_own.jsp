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
        <h3>自营商品管理

        </h3>
    </div>

</div>
<div class="breadcrumb-line">
    <ul class="breadcrumb">
        <li><a class="active">自营商品管理</a></li>
    </ul>

</div>

<div class="block search">
<form class="form-inline tab-pane" role="form" id="listForm" name="listForm" action="<s:url value="/admin/goodsOwnList.do" includeParams='none'/>" method="post">
    <a href="<s:url value="/admin/goodsOwnAddPage.do" includeParams='none'/>" class="btn btn-default pull-right">
        <span class="fa fa-plus fa-lg"></span> 添加商品
    </a>

        <div class="form-group">
            <label class="">城市:</label>
            <select class="form-control" id="cityId" name="goodsInfo.cityId">
                <s:iterator value="areaList">
            	<option value="<s:property value="id" />"><s:property value="areaName" /></option>
            	</s:iterator>
            </select>
        </div>
        <div class="form-group">
            <label class="">商品名称:</label>
            <input type="text" class="form-control" id="goodsName" name="goodsInfo.goodsName" value="<s:property value="goodsInfo.goodsName"/>">
        </div>
        <div class="form-group">
            <label class="">状态:</label>
           <select class="form-control" id="status" name="goodsInfo.status">
               <option value="">全部</option>
               <option value="0" <s:if test="goodsInfo.status == 0">selected="selected"</s:if>>已上架</option>
               <option value="1" <s:if test="goodsInfo.status == 1">selected="selected"</s:if>>已下架</option>
               <option value="2" <s:if test="goodsInfo.status == 2">selected="selected"</s:if>>未上架</option>
           </select>
        </div>

        <button type="button" class="btn btn-success" onclick="search()">搜 索</button>

</div>
<div class="block">

    <div class="datatable-tasks">


        <table class="table table-bordered">
            <thead>
            <tr>
                <th class="sq-city">城市</th>
                <th class="sq-center">自营商品名称</th>
                <th class="">分类</th>
                <th class="">价格</th>
                <th class="">状态</th>
                <th class="">操作</th>
            </tr>
            </thead>
            <tbody>
            <s:if test="pagination.hasData == true">
            <s:iterator value="pagination.dataList" status="rowstatus">
            <tr>
                <td class="task-desc">
                    <s:property value="cityName"/>
                </td>
                <td class="text-center">
                	<s:property value="goodsName"/>
                </td>
                <td class="text-center">
                	<s:if test="isDelete == 0">
                	<s:property value="categoryName"/>
                	</s:if>
                </td>
                <td class="text-center">
                	<s:if test="preferentialPrice > 0">
                		￥<s:property value="%{formatDouble(preferentialPrice)}"/>
                	</s:if>
                	<s:else>
                		￥<s:property value="%{formatDouble(oldPrice)}"/>
                	</s:else>
                </td>
                <td class="text-center" id="status_<s:property value="id"/>">
                	<s:if test="status == 2">
                		未上架
                	</s:if>
                	<s:elseif test="status == 0">
                		已上架
                	</s:elseif>
                	<s:else>
                		已下架
                	</s:else>
                </td>
                <td class="text-center">
                    <div class="btn-group">
                    	<s:if test="status == 1 || status == 2">
                        	<button type="button" class="btn btn-default" id="shang_<s:property value="id"/>" onclick="changeStatus(<s:property value="id"/>, 0, <s:property value="isDelete"/>)">
                        </s:if>
                        <s:else>
                        	<button type="button" class="btn btn-default" id="shang_<s:property value="id"/>" onclick="changeStatus(<s:property value="id"/>, 0, <s:property value="isDelete"/>)" style="display: none;">
                        </s:else>
                        <i class="fa  fa-arrow-up "></i>上架
                        </button>
                        <s:if test="status == 1 || status == 2">
                        	<button type="button" class="btn btn-default" id="xia_<s:property value="id"/>" onclick="changeStatus(<s:property value="id"/>, 1, <s:property value="isDelete"/>)" style="display: none;">
                        </s:if>
                        <s:else>
                        	<button type="button" class="btn btn-default" id="xia_<s:property value="id"/>" onclick="changeStatus(<s:property value="id"/>, 1, <s:property value="isDelete"/>)">
                        </s:else>
                        <i class="fa  fa-arrow-down"></i> 下架
                        </button>
                        <button type="button" class="btn btn-default" onclick="updateGoods(<s:property value="id"/>)">
                            <i class="fa fa-pencil fa-lg"></i> 编辑
                        </button>
                        <button type="button" class="btn btn-default" onclick="delGoods(<s:property value="id"/>)">
                            <i class="fa fa-trash-o fa-lg"></i> 删除
                        </button>
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
<form id="delForm" name="delForm" action="<s:url value="/admin/goodsOwnDelete.do" includeParams='none'/>" method="post">
	<input type="hidden" id="goodsId" name="goodsInfo.id"/>
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
	function search() {
		var goodsName = trim($("#goodsName").val());
		$("#goodsName").val(goodsName);
		$("#currentPage").val(1);
		$('#listForm').submit();
	}

	function changeStatus(id, status, isDelete){
		if (status == 0 && isDelete == 1) {
			top.dialog_alert("该商品所属分类已经删除，请先编辑该商品，重新选择商品分类！");
			return false;
		}

		
		var info = "您确认上架该商家商品吗？";
		if (status == 1) {
			info = "您确认下架该商家商品吗？";
		}
		top.dialog_confirm(info, function(){
			var param = {"goodsInfo.id":id, "goodsInfo.status":status};
			var url = "<s:url value='/admin/goodsOwnStatusChange.do' includeParams='none'/>";
		    $.ajax({
				type:"post",
				url:url,
				data:param,
				cache:false,
				success: function(msg) {
		    		if(msg == "success"){
			    		var html;
			    		if (status == 0) {
			    			html = "已上架";
	
			    			$("#shang_" + id).hide();
			    			$("#xia_" + id).show();
			    		} else {
			    			html = "已下架";
	
			    			$("#shang_" + id).show();
			    			$("#xia_" + id).hide();
			    		}
			    		$("#status_" + id).html(html);
		    		} else {
		    			top.dialog_alert("操作失败，请稍后再试！");
		    		}
		    	
		        }
			});
		});
	}
	
	function updateGoods(goodsId){
		window.location="<s:url value='/admin/goodsOwnUpdatePage.do' />?goodsInfo.id=" + goodsId;
	}
	
	function delGoods(goodsId){
		top.dialog_confirm("您确认删除商品吗？", function(){
			var param = {"goodsInfo.id":goodsId};
			var url = "<s:url value='/admin/checkOwnGoodsOrder.do' />";
		    $.ajax({
				type:"post",
				url:url,
				data:param,
				cache:false,
				success: function(msg) {
		    		if(msg == "exist"){
		    			top.dialog_alert("请先完成或取消与该商品关联的订单后，再删除该商品！");
		    		} else {
			    		$("#goodsId").val(goodsId);
		    			$("#delForm").submit();
		    		}
		        }
			});
		});
	}
</script>

</html>
