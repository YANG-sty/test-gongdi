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
            <span>工地管理</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
		         
				  
				   <li>
						<a target="main" href="${pageContext.request.contextPath}/admin/consitemanager.do?actiontype=get&hyid=${huiyuan.id }&forwardurl=/huiyuan/consitemanager.jsp">
						<i class="fa fa-navicon"></i>
						工地管理</a>
				  </li>
				  
				    <li>
						<a target="main" href="${pageContext.request.contextPath}/admin/consitemanager.do?actiontype=load&forwardurl=/huiyuan/consiteadd.jsp">
						<i class="fa fa-navicon"></i>
						添加工地</a>
				  </li>
				  
				   <li>
						<a target="main" href="${pageContext.request.contextPath}/admin/zhiyuanmanager.do?actiontype=get&hyid=${huiyuan.id }&forwardurl=/huiyuan/zhiyuanmanager.jsp">
						<i class="fa fa-navicon"></i>
						我的员工管理</a>
				  </li>
				  
				   <li>
						<a target="main" href="${pageContext.request.contextPath}/admin/zhiyuanmanager.do?actiontype=load&forwardurl=/huiyuan/zhiyuanadd.jsp">
						<i class="fa fa-navicon"></i>
						添加员工</a>
				  </li>
				    <li>
						<a target="main" href="${pageContext.request.contextPath}/admin/zhiwumanager.do?actiontype=get&hyid=${huiyuan.id}&forwardurl=/huiyuan/zhiwumanager.jsp">
						<i class="fa fa-navicon"></i>
						工种管理</a>
				  </li>
				  
				    <li>
						<a target="main" href="${pageContext.request.contextPath}/admin/wagebillmanager.do?actiontype=get&hyid=${huiyuan.id}&forwardurl=/huiyuan/wagebillmanager.jsp">
						<i class="fa fa-navicon"></i>
						工资管理</a>
				  </li>
				  
				   <li>
						<a target="main" href="${pageContext.request.contextPath}/admin/zhiyuanmanager.do?actiontype=get&hyid=${huiyuan.id}&forwardurl=/huiyuan/wagebillguide.jsp">
						<i class="fa fa-navicon"></i>
						工资出账</a>
				  </li>
				
		</ul>
        </li>
        
        
         <li class="treeview">
          <a href="#">
            <i class="fa fa-pie-chart"></i>
            <span>材料管理</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
		         
				  
				   <li>
						<a target="main" href="${pageContext.request.contextPath}/admin/shangpinmanager.do?actiontype=get&hyid=${huiyuan.id }&forwardurl=/huiyuan/shangpinmanager.jsp">
						<i class="fa fa-navicon"></i>
						材料管理</a>
				  </li>
				  
				    <li>
						<a target="main" href="${pageContext.request.contextPath}/admin/shangpinmanager.do?actiontype=load&forwardurl=/huiyuan/shangpinadd.jsp">
						<i class="fa fa-navicon"></i>
						录入材料</a>
				  </li>
				  
				   <li>
						<a target="main" href="${pageContext.request.contextPath}/admin/spcategorymanager.do?actiontype=get&hyid=${huiyuan.id }&forwardurl=/huiyuan/spcategorymanager.jsp">
						<i class="fa fa-navicon"></i>
						材料类别管理</a>
				  </li>
				
				  
				
		</ul>
        </li>
        
          <li class="treeview">
          <a href="#">
            <i class="fa fa-pie-chart"></i>
            <span>库存管理</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
		         
				  
				   <li>
						<a target="main" href="${pageContext.request.contextPath}/admin/shangpinmanager.do?actiontype=get&hyid=${huiyuan.id }&forwardurl=/huiyuan/kucunmanager.jsp">
						<i class="fa fa-navicon"></i>
						库存管理</a>
				  </li>
				  
				    <li>
						<a target="main" href="${pageContext.request.contextPath}/admin/caigoumanager.do?actiontype=get&hyid=${huiyuan.id }&forwardurl=/huiyuan/caigoumanager.jsp">
						<i class="fa fa-navicon"></i>
						采购记录</a>
				  </li>
				 
				  
				  <li>
						<a target="main" href="${pageContext.request.contextPath}/admin/supplyormanager.do?actiontype=get&hyid=${huiyuan.id }&forwardurl=/huiyuan/supplyormanager.jsp">
						<i class="fa fa-navicon"></i>
						供应商管理</a>
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
				<a  href="${pageContext.request.contextPath}/huiyuan/modifypw.jsp"
					target="main"><i class="fa fa-lock"></i>修改密码</a>
			</li>
			<li>
				<a  href="${pageContext.request.contextPath}/huiyuan/accountinfo.jsp"
					target="main"><i class="fa fa-info"></i>我的账户信息</a>
			</li>
			
          </ul>
        </li>
       
      </ul>
