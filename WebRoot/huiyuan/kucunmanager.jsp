<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ include file="law.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="daowen" uri="/daowenpager"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>材料信息</title>
    <link href="${pageContext.request.contextPath}/admin/css/web2table.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/admin/css/layout.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/admin/css/menu.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/jquery/jquery-1.9.0.js"></script>
     <link href="${pageContext.request.contextPath}/webui/artDialog/skins/default.css" rel="stylesheet" type="text/css" />
    <script src="${pageContext.request.contextPath}/webui/artDialog/jquery.artDialog.source.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/webui/artDialog/iframeTools.source.js" type="text/javascript"></script>
    <link href="${pageContext.request.contextPath}/webui/treetable/skin/jquery.treetable.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/webui/treetable/skin/jquery.treetable.theme.default.css" rel="stylesheet"
        type="text/css" />
    <script src="${pageContext.request.contextPath}/webui/treetable/js/jquery.treetable.js" type="text/javascript"></script>
		<script type="text/javascript">
			$(function() {
			   
			});
       </script>
	</head>
<body>
	<div class="search-title">
		<h2>材料采购</h2>
		<div class="description">
			
		</div>
	</div>
	<!-- 搜索控件开始 -->
	<div class="search-options">
		<form id="searchForm"
			action="${pageContext.request.contextPath}/admin/shangpinmanager.do"
			method="post">
			<table cellspacing="0" width="100%">
				<tbody>
					<tr>
						<td>材料名称 <input name="spname" value="${spname}"
							class="input-txt" type="text" id="spname" />
							
							 <input
							    type="hidden" name="actiontype" value="search" />
							<input
							    type="hidden" name="hyid" value="${huiyuan.id}" />
							
							 <input
							type="hidden" name="forwardurl" value="/huiyuan/kucunmanager.jsp" />
							<div class="ui-button">
								<input type="submit" value="搜索" id="btnSearch"
									class="ui-button-text" />
							</div></td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<!-- 搜索控件结束 -->
	<div class="clear"></div>
	
	<table id="module" width="100%" border="0" cellspacing="0"
		cellpadding="0" class="ui-record-table">
		<thead>
			<tr>
				
				<th><b>材料名</b></th>
				<th><b>材料编码</b></th>
				<th><b>材料分类</b></th>
				<th><b>库存</b></th>

				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${listshangpin== null || fn:length(listshangpin) == 0}">
				<tr>
					<td colspan="20">没有相关材料信息</td>
				</tr>
			</c:if>
			<%	
									if(request.getAttribute("listshangpin")!=null)
								      {
									  List<Shangpin> listshangpin=( List<Shangpin>)request.getAttribute("listshangpin");
								     for(Shangpin  temshangpin  :  listshangpin)
								      {
							%>
			<tr>
				
				<td width="300px;"><%=temshangpin.getSpname()%></td>
				<td><%=temshangpin.getSpno()%></td>
				<td><%=temshangpin.getSpcategory()%></td>
				<td><span class="weight14font"><%=temshangpin.getKucun()%></span><%=temshangpin.getDanwei() %></td>

				<td>
				   
				     <a class="orange-href"
					    href="${pageContext.request.contextPath}/huiyuan/caigouadd.jsp?id=<%=temshangpin.getId()%>">采购</a>
				   
					
				</td>
			</tr>
			<%}}%>
		</tbody>
	</table>
	<div class="clear"></div>
	<daowen:pager id="pager1" attcheform="searchForm" />
</body>
</html>
