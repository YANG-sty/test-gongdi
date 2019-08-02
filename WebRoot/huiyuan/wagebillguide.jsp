<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ include file="law.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="daowen" uri="/daowenpager"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>员工信息</title>
       <script src="${pageContext.request.contextPath}/webui/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
    <link href="${pageContext.request.contextPath}/webui/artDialog/skins/default.css" rel="stylesheet" type="text/css" />
    <script src="${pageContext.request.contextPath}/webui/artDialog/jquery.artDialog.source.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/webui/artDialog/iframeTools.source.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/webui/combo/combo.js"
			type="text/javascript"></script>
    
    <link href="${pageContext.request.contextPath}/admin/css/web2table.css" rel="stylesheet" type="text/css" />
	</head>
	 <body >
	<div class="search-title">
		<h2>工资账单出账</h2>
		<div class="description">
			
		</div>
	</div>
	<!-- 搜索控件开始 -->
	<div class="search-options">
		<form id="searchForm"
			action="${pageContext.request.contextPath}/admin/zhiyuanmanager.do"
			method="post">
			<table cellspacing="0" width="100%">
				<tbody>
					<tr>
						<td>姓名<input name="name" value="${name}"
							class="input-txt" type="text" id="accountname" /> <input
							type="hidden" name="actiontype" value="search" /> <input
							type="hidden" name="state" value="1" /> <input
							type="hidden" name="forwardurl" value="/huiyuan/wagebillguide.jsp" />
							<button class="orange-button">
								<i class="icon-search icon-white"></i>搜索
							</button></td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<!-- 搜索控件结束 -->
	<div class="clear"></div>
	<div class="picture-box2">
		<ul>
			<%	
									if(request.getAttribute("listzhiyuan")!=null)
								      {
									  List<Zhiyuan> listzhiyuan=( List<Zhiyuan>)request.getAttribute("listzhiyuan");
								     for(Zhiyuan  temzhiyuan  :  listzhiyuan)
								      {
						        %>
			<li><img width="180" height="180"
				src="<%= temzhiyuan.getPhoto()%>" /> <span> <%= temzhiyuan.getName()%></span>
				<div style="text-align:center;">
					<a class="orange-href"
						href="${pageContext.request.contextPath}/admin/wagebillmanager.do?actiontype=load&zyid=<%= temzhiyuan.getId()%>&forwardurl=/huiyuan/wagebilladd.jsp">
						出工资单 
					 </a>
				</div>
			 </li>
			<%}}%>
			</li>
		</ul>
	</div>
	<!--end  picture-box-->
	<div class="clear"></div>
	<daowen:pager id="pager1" attcheform="searchForm" />
</body>
</html>
