package com.daowen.controller;

import java.text.MessageFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.daowen.entity.Caigou;
import com.daowen.entity.Shangpin;
import com.daowen.service.CaigouService;
import com.daowen.service.ShangpinService;
import com.daowen.service.SpcategoryService;
import com.daowen.ssm.simplecrud.SimpleController;
import com.daowen.util.SequenceUtil;
import com.daowen.webcontrol.PagerMetal;

/**************************
 * 
 * 
 *
 */
@Controller
public class ShangpinController extends SimpleController {
	@Autowired
	private ShangpinService shangpinSrv = null;
	@Autowired
	private CaigouService caigouSrv=null;
	@Autowired
	private SpcategoryService spcSrv=null;

	@Override
	@RequestMapping("/admin/shangpinmanager.do")
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
		shangpinSrv.delete(SQL);
	}

	/*************************************************************
	 **************** 保存动作监听支持******************************
	 **************************************************************/
	public void save() {
		String forwardurl = request.getParameter("forwardurl");
		String errorurl = request.getParameter("errorurl");
		String spname = request.getParameter("spname");
		String spno = request.getParameter("spno");
		String spcategory = request.getParameter("spcategory");
		String price = request.getParameter("price");
		String tupian = request.getParameter("tupian");
		String des = request.getParameter("des");
		String kucun = request.getParameter("kucun");
        String changjia=request.getParameter("changjia");
		String danwei = request.getParameter("danwei");
		String pinpai = request.getParameter("pinpai");
		String xinghao = request.getParameter("xinghao");
		String hyid=request.getParameter("hyid");
		SimpleDateFormat sdfshangpin = new SimpleDateFormat("yyyy-MM-dd");
		Shangpin shangpin = new Shangpin();
		shangpin.setSpname(spname == null ? "" : spname);
		shangpin.setSpno(SequenceUtil.buildSequence("E"));
		shangpin.setSpcategory(spcategory == null ? "" : spcategory);
	 	shangpin.setCreatetime(new Date());
		shangpin.setTupian(tupian == null ? "" : tupian);
		shangpin.setDes(des == null ? "" : des);
		shangpin.setKucun(kucun == null ? 0 : new Integer(kucun));
		shangpin.setDanwei(danwei == null ? "" : danwei);
		shangpin.setPinpai(pinpai == null ? "" : pinpai);
		shangpin.setXinghao(xinghao == null ? "" : xinghao);
		shangpin.setChangjia(changjia);
		if(hyid!=null)
			shangpin.setHyid(Integer.parseInt(hyid));
		shangpin.setPrice(price==null?0:Double.parseDouble(price));
		if (shangpinSrv.isExist("where spno='" + spno + "'")) {

			request.setAttribute("actiontype", "save");
			request.setAttribute("shangpin", shangpin);
			List<Object> spcategory_datasource = spcSrv.getEntity("");
			request.setAttribute("spcategory_datasource", spcategory_datasource);
			request.setAttribute("errormsg", MessageFormat.format(
					"<label class='error'>药品编号{0}已经存在<label>",
					shangpin.getSpno()));
			forward(errorurl);

			return;

		}

		shangpinSrv.save(shangpin);
		if (forwardurl == null) {
			forwardurl = "/admin/shangpinmanager.do?actiontype=get";
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
		Shangpin shangpin =shangpinSrv.load(new Integer(id));
		if (shangpin == null)
			return;
		String changjia=request.getParameter("changjia");
		String spname = request.getParameter("spname");
		String spcategory = request.getParameter("spcategory");
		String hyid=request.getParameter("hyid");
		String tupian = request.getParameter("tupian");
		String des = request.getParameter("des");
		String danwei = request.getParameter("danwei");
		String pinpai = request.getParameter("pinpai");
		String xinghao = request.getParameter("xinghao");
		String price=request.getParameter("price");
		shangpin.setSpname(spname);
		shangpin.setSpcategory(spcategory);
		shangpin.setTupian(tupian);
		shangpin.setDes(des);
		shangpin.setChangjia(changjia);
		if(hyid!=null)
			shangpin.setHyid(Integer.parseInt(hyid));
		shangpin.setDanwei(danwei == null ? "" : danwei);
		shangpin.setPinpai(pinpai == null ? "" : pinpai);
		shangpin.setXinghao(xinghao == null ? "" : xinghao);
		shangpin.setPrice(price==null?0:Double.parseDouble(price));
		shangpinSrv.update(shangpin);
		if (forwardurl == null) {
			forwardurl = "/admin/shangpinmanager.do?actiontype=get";
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
			Shangpin shangpin = shangpinSrv.load("where id=" + id);
			if (shangpin != null) {
				request.setAttribute("shangpin", shangpin);
			}
			actiontype = "update";
			request.setAttribute("id", id);
		}
		List<Object> spcategory_datasource = spcSrv.getEntity("");
		request.setAttribute("spcategory_datasource", spcategory_datasource);
		request.setAttribute("actiontype", actiontype);
		String forwardurl = request.getParameter("forwardurl");
		System.out.println("forwardurl=" + forwardurl);
		if (forwardurl == null) {
			forwardurl = "/admin/shangpinadd.jsp";
		}
		forward(forwardurl);
	}

	/******************************************************
	 *********************** 数据绑定内部支持*********************
	 *******************************************************/
	public void get() {
		String filter = "where 1=1 ";
		String hyid=request.getParameter("hyid");
		String spname = request.getParameter("spname");
		if (spname != null)
			filter += "  and spname like '%" + spname + "%'  ";
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
		List<Shangpin> listshangpin = shangpinSrv.getPageEntitys(filter,
				pageindex, pagesize);
		int recordscount = shangpinSrv.getRecordCount(filter == null ? ""
				: filter);
		request.setAttribute("listshangpin", listshangpin);
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
			forwardurl = "/admin/shangpinmanager.jsp";
		}
		forward(forwardurl);
	}
	public void getLowcount() {

		String filter = "where kucun<20 ";

		List<Shangpin> listshangpin =shangpinSrv.getEntity(filter);

		request.setAttribute("listshangpin", listshangpin);
		// 分发请求参数
		dispatchParams(request, response);
		String forwardurl = request.getParameter("forwardurl");
		System.out.println("forwardurl=" + forwardurl);
		if (forwardurl == null) {
			forwardurl = "/admin/shangpinmanager.jsp";
		}
		forward(forwardurl);
	}
}
