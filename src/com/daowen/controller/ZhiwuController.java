﻿package com.daowen.controller;

import java.util.List;
import java.text.MessageFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.daowen.entity.*;
import com.daowen.service.*;
import com.daowen.ssm.simplecrud.SimpleController;
import com.daowen.webcontrol.PagerMetal;

/**************************
 * 
 * 工种控制
 *
 */
@Controller
public class ZhiwuController extends SimpleController {
	@Autowired
	private ZhiwuService zhiwuSrv = null;

	@Override
	@RequestMapping("/admin/zhiwumanager.do")
	public void mapping(HttpServletRequest request, HttpServletResponse response) {
		mappingMethod(request, response);
	}

	/********************************************************
	 ****************** 信息注销监听支持*****************************
	 *********************************************************/
	public void delete() {
		String[] ids = request.getParameterValues("ids");
		if (ids == null)
			return;
		String spliter = ",";
		String SQL = " where id in(" + join(spliter, ids) + ")";
		System.out.println("sql=" + SQL);
		zhiwuSrv.delete(SQL);
	}

	/*************************************************************
	 **************** 保存动作监听支持******************************
	 **************************************************************/
	public void save() {
		String forwardurl = request.getParameter("forwardurl");
		// 验证错误url
		String errorurl = request.getParameter("errorurl");
		String name = request.getParameter("name");
		String salary = request.getParameter("salary");
		String hyid = request.getParameter("hyid");
		SimpleDateFormat sdfzhiwu = new SimpleDateFormat("yyyy-MM-dd");
		Zhiwu zhiwu = new Zhiwu();
		zhiwu.setName(name == null ? "" : name);
		zhiwu.setSalary(salary == null ? 0 : new Integer(salary));
		zhiwu.setHyid(hyid == null ? 0 : new Integer(hyid));
		// 产生验证
		Boolean validateresult = zhiwuSrv.isExist(MessageFormat.format("where name=''{0}'' and hyid={1} ",name,hyid));
		if (validateresult) {
			
				request.setAttribute("errormsg",
						"<label class='error'>已存在的名称</label>");
				request.setAttribute("zhiwu", zhiwu);
				request.setAttribute("actiontype", "save");
				forward(errorurl);
			
			return;
		}
		zhiwuSrv.save(zhiwu);
		if (forwardurl == null) {
			forwardurl = "/admin/zhiwumanager.do?actiontype=get";
		}
		redirect(forwardurl);
	}

	/******************************************************
	 *********************** 更新内部支持*********************
	 *******************************************************/
	public void update() {
		String forwardurl = request.getParameter("forwardurl");
		String id = request.getParameter("id");
		if (id == null)
			return;
		Zhiwu zhiwu = zhiwuSrv.load(new Integer(id));
		if (zhiwu == null)
			return;
		String name = request.getParameter("name");
		String salary = request.getParameter("salary");
		String hyid = request.getParameter("hyid");
		SimpleDateFormat sdfzhiwu = new SimpleDateFormat("yyyy-MM-dd");
		zhiwu.setName(name);
		zhiwu.setSalary(salary == null ? 0 : new Integer(salary));
		zhiwu.setHyid(hyid == null ? 0 : new Integer(hyid));
		zhiwuSrv.update(zhiwu);
		if (forwardurl == null) {
			forwardurl = "/admin/zhiwumanager.do?actiontype=get";
		}
		redirect(forwardurl);
	}

	/******************************************************
	 *********************** 加载内部支持*********************
	 *******************************************************/
	public void load() {
		//
		String id = request.getParameter("id");
		String actiontype = "save";
		dispatchParams(request, response);
		if (id != null) {
			Zhiwu zhiwu = zhiwuSrv.load("where id=" + id);
			if (zhiwu != null) {
				request.setAttribute("zhiwu", zhiwu);
			}
			actiontype = "update";
			request.setAttribute("id", id);
		}
		request.setAttribute("actiontype", actiontype);
		String forwardurl = request.getParameter("forwardurl");
		System.out.println("forwardurl=" + forwardurl);
		if (forwardurl == null) {
			forwardurl = "/admin/zhiwuadd.jsp";
		}
		forward(forwardurl);
	}

	/******************************************************
	 *********************** 数据绑定内部支持*********************
	 *******************************************************/
	public void get() {
		String filter = "where 1=1 ";
		String name = request.getParameter("name");
		String hyid=request.getParameter("hyid");
		if (name != null)
			filter += "  and name like '%" + name + "%'  ";
		//
		if(hyid!=null)
			filter+=" and hyid="+hyid;
		int pageindex = 1;
		int pagesize = 10;
		// 获取当前分页
		String currentpageindex = request.getParameter("currentpageindex");
		// 当前页面尺寸
		String currentpagesize = request.getParameter("pagesize");
		// 设置当前页
		if (currentpageindex != null)
			pageindex = new Integer(currentpageindex);
		// 设置当前页尺寸
		if (currentpagesize != null)
			pagesize = new Integer(currentpagesize);
		List<Zhiwu> listzhiwu = zhiwuSrv.getPageEntitys(filter, pageindex,
				pagesize);
		int recordscount = zhiwuSrv
				.getRecordCount(filter == null ? "" : filter);
		request.setAttribute("listzhiwu", listzhiwu);
		PagerMetal pm = new PagerMetal(recordscount);
		// 设置尺寸
		pm.setPagesize(pagesize);
		// 设置当前显示页
		pm.setCurpageindex(pageindex);
		// 设置分页信息
		request.setAttribute("pagermetal", pm);
		// 分发请求参数
		dispatchParams(request, response);
		String forwardurl = request.getParameter("forwardurl");
		System.out.println("forwardurl=" + forwardurl);
		if (forwardurl == null) {
			forwardurl = "/admin/zhiwumanager.jsp";
		}
		forward(forwardurl);
	}
}
