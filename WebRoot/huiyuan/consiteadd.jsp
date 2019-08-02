<%@ page language="java" import="java.util.*"
	contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="web" uri="/WEB-INF/webcontrol.tld"%>
<%@ include file="law.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>工地</title>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/webui/jquery/jquery-1.8.3.min.js"></script>
<link
	href="${pageContext.request.contextPath}/webui/artDialog/skins/default.css"
	rel="stylesheet" type="text/css" />
<script
	src="${pageContext.request.contextPath}/webui/artDialog/jquery.artDialog.source.js"
	type="text/javascript"></script>
<script
	src="${pageContext.request.contextPath}/webui/artDialog/iframeTools.source.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/webui/jquery/jquery.validate.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/webui/jquery/jquery.validateex.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/webui/jquery/jquery.metadata.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/webui/jquery/messages_cn.js"></script>
<link
	href="${pageContext.request.contextPath}/webui/easydropdown/themes/easydropdown.css"
	rel="stylesheet" type="text/css" />
<script
	src="${pageContext.request.contextPath}/webui/easydropdown/jquery.easydropdown.js"
	type="text/javascript"></script>
<link
	href="${pageContext.request.contextPath}/uploadifyv3.1/uploadify.css"
	rel="stylesheet" type="text/css" />
<script
	src="${pageContext.request.contextPath}/uploadifyv3.1/jquery.uploadify-3.1.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/editor/kindeditor-min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/editor/lang/zh_CN.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/webui/jqueryui/themes/base/jquery.ui.all.css"
	type="text/css"></link>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/webui/jqueryui/ui/jquery-ui.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/webui/jqueryui/ui/i18n/jquery.ui.datepicker-zh-CN.js"></script>
<script
	src="${pageContext.request.contextPath}/webui/jqueryui/ui/jquery-ui-timepicker-addon.js"
	type="text/javascript"></script>
<link href="${pageContext.request.contextPath}/admin/css/web2table.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript">
	function initControl() {
		$('#btnulTupian')
				.uploadify(
						{
							'formData' : {
								'folder' : '${pageContext.request.contextPath}/Upload'
							},
							'buttonText' : '选择图片',
							'buttonClass' : 'browser',
							'removeCompleted' : true,
							'swf' : '${pageContext.request.contextPath}/uploadifyv3.1/uploadify.swf',
							'fileTypeExts' : "*.jpg;*.gif;*.png;",
							'auto' : true,
							'removeTimeout' : 0,
							'debug' : false,
							'height' : 15,
							'width' : 90,
							'uploader' : '${pageContext.request.contextPath}/admin/uploadmanager.do',
							'fileSizelimit' : '2048KB',
							'queueSizelimit' : '5',
							'onUploadSuccess' : function(file, data, response) {
								$("#filelist").show();
								$("#imgTupian").attr(
										"src",
										"${pageContext.request.contextPath}/upload/temp/"
												+ file.name);
								$("#hidTupian").val(
										"${pageContext.request.contextPath}/upload/temp/"
												+ file.name);
							}
						});
		var imgtupiansrc = "${requestScope.consite.tupian}";
		if (imgtupiansrc == "") {
			var url = "${pageContext.request.contextPath}/upload/nopic.jpg";
			$("#imgTupian").attr("src", url);
			$("#hidTupian").val(url);
		} else {
			$("#imgTupian").attr("src", imgtupiansrc);
			$("#hidTupian").val(imgtupiansrc);
		}
		$("#txtBegindate").datepicker({
			dateFormat : 'yy-mm-dd'
		}).datepicker("setDate", new Date());
		editor = KindEditor.create('textarea[name="des"]', {
			uploadJson : '../plusin/upload_json.jsp',
			fileManagerJson : '../plusin/file_manager_json.jsp',
			resizeType : 1,
			allowFileManager : true
		});
	}
	$(function() {
		initControl();
		$.metadata.setType("attr", "validate");
		$("#consiteForm").validate();
	});
</script>
</head>
<body>
	<div class="search-title">
		<h2>新建工地</h2>
		<div class="description"></div>
	</div>
	<form name="consiteform" method="post" action="${pageContext.request.contextPath}/admin/consitemanager.do" id="consiteForm">
		<table class="grid" cellspacing="1" width="100%">
			<input type="hidden" name="id" value="${id}" />
			<input name="hyid" placeholder="会员编号" validate="{required:true,messages:{required:'请输入会员编号'}}" value="${huiyuan.id}" class="input-txt" type="hidden" id="txtHyid" />
			<input type="hidden" name="actiontype" value="${actiontype}" />
			<input type="hidden" name="seedid" value="${seedid}" />
			<input type="hidden" name="errorurl" value="/huiyuan/consiteadd.jsp" />
			<input type="hidden" name="forwardurl" value="/admin/consitemanager.do?actiontype=get&hyid=${huiyuan.id}&forwardurl=/huiyuan/consitemanager.jsp" />
			<tr>
				<td colspan="4">${errormsg}</td>
			</tr>
			
			<tr>
				<td align="right">工地名称:</td>
				<td>
					<input name="csname" placeholder="工地名称" validate="{required:true,messages:{required:'请输入工地名称'}}" value="${requestScope.consite.csname}" class="input-txt" type="text" id="txtCsname" />
				</td>
			</tr>
			<tr>
				<td align="right">图片:</td>
				<td>
					<img id="imgTupian" width="200px" height="200px" src="${requestScope.consite.tupian}" />
					<div>
						<input type="file" name="upload" id="btnulTupian" />
					</div>
					<input type="hidden" id="hidTupian" name="tupian" value="${requestScope.consite.tupian}" />
				</td>
			</tr>

			<tr>
				<td align="right">开始日期:</td>
				<td>
					<input name="begindate" value="${requestScope.consite.begindate}" type="text" id="txtBegindate" class="input-txt" validate="{required:true}" />
				</td>
			</tr>
			<tr>
				<td align="right">项目介绍:</td>
				<td colspan="3">
					<textarea name="des" id="txtDes" style="width: 98%; height: 200px;">${requestScope.consite.des}</textarea>
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
