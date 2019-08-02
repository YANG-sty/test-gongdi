<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ page  contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="law.jsp"%>
<%
    String  id=request.getParameter("id");
    ShangpinService shangpinSrv=BeansUtil.getBean("shangpinService", ShangpinService.class);
    if( id!=null)
    {
     
      Shangpin temobjshangpin=shangpinSrv.load(" where id="+ id);
      request.setAttribute("shangpin",temobjshangpin);
    }
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
 <head>
  <title>材料信息查看</title>
    <link href="${pageContext.request.contextPath}/admin/css/web2table.css" rel="stylesheet" type="text/css" />
   
    <link href="${pageContext.request.contextPath}/admin/css/menu.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/jquery/jquery-1.9.0.js"></script>
</head>
<body >
	<div class="search-title">
		<h2>材料查看</h2>
		<div class="description"></div>
	</div>
	<table cellpadding="0" cellspacing="1" class="grid" width="100%">
		<tr>
			<td align="right">材料名称:</td>
			<td>${requestScope.shangpin.spname}</td>
			<td colspan="2" rowspan="6"><img id="imgTupian" width="200px"
				height="200px" src="${requestScope.shangpin.tupian}" /></td>
		</tr>
		<tr>
			<td align="right">材料编码:</td>
			<td>${requestScope.shangpin.spno}</td>
		</tr>
		<tr>
			<td align="right">材料分类:</td>
			<td>${requestScope.shangpin.spcategory}</td>
		</tr>
		
		<tr>
			<td align="right">价格:</td>
			<td>${requestScope.shangpin.price}元</td>
		</tr>
		
		

		<tr>
			<td align="right">库存:</td>
			<td>${requestScope.shangpin.kucun}${requestScope.shangpin.danwei}</td>
		</tr>
		
		<tr>
			<td width="10%" align="right">品牌:</td>
			<td>${requestScope.shangpin.pinpai}</td>
         </tr>
         <tr>
			<td width="10%" align="right">产地:</td>
			<td>${requestScope.shangpin.xinghao}</td>
		</tr>
		<tr>
			<td align="right">介绍:</td>
			<td colspan="3">${requestScope.shangpin.des}</td>
		</tr>
	</table>
</body>
</html>
