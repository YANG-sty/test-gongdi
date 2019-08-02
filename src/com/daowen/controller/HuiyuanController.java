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
import com.daowen.webcontrol.PagerMetal;

/**************************
 * 
 * 会员管理控制
 *
 */
@Controller
public class HuiyuanController extends SimpleController {
	@Autowired
	private HuiyuanService huiyuanSrv = null;

	@Override
	@RequestMapping("/admin/huiyuanmanager.do")
	public void mapping(HttpServletRequest request, HttpServletResponse response) {
		mappingMethod(request, response);
	}

	public void chongzhi() {

		String jine = request.getParameter("jine");
		String forwardurl = request.getParameter("forwardurl");

		String id = request.getParameter("id");
		if (id == null || id == "")
			return;
		Huiyuan huiyuan = huiyuanSrv.load(new Integer(id));
		if (huiyuan == null) {
			request.setAttribute("errormsg",
					"<label class='error'>账户不合法</label>");
			return;
		}
		huiyuan.setYue(huiyuan.getYue() + Double.parseDouble(jine));
		huiyuanSrv.update(huiyuan);
		request.getSession().setAttribute("huiyuan", huiyuan);
		redirect(forwardurl);

	}

	private void modifyPaypw() {

		String paypwd = request.getParameter("paypwd");
		String errorurl = request.getParameter("errorurl");
		String forwardurl = request.getParameter("forwardurl");
		String repassword1 = request.getParameter("repassword1");
		String repassword2 = request.getParameter("repassword2");
		String id = request.getParameter("id");
		if (id == null || id == "")
			return;
		Huiyuan huiyuan = huiyuanSrv.load(new Integer(id));
		if (huiyuan == null) {
			request.setAttribute("errormsg",
					"<label class='error'>账户不成立</label>");
			forward(errorurl);
			return;
		}
		if (!huiyuan.getPaypwd().equals(paypwd)) {
			request.setAttribute("errormsg",
					"<label class='error'>不正确</label>");

			forward(errorurl);
			return;
		}
		huiyuan.setPaypwd(repassword1);
		huiyuanSrv.update(huiyuan);
		request.getSession().setAttribute("huiyuan", huiyuan);
		redirect(forwardurl);

	}

	public void modifyPw() {
		String password1 = request.getParameter("password1");
		String repassword1 = request.getParameter("repassword1");
		String repassword2 = request.getParameter("repassword2");
		String forwardurl = request.getParameter("forwardurl");
		String errorurl = request.getParameter("errorurl");
		String id = request.getParameter("id");
		if (id == null || id == "")
			return;
		Huiyuan huiyuan = huiyuanSrv.load(new Integer(id));
		if (huiyuan == null) {
			request.setAttribute("errormsg",
					"<label class='error'>账户不成立</label>");
			forward(errorurl);
			return;
		}

		if (!huiyuan.getPassword().equals(password1)) {
			request.setAttribute("errormsg",
					"<label class='error'>原始密码不正确，不能修改</label>");
			forward(errorurl);
			return;
		} else {
			huiyuan.setPassword(repassword1);
			huiyuanSrv.update(huiyuan);
			request.getSession().setAttribute("huiyuan", huiyuan);
			forward(forwardurl);
		}

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
		huiyuanSrv.delete(SQL);
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
		String tel = request.getParameter("tel");
		String idcardno = request.getParameter("idcardno");
		String photo = request.getParameter("photo");
		String jiguan = request.getParameter("jiguan");
		String logintimes = request.getParameter("logintimes");
		String yue = request.getParameter("yue");
		String birthday = request.getParameter("birthday");
		String jifen = request.getParameter("jifen");
		String address = request.getParameter("address");
		String des = request.getParameter("des");
		String xtype = request.getParameter("xtype");
		SimpleDateFormat sdfhuiyuan = new SimpleDateFormat("yyyy-MM-dd");
		Huiyuan huiyuan = new Huiyuan();
		huiyuan.setAccountname(accountname == null ? "" : accountname);
		huiyuan.setName(name == null ? "" : name);
		huiyuan.setSex(sex == null ? "" : sex);
		huiyuan.setTel(tel == null ? "" : tel);
		huiyuan.setIdcardno(idcardno == null ? "" : idcardno);
		huiyuan.setPhoto(photo == null ? "" : photo);
		huiyuan.setJiguan(jiguan == null ? "" : jiguan);

		huiyuan.setCreatetime(new Date());
		huiyuan.setLogintimes(logintimes == null ? 0 : new Integer(logintimes));
		huiyuan.setYue(yue == null ? (double) 0 : new Double(yue));
		if (birthday != null) {
			try {
				huiyuan.setBirthday(sdfhuiyuan.parse(birthday));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		} else {
			huiyuan.setBirthday(new Date());
		}
		huiyuan.setJifen(jifen == null ? (double) 0 : new Double(jifen));
		huiyuan.setAddress(address == null ? "" : address);
		huiyuan.setDes(des == null ? "" : des);
		huiyuan.setPassword("123456");
		huiyuan.setPaypwd(huiyuan.getPassword());
		huiyuan.setXtype(xtype == null ? 0 : new Integer(xtype));
		Boolean validateresult = huiyuanSrv.isExist("where accountname='"
				+ accountname + "'");
		if (validateresult) {
			
				request.setAttribute("errormsg",
						"<label class='error'>已经存在的账号</label>");
				request.setAttribute("huiyuan", huiyuan);
				
				request.setAttribute("actiontype", "save");
			    forward(errorurl);
			return;
		}
		huiyuanSrv.save(huiyuan);
		if (forwardurl == null) {
			forwardurl = "/admin/huiyuanmanager.do?actiontype=get";
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
		Huiyuan huiyuan = huiyuanSrv.load(new Integer(id));
		if (huiyuan == null)
			return;
		String accountname = request.getParameter("accountname");
		String name = request.getParameter("name");
		String sex = request.getParameter("sex");
		String tel = request.getParameter("tel");
		String idcardno = request.getParameter("idcardno");
		String photo = request.getParameter("photo");
		String jiguan = request.getParameter("jiguan");
		String createtime = request.getParameter("createtime");
		String logintimes = request.getParameter("logintimes");
		String birthday = request.getParameter("birthday");
		String jifen = request.getParameter("jifen");
		String address = request.getParameter("address");
		String des = request.getParameter("des");
		String xtype = request.getParameter("xtype");
		SimpleDateFormat sdfhuiyuan = new SimpleDateFormat("yyyy-MM-dd");
		huiyuan.setAccountname(accountname);
		huiyuan.setName(name);
		huiyuan.setSex(sex);
		huiyuan.setTel(tel);
		huiyuan.setIdcardno(idcardno);
		huiyuan.setPhoto(photo);
		huiyuan.setJiguan(jiguan);
		if (createtime != null) {
			try {
				huiyuan.setCreatetime(sdfhuiyuan.parse(createtime));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		huiyuan.setLogintimes(logintimes == null ? 0 : new Integer(logintimes));
		if (birthday != null) {
			try {
				huiyuan.setBirthday(sdfhuiyuan.parse(birthday));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		huiyuan.setJifen(jifen == null ? (double) 0 : new Double(jifen));
		huiyuan.setAddress(address);
		huiyuan.setDes(des);
		huiyuan.setXtype(xtype == null ? 0 : new Integer(xtype));
		huiyuanSrv.update(huiyuan);
		if (forwardurl == null) {
			forwardurl = "/admin/huiyuanmanager.do?actiontype=get";
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
			Huiyuan huiyuan = huiyuanSrv.load("where id=" + id);
			if (huiyuan != null) {
				request.setAttribute("huiyuan", huiyuan);
			}
			actiontype = "update";
			request.setAttribute("id", id);
		}
		request.setAttribute("actiontype", actiontype);
		String forwardurl = request.getParameter("forwardurl");
		System.out.println("forwardurl=" + forwardurl);
		if (forwardurl == null) {
			forwardurl = "/admin/huiyuanadd.jsp";
		}
		forward(forwardurl);
	}

	/******************************************************
	 *********************** 数据绑定内部支持*********************
	 *******************************************************/
	public void get() {
		String filter = "where 1=1 ";
		String accountname = request.getParameter("accountname");
		if (accountname != null)
			filter += "  and accountname like '%" + accountname + "%'  ";
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
		List<Huiyuan> listhuiyuan = huiyuanSrv.getPageEntitys(filter,
				pageindex, pagesize);
		int recordscount = huiyuanSrv.getRecordCount(filter == null ? ""
				: filter);
		request.setAttribute("listhuiyuan", listhuiyuan);
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
			forwardurl = "/admin/huiyuanmanager.jsp";
		}
		forward(forwardurl);
	}
}
