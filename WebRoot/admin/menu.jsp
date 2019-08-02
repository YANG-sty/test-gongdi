<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

 <!-- sidebar menu: : style can be found in sidebar.less -->
      <ul class="sidebar-menu" data-widget="tree">
        <li class="header">系统菜单</li>
       
       
        <li class="treeview">
          <a href="#">
            <i class="fa fa-pie-chart"></i>
            <span>用户管理</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
		         
				  
				   <li>
						<a target="main" href="${pageContext.request.contextPath}/admin/huiyuanmanager.do?actiontype=get">
						<i class="fa fa-navicon"></i>
						普通用户管理</a>
				  </li>
				  
				    <li>
						<a target="main" href="${pageContext.request.contextPath}/admin/huiyuanmanager.do?actiontype=load">
						<i class="fa fa-navicon"></i>
						添加普通用户</a>
				  </li>
				  
				   <li>
						<a target="main" href="${pageContext.request.contextPath}/admin/usersmanager.do?actiontype=get">
						<i class="fa fa-navicon"></i>
						后台用户管理</a>
				  </li>
				  
				
		</ul>
        </li>
        

        <li class="treeview">
          <a href="#">
            <i class="fa fa-laptop"></i>
            <span>系统设置</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
          
          
             
			
             <li>
				<a  href="${pageContext.request.contextPath}/admin/modifypw.jsp"
					target="main"><i class="fa fa-lock"></i>修改密码</a>
			</li>
			<li>
				<a  href="${pageContext.request.contextPath}/admin/accountinfo.jsp"
					target="main"><i class="fa fa-info"></i>我的账户信息</a>
			</li>
			<li>
				<a  href="${pageContext.request.contextPath}/admin/modifyinfo.jsp"
					target="main"><i class="fa fa-share-alt-square"></i>修改账户信息</a>
			</li>
          </ul>
        </li>
       
      </ul>
