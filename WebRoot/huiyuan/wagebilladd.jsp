<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="web" uri="/WEB-INF/webcontrol.tld"%>
<%@ include file="law.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
 <head>
  <title>工资单</title>
   <script type="text/javascript" src="${pageContext.request.contextPath}/webui/jquery/jquery-1.8.3.min.js"></script>
     <link href="${pageContext.request.contextPath}/webui/artDialog/skins/default.css" rel="stylesheet" type="text/css" />
    <script src="${pageContext.request.contextPath}/webui/artDialog/jquery.artDialog.source.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/webui/artDialog/iframeTools.source.js" type="text/javascript"></script>
    <script  type="text/javascript" src="${pageContext.request.contextPath}/webui/jquery/jquery.validate.min.js"></script>
    <script type="text/javascript"  src="${pageContext.request.contextPath}/webui/jquery/jquery.validateex.js" ></script>
    <script type="text/javascript"  src="${pageContext.request.contextPath}/webui/jquery/jquery.metadata.js" ></script>
    <script type="text/javascript"  src="${pageContext.request.contextPath}/webui/jquery/messages_cn.js" ></script>
     <link href="${pageContext.request.contextPath}/webui/easydropdown/themes/easydropdown.css" rel="stylesheet" type="text/css" />
    <script src="${pageContext.request.contextPath}/webui/easydropdown/jquery.easydropdown.js" type="text/javascript"></script>
    <link href="${pageContext.request.contextPath}/uploadifyv3.1/uploadify.css" rel="stylesheet" type="text/css" />
    <script src="${pageContext.request.contextPath}/uploadifyv3.1/jquery.uploadify-3.1.js" type="text/javascript"></script>
    <script type="text/javascript"  src="${pageContext.request.contextPath}/webui/jquery-form/jquery.form.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/editor/kindeditor-min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/editor/lang/zh_CN.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webui/jqueryui/themes/base/jquery.ui.all.css" type="text/css"></link>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/jqueryui/ui/jquery-ui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/jqueryui/ui/i18n/jquery.ui.datepicker-zh-CN.js"></script>
    <script src="${pageContext.request.contextPath}/webui/jqueryui/ui/jquery-ui-timepicker-addon.js" type="text/javascript"></script>
    <link href="${pageContext.request.contextPath}/webui/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/webui/bootstrap/css/bootstrap-responsive.css" rel="stylesheet" type="text/css" />
    <script src="${pageContext.request.contextPath}/webui/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
     <link href="${pageContext.request.contextPath}/admin/css/web2table.css" rel="stylesheet" type="text/css" />
   <script type="text/javascript">
        function initControl(){
	$("#txtCreatetime").datepicker({
                         dateFormat:'yy-mm-dd'
                      }).datepicker("setDate",new Date());
        }
        $(function ()
        {
            initControl();
            $.metadata.setType("attr","validate");
            $("#wagebillForm").validate();
        });  
    </script>
</head>
<body>
	<div class="search-title">
		<h2>工资出账</h2>
		<div class="description"></div>
	</div>

	<form name="wagebillform" method="post" action="${pageContext.request.contextPath}/admin/wagebillmanager.do" id="wagebillForm">
		<table class="grid" cellspacing="1" width="100%">
			<input type="hidden" name="id" value="${id}" />
			<input type="hidden" name="accountname" value="${requestScope.operzhiyuan.accountname}" />
			<input type="hidden" name="zgname" value="${requestScope.operzhiyuan.name}" />
			<input type="hidden" name="actiontype" value="${actiontype}" />
			<input type="hidden" name="hyid" value="${huiyuan.id}" />
			<input type="hidden" name="errorurl" value="/huiyuan/wagebilladd.jsp?zyid=${requestScope.operzhiyuan.id}" />
			<input name="creator" placeholder="出单人" validate="{required:true,messages:{required:'请输入出单人'}}" value="${huiyuan.accountname}" class="input-txt" type="hidden" id="txtCreator" />
			<input type="hidden" name="forwardurl" value="/admin/wagebillmanager.do?actiontype=get&hyid=${huiyuan.id}&forwardurl=/huiyuan/wagebillmanager.jsp" />
			<tr>
				<td colspan="4">${errormsg}</td>
			</tr>

			<tr>
				<td align="right">姓名:</td>
				<td>${requestScope.operzhiyuan.name}</td>
				<td colspan="2" rowspan="5">
					<img src="${requestScope.operzhiyuan.photo}" width="200" height="200" />
				</td>

			</tr>
			<tr>
				<td align="right">工号:</td>
				<td>${requestScope.operzhiyuan.accountname }</td>
			</tr>
			<tr>
				<td align="right">性别:</td>
				<td>${requestScope.operzhiyuan.sex }</td>
			</tr>
			<tr>
				<td align="right">年度:</td>


				<td>

					<select class="dropdown" name="niandu">

						<option value="2019">2019年度</option>
						<option value="2020">2020年度</option>

					</select>
				</td>
			</tr>
			<tr>
				<td align="right">月份:</td>
				<td>

					<select class="dropdown" name="yuefen">
						<option value="01">1月份</option>
						<option value="02">2月份</option>
						<option value="03">3月份</option>
						<option value="04">4月份</option>
						<option value="05">5月份</option>
						<option value="06">6月份</option>
						<option value="07">7月份</option>
						<option value="08">8月份</option>
						<option value="09">9月份</option>
						<option value="10">10月份</option>
						<option value="11">11月份</option>
						<option value="12">12月份</option>
					</select>

				</td>
			</tr>

			<tr>
				<td align="right">工作天数:</td>
				<td>
					<input name="workdays" placeholder="工作天数" validate="{required:true,digits:true,min:1,max:31,messages:{required:'请设置员工工作天数',digits:'请输入正确的工作天数'}}" value="${requestScope.salaryness.workdays}" class="input-txt" type="text" />
				</td>

			</tr>

			<tr>
				<td colspan="4">

					<button class="orange-button">
						<i class="icon-ok icon-white"></i>
						提交
					</button>
				</td>
			</tr>
		</table>
	</form>

</body>
</html>
