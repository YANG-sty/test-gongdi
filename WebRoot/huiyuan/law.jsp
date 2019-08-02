<%@ page import="com.daowen.util.*" %>
<%@ page import="com.daowen.entity.*" %>
<%@ page import="com.daowen.service.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%
      Object o=  request.getSession().getAttribute("huiyuan");
     if(o==null)
          response.sendRedirect(request.getContextPath()+"/admin/login.jsp");
%>
