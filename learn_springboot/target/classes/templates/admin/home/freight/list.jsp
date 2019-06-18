<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/pages/admin/common/admin_meta.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>易食客后台管理系统</title>
</head>
<body class="sub-page">
    <div class="page-header">
        <div class="page-title">
            <h3>运费定制</h3>
        </div>
    </div>
    <div class="breadcrumb-line">
        <ul class="breadcrumb">
            <li>
                <a class="active">运费定制</a>
            </li>
        </ul>
    </div>
    <div class="block s-form">
        <form class="form-horizontal" id="configurationForm"
            action="<s:url value="/admin/configurationUpdate.do" includeParams='none'/>"
            role="form" method="post">
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="form-group">
                        <label class="col-sm-2 control-label text-right">配送距离区间1:&nbsp;</label>
                        <input type="hidden" id="price_1_start" name="price_1_start" value="0">
                        <label >零</label>
                        &nbsp;公里至 <input type="text" id="price_1_end" name="price_1_end" value="<s:property value="%{getFreightValue(EXPRESS_PRICE_1, 1)}" />" onblur="javascript:changeStart(1);">
                                公里&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                配送费用:&nbsp;&nbsp;
                        <input type="text" id="price_1_value" name="price_1_value" value="<s:property value="%{getFreightValue(EXPRESS_PRICE_1, 2)}" />">&nbsp;元 &nbsp;（例如：10.00元）
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label text-right"> 配送距离区间2:&nbsp; </label>
                        <label id="price_2_start" name="price_2_start">
                            <s:property value="%{getFreightValue(EXPRESS_PRICE_2, 0)}" />
                        </label>
                        &nbsp;公里至
                        <input type="text" id="price_2_end" name="price_2_end" value="<s:property value="%{getFreightValue(EXPRESS_PRICE_2, 1)}" />" onblur="javascript:changeStart(2);">
                            公里&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            配送费用:&nbsp;&nbsp;
                        <input type="text" id="price_2_value" name="price_2_value" value="<s:property value="%{getFreightValue(EXPRESS_PRICE_2, 2)}" />">&nbsp;元  &nbsp;（例如：10.00元）
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label text-right">配送距离区间3:&nbsp;</label>
                        <label id="price_3_start" name="price_3_start">
                            <s:property value="%{getFreightValue(EXPRESS_PRICE_3, 0)}" />
                        </label>
                        &nbsp;公里至
                        <input type="text" id="price_3_end" name="price_3_end" value="<s:property value="%{getFreightValue(EXPRESS_PRICE_3, 1)}" />" onblur="javascript:changeStart(3);">
                            公里&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            配送费用:&nbsp;&nbsp;
                        <input type="text" id="price_3_value" name="price_3_value" value="<s:property value="%{getFreightValue(EXPRESS_PRICE_3, 2)}" />">&nbsp;元  &nbsp;（例如：10.00元）
                    </div>
                    
                    <div class="form-group">&nbsp;&nbsp;&nbsp;&nbsp;<font color="red" id="errorMsg"></font></div>

                    <div class="form-actions text-right">
                        <input type="button" value="取  消" id="cancelButton" name="cancelButton" 
                            class="btn btn-danger"
                            onclick="resetConfiguration()">
                            <input type="button" value="保  存"
                                class="btn btn-primary"
                                onclick="submitConfiguration()">
                    </div>
                </div>
            </div>
        </form>
    </div>

    <!-- Footer -->
    <s:include value="/pages/admin/common/footer.jsp"></s:include>
    <!-- /Footer -->
</body>
<script language=javascript>
$(function() {
	var message = "<s:property value='message'/>";
	if (message != null && message != "") {
		top.dialog_alert(message, function() {
			window.location = "<s:url value='/admin/freightList.do' />";
		});
	}
});

function changeStart(index) {
	if (index == 1) {
		var price1end = js_trim($("#price_1_end").val());
		//top.dialog_alert("price1end: - " + price1end + "-" + isInteger(price1end) + "-" + (parseInt(price1end) <= 0) + "-");
		if (price1end == '' || !isInteger(price1end) || parseInt(price1end) <= 0) {
			document.getElementById("errorMsg").innerHTML = "配送距离为正整数，请输入正确配送区间！";
			return false;
		} else {
			document.getElementById("price_2_start").innerHTML = price1end;
			document.getElementById("errorMsg").innerHTML = "";
		}
	} else if (index == 2) {
		var price2end = js_trim($("#price_2_end").val());
		if (price2end == '' || !isInteger(price2end) || parseInt(price2end) <= 0) {
			document.getElementById("errorMsg").innerHTML = "配送距离为正整数，请输入正确配送区间！";
			return false;
		} else {
			var p2start = parseInt(trim(document.getElementById("price_2_start").innerHTML));
			
			if (price2end <= p2start) {
				document.getElementById("errorMsg").innerHTML = "配送区间结束值应比起始值大，请重新设置。";
				return false;
			} else {
				document.getElementById("price_3_start").innerHTML = price2end;
				document.getElementById("errorMsg").innerHTML = "";
			}
		}
	} else if (index == 3) {
		var price3end = js_trim($("#price_3_end").val());
		if (price3end == '' || !isInteger(price3end) || parseInt(price3end) <= 0) {
			document.getElementById("errorMsg").innerHTML = "配送距离为正整数，请输入正确配送区间！";
			return false;
		} else {
			var p3start = parseInt(trim(document.getElementById("price_3_start").innerHTML));
			
			if (price3end <= p3start) {
				document.getElementById("errorMsg").innerHTML = "配送区间结束值应比起始值大，请重新设置。";
				return false;
			}
		}
	}
}

function submitConfiguration() {
	var p1start = 0;
	var p1end = trim($("#price_1_end").val());
	var p1value = trim($("#price_1_value").val());
	var p2start = trim(document.getElementById("price_2_start").innerHTML);
	var p2end = trim($("#price_2_end").val());
	var p2value = trim($("#price_2_value").val());
	var p3start = trim(document.getElementById("price_3_start").innerHTML);
	var p3end = trim($("#price_3_end").val());
	var p3value = trim($("#price_3_value").val());

	if (js_trim(p1start) == '' || js_trim(p1end) == ''
			|| js_trim(p2start) == '' || js_trim(p2end) == ''
			|| js_trim(p3start) == '' || js_trim(p3end) == '') {
		document.getElementById("errorMsg").innerHTML = "请设置配送距离区间的终止值。";
		return false;
	}

	if (!isInteger(p1end) || parseInt(p1end) <= 0 || !isInteger(p2end) || parseInt(p2end) <= 0 || !isInteger(p3end) || parseInt(p3end) <= 0) {
		document.getElementById("errorMsg").innerHTML = "配送距离区间的终止值必须为正整数格式。";
		return false;
	}

	p1end = parseInt(p1end);
	p2end = parseInt(p2end);
	p3end = parseInt(p3end);

	if (p1end >= p2end || p2end >= p3end) {
		document.getElementById("errorMsg").innerHTML = "配送区间结束值应比起始值大，请重新设置。";
		return false;
	}

	if (p3end > 80) {
		document.getElementById("errorMsg").innerHTML = "配送范围最大不能超过80公里。";
		return false;
	}

	if (js_trim(p1value) == '' || js_trim(p2value) == ''
			|| js_trim(p3value) == '') {
		document.getElementById("errorMsg").innerHTML = "请输入各配送距离区间对应的配送费用。";
		return false;
	}

	if (p1value < 0 || p2value < 0 || p3value < 0
			|| !isMoney(p1value)
			|| !isMoney(p2value)
			|| !isMoney(p3value)) {
		document.getElementById("errorMsg").innerHTML = "请输入正确的配送费用！";
		return false;
	}

	var p1 = p1start + "-" + p1end + "-" + roundNumber(p1value, 2);
	var p2 = p2start + "-" + p2end + "-" + roundNumber(p2value, 2);
	var p3 = p3start + "-" + p3end + "-" + roundNumber(p3value, 2);

	var param = {
		"PRICE_1" : p1,
		"PRICE_2" : p2,
		"PRICE_3" : p3
	};
	var act = "<s:url value='/admin/freightUpdate.do' includeParams='none'/>";
	$.ajax({
		type : "post",
		url : act,
		data : param,
		cache : false,
		success : function(msg) {
			if (msg == "success") {
				top.dialog_alert("运费定制成功！");
				resetConfiguration();
			} else {
				top.dialog_alert(msg);
			}
		}
	});
}

function resetConfiguration() {
	location.href = '<s:url value="/admin/freightList.do" includeParams="none"/>';
}

function isMoney(s) {
	if (s.indexOf(".") == -1) {
		return isInteger(s);
	} else {
		if (s.length - s.indexOf(".") == 1) {
			s = s + "0";
		}
		var regu = "^[0-9]+[\.][0-9]{0,2}$";
		var re = new RegExp(regu);
		if (re.test(s)) {
			return true;
		} else {
			return false;
		}
	}
}

function isInteger(s) { 
	var regu = /^[-]{0,1}[0-9]{1,}$/;
	return regu.test(s);
}
</script>
</html>