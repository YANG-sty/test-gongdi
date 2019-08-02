package com.daowen.controller;

import java.util.List;
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
import com.daowen.util.SequenceUtil;
import com.daowen.webcontrol.PagerMetal;

/**************************
 * 
 * 工地控制
 *
 */
@Controller
public class ConsiteController extends SimpleController {
	@Autowired
	private ConsiteService consiteSrv = null;

	@Override
	@RequestMapping("/admin/consitemanager.do")
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
		consiteSrv.delete(SQL);
	}

	/*************************************************************
	 **************** 保存动作监听支持******************************
	 **************************************************************/
	public void save() {
		String forwardurl = request.getParameter("forwardurl");
		// 验证错误url
		String errorurl = request.getParameter("errorurl");
		String csno = request.getParameter("csno");
		String csname = request.getParameter("csname");
		String tupian = request.getParameter("tupian");
		String hyid = request.getParameter("hyid");
		String begindate = request.getParameter("begindate");
		String des = request.getParameter("des");
		SimpleDateFormat sdfconsite = new SimpleDateFormat("yyyy-MM-dd");
		Consite consite = new Consite();
		consite.setCsno(SequenceUtil.buildSequence("C"));
		consite.setCsname(csname == null ? "" : csname);
		consite.setTupian(tupian == null ? "" : tupian);
		consite.setHyid(hyid == null ? "" : hyid);
		if (begindate != null) {
			try {
				consite.setBegindate(sdfconsite.parse(begindate));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		} else {
			consite.setBegindate(new Date());
		}
		consite.setDes(des == null ? "" : des);
	    Boolean validateresult=consiteSrv.isExist( "where csname='"+csname+"'");
	     if(validateresult){
		
				request.setAttribute("errormsg","<label class='error'>已存在的工程名</label>");
				request.setAttribute("consite", consite);
				request.setAttribute("actiontype", "save");
				forward(errorurl);
			
			return;
		}
		consiteSrv.save(consite);
		if (forwardurl == null) {
			forwardurl = "/admin/consitemanager.do?actiontype=get";
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
		Consite consite = consiteSrv.load(new Integer(id));
		if (consite == null)
			return;
		String csname = request.getParameter("csname");
		String tupian = request.getParameter("tupian");
		String hyid = request.getParameter("hyid");
		String begindate = request.getParameter("begindate");
		String des = request.getParameter("des");
		SimpleDateFormat sdfconsite = new SimpleDateFormat("yyyy-MM-dd");
		consite.setCsname(csname);
		consite.setTupian(tupian);
		consite.setHyid(hyid);
		if (begindate != null) {
			try {
				consite.setBegindate(sdfconsite.parse(begindate));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		consite.setDes(des);
		consiteSrv.update(consite);
		if (forwardurl == null) {
			forwardurl = "/admin/consitemanager.do?actiontype=get";
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
			Consite consite = consiteSrv.load("where id=" + id);
			if (consite != null) {
				request.setAttribute("consite", consite);
			}
			actiontype = "update";
			request.setAttribute("id", id);
		}
		request.setAttribute("actiontype", actiontype);
		String forwardurl = request.getParameter("forwardurl");
		System.out.println("forwardurl=" + forwardurl);
		if (forwardurl == null) {
			forwardurl = "/admin/consiteadd.jsp";
		}
		forward(forwardurl);
	}

	/******************************************************
	 *********************** 数据绑定内部支持*********************
	 *******************************************************/
	public void get() {
		String filter = "where 1=1 ";
		String csno = request.getParameter("csno");
		String hyid=request.getParameter("hyid");
		if (csno != null)
			filter += "  and csno like '%" + csno + "%'  ";
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
		List<Consite> listconsite = consiteSrv.getPageEntitys(filter,
				pageindex, pagesize);
		int recordscount = consiteSrv.getRecordCount(filter == null ? ""
				: filter);
		request.setAttribute("listconsite", listconsite);
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
			forwardurl = "/admin/consitemanager.jsp";
		}
		forward(forwardurl);
	}
}
