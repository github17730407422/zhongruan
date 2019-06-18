<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE></TITLE>
		<META http-equiv=Content-Type content="text/html; charset=UTF-8">
	</HEAD>
	<BODY>
		<h3 style="color:#2366A8;padding-top:50px;text-align:center;font:宋体">操作错误</h3>
		<div style="color:#000;text-align:center;font-size:16px;padding-top:20px">
		您没有权限进行操作，请联系统管理员给您设置相应权限！<a style="color:blue" href="<s:url value="/admin/parent_index.do" includeParams='none'/>"> >>返回</a>
		</div>
	</BODY>
</HTML>