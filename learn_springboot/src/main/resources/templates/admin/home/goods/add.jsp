<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/pages/admin/common/admin_meta.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>易食客后台管理系统</title>
    <link rel="stylesheet" href="<%=basePath%>js/kindeditor/themes/default/default.css" />
	<link rel="stylesheet" href="<%=basePath%>js/kindeditor/plugins/code/prettify.css" />
	<script charset="utf-8" src="<%=basePath%>js/kindeditor/kindeditor.js"></script>
	<script charset="utf-8" src="<%=basePath%>js/kindeditor/lang/zh_CN.js"></script>
	<script charset="utf-8" src="<%=basePath%>js/kindeditor/plugins/code/prettify.js"></script>
	<script>
		KindEditor.ready(function(K) {

		    var address = document.getElementById("address").value;
		   // alert(address);
			var editor1 = K.create('textarea[name="goodsInfo.description"]', {
				cssPath : address+'js/kindeditor/plugins/code/prettify.css',
				uploadJson : address+'js/kindeditor/jsp/upload_json.jsp',
				fileManagerJson : address+'js/kindeditor/jsp/file_manager_json.jsp',
				allowFileManager : true,
				afterBlur: function(){this.sync();}
			});
			prettyPrint();
		});
	</script>
</head>
<body class="sub-page">
<div class="page-header">
    <div class="page-title">
        <h3>添加商家商品
        </h3>
    </div>
</div>
<div class="breadcrumb-line">
    <ul class="breadcrumb">
        <li><a href="<s:url value="/admin/goodsList.do" includeParams='none'/>">商家商品管理</a></li>
        <li class="active">添加商家商品</li>
    </ul>
</div>
<div class="block s-form">
    <form class="form-horizontal" id="goodsForm" name="goodsForm" action="<s:url value="/admin/goodsAdd.do" includeParams='none'/>" role="form" method="post" enctype="multipart/form-data">
        <div class="panel panel-default ">

            <div class="panel-body">
            	<div class="form-group"><label class="col-sm-2 control-label text-right">城市:<font style="color: red;">*</font></label>
                    <div class="col-sm-10">
                    <select class="form-control" id="cityId" name="goodsInfo.cityId" onchange="getBusinessSimpList()">
		                <s:iterator value="areaList">
		            	<option value="<s:property value="id" />"><s:property value="areaName" /></option>
		            	</s:iterator>
		            </select>
                    </div>
                </div>
                <div class="form-group "><label class="col-sm-2 control-label text-right">所属商家:<font style="color: red;">*</font></label>
                    <div class="col-sm-10">
                        <select class="form-control" id="businessId" name="goodsInfo.businessId">
                        </select>
                    </div>
                </div>
                <div class="form-group "><label class="col-sm-2 control-label text-right">商品名称:<font style="color: red;">*</font></label>
                    <div class="col-sm-10">
                    	<input type="text" class="form-control" id="goodsName" name="goodsInfo.goodsName">
                    </div>
                </div>
                <div class="form-group ">
                	<label class="col-sm-2 control-label text-right">商品Logo:<font style="color: red;">*</font></label>
                    <div class="col-sm-10">
                        <div class="uploader">
                        <input type="file" class="styled" id="image" name="image">
                        <span class="filename" style="-webkit-user-select: none;">No file selected</span>
                        <span class="action" style="-webkit-user-select: none;">Choose File</span>
                        </div>
                        	<font color="red">图片尺寸建议292*240</font>
                    </div>
                </div>

                <div class="form-group"><label class="col-sm-2 control-label text-right">分类:<font style="color: red;">*</font></label>
                    <div class="col-sm-10">
                    	<select class="form-control" id="categoryId" name="goodsInfo.categoryCode">
			                <s:iterator value="simpList">
			                <option value="<s:property value="code" />" disabled="disabled">
			            		<s:property value="name" />
			            	</option>
				            	<s:iterator value="list">
				                <option value="<s:property value="code" />">
				            		&nbsp;&nbsp;<s:property value="name" />
				            	</option>
				            	</s:iterator>
			            	</s:iterator>
			            </select>
                    </div>
                </div>
                <div class="form-group "><label class="col-sm-2 control-label text-right">价格:<font style="color: red;">*</font></label>
                    <div class="col-sm-10">
                    	<input type="text" class="form-control" id="oldPrice" name="goodsInfo.oldPrice">
                    </div>
                </div>
                <div class="form-group "><label class="col-sm-2 control-label text-right">优惠价:</label>
                    <div class="col-sm-10">
                    	<input type="text" class="form-control" id="preferentialPrice" name="goodsInfo.preferentialPrice">
                    </div>
                </div>
                <div class="form-group "><label class="col-sm-2 control-label text-right">商品描述:</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="descriptionSimp" name="goodsInfo.descriptionSimp">
                    </div>
                </div>
                <hr/>
                <div class="form-group ">
                    <div class="col-sm-10">
                        <button id="setPropertiesDivButton" type="button" class="btn btn-default"
                            onclick='showSetPropertiesDiv(-1)'>添加商品属性
                        </button>
                    </div>
                </div>
                
                <div class="form-group ">
                <s:iterator value="attributeList" id="goodsAttributeInfo" status="rowstatus">
                    <div class="col-sm-10">
                        <span id="attribute_row_<s:property value="#rowstatus.index" />" style="display:none">
                            <img onclick="deleteAttribute('<s:property value="#rowstatus.index" />')" border="0" src='<s:url value="/pages/admin/images/forms/collapse.png"/>' width="15" height="15" />
                            属性 <s:property value="#rowstatus.index + 1" />：
                            
                            <label name="attribute_label_<s:property value="#rowstatus.index" />" id="attribute_label_<s:property value="#rowstatus.index" />"><s:property value="#goodsAttributeInfo.attributeName" /></label>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <button type="button" class="btn btn-default" onclick="showSetPropertiesDiv('<s:property value="#rowstatus.index" />')">编辑属性</button>
                            <button type="button" class="btn btn-default" onclick="showSpecDiv('<s:property value="#rowstatus.index" />');">管理规格</button>
                            <p>
                        </span>
                    </div>
                </s:iterator>
                </div>
                
                <hr/>
                <div class="form-group ">
                    <label class="col-sm-5 control-label text-right">请选择该商品的详情在前台页面的展现方式:</label>
                </div>
                <input type="hidden" id="descriptionType" name="goodsInfo.descriptionType" value="0">
                <div class="form-group "><label class="col-sm-2 control-label text-right">&nbsp;</label>
                    <input type="radio" name="descriptionTypeButton" value="0" checked="checked" onClick="changeDescriptionType(0)"/>系统默认模式<br />
                    <input type="radio" name="descriptionTypeButton" value="1" onClick="changeDescriptionType(1)"/>商家自定义模式
                </div>
                
                <div class="form-group ">
                    <span id="editorSpan" style="display:none">
                        <textarea id="description" name="goodsInfo.description" style="width:700px;height:500px;" cols="10" rows="2" class="ckeditor"></textarea>
                    </span>
                </div>
                
                <div class="form-actions text-right">
                    <input type="button" value="取  消" class="btn btn-danger" onclick="resetGoods()">
                    <input type="button" value="保  存" class="btn btn-primary" onclick="submitGoods()">
                </div>
            </div>
        </div>
<input type="hidden" id="attributeStrInJson" name="attributeStrInJson" value="" />
<input type="hidden" id="address" name="address" value="<s:property value="adminAddress" />" />

<s:bean name="org.apache.struts2.util.Counter" id="counter">
    <s:param name="first" value="0" />
    <s:param name="last" value="attributeSize-1" />
    <s:iterator>
        <input type="hidden" id="specStrInJson_<s:property value="current-1"/>" name="specStrInJson_<s:property value="current-1"/>" value="" />
    </s:iterator>
</s:bean>
    </form>
</div>

<div class="modal fade" id="setPropertiesDiv">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                    aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="attribute_div_title">添加商品属性</h4>
            </div>
            <div class="modal-body">
                <div class="form-group" id="mention_div">请输入该商品的属性名称：<br/></div>
                <input type="hidden" id="attributePageIndex" name="attributePageIndex" value=""/>
                <div class="form-group" id="name_div">&nbsp;&nbsp;&nbsp;&nbsp;属性名称：<font color="red">*&nbsp;</font><input type="text" id="tmpAttributeName" name="tmpAttributeName" value=""/><br/></div>
                <div class="form-group" id="tip_div">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(输入最多不得超过十个字)<br/></div>
                <div class="form-group">&nbsp;&nbsp;&nbsp;&nbsp;<font color="red" id="attributeMsg"></font></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" onclick="saveAttribute();">保存</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>

<div class="modal fade" id="setSpecDiv">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                    aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="spec_div_title">管理规格</h4>
            </div>
            <div class="modal-body">
                <div class="form-group" id="mention_div"><strong>商品价格：<font color="red" id="goodsPreferentialPrice"></font>&nbsp;&nbsp;&nbsp;<font color="red" style="text-decoration: line-through ;" id="goodsPrice"></font><br/></strong></div>
                <input type="hidden" id="specIndexInPage" name="specIndexInPage" value=""/>
                <input type="hidden" id="specIndexInDiv" name="specIndexInDiv" value=""/>
                <input type="hidden" id="selectedSpecRowNum" name="selectedSpecRowNum" value="-1"/>
                
                <div style="height: 150px; width:500px;"> 
                    <table width="100%">
                        <tr width="100%">
                            <td width="420">
                                <div style="width:400px;">
                                    <table border="1">
                                        <thead>
                                            <tr width="400">
                                                <th width="200" STYLE="background-color:#999999">规格名称</th>
                                                <th width="200" STYLE="background-color:#999999">波动价格</th>
                                            </tr>
                                        </thead>
                                    </table>
                                </div>
                                <div style="overflow-x: auto; overflow-y: scroll; height: 100px; width:400px; border:1px solid #808080;">
                                    <table border="1">
                                        <tbody>
                                            <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                                <s:param name="first" value="0" />
                                                <s:param name="last" value="specSize-1" />
                                                <s:iterator>
                                                    <tr onclick="selectSpecRow('<s:property value="current-1"/>')" id="spec_row_<s:property value="current-1"/>" style="display:none">
                                                        <td id="spec_name_<s:property value="current-1"/>" width="199"></td>
                                                        <td id="spec_price_<s:property value="current-1"/>" width="181"></td>
                                                    </tr>
                                                </s:iterator>
                                            </s:bean>
                                        </tbody>
                                    </table>
                                </div>
                            </td>
                            <td valign="top">
                                <button type="button" id="addSpecButton" class="btn btn-default" onclick="addSpec();">添加</button><p/><p/>
                                <button type="button" class="btn btn-default" onclick="editSpec();">编辑</button><p/><p/>
                                <button type="button" class="btn btn-default" onclick="deleteSpec();">删除</button>
                            </td>
                        </tr>
                     </table>
                </div>
                
                <div class="form-group" id="spec_name_div" style="display:none">&nbsp;&nbsp;&nbsp;&nbsp;规格名称：<font color="red">*&nbsp;</font>&nbsp;<input type="text" id="tmpSpecName" name="tmpSpecName" value=""/><br/>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(最多不允许超过五个中文字)<br/></div>
                
                <div class="form-group" id="spec_price_div" style="display:none">
                    &nbsp;&nbsp;&nbsp;&nbsp;波动价格：<font color="red">*&nbsp;</font>
                    <select name="specSign" id="specSign">
                        <option value="-"> - </option>
                        <option value="+"> + </option>
                    </select>
                    <input type="text" id="specPrice" name="specPrice" value=""/>
                </div>
                <div class="form-group">&nbsp;&nbsp;&nbsp;&nbsp;<font color="red" id="specMsg"></font></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="saveSpec();">保存</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>

<!-- Footer -->
<s:include value="/pages/admin/common/footer.jsp"></s:include>
<!-- /Footer -->
</body>
<script language=javascript>
var attributeSize = parseInt(<s:property value='attributeSize'/>);
var specSize = parseInt(<s:property value='specSize'/>);
var splitStr = "<s:property value='splitStr'/>";
var moneySign = "￥";

var newAttributeIndex = parseInt("0");
var newSpecIndex = parseInt("0");

var attributeIdArray = new Array(attributeSize);
var attributeNameArray = new Array(attributeSize);
var specArray = new Array(attributeSize);

var specOperationType = "-1";

$(function(){
	var message = "<s:property value='message'/>";
	if(message != null && message != ""){
		top.dialog_alert(message, function(){window.location="<s:url value='/admin/goodsList.do' />";});
	}
	var uploadItem = $('.uploader');
    uploadItem.find('input').on('change',function(){
        var file = uploadItem.find('input').val();
        uploadItem.find('.filename').text(file);
    });
	getBusinessSimpList();
    
    initAttributeSpecArray();
});

/*
 * 初始化属性及规格数组
 */
function initAttributeSpecArray() {
	for (var i = 0; i < attributeSize; i++) {
		attributeIdArray[i] = "-1";
		attributeNameArray[i] = "";
		
		var sa = new Array(specSize);
		for (var j = 0; j < specSize; j++) {
			sa[j] = "";
		}
		specArray[i] = sa;
	}
}
 
/*
 * 根据城市ID取得商家列表
 */
function getBusinessSimpList(){
    var cityId = $("#cityId").val();
	var param = {"cityId":cityId};
	var url = "<s:url value='/admin/businessSimpListJson.do' />";
    $.ajax({
		type:"post",
		url:url,
		data:param,
		cache:false,
		success: function(result) {
	    	var json = eval(result);
	    	var businessHtml = "";
	    	for(var i = 0; i < json.length; i++) {
	    		businessHtml = businessHtml + "<option value=" + json[i].id + ">" + json[i].name + "</option>";
	    	}
			$("#businessId").html(businessHtml);
        }
	});
}

function submitGoods() {
	if(!checkObjIsNull($("#goodsName"))) {
		top.dialog_alert("请完成所有必填项的输入。");
		return false;
	}
	if(!checkObjLength($("#goodsName"), 20)){
		top.dialog_alert("商品名称不能超过20个字符。");
		return false;
	}

	var photoExt = $("#image").val().substr($("#image").val().lastIndexOf(".")).toLowerCase();//获得文件后缀名
    if(photoExt!='.jpg' && photoExt!='.png' && photoExt!='.bmp' && photoExt!='.gif'){
        alert("请上传后缀名为jpg、bmp、gif、png的照片!");
        return false;
    }
    
	if(!checkObjIsNull($("#image"))) { 
		top.dialog_alert("请选择商品Logo。");
		return false;
	} 
	if(!checkObjIsNull($("#oldPrice"))) {
		top.dialog_alert("请输入原价。");
		return false;
	}

	var oldPrice = $("#oldPrice").val();
	var preferentialPrice = $("#preferentialPrice").val();
	if(!checkMoney($("#oldPrice"))){
		top.dialog_alert("请输入正确的原价！");
		return false;
	}
	if(oldPrice <= 0){
		top.dialog_alert("请输入正确的原价！");
		return false;
	}

	if(checkObjIsNull($("#preferentialPrice"))) {
		if(!checkMoney($("#preferentialPrice"))){
			top.dialog_alert("请输入正确的优惠价！");
			return false;
		}
		if(preferentialPrice <= 0){
			top.dialog_alert("请输入正确的优惠价！");
			return false;
		}
		
		if(parseFloat(preferentialPrice) > parseFloat(oldPrice)) {
			top.dialog_alert("优惠价不能高于原价。");
			return false;
		}
	}
	
	if (checkObjIsNull($("#descriptionSimp")) && !checkObjLength($("#descriptionSimp"), 200)){
		top.dialog_alert("商品描述不能超过200个字符。");
		return false;
	}
	
	if (document.goodsForm.descriptionTypeButton[0].checked == true) {
		document.getElementById("descriptionType").value = 0;
	} else {
		document.getElementById("descriptionType").value = 1;
	}
	
	$("#descriptionSimp").blur();
	
	var goodsName = trim($("#goodsName").val());
	var businessId = trim($("#businessId").val());
	var param = {"goodsInfo.goodsName":goodsName, "goodsInfo.id":0, "goodsInfo.businessId":businessId};
	var act = "<s:url value='/admin/checkGoodsName.do' includeParams='none'/>";
    $.ajax({
		type:"post",
		url:act,
		data:param,
		cache:false,
		success: function(msg) {
			if(msg == "noexist"){
				formatAttributeIntoJSON();
				formatSpecIntoJSON();
				$('#goodsForm').submit();
        	} else {
        		top.dialog_alert(msg);
        	}
        }
	});
}

function resetGoods() {
	location.href='<s:url value="/admin/goodsList.do" includeParams="none"/>';
}

function showSetPropertiesDiv(pageIndex) {
	if (!checkObjIsNull($("#oldPrice"))) {
		top.dialog_alert("添加或修改商品属性前请先设置商品价格。");
		return false;
	}
	
	$('#setPropertiesDiv').modal();
	$('#attributePageIndex').val(pageIndex);
	var name = "";
	if (pageIndex >= 0) {
		//编辑属性
		name = document.getElementById("attribute_label_" + pageIndex).innerHTML;
		document.getElementById("attribute_div_title").innerHTML = "编辑商品属性";
	} else {
		document.getElementById("attribute_div_title").innerHTML = "添加商品属性";
	}
	document.getElementById("attributeMsg").innerHTML = "";
	$('#tmpAttributeName').val(name);
	$("#setPropertiesDiv .modal-dialog .modal-content .modal-footer .btn.btn-primary").show();
}

function saveAttribute() {
	//top.dialog_alert("修改前： " +attributeNameArray[0] + "ss" + attributeNameArray[1] + "ss" + attributeNameArray[2] + "ss" + attributeNameArray[3] + "ss" + attributeNameArray[4]);
	var index = parseInt($('#attributePageIndex').val());
	var name = trim($('#tmpAttributeName').val());
	
	if (index < 0 && newAttributeIndex == 5) {
		document.getElementById("attributeMsg").innerHTML = "商品最多只能添加5个属性。";
		return false;
	}
	
	if (!checkObjIsNull($('#tmpAttributeName'))) {
		document.getElementById("attributeMsg").innerHTML = "请输入属性名称。";
		return false;
	}
	if (!checkObjLength($('#tmpAttributeName'), 20)) {
		document.getElementById("attributeMsg").innerHTML = "属性名称最多不得超过十个字。";
		return false;
	}
	if (containSpecial(name)) {
		document.getElementById("attributeMsg").innerHTML = "属性名称不得包含特殊字符。";
		return false;
	}
	
	//判断属性名称的唯一性
	for (var i = 0; i < attributeSize; i++) {
		if (trim(attributeNameArray[i]) == trim(name)) {
			if (index == -1 || (index != -1 && index != i)) {
				document.getElementById("attributeMsg").innerHTML = "属性名称已经存在，请重新设置。";
				return false;
			}
		}
	}
	
	if (index < 0) {
		//add new attribute
		var rowId = "attribute_row_" + newAttributeIndex;
		var labelId = "attribute_label_" + newAttributeIndex;
		//top.dialog_alert(labelId);
		//top.dialog_alert(document.getElementById(labelId).innerHTML);
		document.getElementById(labelId).innerHTML = name;
		document.getElementById(rowId).style.display = '';
		attributeNameArray[newAttributeIndex] = name;
		
		newAttributeIndex += 1;
		if (newAttributeIndex == 5) {
			//如果商品属性已经达到5个，则disable “添加商品属性”按钮
			document.getElementById("setPropertiesDivButton").disabled = true;
		}
	} else {
		//edit attribute
		var labelId = "attribute_label_" + index;
		document.getElementById(labelId).innerHTML = name;
		attributeNameArray[index] = name;
	}
	//$("#setPropertiesDiv .modal-dialog .modal-content .modal-footer .btn.btn-primary").hide();
	var successMsg = index < 0 ? "属性创建成功。" : "属性编辑成功。";
	document.getElementById("attributeMsg").innerHTML = successMsg;
	$('#tmpAttributeName').val("");
	//top.dialog_alert("修改后： " +attributeNameArray[0] + "ss" + attributeNameArray[1] + "ss" + attributeNameArray[2] + "ss" + attributeNameArray[3] + "ss" + attributeNameArray[4]);
}

function deleteAttribute(pageIndex) {
	top.dialog_confirm("您确认删除该属性及其所有规格选项吗？", function(){
		if (pageIndex == attributeSize - 1) {
			//页面清空
			var rowId = "attribute_row_" + pageIndex;
			var labelId = "attribute_label_" + pageIndex;
			document.getElementById(rowId).style.display = 'none';
			document.getElementById(labelId).innerHTML = '';
			//数组清空
			attributeIdArray[pageIndex] = "-1";
			attributeNameArray[pageIndex] = "";
			var sa = new Array(specSize);
			for (var j = 0; j < specSize; j++) {
				sa[j] = "";
			}
			specArray[pageIndex] = sa;
		} else {
			for (var i = pageIndex; i < attributeSize - 1; i++) {
				//页面
				var rowId = "attribute_row_" + i;
	    		var labelId = "attribute_label_" + i;
	    		var nextLabelId = "attribute_label_" + (parseInt(i)+1);
	    		//top.dialog_alert(pageIndex + "--" + rowId + "|" + labelId + "|" + nextLabelId);
	    		document.getElementById(labelId).innerHTML = trim(document.getElementById(nextLabelId).innerHTML);
				if (document.getElementById(labelId).innerHTML == '') {
					document.getElementById(rowId).style.display = 'none';
				}
	    		
				//数组
				//top.dialog_alert(i + "前:" + attributeNameArray[0] + "ss" + attributeNameArray[1] + "ss" + attributeNameArray[2] + "ss" + attributeNameArray[3] + "ss" + attributeNameArray[4]);
				attributeIdArray[i] = attributeIdArray[parseInt(i) + 1];
				attributeNameArray[i] = attributeNameArray[parseInt(i) + 1];
				//top.dialog_alert(i + "后:" + attributeNameArray[0] + "ss" + attributeNameArray[1] + "ss" + attributeNameArray[2] + "ss" + attributeNameArray[3] + "ss" + attributeNameArray[4]);
				specArray[i] = specArray[parseInt(i) + 1];
			}
			var maxIndex = attributeSize - 1;
			var rowId = "attribute_row_" + maxIndex;
			var labelId = "attribute_label_" + maxIndex;
			document.getElementById(rowId).style.display = 'none';
			document.getElementById(labelId).innerHTML = '';

			attributeIdArray[maxIndex] = "-1";
			attributeNameArray[maxIndex] = "";
			var sa = new Array(specSize);
			for (var j = 0; j < specSize; j++) {
				sa[j] = "";
			}
			specArray[maxIndex] = sa;
		}
		
		document.getElementById("setPropertiesDivButton").disabled = false;
		newAttributeIndex--;
		//top.dialog_alert(attributeNameArray[0] + "ss" + attributeNameArray[1] + "ss" + attributeNameArray[2] + "ss" + attributeNameArray[3] + "ss" + attributeNameArray[4]);
	});
}

function formatAttributeIntoJSON() {
	var jsonStr = "[";
	
	for (var i = 0; i < attributeSize; i++) {
		var id = attributeIdArray[i];
		var name = attributeNameArray[i];
		var objStr = '{"id":"' + id + '","attributeName":"' + name + '"}';
		if (i != attributeSize - 1) {
			objStr += ',';
		}
		jsonStr += objStr;
	}
	jsonStr += "]";
	
	$("#attributeStrInJson").val(jsonStr);
}

function showSpecDiv(pageIndex) {
	if (!checkObjIsNull($("#oldPrice"))) {
		top.dialog_alert("管理规格前请先设置商品价格。");
		return false;
	}
	
	$('#setSpecDiv').modal();
	$('#specIndexInPage').val(pageIndex);
	
	//设置商品价格
	var goodsPrice = $("#oldPrice").val();
	var goodsPreferentialPrice = $("#preferentialPrice").val();
	
	document.getElementById("goodsPrice").innerHTML = '';
	document.getElementById("goodsPreferentialPrice").innerHTML = '';
	
	if (trim(goodsPrice) != '' && trim(goodsPreferentialPrice) != '') {
		document.getElementById("goodsPrice").innerHTML = moneySign + goodsPrice;
		document.getElementById("goodsPreferentialPrice").innerHTML = moneySign + goodsPreferentialPrice;
	} else if (trim(goodsPrice) != '') {
		document.getElementById("goodsPreferentialPrice").innerHTML = moneySign + goodsPrice;
	} else if (trim(goodsPreferentialPrice) != '') {
		document.getElementById("goodsPreferentialPrice").innerHTML = moneySign + goodsPreferentialPrice;
	}

	//设置现有规格
	newSpecIndex = 0;
	for (var i = 0; i < specSize; i++) {
		var str = specArray[pageIndex][i];
		
		if (str != "") {
			var strArray = str.split(splitStr);
			document.getElementById("spec_name_" + i).innerHTML = strArray[1];
			document.getElementById("spec_price_" + i).innerHTML = strArray[2] + strArray[3] + "￥";
			document.getElementById("spec_row_" + i).style.display = "";
			newSpecIndex++;
		} else {
			document.getElementById("spec_name_" + i).innerHTML = "";
			document.getElementById("spec_price_" + i).innerHTML = "";
			document.getElementById("spec_row_" + i).style.display = "none";
		}
	}
	
	initSpecInput();
	
	$("#setSpecDiv .modal-dialog .modal-content .modal-footer .btn.btn-primary").show();
}

function selectSpecRow(specRowId) {
	var previousSelectedRowNum = document.getElementById("selectedSpecRowNum").value;
	if (previousSelectedRowNum != -1) {
		document.getElementById("spec_row_" + previousSelectedRowNum).style.background = "#FFFFFF";
	}
	
	document.getElementById("selectedSpecRowNum").value = specRowId;
	document.getElementById("spec_row_" + specRowId).style.background = "#BEBEBE";
}

function addSpec() {
	if (newSpecIndex == specSize) {
		top.dialog_alert("规格数量不能超过" + specSize + "个。");
		return false;
	}
	
	var previousSelectedRowNum = document.getElementById("selectedSpecRowNum").value;
	if (previousSelectedRowNum != -1) {
		document.getElementById("spec_row_" + previousSelectedRowNum).style.background = "#FFFFFF";
	}
	document.getElementById("selectedSpecRowNum").value = -1;
	
	$('#tmpSpecName').val("");
	document.getElementById("specSign").selectedIndex = 0;
	$('#specPrice').val("0.00");
	
	specOperationType = 1;
	document.getElementById("spec_name_div").style.display = "";
	document.getElementById("spec_price_div").style.display = "";
	document.getElementById("specMsg").innerHTML = "";
}

function editSpec() {
	var selectedRowNum = document.getElementById("selectedSpecRowNum").value;
	if (selectedRowNum == -1) {
		top.dialog_alert("请选择需要编辑的规格！");
		return false;
	}
	
	var name = document.getElementById("spec_name_" + selectedRowNum).innerHTML;
	var price = document.getElementById("spec_price_" + selectedRowNum).innerHTML;
	
	if (price.substring(0, 1) == '+') {
		document.getElementById("specSign").selectedIndex = 1;
	}
	$('#tmpSpecName').val(name);
	$('#specPrice').val(price.substring(1, price.length - 1));
	
	specOperationType = 2;
	document.getElementById("spec_name_div").style.display = "";
	document.getElementById("spec_price_div").style.display = "";
	document.getElementById("specMsg").innerHTML = "";
}

function deleteSpec() {
	var pageIndex = $('#specIndexInPage').val();
	var selectedRowNum = document.getElementById("selectedSpecRowNum").value;
	if (selectedRowNum == -1) {
		top.dialog_alert("请选择需要删除的规格选项！");
		return false;
	}
	
	top.dialog_confirm("您确认删除该规格选项吗？", function(){
		if (selectedRowNum == parseInt(newSpecIndex) - 1) {
			//最后一行
			//页面
			document.getElementById("spec_name_" + selectedRowNum).innerHTML = "";
			document.getElementById("spec_price_" + selectedRowNum).innerHTML = "";
			document.getElementById("spec_row_" + selectedRowNum).style.background = "#FFFFFF";
			document.getElementById("spec_row_" + selectedRowNum).style.display = "none";
			
			//数组
			specArray[pageIndex][selectedRowNum] = "";
		} else {
			//页面
			for (var i = selectedRowNum; i < parseInt(specSize) - 1; i++) {
				//页面
				var rowId = "spec_row_" + i;
				var nextRowId = "spec_row_" + (parseInt(i)+1);
	    		var nameId = "spec_name_" + i;
	    		var nextNameId = "spec_name_" + (parseInt(i)+1);
	    		var priceId = "spec_price_" + i;
	    		var nextPriceId = "spec_price_" + (parseInt(i)+1);
	    		
	    		document.getElementById(nameId).innerHTML = document.getElementById(nextNameId).innerHTML;
	    		document.getElementById(priceId).innerHTML = document.getElementById(nextPriceId).innerHTML;
				if (document.getElementById(nameId).innerHTML == '') {
					document.getElementById(rowId).style.display = 'none';
				}
	    		
				//数组
				specArray[pageIndex][i] = specArray[pageIndex][parseInt(i) + 1];
			}
			
			var maxIndex = parseInt(specSize) - 1;
			var rowId = "spec_row_" + maxIndex;
			var nameId = "spec_name_" + maxIndex;
			var priceId = "spec_price_" + maxIndex;
			document.getElementById(rowId).style.display = 'none';
			document.getElementById(nameId).innerHTML = '';
			document.getElementById(priceId).innerHTML = '';
			
			specArray[pageIndex][maxIndex] = "";
		}
		
		newSpecIndex--;
		
		initSpecInput();
	});
}

function saveSpec() {
	if (specOperationType == -1) {
		document.getElementById("specMsg").innerHTML = "请选择操作类型。";
		return false;
	}
	
	//for spec adding, get the last index
	var divIndex = newSpecIndex;
	var pageIndex = $('#specIndexInPage').val();
	//for spec editing, get the selected row num
	var selectedRowNum = document.getElementById("selectedSpecRowNum").value;
	
	var specName = trim($('#tmpSpecName').val());
	var specSign = document.getElementById("specSign").options[document.getElementById("specSign").selectedIndex].value;
	var specPrice = $('#specPrice').val();
	//top.dialog_alert(specName + "=" + specSign + specPrice);
	
	if (!checkObjIsNull($("#tmpSpecName")) && !checkObjIsNull($("#specPrice"))) {
		document.getElementById("specMsg").innerHTML = "请设置规格名称、波动价格。";
		return false;
	}
	
	if(!checkObjIsNull($("#tmpSpecName"))) {
		document.getElementById("specMsg").innerHTML = "请输入规格名称。";
		return false;
	}
	if (containSpecial(specName)) {
		document.getElementById("specMsg").innerHTML = "规格名称不得包含特殊字符。";
		return false;
	}
	if(!checkObjIsNull($("#specPrice"))) {
		document.getElementById("specMsg").innerHTML = "请输入波动价格。";
		return false;
	}
	if (!checkObjLength($("#tmpSpecName"), 10)) {
		document.getElementById("specMsg").innerHTML = "规格名称最多不得超过五个中文字。";
		return false;
	}
	if (!isMoney($("#specPrice").val()) || parseFloat(trim($("#specPrice").val())) < 0) {
		document.getElementById("specMsg").innerHTML = "请输入正确的波动价格（例如：10.00元）。";
		return false;
	}
	
	if (hasSameSpecName(pageIndex, specName, selectedRowNum) == true) {
		document.getElementById("specMsg").innerHTML = "已有同名的规格，请重新输入。";
		return false;
	}
	
	//判断波动价格是否使得商品价格小于或等于0
	var goodsPrice = trim($("#oldPrice").val());
	var goodsPreferentialPrice = trim($("#preferentialPrice").val());
	var price = 0;
	var totalFluctuationPrice = getTotalFluctuationPrice(pageIndex);
	if (goodsPreferentialPrice != '') {
		price = goodsPreferentialPrice;
	} else if (goodsPrice != '') {
		price = goodsPrice;
	}
	if ((parseFloat(price) + totalFluctuationPrice + parseFloat(specSign + trim(specPrice))) <= 0) {
		document.getElementById("specMsg").innerHTML = "波动价格不能使得商品价格小于或者等于零，请重新设置波动价格。";
		return false;
	}
	
	if (specOperationType == 1) {
		//add new spec
		//页面
		document.getElementById("spec_name_" + divIndex).innerHTML = specName;
		document.getElementById("spec_price_" + divIndex).innerHTML = specSign + roundNumber(specPrice, 2) + "￥";
		document.getElementById("spec_row_" + divIndex).style.display = "";
		
		//数组
		specArray[pageIndex][newSpecIndex] = "-1" + splitStr + specName + splitStr + specSign + splitStr + roundNumber(specPrice, 2);
		newSpecIndex++;
		top.dialog_alert("规格已创建成功！");
		//top.dialog_alert("1: " + specArray[1][0] + "2: " + specArray[1][1]);
		initSpecInput();
	} else if (specOperationType == 2) {
		//edit spec
		//页面
		document.getElementById("spec_name_" + selectedRowNum).innerHTML = specName;
		document.getElementById("spec_price_" + selectedRowNum).innerHTML = specSign + roundNumber(specPrice, 2) + "￥";
		
		//数组
		specArray[pageIndex][selectedRowNum] = "-1" + splitStr + specName + splitStr + specSign + splitStr + roundNumber(specPrice, 2);
		top.dialog_alert("规格已编辑成功！");
		//top.dialog_alert("1: " + specArray[1][0] + "2: " + specArray[1][1]);
		initSpecInput();
	}
}

function initSpecInput() {
	//初始化规格输入框
	$('#tmpSpecName').val("");
	document.getElementById("specSign").selectedIndex = 0;
	$('#specPrice').val("");
	specOperationType = -1;
	
	var previousSelectedRowNum = document.getElementById("selectedSpecRowNum").value;
	if (previousSelectedRowNum != -1) {
		document.getElementById("spec_row_" + previousSelectedRowNum).style.background = "#FFFFFF";
	}
	document.getElementById("selectedSpecRowNum").value = -1;
	document.getElementById("spec_name_div").style.display = "none";
	document.getElementById("spec_price_div").style.display = "none";
	document.getElementById("specMsg").innerHTML = "";
}

function formatSpecIntoJSON() {
	for (var i = 0; i < attributeSize; i++) {
		if (specArray[i][0] != "") {
			var jsonStr = "[";
			var j = 0;
			
			while (j < specSize && specArray[i][j] != '') {
				var str = specArray[i][j];
				var strArray = str.split(splitStr);
				var id = strArray[0];
				var name = strArray[1];
				var price = strArray[2] + strArray[3];
				var objStr = '{"id":"' + id + '","specName":"' + name + '","specPrice":"' + price + '"}';
				jsonStr += objStr + ',';
				j++;
			}
			
			jsonStr = jsonStr.substring(0, jsonStr.length - 1) + "]";
			document.getElementById("specStrInJson_" + i).value = jsonStr;
		}
	}
}

function isMoney(s) {
	if (s.indexOf(".") == -1 || (s.length - s.indexOf(".")) != 3) {
		return false;
	} else {
		var regu = "^[0-9]+[\.][0-9]{0,2}$";
		var re = new RegExp(regu);
		if (re.test(s)) {
			return true;
		} else {
			return false;
		}
	}
}

function getTotalFluctuationPrice() {
	var totalFluctuationPrice = parseFloat(0);
	for (var i = 0; i < attributeSize; i++) {
		var j = 0;
		while (j < specSize && specArray[i][j] != '') {
			var str = specArray[i][j];
			var strArray = str.split(splitStr);
			var price = parseFloat(strArray[2] + strArray[3]);
			totalFluctuationPrice += price;
			j++;
		}
	}
	
	return totalFluctuationPrice;
}

function hasSameSpecName(pageIndex, specName, selectedRowNum) {
	var i = 0;
	while (i < specSize && specArray[pageIndex][i] != '') {
		var str = specArray[pageIndex][i];
		var strArray = str.split(splitStr);
		if ((selectedRowNum == -1 && trim(strArray[1]) == trim(specName)) || 
				(selectedRowNum != -1 && trim(strArray[1]) == trim(specName) && i != selectedRowNum)) {
			return true;
		}
		i++;
	}
	return false;
}

function changeDescriptionType(type) {
	if (type == 0) {
		document.getElementById("editorSpan").style.display = "none";
	} else {
		document.getElementById("editorSpan").style.display = "";
	}
}
</script>	
</html>