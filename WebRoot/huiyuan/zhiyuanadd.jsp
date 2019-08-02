<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="web" uri="/WEB-INF/webcontrol.tld"%>
<%@ include file="law.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
 <head>
  <title>员工</title>
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
    <script type="text/javascript" src="${pageContext.request.contextPath}/editor/kindeditor-min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/editor/lang/zh_CN.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webui/jqueryui/themes/base/jquery.ui.all.css" type="text/css"></link>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/jqueryui/ui/jquery-ui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/jqueryui/ui/i18n/jquery.ui.datepicker-zh-CN.js"></script>
    <script src="${pageContext.request.contextPath}/webui/jqueryui/ui/jquery-ui-timepicker-addon.js" type="text/javascript"></script>
     <link href="${pageContext.request.contextPath}/admin/css/web2table.css" rel="stylesheet" type="text/css" />
   <script type="text/javascript">
        function initControl(){
	  //开始绑定
                    //结束绑定
			            editor = KindEditor.create('textarea[name="des"]', {
			            uploadJson : '../plusin/upload_json.jsp',
				        fileManagerJson : '../plusin/file_manager_json.jsp',
			            resizeType: 1,
				        allowFileManager: true
				       });
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
			          var imgphotosrc="${requestScope.zhiyuan.photo}";
				       if(imgphotosrc==""){
				         var url="${pageContext.request.contextPath}/upload/nopic.jpg";
				         $("#imgPhoto").attr("src",url);
				         $("#hidPhoto").val(url);
				       }else
				       {
				          $("#imgPhoto").attr("src",imgphotosrc);
				          $("#hidPhoto").val(imgphotosrc); 
				       }
	                  $("#txtRzdate").datepicker({
                         dateFormat:'yy-mm-dd'
                      }).datepicker("setDate",new Date());
        }
        $(function ()
        {
            initControl();
            $("#zwid").change(function(){
      	        $("[name=zhiwu]").val($("#zwid option:selected").text());
            });
            $("[name=zhiwu]").val($("#zwid option:selected").text());
            $.metadata.setType("attr","validate");
            $("#zhiyuanForm").validate();
        });  
    </script>
</head>
<body>
	<div class="search-title">
		<h2>新建员工</h2>
		<div class="description"></div>
	</div>
	<form name="zhiyuanform" method="post" action="${pageContext.request.contextPath}/admin/zhiyuanmanager.do" id="zhiyuanForm">
		<table class="grid" cellspacing="1" width="100%">
			<input type="hidden" name="id" value="${id}" />
			<input type="hidden" name="actiontype" value="${actiontype}" />
			<input type="hidden" name="hyid" value="${huiyuan.id}" />
			<input type="hidden" name="errorurl" value="/huiyuan/zhiyuanadd.jsp" />
			<input type="hidden" name="forwardurl" value="/admin/zhiyuanmanager.do?actiontype=get&hyid=${huiyuan.id}&forwardurl=/huiyuan/zhiyuanmanager.jsp" />
			<tr>
				<td colspan="4">${errormsg}</td>
			</tr>
			<tr>
				<td align="right">工号:</td>
				<td>
					<input name="accountname" placeholder="工号" validate="{required:true,messages:{required:'请输入工号'}}" value="${requestScope.zhiyuan.accountname}" class="input-txt" type="text" id="txtAccountname" />
				</td>
				<td colspan="2" rowspan="6">
					<img id="imgPhoto" width="200px" height="200px" src="${requestScope.zhiyuan.photo}" />
					<div>
						<input type="file" name="upload" id="btnulPhoto" />
					</div>
					<input type="hidden" id="hidPhoto" name="photo" value="${requestScope.zhiyuan.photo}" />
				</td>
			</tr>
			<tr>
				<td align="right">姓名:</td>
				<td>
					<input name="name" placeholder="姓名" validate="{required:true,messages:{required:'请输入姓名'}}" value="${requestScope.zhiyuan.name}" class="input-txt" type="text" id="txtName" />
				</td>
			</tr>
			<tr>
				<td align="right">性别:</td>
				<td>
					<select name="sex" id="ddlSex" class="dropdown">
						<option value="男">男</option>
						<option value="女">女</option>
					</select>
				</td>
			</tr>
			<tr>
				<td align="right">籍贯:</td>
				<td>
					<input name="jiguan" placeholder="籍贯" validate="{required:true,messages:{required:'请输入籍贯'}}" value="${requestScope.zhiyuan.jiguan}" class="input-txt" type="text" id="txtJiguan" />
				</td>
			</tr>
			<tr>
				<td align="right">民族:</td>
				<td>
					<input name="nation" placeholder="民族" validate="{required:true,messages:{required:'请输入名族'}}" value="${requestScope.zhiyuan.nation}" class="input-txt" type="text" id="txtNation" />
				</td>
			</tr>
			<tr>
				<td align="right">工种:</td>
				<td>
					<web:dropdownlist name="zwid" id="zwid" cssclass="dropdown" value="${requestScope.zhiyuan.zwid}" datasource="${zwid_datasource}" textfieldname="name" valuefieldname="id">
					</web:dropdownlist>
					<input name="zhiwu" type="hidden" vlaue="${requestScope.zhiyuan.zhiwu}" />
				</td>
			</tr>
			<tr>
				<td align="right">电话:</td>
				<td>
					<input name="mobile" placeholder="电话" validate="{required:true,messages:{required:'请输入电话'}}" value="${requestScope.zhiyuan.mobile}" class="input-txt" type="text" id="txtMobile" />
				</td>
			
				<td align="right">qq:</td>
				<td>
					<input name="qq" placeholder="qq" validate="{required:true,messages:{required:'请输入qq'}}" value="${requestScope.zhiyuan.qq}" class="input-txt" type="text" id="txtQq" />
				</td>
			</tr>
			
			<tr>
				<td align="right">入职时间:</td>
				<td>
					<input name="rzdate" value="${requestScope.zhiyuan.rzdate}" type="text" id="txtRzdate" class="input-txt" validate="{required:true}" />
				</td>
			</tr>
			
			<tr>
				<td align="right">备注:</td>
				<td colspan="3">
					<textarea name="des" id="txtDes" style="width: 98%; height: 200px;">${requestScope.zhiyuan.des}</textarea>
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
