<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ page  contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="law.jsp"%>
<%
    String  id=request.getParameter("id");
    HuiyuanService huiyuanSrv=BeansUtil.getBean("huiyuanService", HuiyuanService.class);
    if( id!=null)
    { 
      Huiyuan temobjhuiyuan=huiyuanSrv.load(" where id="+ id);
      request.setAttribute("huiyuan",temobjhuiyuan);
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
 <head>
  <title>会员管理信息查看</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/jquery/jquery-1.8.3.min.js"></script>
     <link href="${pageContext.request.contextPath}/admin/css/web2table.css" rel="stylesheet" type="text/css" />
</head>
<body >
	<div class="search-title">
		<h2>查看会员</h2>
		<div class="description"></div>
	</div>
	<table cellpadding="0" cellspacing="1" class="grid" width="100%">
		<tr>
			<td width="10%" align="right">账户名:</td>
			<td>${requestScope.huiyuan.accountname}</td>
			<td colsapn="2" rowspan="6"><img id="imgPhoto" width="200px" height="200px"
				src="${requestScope.huiyuan.photo}" /></td>
		</tr>
		<tr>
			<td width="10%" align="right">姓名:</td>
			<td>${requestScope.huiyuan.name}</td>
		</tr>
		<tr>
			<td align="right">性别:</td>
			<td>${requestScope.huiyuan.sex}</td>
		</tr>
		<tr>
			<td width="10%" align="right">联系电话:</td>
			<td>${requestScope.huiyuan.tel}</td>
		</tr>
		<tr>
			<td width="10%" align="right">身份证:</td>
			<td>${requestScope.huiyuan.idcardno}</td>
		</tr>
		
		<tr>
			<td width="10%" align="right">籍贯:</td>
			<td>${requestScope.huiyuan.jiguan}</td>
		</tr>
		<tr>
			<td align="right">注册时间:</td>
			<td><fmt:formatDate value="${requestScope.huiyuan.createtime}"
					pattern="yyyy-MM-dd" /></td>
		</tr>
		
		<tr>
			
			
			<td align="right">账户余额:</td>
			<td>${requestScope.huiyuan.yue}元</td>
		
		</tr>
		<tr>
			
			
			<td align="right">出生年月:</td>
			<td><fmt:formatDate value="${requestScope.huiyuan.birthday}"
					pattern="yyyy-MM-dd" /></td>
		
		
			<td width="10%" align="right">家庭住址:</td>
			<td>${requestScope.huiyuan.address}</td>
		</tr>
		
		<tr>
			<td align="right">说明:</td>
			<td colspan="3">${requestScope.huiyuan.des}</td>
		</tr>
	</table>
</body>
</html>
