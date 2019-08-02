<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ page  contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="web" uri="/WEB-INF/webcontrol.tld"%>
<%@ include file="law.jsp"%>
<%
     Huiyuan huiyuan= (Huiyuan)request.getSession().getAttribute("huiyuan");
     HuiyuanService huiyuanSrv=BeansUtil.getBean("huiyuanService", HuiyuanService.class);
	 if(huiyuan!=null)
	 {
	     Huiyuan temhuiyuan   =huiyuanSrv.load("where id="+((Huiyuan)huiyuan).getId());
	     request.setAttribute("huiyuan",temhuiyuan);
	 }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
 <head>
  <title>会员管理</title>
	 <script type="text/javascript" src="${pageContext.request.contextPath}/webui/jquery/jquery-1.8.3.min.js"></script>
    <script  type="text/javascript" src="${pageContext.request.contextPath}/webui/jquery/jquery.validate.min.js"></script>
  <script type="text/javascript"  src="${pageContext.request.contextPath}/webui/jquery/jquery.metadata.js" ></script>
  <script type="text/javascript"  src="${pageContext.request.contextPath}/webui/jquery/messages_cn.js" ></script>
   <link href="${pageContext.request.contextPath}/webui/artDialog/skins/default.css" rel="stylesheet" type="text/css" />
    <script src="${pageContext.request.contextPath}/webui/artDialog/jquery.artDialog.source.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/webui/artDialog/iframeTools.source.js" type="text/javascript"></script>
    <link href="${pageContext.request.contextPath}/webui/treetable/skin/jquery.treetable.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/webui/treetable/skin/jquery.treetable.theme.default.css" rel="stylesheet"
        type="text/css" />
    <script src="${pageContext.request.contextPath}/webui/treetable/js/jquery.treetable.js" type="text/javascript"></script>
  <link href="${pageContext.request.contextPath}/uploadifyv3.1/uploadify.css" rel="stylesheet" type="text/css" />
    <script src="${pageContext.request.contextPath}/uploadifyv3.1/jquery.uploadify-3.1.js" type="text/javascript"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/editor/kindeditor-min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/editor/lang/zh_CN.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webui/jqueryui/themes/base/jquery.ui.all.css" type="text/css"></link>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/jqueryui/ui/jquery-ui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/jqueryui/ui/i18n/jquery.ui.datepicker-zh-CN.js"></script>
   <link href="${pageContext.request.contextPath}/admin/css/web2table.css" rel="stylesheet" type="text/css" />
   <script type="text/javascript">
        function initControl(){
			           $('#btnulPhoto').uploadify({  
			                'formData': { 'folder': '${pageContext.request.contextPath}/Upload' },  
			                'buttonText': '选择图片',  
			                'buttonClass': 'browser',  
			                'removeCompleted': true,  
			                'swf': '${pageContext.request.contextPath}/uploadifyv3.1/uploadify.swf', 
			                'fileTypeExts':"*.jpg;*.gif;*.png;",
			                'auto':true, 
			                'removeTimeout':0,
			                'debug': false,  
			                'height': 15,  
			                'width':90,  
			                'uploader': '${pageContext.request.contextPath}/admin/uploadmanager.do',
			                 'fileSizelimit':'2048KB',
			                 'queueSizelimit':'5',
			                 'onUploadSuccess':function(file, data, response){
			                     $("#filelist").show();
			                     $("#imgPhoto").attr("src","${pageContext.request.contextPath}/upload/temp/"+file.name);
                                 $("#hidPhoto").val("${pageContext.request.contextPath}/upload/temp/"+file.name);
			                  }
			             }); 
			          var imgphotosrc="${requestScope.huiyuan.photo}";
				       if(imgphotosrc==""){
				         var url="${pageContext.request.contextPath}/upload/nopic.jpg";
				         $("#imgPhoto").attr("src",url);
				         $("#hidPhoto").val(url);
				       }else
				       {
				          $("#imgPhoto").attr("src",imgphotosrc);
				          $("#hidPhoto").val(imgphotosrc); 
				       }
                      $("#txtBirthday").datepicker({
                         dateFormat:'yy-mm-dd'
                      }).datepicker("setDate",new Date());
			            editor = KindEditor.create('textarea[name="des"]', {
			            resizeType: 1,
				        allowFileManager: true
				       });
        }
        $(function ()
        {
            initControl();
            $.metadata.setType("attr","validate");
            $("#teacherForm").validate();
        });  
    </script>
</head>
<body>
	<div class="search-title">
		<h2>账户信息管理</h2>
		<div class="description">修改帐户信息</div>
	</div>
	<form name="huiyuanform" method="post"
		action="${pageContext.request.contextPath}/admin/huiyuanmanager.do"
		id="huiyuanForm">
		<input type="hidden" name="actiontype" value="update" /> <input
			type="hidden" name="id" value="${requestScope.huiyuan.id}" /> <input
			type="hidden" name="forwardurl"
			value="/huiyuan/accountinfo.jsp?seedid=101" />
		<table border="0" cellspacing="1" class="grid" cellpadding="0"
			width="100%">
			<tr>
				<td height="30" align="right">账户名:</td>
				<td>${requestScope.huiyuan.accountname}</td>
				<td colspan="2" rowspan="6"><img id="imgPhoto" width="200px" height="200px"
					src="${requestScope.huiyuan.photo}" />
					<div>
						<input type="file" name="upload" id="btnulPhoto" />
					</div> <input type="hidden" id="hidPhoto" name="photo"
					value="${requestScope.huiyuan.photo}" /></td>
			</tr>
			<tr>
				<td height="30" align="right">姓名:</td>
				<td><input name="name" value="${requestScope.huiyuan.name}"
					class="input-txt" type="text" id="txtName"
					validate="{required:true,messages:{required:'请输入姓名'}}" /></td>
			</tr>
			<tr>
				<td height="30" align="right">性别:</td>
				<td><select name="sex" id="ddlSex">
						<option value="男">男</option>
						<option value="女">女</option>
				</select></td>
			</tr>
			<tr>
				<td height="30" align="right">联系电话:</td>
				<td><input name="tel" value="${requestScope.huiyuan.tel}"
					class="input-txt" type="text" id="txtTel"
					validate="{required:true,messages:{required:'请输入联系电话'}}" /></td>
			</tr>
			<tr>
				<td height="30" align="right">身份证:</td>
				<td><input name="idcardno"
					value="${requestScope.huiyuan.idcardno}" class="input-txt"
					type="text" id="txtIdcardno"
					validate="{required:true,messages:{required:'请输入身份证'}}" /></td>
			</tr>
	
			<tr>
				<td height="30" align="right">籍贯:</td>
				<td><input name="jiguan"
					value="${requestScope.huiyuan.jiguan}" class="input-txt"
					type="text" id="txtJiguan"
					validate="{required:true,messages:{required:'请输入籍贯'}}" /></td>
			</tr>
			
			<tr>
				<td height="30" align="right">出生年月:</td>
				<td><input name="birthday"
					value="${requestScope.huiyuan.birthday}" type="text"
					id="txtBirthday" class="input-txt"
					validate="{required:true,messages:{required:'请选择日期'}}" /></td>
			
				<td height="30" align="right">家庭住址:</td>
				<td><input name="address"
					value="${requestScope.huiyuan.address}" class="input-txt"
					type="text" id="txtAddress"
					validate="{required:true,messages:{required:'请输入家庭住址'}}" /></td>
			</tr>
			
			<tr>
				<td align="right">说明:</td>
				<td colspan="3"><textarea name="des" class="l-textarea"
						id="txtDes" style="width:98%;height:200px;">${requestScope.huiyuan.des}</textarea>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<div class="ui-button">
						<button class="ui-button-text">
							<i class="icon-ok icon-white"></i>提交
						</button>
					</div></td>
			</tr>
		</table>
	</form>
</body>
</html>
