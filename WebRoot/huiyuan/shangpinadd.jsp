<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="web" uri="/WEB-INF/webcontrol.tld"%>
<%@ include file="law.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
 <head>
  <title>材料</title>
    <link href="${pageContext.request.contextPath}/admin/css/web2table.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/admin/css/menu.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/jquery/jquery-1.9.0.js"></script>
     <link href="${pageContext.request.contextPath}/webui/artDialog/skins/default.css" rel="stylesheet" type="text/css" />
    <script src="${pageContext.request.contextPath}/webui/artDialog/jquery.artDialog.source.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/webui/artDialog/iframeTools.source.js" type="text/javascript"></script>
    <script  type="text/javascript" src="${pageContext.request.contextPath}/webui/jquery/jquery.validate.min.js"></script>
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
   <script type="text/javascript">
        function initControl(){
	  //开始绑定
                    //结束绑定
			           $('#btnulTupian').uploadify({  
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
			                     $("#imgTupian").attr("src","${pageContext.request.contextPath}/upload/temp/"+file.name);
                                 $("#hidTupian").val("${pageContext.request.contextPath}/upload/temp/"+file.name);
			                  }
			             }); 
			          var imgtupiansrc="${requestScope.shangpin.tupian}";
				       if(imgtupiansrc==""){
				         var url="${pageContext.request.contextPath}/upload/nopic.jpg";
				         $("#imgTupian").attr("src",url);
				         $("#hidTupian").val(url);
				       }else
				       {
				          $("#imgTupian").attr("src",imgtupiansrc);
				          $("#hidTupian").val(imgtupiansrc); 
				       }
			            editor = KindEditor.create('textarea[name="des"]', {
			            uploadJson : '../plusin/upload_json.jsp',
				        fileManagerJson : '../plusin/file_manager_json.jsp',
			            resizeType: 1,
				        allowFileManager: true
				       });
        }
        $(function ()
        {
            initControl();
            $.metadata.setType("attr","validate");
            $("#shangpinForm").validate();
        });  
    </script>
</head>
<body>
	<div class="search-title">
		<h2>录入材料信息</h2>
		<div class="description"></div>
	</div>
	<form name="shangpinform" method="post"
		action="${pageContext.request.contextPath}/admin/shangpinmanager.do"
		id="shangpinForm">
		<table class="grid" cellspacing="1" width="100%">
			<input type="hidden" name="id" value="${id}" />
			<input type="hidden" name="actiontype" value="${actiontype}" />
			<input type="hidden" name="hyid" value="${huiyuan.id}" />
			<input type="hidden" name="errorurl" value="/admin/shangpinadd.jsp" />
			<input type="hidden" name="forwardurl" value="/admin/shangpinmanager.do?actiontype=get&hyid=${huiyuan.id}&forwardurl=/huiyuan/shangpinmanager.jsp" />

			<tr>
				<td colspan="2">${errormsg }</td>
			</tr>
			<tr>
				<td align="right">材料名称:</td>
				<td><input name="spname"
					validate="{required:true,messages:{required:'请输入材料名'}}"
					value="${requestScope.shangpin.spname}" class="input-txt"
					type="text" id="txtSpname" /></td>

				<td colspan="2" rowspan="7"><img id="imgTupian" width="200px"
					height="200px" src="${requestScope.shangpin.tupian}" />
					<div>
						<input type="file" name="upload" id="btnulTupian" />
					</div> <input type="hidden" id="hidTupian" name="tupian"
					value="${requestScope.shangpin.tupian}" /></td>
			</tr>
			
			<tr>
				<td align="right">材料分类:</td>
				<td><web:dropdownlist cssclass="dropdown" name="spcategory"
						id="spcategory" value="${requestScope.shangpin.spcategory}"
						datasource="${spcategory_datasource}" textfieldname="name"
						valuefieldname="name">
					</web:dropdownlist></td>
			</tr>
			
			<tr>
				<td align="right">计量单位:</td>
				<td><input name="danwei" placeholder="单位"
					validate="{required:true,messages:{required:'请输入单位'}}"
					value="${requestScope.shangpin.danwei}" class="input-txt"
					type="text" id="txtDanwei" /></td>
			</tr>
			<tr>
				<td align="right">价格:(元)</td>
				<td><input name="price" style="width:80px;" placeholder="价格"
					validate="{required:true,number:true,messages:{required:'请输入价格',number:'请输入正确的价格'}}"
					value="${requestScope.shangpin.price}" class="input-txt"
					type="text" id="txtPinpai" /></td>
			</tr>
			<tr>
				<td align="right">品牌:</td>
				<td><input name="pinpai" placeholder="品牌"
					validate="{required:true,messages:{required:'请输入品牌'}}"
					value="${requestScope.shangpin.pinpai}" class="input-txt"
					type="text" id="txtPinpai" /></td>
			</tr>
			<tr>

				<td align="right">生产厂家:</td>
				<td><input name="changjia" placeholder="生产厂家"
					validate="{required:true,messages:{required:'请输入生产厂家'}}"
					value="${requestScope.shangpin.changjia}" class="input-txt"
					type="text" id="txtChangjia" /></td></tr>
			<tr>	<td align="right">产地:</td>
			
			
				<td><input name="xinghao" placeholder="产地"
					validate="{required:true,messages:{required:'请输入产地'}}"
					value="${requestScope.shangpin.xinghao}" class="input-txt"
					type="text" id="txtXinghao" /></td>

			</tr>

			<tr>
				<td align="right">介绍:</td>
				<td colspan="3"><textarea name="des" id="txtDes"
						style="width:98%;height:200px;">${requestScope.shangpin.des}</textarea>
				</td>
			</tr>
		</table>
		<div>
			<input type="submit" value="提交" id="Button1" class="orange-button" />
		</div>
	</form>
</body>
</html>
