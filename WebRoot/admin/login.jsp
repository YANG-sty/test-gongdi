<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>系统登录</title>

    <link rel="stylesheet"
	href="${pageContext.request.contextPath}/webui/bootstrap/css/bootstrap.min.css"/>
<!-- Font Awesome -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/webui/bootstrap/css/font-awesome.min.css"/>
<!-- Ionicons -->

<!-- Theme style -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/admin/css/AdminLTE.css"/>

    <script src="${pageContext.request.contextPath}/webui/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>

    <script src="${pageContext.request.contextPath}/webui/jquery/jquery.validate.min.js" type="text/javascript"></script>

    <script src="${pageContext.request.contextPath}/webui/jquery/jquery.metadata.js" type="text/javascript"></script>
    <style type="text/css">
          .login-box{
             background:#fff;
             padding:50px 120px;
             width:600px;
             height:500px;
             border-radius:5px;
          }
          .login-logo{
             border-bottom:3px solid #3c8dbc;
             color:#3c8dbc;
          }
          body{
            background:#fff;	
            overflow-y:hidden;
          }
    </style>
    
  <script type="text/javascript"> 
  
      
       if(top.window!=window)
    	   top.location.href="login.jsp";
      
      $(function(){
      
           $("#loginForm").submit(function(){
              
              //alert($("#txtUsername").val());
               if($("#txtUsername").val()=="")
               {
                  alert("用户名不能为空");
                  return false;
               }
               return true;
           
           });
           $("#btnReloadImage,#imgvc").on("click",function () {

               $("#imgvc").prop("src", "../plusin/image.jsp?time="+new Date().getMilliseconds());

           });
           
          var userType="${usertype}";
       	  if(userType!=""){
       			$("[name=usertype][value="+userType+"]").prop("checked",true);
       	  }
          
      
      });
  
  </script>
							

</head>
<body >
  
<div class="login-box">
  <div class="login-logo">
              工地管理系统
  </div>
  <!-- /.login-logo -->
  <div class="login-box-body">
    <!-- <p class="login-box-msg">系统登录</p>  -->

    <form method="post" action="${pageContext.request.contextPath}/admin/login.do" id="loginForm">
       <input type="hidden" name="actiontype" value="login" />
           <input type="hidden" name="forwardurl"   value="/admin/index.jsp"/>
      账&nbsp;号
      <div class="form-group has-feedback">
        	<input type="text" name="username" value="${username}"  class="form-control" placeholder="用户名"/>
        	<span class="fa fa-user form-control-feedback"></span>
      </div>
  密&nbsp;码
      <div class="form-group has-feedback">
        	<input type="password" class="form-control"  value="${password}" name="password" placeholder="密码"/>
        	<span class="fa fa-lock form-control-feedback"></span>
      </div>
       <div class="form-group input-group">
                            <label class="input-group-addon dl-icon-left">
                                                                                             用户类型: 
                            </label>
							
							&nbsp;&nbsp;&nbsp;
							<input name="usertype" value="1" type="radio"/>普通用户
							&nbsp;&nbsp;&nbsp;
							<input name="usertype" value="0" type="radio" checked="checked"/>管理员 			
         </div>
       <div class="input-group">

                            <label style="padding:0px;" class="input-group-addon dl-icon-left">

                                <img id="imgvc" class='validatecode' src="../plusin/image.jsp" width="70" height="47" alt="图片看不清？点击重新得到验证码" style="cursor:pointer;" />
                            </label>
                            <input type="text" name="validcode"  style="font-size:18px;font-weight:600;height:49px; " value="${validcode}" placeholder="验证码" class="form-input form-control">
                            <span id="btnReloadImage" style="cursor:pointer;" class="input-group-addon dl-icon-left">
                                看不清换一组
                            </span>
          </div>
      <div class="row" style="margin-top:30px;" align="center">
        <div class="col-xs-4">
          <button type="reset" class="btn btn-primary btn-block">重置</button>
        </div>
        
        <div class="col-xs-4">
          &nbsp;&nbsp;&nbsp;
        </div>
        
        <!-- /.col -->
        <div class="col-xs-4">
          <button type="submit" class="btn btn-primary btn-block btn-left">登录</button>${errmsg}
         
        </div>
	
        <!-- /.col -->
      </div>
      
      
      
    </form>

   
  </div>
  <!-- /.login-box-body -->
</div>
</body>
</html>