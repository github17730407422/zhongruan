<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/pages/admin/common/admin_meta.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>易食客后台管理系统</title> 
    
</head>
<body class="sub-page">
<div class="page-header">
    <div class="page-title">
        <h3>编辑商家
        </h3>
    </div>
</div>
<div class="breadcrumb-line">
    <ul class="breadcrumb">
        <li><a href="<s:url value="/admin/businessList.do" includeParams='none'/>">商家管理</a></li>
        <li class="active">编辑商家</li>
    </ul>
</div>
<div class="block s-form">
    <form id="businessForm" class="form-horizontal" action="<s:url value="/admin/businessUpdate.do" includeParams='none'/>"  enctype="multipart/form-data" method="post">
        <input type="hidden" id="businessid" name="businessInfo.id" value="<s:property value="businessInfo.id"/>" />
        <input type="hidden" id="licence_scan_url" name="businessInfo.licence_scan_url" value="<s:property value="businessInfo.licence_scan_url"/>" />
        <input type="hidden" id="id_card_zheng_url" name="businessInfo.id_card_zheng_url" value="<s:property value="businessInfo.id_card_zheng_url"/>" />
        <input type="hidden" id="id_card_fan_url" name="businessInfo.id_card_fan_url" value="<s:property value="businessInfo.id_card_fan_url"/>" />
       	<input type="hidden" id="business_logo" name="businessInfo.business_logo" value="<s:property value="businessInfo.id_card_fan_url"/>" />
       	<input type="hidden" id="business_status" name="businessInfo.status" value="<s:property value="businessInfo.status"/>" />
        <input type="hidden" id="business_city_id" name="businessInfo.city_id" value="<s:property value="businessInfo.city_id"/>" />
        <input type="hidden" id="start_time" name="start_time" value="<s:property value="businessInfo.hours_start"/>" />
        <input type="hidden" id="end_time" name="end_time" value="<s:property value="businessInfo.hours_end"/>" />
        <input type="hidden" id="start_time_am" name="start_time_am" value="<s:property value="businessInfo.hours_start_am"/>" />
        <input type="hidden" id="end_time_am" name="end_time_am" value="<s:property value="businessInfo.hours_end_am"/>" />
         <input type="hidden" id="start_time_pm" name="start_time_pm" value="<s:property value="businessInfo.hours_start_pm"/>" />
        <input type="hidden" id="end_time_pm" name="end_time_pm" value="<s:property value="businessInfo.hours_end_pm"/>" />
       	
        <div class="panel panel-default ">

            <div class="panel-body">
                <div class="form-group">
                    <label class="col-sm-3 control-label text-right">商家名称:<span class="required"><font style="color: red;">*</font></span></label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="name" name="businessInfo.name" value="<s:property value="businessInfo.name"/>">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label text-right">企业名称:<span class="required"><font style="color: red;">*</font></span></label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="businessName" name="businessInfo.business_name" value="<s:property value="businessInfo.business_name"/>">
                    </div>
                </div>
                <div class="form-group"><label class="col-sm-3 control-label text-right">营业执照注册号:</label>

                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="licence_number" name="businessInfo.licence_number" value="<s:property value="businessInfo.licence_number"/>">
                    </div>
                </div>
                <div class="form-group"><label class="col-sm-3 control-label text-right">营业执照所在地:</label>

                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="licence_address" name="businessInfo.licence_address" value="<s:property value="businessInfo.licence_address"/>">
                    </div>
                </div>
                <div class="form-group"><label class="col-sm-3 control-label text-right">营业执照有效期:</label>

                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="licence_date_end" name="businessInfo.licence_date_end" value="<s:date name="businessInfo.licence_date_end" format="yyyy-MM-dd"/>" readonly="readonly" onfocus="WdatePicker({skin:'whyGreen',minDate:'%y-%M-%d'})" >
                
                    </div>
                </div>
                <div class="form-group"><label class="col-sm-3 control-label text-right">营业地址:<span
                        class="required"><font style="color: red;">*</font></span></label>

                    <div class="col-sm-9">
                        <div class="input-group">
                            <input type="text" class="form-control" id="centerPoint" name="businessInfo.address" value="<s:property value="businessInfo.address"/>">
                              <span class="input-group-btn">
                                <button class="btn btn-default" type="button" onclick="showMap('<s:url value="/admin/showMap.do" includeParams='none'/>')"><i class="fa fa-map-marker"></i> 定 位</button>
                                <input type="hidden" id="longitude" name="businessInfo.longitude" value="<s:property value="businessInfo.longitude"/>" />
       							<input type="hidden" id="latitude" name="businessInfo.latitude" value="<s:property value="businessInfo.latitude"/>" />
                              </span>
                        </div>
                    </div>
                </div>
                <div class="form-group"><label class="col-sm-3 control-label text-right">联系电话:<span
                        class="required"><font style="color: red;">*</font></span></label>

                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="telphone" name="businessInfo.telphone" value="<s:property value="businessInfo.telphone"/>" />
                    </div>
                </div>
                <div class="form-group"><label class="col-sm-3 control-label text-right">手机号码:<span
                        class="required"><font style="color: red;">*</font></span></label>

                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="mobilephone" name="businessInfo.mobilephone" value="<s:property value="businessInfo.mobilephone"/>" />
                    </div>
                </div>
                <div class="form-group "><label class="col-sm-3 control-label text-right">当前营业执照扫描件:</label>
                    &nbsp;&nbsp;&nbsp;
                    <s:if test="businessInfo.licence_scan_url == null || businessInfo.licence_scan_url == ''">无</s:if>
                    <s:else>
                    <a href="javascript:void(0)" onclick="javascript:previewAdPicture('<s:property value="businessInfo.licence_scan_url"/>')">预 览</a>
                    </s:else>
                </div>
                <div class="form-group "><label class="col-sm-2 control-label text-right" value="">上传新营业执照扫描件:</label>
                    <div class="col-sm-10">
                        <div class="uploader">
                            <input type="file" class="styled" id="licence_scan_file" name="licence_scan_file" value="<s:property value="businessInfo.licence_scan_url"/>"/>
                            <span class="filename" style="-webkit-user-select: none;">No file selected</span>
	                        <span class="action" style="-webkit-user-select: none;">Choose File</span>
                        </div>
                    </div>
                </div>
                <div class="form-group "><label class="col-sm-3 control-label text-right">对公开户银行:</label>
                    <div class="col-sm-9"><input type="text" class="form-control" id="bank_name" name="businessInfo.bank_name" value="<s:property value="businessInfo.bank_name"/>">
                    </div>
                </div>
                <div class="form-group "><label class="col-sm-3 control-label text-right">开户行所在地址:</label>
                    <div class="col-sm-9"><input type="text" class="form-control" id="bank_address" name="businessInfo.bank_address" value="<s:property value="businessInfo.bank_address"/>"  >
                    </div>
                </div>
                <div class="form-group "><label class="col-sm-3 control-label text-right">开户银行支行名称:</label>
                    <div class="col-sm-9"><input type="text" class="form-control" id="bank_branch_name" name="businessInfo.bank_branch_name" value="<s:property value="businessInfo.bank_branch_name"/>">
                    </div>
                </div>
                <div class="form-group "><label class="col-sm-3 control-label text-right">公司对公账号银行卡号:</label>
                    <div class="col-sm-9"><input type="text" class="form-control" id="bank_account_number" name="businessInfo.bank_account_number" value="<s:property value="businessInfo.bank_account_number"/>" >
                    </div>
                </div>
                <div class="form-group "><label class="col-sm-3 control-label text-right">法人代表真实姓名:</label>
                    <div class="col-sm-9"><input type="text" class="form-control" id="legal_person_name" name="businessInfo.legal_person_name" value="<s:property value="businessInfo.legal_person_name"/>" >
                    </div>
                </div>
                <div class="form-group "><label class="col-sm-3 control-label text-right">法人代表联系电话:</label>
                    <div class="col-sm-9"><input type="text" class="form-control" id="legal_person_phone" name="businessInfo.legal_person_phone" value="<s:property value="businessInfo.legal_person_phone"/>" >
                    </div>
                </div>
                <div class="form-group "><label class="col-sm-3 control-label text-right">身份号码:</label>
                    <div class="col-sm-9"><input type="text" class="form-control" id="legal_no" name="businessInfo.legal_no" value="<s:property value="businessInfo.legal_no"/>" >
                    </div>
                </div>
                <div class="form-group "><label class="col-sm-3 control-label text-right">当前身份证扫描件:</label>
                    &nbsp;&nbsp;&nbsp;
                    <s:if test="businessInfo.id_card_zheng_url == null || businessInfo.id_card_zheng_url == ''">无正面扫描件</s:if>
                    <s:else>
                    <a href="javascript:void(0)" onclick="javascript:previewAdPicture('<s:property value="businessInfo.id_card_zheng_url"/>')">预览正面</a>
                    </s:else>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <s:if test="businessInfo.id_card_fan_url == null || businessInfo.id_card_fan_url == ''">无反面扫描件</s:if>
                    <s:else>
                    <a href="javascript:void(0)" onclick="javascript:previewAdPicture('<s:property value="businessInfo.id_card_fan_url"/>')">预览反面</a>
                    </s:else>
                </div>
                <div class="form-group "><label class="col-sm-3 control-label text-right">新身份证图片上传:</label>
                    <div class="col-sm-4">
                        <div class="col-sm-10">
                            <div class="uploader">
                                <input type="file" class="styled" id="id_card_zheng_file" name="id_card_zheng_file" value="<s:property value="businessInfo.id_card_zheng_url"/>">
                                <span class="filename" style="-webkit-user-select: none;">No file selected</span>
	                            <span class="action" style="-webkit-user-select: none;">Choose File</span>
                            </div>
                        </div>
                        <span class="help-block">正面</span>
                    </div>
                    <div class="col-sm-4">
                        <div class="col-sm-10">
                            <div class="uploader">
                                <input type="file" class="styled" id="id_card_fan_file" name="id_card_fan_file" value="<s:property value="businessInfo.id_card_fan_url"/>">
                                <span class="filename" style="-webkit-user-select: none;">No file selected</span>
	                            <span class="action" style="-webkit-user-select: none;">Choose File</span>
                            </div>
                        </div>
                        <span class="help-block">反面</span>
                    </div>
                </div>
                <div class="form-group "><label class="col-sm-3 control-label text-right">当前商家Logo:</label>
                        &nbsp;&nbsp;&nbsp;
                        <a href="javascript:void(0)" onclick="javascript:previewAdPicture('<s:property value="businessInfo.business_logo"/>')">预 览</a>
                    </div>
                </div>
                <div class="form-group "><label class="col-sm-2 control-label text-right" value="">新商家Logo:</label>
                    <div class="col-sm-10">
                        <div class="uploader">
                            <input type="file" class="styled" id="business_logo_file" name="business_logo_file" value="<s:property value="businessInfo.business_logo"/>"/>
                            <span class="filename" style="-webkit-user-select: none;">No file selected</span>
	                            <span class="action" style="-webkit-user-select: none;">Choose File</span>
                        </div>
                        	<font color="red">图片尺寸建议292*240</font>
                    </div>
                </div>
                <div class="form-group "><label class="col-sm-3 control-label text-right">营业时间:<font style="color: red;">*</font></label>
                   <s:if test="businessInfo.type==0">
                     <div><input type="radio" name="time_type"  value="0"  checked="checked"/> 全天型</div>
                   </s:if>
                   <s:else>
                      <div><input type="radio" name="time_type"  value="0"/> 全天型</div>
                   </s:else>
                    <div class="col-sm-4"style="padding-top:20px;">
                    	<s:if test="businessInfo.hours_start != null">
                    	<input type="text" class="form-control" id="startDate" name="businessInfo.hours_start"  value="<s:date name="businessInfo.hours_start" format="HH:mm"/>" >
                    	</s:if>
                    	<s:else>
                    	<input type="text" class="form-control" id="startDate" name="businessInfo.hours_start">
                    	</s:else>
                    	（例如：8:00）
                    </div>
                    <div class="col-sm-4"style="padding-top:20px;">
                    	<s:if test="businessInfo.hours_end != null">
                        <input type="text" class="form-control" id="endDate" name="businessInfo.hours_end" value="<s:date name="businessInfo.hours_end" format="HH:mm"/>" >
                   		</s:if>
                   		<s:else>
                   		<input type="text" class="form-control" id="endDate" name="businessInfo.hours_end" >
                   		</s:else>
                   		（例如：18:00）
                    </div>
                    <div style="clear:both;"></div>
                    <s:if test="businessInfo.type==1">
                      <div style="float:left;margin-left:206px; margin-top:20px;"><input type="radio" name="time_type"  value="1" checked="checked"/> 时间段型</div>
                    </s:if>
                    <s:else>
                      <div style="float:left;margin-left:206px; margin-top:20px;"><input type="radio" name="time_type"  value="1"/> 时间段型</div>
                    </s:else>
                    <div style="clear:both;"></div>
                    <div class="col-sm-4"style="padding-top:20px;float:left;margin-left:206px;">
                    	<s:if test="businessInfo.hours_start_am != null">
                        <input type="text" class="form-control" id="startDateAm" name="businessInfo.hours_start_am" value="<s:date name="businessInfo.hours_start_am" format="HH:mm"/>" >
                   		</s:if>
                   		<s:else>
                   		<input type="text" class="form-control" id="startDateAm" name="businessInfo.hours_start_am" >
                   		</s:else>
                   		（例如：8:00）
                    </div>
                     <div class="col-sm-4"style="padding-top:20px;">
                    	<s:if test="businessInfo.hours_end_am != null">
                        <input type="text" class="form-control" id="endDateAm" name="businessInfo.hours_end_am" value="<s:date name="businessInfo.hours_end_am" format="HH:mm"/>" >
                   		</s:if>
                   		<s:else>
                   		<input type="text" class="form-control" id="endDateAm" name="businessInfo.hours_end_am" >
                   		</s:else>
                   		（例如：11:00）
                    </div>
                    <div style="margin-top:30px;">AM</div>
                    <div style="clear:both;"></div>
                     <div class="col-sm-4"style="padding-top:20px;float:left;margin-left:206px;">
                    	<s:if test="businessInfo.hours_start_pm != null">
                        <input type="text" class="form-control" id="startDatePm" name="businessInfo.hours_start_pm" value="<s:date name="businessInfo.hours_start_pm" format="HH:mm"/>" >
                   		</s:if>
                   		<s:else>
                   		<input type="text" class="form-control" id="startDatePm" name="businessInfo.hours_start_pm" >
                   		</s:else>
                   		（例如：13:00）
                    </div>
                     <div class="col-sm-4"style="padding-top:20px;">
                    	<s:if test="businessInfo.hours_end_pm != null">
                        <input type="text" class="form-control" id="endDatePm" name="businessInfo.hours_end_pm" value="<s:date name="businessInfo.hours_end_pm" format="HH:mm"/>" >
                   		</s:if>
                   		<s:else>
                   		<input type="text" class="form-control" id="endDatePm" name="businessInfo.hours_end_pm" >
                   		</s:else>
                   		（例如：18:00）
                    </div>
                    <div style="margin-top:30px;">PM</div>
                </div>
                <div class="form-group "><label class="col-sm-3 control-label text-right">商家公告:</label>
                    <div class="col-sm-9"><input type="text" class="form-control" id="business_notice" name="businessInfo.business_notice" value="<s:property value="businessInfo.business_notice"/>" >
                    </div>
                </div>
                <div class="form-group "><label class="col-sm-3 control-label text-right">商家介绍:</label>
                    <div class="col-sm-9"><textarea class="form-control" id="business_des" name="businessInfo.business_des" ><s:property value="businessInfo.business_des"/></textarea>
                    </div>
                </div>
                <div class="form-group "><label class="col-sm-3 control-label text-right">提成点:</label>
                    <div class="col-sm-4">
                    <input class="form-control" id="points" name="businessInfo.points" value="<s:property value="businessInfo.points"/>"  onkeyup="clearNoNum(this)"/>
                    <div class="col-sm-5" class="form-control">例如：10.12</div>
                    </div>
                </div>

                <div class="form-actions text-right">
                    <input type="button" value="取消" class="btn btn-danger" onclick="resetBusiness()">
                    <input type="button" value="保  存" class="btn btn-primary" onclick="return check()">
                </div>
            </div>
    </form>
</div>
<!-- Footer -->
<s:include value="/pages/admin/common/footer.jsp"></s:include>
<!-- /Footer -->
<style type="text/css">
 .ui-datepicker { width: 17em; padding: .2em .2em 0; font-size: 15px;}  /*覆盖了jquery-ui-1.8.13.custom.css中的.ui-datepicker，用于调整大小*/
 
 </style>
<script>

function clearNoNum(obj){   
	obj.value = obj.value.replace(/[^\d.]/g,"");  //清除“数字”和“.”以外的字符
	obj.value = obj.value.replace(/^\./g,"");  //验证第一个字符是数字而不是.
	obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的.
	obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
}

function check(){
	if (!checkObjIsNull($("#name"))) {
		top.dialog_alert("请输入商家名称。");
		return false;
	}
	
	if (!checkObjMinLength($("#name"), 4) || !checkObjLength($("#name"), 40)){
		top.dialog_alert("商家名称长度为2~20个字。");
		return false;
	}
	
	if (!checkObjIsNull($("#businessName"))) {
		top.dialog_alert("请输入企业名称。");
		return false;
	}
    
	if (!checkObjMinLength($("#businessName"), 4) || !checkObjLength($("#businessName"), 40)){
		top.dialog_alert("企业名称长度为2~20个字。");
		return false;
	}
	
	if (checkObjIsNull($("#licence_number"))) {
		if (!checkObjMinLength($("#licence_number"), 2) || !checkObjLength($("#licence_number"), 50)){
			top.dialog_alert("营业执照注册号长度为2~50。");
			return false;
		}
	}
	
	if (checkObjIsNull($("#licence_address"))) {
		if (!checkObjMinLength($("#licence_address"), 4) || !checkObjLength($("#licence_address"), 20)){
			top.dialog_alert("营业执照所在地长度为2~20个字。");
			return false;
		}
	}
	
	if (!checkObjIsNull($("#centerPoint"))) {
		top.dialog_alert("请输入营业地址。");
		return false;
	}
	
	if(!checkObjLength($("#centerPoint"), 200)){
		top.dialog_alert("营业地址不能超过100个字。");
		return false;
	}
	
	if(!checkObjIsNull($("#longitude")) || $("#longitude").val() == 0){
		top.dialog_alert("请对营业地址进行定位。");
		return false;
	}
	
	if(!checkObjIsNull($("#telphone"))) {
		top.dialog_alert("请输入联系电话。");
		return false;
	}
	
	if (checkTel($("#telphone").val()) == 0)
	{
		top.dialog_alert("请输入正确的联系电话。");
		return false;
	}
	
	if(!checkObjIsNull($("#mobilephone"))) {
		top.dialog_alert("请输入手机号码。");
		return false;
	}
	
	if(!checkMobile($("#mobilephone"))) {
		top.dialog_alert("请输入正确的手机号码。");
		return false;
	}

	if (checkObjIsNull($("#bank_name"))) {
		if (!checkObjMinLength($("#bank_name"), 4) || !checkObjLength($("#bank_name"), 100)){
			top.dialog_alert("对公开户银行名称长度为2~50个字。");
			return false;
		}
	}
	
	if (checkObjIsNull($("#bank_address"))) {
		if (!checkObjMinLength($("#bank_address"), 4) || !checkObjLength($("#bank_address"), 100)){
			top.dialog_alert("开户行所在地址长度为2~50个字。");
			return false;
		}
	}
	
	if (checkObjIsNull($("#bank_branch_name"))) {
		if (!checkObjMinLength($("#bank_branch_name"), 4) || !checkObjLength($("#bank_branch_name"), 100)){
			top.dialog_alert("开户银行支行名称长度为2~50个字。");
			return false;
		}
	}
	
	if (checkObjIsNull($("#bank_account_number"))) {
		if (!checkObjMinLength($("#bank_account_number"), 2) || !checkObjLength($("#bank_account_number"), 50)){
			top.dialog_alert("公司对公账号银行卡号长度为2~50。");
			return false;
		}
	}
	
	//to-do 校验银行卡号
	
	if (checkObjIsNull($("#legal_person_name"))) {
		if (!checkObjMinLength($("#legal_person_name"), 4) || !checkObjLength($("#legal_person_name"), 20)){
			top.dialog_alert("法人代表真实姓名长度为2~10个字。");
			return false;
		}
	}
	
	if (checkObjIsNull($("#legal_person_phone"))) {
		if (!checkObjMinLength($("#legal_person_phone"), 6) || !checkObjLength($("#legal_person_phone"), 20)){
			top.dialog_alert("法人代表联系电话长度为6~20。");
			return false;
		}
		
		if (checkTel($("#legal_person_phone").val()) == 0)
		{
			top.dialog_alert("请输入正确的法人代表联系电话。");
			return false;
		}
	}
	
	if (checkObjIsNull($("#legal_no"))) {
		if (!checkObjMinLength($("#legal_no"), 10) || !checkObjLength($("#legal_no"), 30)){
			top.dialog_alert("法人代表身份号码长度为10~30。");
			return false;
		}
	}
	
	 if($("input[name='time_type']:checked").val()==0){
     //alert(0);
    if (!checkTime($("#startDate"), $("#endDate"))) {
			return false;
		}
		
   }else if($("input[name='time_type']:checked").val()==1){
    // alert(1);
     if (!checkTime($("#startDateAm"), $("#endDateAm")) || !checkTime($("#startDatePm"), $("#endDatePm"))) {
			return false;
		}
		
   }

       var start_time = $("#startDate").val();
		var end_time = $("#endDate").val();
		var start_time_am = $("#startDateAm").val();
		var end_time_am = $("#endDateAm").val();
		var start_time_pm = $("#startDatePm").val();
		var end_time_pm = $("#endDatePm").val();
	
	$("#start_time").val(start_time);
	$("#end_time").val(end_time);
	$("#start_time_am").val(start_time_am);
	$("#end_time_am").val(end_time_am);
	$("#start_time_pm").val(start_time_pm);
	$("#end_time_pm").val(end_time_pm);
	
	if (checkObjIsNull($("#business_des"))) {
		if (!checkObjMinLength($("#business_des"), 2) || !checkObjLength($("#business_des"), 200)){
			top.dialog_alert("商家介绍长度为1~100个字。");
			return false;
		}
	}
	
	if (checkObjIsNull($("#business_notice"))) {
		if (!checkObjMinLength($("#business_notice"), 2) || !checkObjLength($("#business_notice"), 200)){
			top.dialog_alert("商家公告长度为1~100个字。");
			return false;
		}
	}
	
	if (checkObjIsNull($("#points"))) {
		var points = $("#points").val();
		if (checkObjIsNumOrDecimals($("#points"))) {
			if (points >= 99.99 || points < 0) {
				top.dialog_alert("提成点的范围在0-99.99之间。");
				return false;
			}
		} else {
			top.dialog_alert("请输入正确格式的提成点。");
			return false;
		}
	}
	
    var fileName = $("#licence_scan_file").val();
    var fileName2 = $("#id_card_zheng_file").val();
    var fileName3 = $("#id_card_fan_file").val();
    var fileName4 = $("#business_logo_file").val();
    	
	if (fileName != '') {
		fileName = fileName.toLowerCase();
		var patten = /(.jpg|.png|.gif)$/;
		if (fileName.search(patten) <= -1) {
			top.dialog_alert("请上传 jpeg/gif/png 格式的营业执照扫描文件。");
			return false;
		}
	}
    
    if (fileName2 != '') {
		fileName2 = fileName2.toLowerCase();
		var patten = /(.jpg|.png|.gif)$/;
		if (fileName2.search(patten) <= -1) {
			top.dialog_alert("请上传 jpeg/gif/png 格式的身份证（正面）文件。");
			return false;
		}
	}
	if (fileName3 != '') {
		fileName3 = fileName3.toLowerCase();
		var patten = /(.jpg|.png|.gif)$/;
		if (fileName3.search(patten) <= -1) {
			top.dialog_alert("请上传 jpeg/gif/png 格式的身份证（反面）文件。");
			return false;
		}
	}
	if (fileName4 != '') {
		fileName4 = fileName4.toLowerCase();
		var patten = /(.jpg|.png|.gif)$/;
		if (fileName4.search(patten) <= -1) {
			top.dialog_alert("请上传 jpeg/gif/png 格式的商家Logo文件");
			return false;
		}
	}
	
	//检查商户名称是否重复
	var businessName = trim($("#businessName").val());
	var businessid=trim($("#businessid").val());
	var param = {"businessInfo.id":businessid,"businessInfo.name":businessName};
	var act = "<s:url value='/admin/checkBusinessName.do' includeParams='none'/>";
    $.ajax({
		type:"post",
		url:act,
		data:param,
		cache:false,
		success: function(msg) {
			if(msg == "noexist"){
				clearDialogData();
				$('#businessForm').submit();
        	} else {
        		top.dialog_alert(msg);
        	}
        }
	});
}

//提示信息
$(function(){
	var message = "<s:property value='message'/>";
	if(message != null && message != ""){
		top.dialog_alert(message);
	}

	$('.uploader').each(function(){
        var uploadItem = $(this);
        uploadItem.find('input').on('change',function(){
            var file = uploadItem.find('input').val()
            uploadItem.find('.filename').text(file)
        })
    })
});

function resetBusiness() {
	location.href='<s:url value="/admin/businessList.do" includeParams="none"/>';
}

function previewAdPicture(adUrl) {
	var url = '<s:url value="/"/>' + adUrl;
	top.dialog_open(url, {
		id : 'adPic',
		esc : false,
		lock : true,
		title : '商家相关图片预览',
		width : '1000px',
		height : '500px'
	}, false);
}

/**
 * 检查输入对像是否为数字或小数,供JS使用
 * 
 * @param {}
 *            obj 要检查的对像
 * @return {Boolean}
 */
function checkObjIsNumOrDecimals(obj)
{
	var re = /^-?[1-9]+(\.\d+)?$|^-?0(\.\d+)?$|^-?[1-9]+[0-9]*(\.\d+)?$/;
	if (!re.test(obj.val())) {
		return false;
	}
	return true;
}
 
function timeCompare(starttime, endtime) {
	var startArr = starttime.split(":");
	var startNum = parseInt(startArr[0], 10) * 60 + parseInt(startArr[1], 10);
	var endArr = endtime.split(":");
	var endNum = parseInt(endArr[0], 10) * 60 + parseInt(endArr[1], 10);
 
	return endNum > startNum;
}

//判断营业开始时间和结束时间
function checkTime(startObj, endObj) {
	var start = trim(startObj.val());
	var end = trim(endObj.val());
	
	var startArr = start.split(":");
	if (startArr.length != 2) {
		top.dialog_alert("开始时间格式不对。");
		return false;
	}		
	var startH = parseInt(startArr[0]);
	var startM = parseInt(startArr[1]);
	if (startH > 23 || startH < 0) {
		top.dialog_alert("开始时间格式不对。");
		return false;
	}
	if (startM > 59 || startM < 0) {
		top.dialog_alert("开始时间格式不对。");
		return false;
	}
	
	var endArr = end.split(":");
	if (endArr.length != 2) {
		top.dialog_alert("结束时间格式不对。");
		return false;
	}		
	var endH = parseInt(endArr[0]);
	var endM = parseInt(endArr[1]);
	if (endH > 23 || endH < 0) {
		top.dialog_alert("结束时间格式不对。");
		return false;
	}
	if (endM > 59 || endM < 0) {
		top.dialog_alert("结束时间格式不对。");
		return false;
	}
	
	if (startH > endH) {
		top.dialog_alert("开始时间不能早于结束时间。");
		return false;
	} else if (startH == endH && startM >= endM){
		top.dialog_alert("开始时间不能早于结束时间。");
		return false;
	}
	return true;
}
</script>
</body>
</html>