<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ page  contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="web" uri="/WEB-INF/webcontrol.tld"%>

<%@ include file="law.jsp"%>
<%
    String  id=request.getParameter("id");
    ShangpinService shangpinSrv=BeansUtil.getBean("shangpinService", ShangpinService.class);
    SupplyorService supplyorSrv=BeansUtil.getBean("supplyorService", SupplyorService.class);
    List<Object> supplor_datasource=supplyorSrv.getEntity("");
    request.setAttribute("supplor_datasource",supplor_datasource);
    if( id!=null)
    {
     
      Shangpin temobjshangpin=shangpinSrv.load(" where id="+ id);
      request.setAttribute("shangpin",temobjshangpin);
      
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
 <head>
  <title>仪器信息查看</title>
    <link href="${pageContext.request.contextPath}/admin/css/web2table.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/admin/css/layout.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/admin/css/menu.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/jquery/jquery-1.9.0.js"></script>
     <script  type="text/javascript" src="${pageContext.request.contextPath}/webui/jquery/jquery.validate.min.js"></script>
    <script type="text/javascript"  src="${pageContext.request.contextPath}/webui/jquery/jquery.metadata.js" ></script>
    <script type="text/javascript"  src="${pageContext.request.contextPath}/webui/jquery/messages_cn.js" ></script>
    	    <link href="${pageContext.request.contextPath}/webui/easydropdown/themes/easydropdown.css" rel="stylesheet" type="text/css" />
    <script src="${pageContext.request.contextPath}/webui/easydropdown/jquery.easydropdown.js" type="text/javascript"></script>   
        <link rel="stylesheet" href="${pageContext.request.contextPath}/webui/jqueryui/themes/base/jquery.ui.all.css" type="text/css"></link>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/jqueryui/ui/jquery-ui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/jqueryui/ui/i18n/jquery.ui.datepicker-zh-CN.js"></script>
    <script src="${pageContext.request.contextPath}/webui/jqueryui/ui/jquery-ui-timepicker-addon.js" type="text/javascript"></script>
    <script type="text/javascript">
       $(function(){
    	   $("#txtCgdate").datepicker({
               dateFormat:'yy-mm-dd'
            }).datepicker("setDate",new Date());
    	   $.metadata.setType("attr","validate");
           $("#shangpinForm").validate();
       })
       
       
    </script>
</head>
<body >
	<div class="search-title">
		<h2>采购申请</h2>
		<div class="description"></div>
	</div>

	<form name="caigouform" method="post"
		action="${pageContext.request.contextPath}/admin/caigoumanager.do"
		id="caigouForm">

        
		<input type="hidden" name="spid" value="<%=id%>" /> 
		<input type="hidden" name="spno" value="${shangpin.spno }" />
		<input type="hidden" name="spname" value="${shangpin.spname }" />
		<input type="hidden" name="hyid" value="${huiyuan.id }" />
		
		<input
			type="hidden" name="actiontype" value="save" /> <input
			type="hidden" name="forwardurl"
			value="/admin/caigoumanager.do?actiontype=get&cgren=${huiyuan.accountname}&hyid=${huiyuan.id}&forwardurl=/huiyuan/caigoumanager.jsp" />
		<table cellpadding="0" cellspacing="1" class="grid" width="100%">
			<tr>
				<td align="right">仪器名:</td>
				<td>${requestScope.shangpin.spname}（${requestScope.shangpin.spno}）</td>
				<td colspan="2" rowspan="5"><img id="imgTupian" width="200px"
					height="200px" src="${requestScope.shangpin.tupian}" /></td>
			</tr>

			<tr>
				<td align="right">仪器分类:</td>
				<td>${requestScope.shangpin.spcategory}</td>
			</tr>
			<tr>
				<td align="right">仪器售价:(元)</td>
				<td>${requestScope.shangpin.price}￥</td>
			</tr>

			<tr>
				<td align="right">仪器库存数量:</td>
				<td>
				   <span class="weight14font">${requestScope.shangpin.kucun}
				    </span>
				   ${requestScope.shangpin.danwei}
				   <input type="hidden" name="danwei" value="${shangpin.danwei }"/>
				   </td>
			</tr>
			<tr>
				<td align="right">供应商:</td>
				<td>
				
				<web:dropdownlist name="supplor" id="supplor"
						cssclass="dropdown" value="${requestScope.caigou.supplor}"
						datasource="${supplor_datasource}" textfieldname="name"
						valuefieldname="name">
					</web:dropdownlist> 
				 </td>
			</tr>
			<tr>
				<td align="right">采购数量:</td>
				<td><input name="count" style="width:80px;"
					validate="{required:true,digits:true,messages:{required:'请输入补充库存',digits:'请输入正确库存'}}"
					type="text" class="input-txt" />${requestScope.shangpin.danwei}
					
					 <input type="hidden" name="danwei" value="${shangpin.danwei}"/>
					</td>
			</tr>
			<tr>
				<td align="right">采购日期:</td>
				<td><input name="cgdate" value="${requestScope.caigou.cgdate}"
					type="text" id="txtCgdate" class="input-txt"
					validate="{required:true}" /></td>
			</tr>
			<tr>
				<td align="right">采购人:</td>
				<td><input name="cgren" placeholder="采购人"
					validate="{required:true,messages:{required:'请输入采购人'}}"
					value="${huiyuan.accountname}" class="input-txt" type="text" /></td>
			</tr>
			<tr>
				<td colspan="2">
					
						<input type="submit" value="采购申请" id="Button1"
							class="orange-button" />
					
				</td>
			</tr>



		</table>

	</form>
</body>
</html>
