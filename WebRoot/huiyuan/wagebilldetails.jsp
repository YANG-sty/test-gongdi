<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ page  contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="law.jsp"%>
<%
    String  id=request.getParameter("id");
    WagebillService wagebillSrv=BeansUtil.getBean("wagebillService", WagebillService.class);
    if( id!=null){
         Wagebill temobjwagebill=wagebillSrv.load(" where id="+ id);
         request.setAttribute("wagebill",temobjwagebill);
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
 <head>
  <title>工资单信息查看</title>
  <script type="text/javascript" src="${pageContext.request.contextPath}/webui/jquery/jquery-1.8.3.min.js"></script>
    <link href="${pageContext.request.contextPath}/webui/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/webui/bootstrap/css/bootstrap-responsive.css" rel="stylesheet" type="text/css" />
    <script src="${pageContext.request.contextPath}/webui/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
     <link href="${pageContext.request.contextPath}/admin/css/web2table.css" rel="stylesheet" type="text/css" />
</head>
<body >
		<div class="search-title">
		<h2>工资账单</h2>
		<div class="description"></div>
	</div>

	<table  class="grid" cellspacing="1" width="100%">
		<tr>
			<td width="10%" align="right">姓名:</td>
			<td>${requestScope.wagebill.zgname}</td>
		</tr>
		<tr>
			<td width="10%" align="right">工号:</td>
			<td>${requestScope.wagebill.accountname}</td>
		</tr>
		<tr>
			<td width="10%" align="right">年度:</td>
			<td>${requestScope.wagebill.nianyue}</td>
		</tr>
		<tr>
			<td width="10%" align="right">基本工资:</td>
			<td>${requestScope.wagebill.basicwage}元/天</td>
		</tr>
		<tr>
			<td width="10%" align="right">工作天数:</td>
			<td>${requestScope.wagebill.workdays}天</td>
		</tr>
		<tr>
			<td width="10%" align="right">总工资:</td>
			<td>${requestScope.wagebill.totalwage}</td>
		</tr>
		<tr>
			<td align="right">出单时间:</td>
			<td><fmt:formatDate value="${requestScope.wagebill.createtime}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
		</tr>
		<tr>
			<td width="10%" align="right">出单人:</td>
			<td>${requestScope.wagebill.creator}</td>
		</tr>
		
	</table>
</body>
</html>
