package com.daowen.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellRangeAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.daowen.entity.Wagebill;
import com.daowen.entity.Zhiwu;
import com.daowen.entity.Zhiyuan;
import com.daowen.service.WagebillService;
import com.daowen.service.ZhiwuService;
import com.daowen.service.ZhiyuanService;
import com.daowen.ssm.simplecrud.SimpleController;
import com.daowen.webcontrol.PagerMetal;

/**************************
 * 
 * 控制
 *
 */
@Controller
public class WagebillController extends SimpleController {
	@Autowired
	// 业务服务
	private WagebillService wagebillSrv = null;
	@Autowired
	private ZhiyuanService  zhiyuanSrv=null;
	@Autowired
	private ZhiwuService  zhiwuSrv=null;
	
	@Override
	@RequestMapping("/admin/wagebillmanager.do")
	public void mapping(HttpServletRequest request, HttpServletResponse response) {
		mappingMethod(request, response);
	}

	private void export() {

		HSSFWorkbook wkb = new HSSFWorkbook();
		// 建立新的sheet对象（excel的表单）
		HSSFSheet sheet = wkb.createSheet("工资账单表");
		// 在sheet里创建第一行，参数为行索引(excel的行)，可以是0～65535之间的任何一个
		HSSFRow row1 = sheet.createRow(0);
		// 创建单元格（excel的单元格，参数为列索引，可以是0～255之间的任何一个
		HSSFCell cell = row1.createCell(0);
		// 设置单元格内容
		cell.setCellValue("工资账单信息");
		// 合并单元格CellRangeAddress构造参数依次表示起始行，截至行，起始列， 截至列
		sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 3));
		// 在sheet里创建第二行
		HSSFRow rowtitle = sheet.createRow(1);
		// 创建单元格并设置单元格内容
		rowtitle.createCell(0).setCellValue("姓名");
		rowtitle.createCell(1).setCellValue("工号");
		rowtitle.createCell(2).setCellValue("年度");
		rowtitle.createCell(3).setCellValue("工作天数");
		rowtitle.createCell(4).setCellValue("每天工资");
		rowtitle.createCell(5).setCellValue("总工资");
		rowtitle.createCell(6).setCellValue("出账时间");
		rowtitle.createCell(7).setCellValue("出账人");
		
		
		int i=2;
		List<Wagebill> listWagebill=wagebillSrv.getEntity("");
		
		for(Wagebill wagebill : listWagebill){
			HSSFRow rowcontent=sheet.createRow(i);
			rowcontent.createCell(0).setCellValue(wagebill.getAccountname());
			rowcontent.createCell(1).setCellValue(wagebill.getZgname());
			
			rowcontent.createCell(2).setCellValue(wagebill.getNianyue());
			
			rowcontent.createCell(3).setCellValue(wagebill.getWorkdays());
			rowcontent.createCell(4).setCellValue(wagebill.getBasicwage());
			rowcontent.createCell(5).setCellValue(wagebill.getTotalwage());
			rowcontent.createCell(6).setCellValue(wagebill.getCreatetime());
			rowcontent.createCell(7).setCellValue(wagebill.getCreator());

			i++;
		}

		OutputStream output = null;
		try {
			output = response.getOutputStream();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		response.reset();
		response.setHeader("Content-disposition",
				"attachment; filename=wagebill.xls");
		response.setContentType("application/msexcel");
		try {
			wkb.write(output);

			output.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	/********************************************************
	 ****************** 信息注销监听支持*****************************
	 *********************************************************/
	public void delete() {
		String id = request.getParameter("id");
		wagebillSrv.delete(" where id=" + id);
		get();
	}
	
	
	/*************************************************************
	 **************** 保存动作监听支持******************************
	 **************************************************************/
	public void save() {
		String forwardurl = request.getParameter("forwardurl");
		// 验证错误url
		String errorurl = request.getParameter("errorurl");
		String zgname = request.getParameter("zgname");
		String accountname = request.getParameter("accountname");
		String niandu = request.getParameter("niandu");
		String yuefen = request.getParameter("yuefen");
		String workdays = request.getParameter("workdays");
		String hyid = request.getParameter("hyid");
		String creator = request.getParameter("creator");
		SimpleDateFormat sdfwagebill = new SimpleDateFormat("yyyy-MM-dd");
		Wagebill wagebill = new Wagebill();
		List<Zhiwu> listZhiwu = zhiwuSrv.query(MessageFormat.format("select * from zhiwu zw,zhiyuan zy where zy.zwid=zw.id and zy.accountname=''{0}''",accountname));
		if(listZhiwu==null&&listZhiwu.size()==0){
			
			request.setAttribute("actiontype", "save");
			request.setAttribute("wagebill", wagebill);
			Zhiyuan zhiyuan = zhiyuanSrv.load("where accountname='"
					+ wagebill.getAccountname()+"'");
			
			if (zhiyuan != null) {
				request.setAttribute("zhiyuan", zhiyuan);
				
			}
			request.setAttribute("errormsg",  MessageFormat.format("<label class=\"error\">员工{0}职务信息异常</label>",accountname));
			forward(errorurl);
			
			return ;
		}
		
		Zhiwu temZhiwu=listZhiwu.get(0);
		wagebill.setZgname(zgname == null ? "" : zgname);
		wagebill.setAccountname(accountname == null ? "" : accountname);
		wagebill.setNianyue(niandu+"-"+yuefen);
		wagebill.setWorkdays(Integer.parseInt(workdays));
		wagebill.setBasicwage(temZhiwu.getSalary()*1.0);
		wagebill.setTotalwage(wagebill.getWorkdays()*temZhiwu.getSalary()*1.0);
		wagebill.setCreatetime(new Date());
		if(hyid!=null)
		   wagebill.setHyid(Integer.parseInt(hyid));
		wagebill.setCreator(creator == null ? "" : creator);
		
		if(wagebillSrv.isExist( MessageFormat.format("where nianyue=''{0}''  and accountname=''{1}''",wagebill.getNianyue(),accountname))){
			
			request.setAttribute("actiontype", "save");
			request.setAttribute("wagebill", wagebill);
			Zhiyuan zhiyuan = zhiyuanSrv.load("where accountname='"
					+ wagebill.getAccountname()+"'");
			
			if (zhiyuan != null) {
				request.setAttribute("operzhiyuan", zhiyuan);
				
			}
			request.setAttribute("errormsg",  MessageFormat.format("<label class=\"error\">{0}已经发放了{1}年度{2}月份工资</label>",zgname,niandu,yuefen));
			forward(errorurl);
			return;
			
		}
		
		
		wagebillSrv.save(wagebill);
		if (forwardurl == null) {
			forwardurl = "/admin/wagebillmanager.do?actiontype=get";
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
		String zyid=request.getParameter("zyid");
		if(zyid!=null){
			Zhiyuan zhiyuan = zhiyuanSrv.load("where id="
					+ zyid);
			if (zhiyuan != null) {
				request.setAttribute("operzhiyuan", zhiyuan);
			}
	    }
		dispatchParams(request, response);
		if (id != null) {
			Wagebill wagebill = wagebillSrv.load("where id="
					+ id);
			if (wagebill != null) {
				request.setAttribute("wagebill", wagebill);
			}
			actiontype = "update";
			request.setAttribute("id", id);
		}
		request.setAttribute("actiontype", actiontype);
		String forwardurl = request.getParameter("forwardurl");
		System.out.println("forwardurl=" + forwardurl);
		if (forwardurl == null) {
			forwardurl = "/admin/wagebilladd.jsp";
		}
		forward(forwardurl);
	}

	/******************************************************
	 *********************** 数据绑定内部支持*********************
	 *******************************************************/
	public void get() {
		String filter = "where 1=1 ";
		String hyid=request.getParameter("hyid");
		String zgname = request.getParameter("zgname");
		String accountname = request.getParameter("accountname");
		if (zgname != null)
			filter += "  and zgname like '%" + zgname + "%'  ";
		if(hyid!=null)
			filter+=" and hyid="+hyid;
		if (accountname != null)
			filter += "  and accountname ='" + accountname + "'  ";
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
		List<Wagebill> listwagebill =wagebillSrv.getPageEntitys( filter,
				pageindex, pagesize);
		int recordscount = wagebillSrv.getRecordCount(filter == null ? "" : filter);
		request.setAttribute("listwagebill", listwagebill);
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
			forwardurl = "/admin/wagebillmanager.jsp";
		}
		forward(forwardurl);
	}
}
