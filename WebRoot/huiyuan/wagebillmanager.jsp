<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ include file="law.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="daowen" uri="/daowenpager"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>工资单信息</title>
    <script src="${pageContext.request.contextPath}/webui/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
     <script src="${pageContext.request.contextPath}/webui/jquery/jquery.jqprint-0.3.js"></script>
    <link href="${pageContext.request.contextPath}/webui/artDialog/skins/default.css" rel="stylesheet" type="text/css" />
    <script src="${pageContext.request.contextPath}/webui/artDialog/jquery.artDialog.source.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/webui/artDialog/iframeTools.source.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/webui/combo/combo.js"
			type="text/javascript"></script>
     
    <link href="${pageContext.request.contextPath}/admin/css/web2table.css" rel="stylesheet" type="text/css" />
    
		<script type="text/javascript">
			$(function() {
			    
				$("#btnPrint").click(function () {

	                $("#printView").jqprint();


	            });
				$("#btnDelete").click(function(){
			        if($(".check:checked").length<1)
			        {
			           top.$.dialog.alert("请选择需要删除的记录");
			           return;
			        } 
			        $(".check:checked").each(function(index,domEle){
			             var id=$(domEle).val();
			             top.$.dialog.confirm("你确定要注销工资单信息?", function(){
				             window.location.href=encodeURI('${pageContext.request.contextPath}/admin/wagebillmanager.do?forwardurl=/admin/wagebillmanager.jsp&actiontype=delete&id='+id);
				         });
			        });
			    });
			    $("#btnCheckAll").click(function(){
			           var ischeck=false;
			           $(".check").each(function(){
			               if($(this).is(":checked"))
			               {
			                  $(this).prop("checked","");
			                  ischeck=false;
			                }
			               else
			               {
			                  $(this).prop("checked","true");
			                  ischeck=true;
			                }
			           });
			           if($(this).text()=="选择记录")
			              $(this).text("取消选择");
			           else
			              $(this).text("选择记录");
			    })
			});
       </script>
	</head>
	 <body >
<div class="search-title">
		<h2>工资账单管理</h2>
		<div class="description">
			
		</div>
	</div>
	<!-- 搜索控件开始 -->
	<div class="search-options">
		<form id="searchForm"
			action="${pageContext.request.contextPath}/admin/wagebillmanager.do"
			method="post">
			<table cellspacing="0" width="100%">
				<tbody>
					<tr>
						<td>姓名 <input name="zgname" value="${zgname}"
							class="input-txt" type="text" id="zgname" /> <input
							type="hidden" name="actiontype" value="search" /> <input
							type="hidden" name="hyid" value="${huiyuan.id }" /> <input
							type="hidden" name="forwardurl"
							value="/huiyuan/wagebillmanager.jsp" />
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
	<div class="action-details">
		<a href="#" id="btnCheckAll"
			class="orange-href">选择</a> 
		<a id="btnDelete" class="orange-href"
			href="#"> 删除工资单
		</a>
		<a class="orange-href" href="${pageContext.request.contextPath}/admin/wagebillmanager.do?actiontype=export" >导出Excel</a> 
		 <span id="btnPrint"  class="orange-href" ><i class="fa fa-print"></i>打印</span>
	</div>
	<div id="printView" class="box">
		
		<table id="wagebill" width="100%" border="0" cellspacing="0"
			cellpadding="0" class="ui-record-table">
			<thead>
				<tr>
					<th>选择</th>
					<th><b>姓名</b>
					</th>
					<th><b>工号</b>
					</th>
					<th><b>年度</b>
					</th>
					
					<th><b>工作天数(天)</b>
					</th>
					<th><b>基本工资(元/每天)</b>
					</th>
					
					<th><b>总工资(元)</b>
					</th>
					<th><b>出单时间</b>
					</th>
					
					<th><b>出单人</b>
					</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${listwagebill== null || fn:length(listwagebill) == 0}">
					<tr>
						<td colspan="20">没有相关工资单信息</td>
					</tr>
				</c:if>
				<%	
									if(request.getAttribute("listwagebill")!=null)
								      {
									  List<Wagebill> listwagebill=( List<Wagebill>)request.getAttribute("listwagebill");
								     for(Wagebill  temwagebill  :  listwagebill)
								      {
							%>
				<tr>
					<td>&nbsp<input id="chk<%=temwagebill.getId()%>" class="check"
						name="chk<%=temwagebill.getId()%>" type="checkbox"
						value='<%=temwagebill.getId()%>'>
					</td>
					<td><%=temwagebill.getZgname()%></td>
					<td><%=temwagebill.getAccountname()%></td>
					<td><%=temwagebill.getNianyue()%></td>
					<td><%=temwagebill.getWorkdays()%>天</td>
					<td><%=temwagebill.getBasicwage()%>¥</td>
					<td><%=temwagebill.getTotalwage()%>¥</td>
					<td><%=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(temwagebill.getCreatetime())%></td>
					
					<td><%=temwagebill.getCreator()%></td>
					<td>
					
					  <a class="orange-href"
						href="${pageContext.request.contextPath}/huiyuan/wagebilldetails.jsp?id=<%=temwagebill.getId()%>"><i
							class="icon-zoom-in icon-white"></i>详细</a>
					</td>
				</tr>
				<%}}%>
			</tbody>
		</table>
	</div>
	<!--end box-->
	<div class="clear"></div>
	<daowen:pager id="pager1" attcheform="searchForm" />
</body>
</html>
