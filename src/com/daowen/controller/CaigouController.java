﻿package com.daowen.controller;

import java.text.MessageFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.daowen.entity.Caigou;
import com.daowen.service.CaigouService;
import com.daowen.service.ShangpinService;
import com.daowen.ssm.simplecrud.SimpleController;
import com.daowen.webcontrol.PagerMetal;

/**************************
 * 
 * 采购控制
 *
 */
@Controller
public class CaigouController extends SimpleController {
	@Autowired
	private CaigouService caigouSrv = null;
	@Autowired
	private ShangpinService shangpinSrv=null;
	
	@Override
	@RequestMapping("/admin/caigoumanager.do")
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
		caigouSrv.delete(SQL);
	}

	/*************************************************************
	 **************** 保存动作监听支持******************************
	 **************************************************************/
	public void save() {
		String forwardurl = request.getParameter("forwardurl");
		// 验证错误url
		String errorurl = request.getParameter("errorurl");
		String hyid=request.getParameter("hyid");
		String spno = request.getParameter("spno");
		String spname = request.getParameter("spname");
		String supplor = request.getParameter("supplor");
		String count = request.getParameter("count");
		String cgren = request.getParameter("cgren");
		String danwei=request.getParameter("danwei");
		Caigou caigou = new Caigou();
		caigou.setSpno(spno == null ? "" : spno);
		caigou.setSpname(spname == null ? "" : spname);
		caigou.setSupplor(supplor == null ? "" : supplor);
		caigou.setCount(count == null ? (double) 0 : new Double(count));
		caigou.setCgdate(new Date());
		caigou.setDanwei(danwei==null?"":danwei);
		caigou.setCgren(cgren == null ? "" : cgren);
		caigou.setState(1);
		if(hyid!=null)
		  caigou.setHyid(Integer.parseInt(hyid));
		caigouSrv.save(caigou);
		shangpinSrv.executeUpdate(MessageFormat.format("update shangpin set kucun=kucun+{0,number,#} where spno=''{1}''",caigou.getCount().intValue(),caigou.getSpno()));
		if (forwardurl == null) {
			forwardurl = "/admin/caigoumanager.do?actiontype=get";
		}
		redirect(forwardurl);
	}
	
	public void shenpi() {
		String id = request.getParameter("id");
		String forwardurl = request.getParameter("forwardurl");
		String status = request.getParameter("state");
		String reply = request.getParameter("reply");
		String shenpiren = request.getParameter("shenpiren");
		int statuscode = 3;
		// 验证错误url
		String errorurl = request.getParameter("errorurl");
		if (id == null)
			return;
		Caigou caigou = caigouSrv.load(" where id=" + id);
		if (caigou == null)
			return;
		if (status != null)
			statuscode = Integer.parseInt(status);
		caigou.setState(statuscode);
		caigouSrv.update(caigou);
		
		//if(caigou.getState()==1){
			shangpinSrv.executeUpdate(MessageFormat.format("update shangpin set kucun=kucun+{0,number,#} where spno=''{1}''",caigou.getCount().intValue(),caigou.getSpno()));
		//}
		
		
		if (forwardurl == null) {
			forwardurl = "/admin/caigoumanager.do?actiontype=get";
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
			Caigou caigou = caigouSrv.load("where id=" + id);
			if (caigou != null) {
				request.setAttribute("caigou", caigou);
			}
			actiontype = "update";
			request.setAttribute("id", id);
		}
		request.setAttribute("actiontype", actiontype);
		
		String forwardurl = request.getParameter("forwardurl");
		System.out.println("forwardurl=" + forwardurl);
		if (forwardurl == null) {
			forwardurl = "/admin/caigouadd.jsp";
		}
		forward(forwardurl);
	}

	/******************************************************
	 *********************** 数据绑定内部支持*********************
	 *******************************************************/
	public void get() {
		String filter = "where 1=1 ";
		String spno = request.getParameter("spno");
		String hyid=request.getParameter("hyid");
		if (spno != null)
			filter += "  and spno like '%" + spno + "%'  ";
		//
		if(hyid!=null)
			filter+=" and hyid="+hyid;
		
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
		List<Caigou> listcaigou = caigouSrv.getPageEntitys(filter, pageindex,
				pagesize);
		int recordscount = caigouSrv.getRecordCount(filter == null ? ""
				: filter);
		request.setAttribute("listcaigou", listcaigou);
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
			forwardurl = "/admin/caigoumanager.jsp";
		}
		forward(forwardurl);
	}
}
