package com.daowen.controller;

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
 * 员工控制
 *
 */
@Controller
public class ZhiyuanController extends SimpleController {
	@Autowired
	private ZhiyuanService zhiyuanSrv = null;
	
	@Autowired
	private ZhiwuService zhiwuSrv=null;

	@Override
	@RequestMapping("/admin/zhiyuanmanager.do")
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
		zhiyuanSrv.delete(SQL);
	}

	/*************************************************************
	 **************** 保存动作监听支持******************************
	 **************************************************************/
	public void save() {
		String forwardurl = request.getParameter("forwardurl");
		// 验证错误url
		String errorurl = request.getParameter("errorurl");
		String accountname = request.getParameter("accountname");
		String name = request.getParameter("name");
		String sex = request.getParameter("sex");
		String jiguan = request.getParameter("jiguan");
		String nation = request.getParameter("nation");
		String zhiwu = request.getParameter("zhiwu");
		String mobile = request.getParameter("mobile");
		String qq = request.getParameter("qq");
		String des = request.getParameter("des");
		String photo = request.getParameter("photo");
		String rzdate = request.getParameter("rzdate");
		String zwid=request.getParameter("zwid");
		String hyid = request.getParameter("hyid");
		SimpleDateFormat sdfzhiyuan = new SimpleDateFormat("yyyy-MM-dd");
		Zhiyuan zhiyuan = new Zhiyuan();
		zhiyuan.setAccountname(accountname == null ? "" : accountname);
		zhiyuan.setName(name == null ? "" : name);
		zhiyuan.setSex(sex == null ? "" : sex);
		zhiyuan.setJiguan(jiguan == null ? "" : jiguan);
		zhiyuan.setNation(nation == null ? "" : nation);
		if(zwid!=null)
			zhiyuan.setZwid(Integer.parseInt(zwid));
		zhiyuan.setZhiwu(zhiwu == null ? "" : zhiwu);
		zhiyuan.setMobile(mobile == null ? "" : mobile);
		zhiyuan.setQq(qq == null ? "" : qq);
		zhiyuan.setDes(des == null ? "" : des);
		zhiyuan.setPhoto(photo == null ? "" : photo);
		if (rzdate != null) {
			try {
				zhiyuan.setRzdate(sdfzhiyuan.parse(rzdate));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		} else {
			zhiyuan.setRzdate(new Date());
		}
		zhiyuan.setHyid(hyid == null ? 0 : new Integer(hyid));
		// 产生验证
		Boolean validateresult = zhiyuanSrv.isExist(MessageFormat.format(
				"where accountname=''{0}'' and hyid={1} ", accountname, hyid));
		if (validateresult) {

			request.setAttribute("errormsg",
					"<label class='error'>已存在的工号</label>");
			request.setAttribute("zhiyuan", zhiyuan);
			request.setAttribute("actiontype", "save");
			forward(errorurl);

			return;
		}
		zhiyuanSrv.save(zhiyuan);
		if (forwardurl == null) {
			forwardurl = "/admin/zhiyuanmanager.do?actiontype=get";
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
		Zhiyuan zhiyuan = zhiyuanSrv.load(new Integer(id));
		if (zhiyuan == null)
			return;
		String accountname = request.getParameter("accountname");
		String name = request.getParameter("name");
		String sex = request.getParameter("sex");
		String jiguan = request.getParameter("jiguan");
		String nation = request.getParameter("nation");
		String zhiwu = request.getParameter("zhiwu");
		String mobile = request.getParameter("mobile");
		String qq = request.getParameter("qq");
		String des = request.getParameter("des");
		String photo = request.getParameter("photo");
		String rzdate = request.getParameter("rzdate");
		String zwid=request.getParameter("zwid");
		String hyid = request.getParameter("hyid");
		SimpleDateFormat sdfzhiyuan = new SimpleDateFormat("yyyy-MM-dd");
		zhiyuan.setAccountname(accountname);
		zhiyuan.setName(name);
		zhiyuan.setSex(sex);
		zhiyuan.setJiguan(jiguan);
		zhiyuan.setNation(nation);
		if(zwid!=null)
			zhiyuan.setZwid(Integer.parseInt(zwid));
		zhiyuan.setZhiwu(zhiwu == null ? "" : zhiwu);
		zhiyuan.setMobile(mobile);
		zhiyuan.setQq(qq);
		zhiyuan.setDes(des);
		zhiyuan.setPhoto(photo);
		if (rzdate != null) {
			try {
				zhiyuan.setRzdate(sdfzhiyuan.parse(rzdate));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		zhiyuan.setHyid(hyid == null ? 0 : new Integer(hyid));
		zhiyuanSrv.update(zhiyuan);
		if (forwardurl == null) {
			forwardurl = "/admin/zhiyuanmanager.do?actiontype=get";
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
			Zhiyuan zhiyuan = zhiyuanSrv.load("where id=" + id);
			if (zhiyuan != null) {
				request.setAttribute("zhiyuan", zhiyuan);
			}
			actiontype = "update";
			request.setAttribute("id", id);
		}
	     List<Object> zwid_datasource=zhiwuSrv.getEntity("");
	     request.setAttribute("zwid_datasource",zwid_datasource);
		request.setAttribute("actiontype", actiontype);
		String forwardurl = request.getParameter("forwardurl");
		System.out.println("forwardurl=" + forwardurl);
		if (forwardurl == null) {
			forwardurl = "/admin/zhiyuanadd.jsp";
		}
		forward(forwardurl);
	}

	/******************************************************
	 *********************** 数据绑定内部支持*********************
	 *******************************************************/
	public void get() {
		String filter = "where 1=1 ";
		String hyid=request.getParameter("hyid");
		String accountname = request.getParameter("accountname");
		if (accountname != null)
			filter += "  and accountname like '%" + accountname + "%'  ";
		if(hyid!=null)
			filter+=" and hyid="+hyid;
		//
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
		List<Zhiyuan> listzhiyuan = zhiyuanSrv.getPageEntitys(filter,
				pageindex, pagesize);
		int recordscount = zhiyuanSrv.getRecordCount(filter == null ? ""
				: filter);
		request.setAttribute("listzhiyuan", listzhiyuan);
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
			forwardurl = "/admin/zhiyuanmanager.jsp";
		}
		forward(forwardurl);
	}
}
