<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="law.jsp"%>
<%
	String id = request.getParameter("id");
	ConsiteService consiteSrv = BeansUtil.getBean("consiteService",
			ConsiteService.class);
	if (id != null) {
		Consite temobjconsite = consiteSrv.load(" where id=" + id);
		request.setAttribute("consite", temobjconsite);
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>工地信息查看</title>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/webui/jquery/jquery-1.8.3.min.js"></script>
<link href="${pageContext.request.contextPath}/admin/css/web2table.css"
	rel="stylesheet" type="text/css" />
</head>
<body>
	<div class="search-title">
		<h2>查看工地</h2>
		<div class="description"></div>
	</div>
	<table cellpadding="0" cellspacing="1" class="grid" width="100%">
		<tr>
			<td width="10%" align="right">工地编号:</td>
			<td>${requestScope.consite.csno}</td>
		</tr>
		<tr>
			<td width="10%" align="right">工地名称:</td>
			<td>${requestScope.consite.csname}</td>
		</tr>
		<tr>
			<td align="right">图片:</td>
			<td>
				<img id="imgTupian" width="200px" height="200px" src="${requestScope.consite.tupian}" />
			</td>
		</tr>
		<tr>
			<td width="10%" align="right">会员编号:</td>
			<td>${requestScope.consite.hyid}</td>
		</tr>
		<tr>
			<td align="right">开始日期:</td>
			<td>
				<fmt:formatDate value="${requestScope.consite.begindate}" pattern="yyyy-MM-dd" />
			</td>
		</tr>
		<tr>
			<td align="right">项目介绍:</td>
			<td colspan="3">${requestScope.consite.des}</td>
		</tr>
	</table>
</body>
</html>
