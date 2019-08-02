package com.daowen.entity;

import java.util.Date;
import javax.persistence.*;

@Entity
public class Wagebill {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	private String zgname;

	public String getZgname() {
		return zgname;
	}

	public void setZgname(String zgname) {
		this.zgname = zgname;
	}

	private String accountname;

	public String getAccountname() {
		return accountname;
	}

	public void setAccountname(String accountname) {
		this.accountname = accountname;
	}

	private String nianyue;

	public String getNianyue() {
		return nianyue;
	}

	public void setNianyue(String nianyue) {
		this.nianyue = nianyue;
	}

	private Double basicwage;

	public Double getBasicwage() {
		return basicwage;
	}

	public void setBasicwage(Double basicwage) {
		this.basicwage = basicwage;
	}

	private int  workdays;
	public int getWorkdays() {
		return workdays;
	}

	public void setWorkdays(int workdays) {
		this.workdays = workdays;
	}

	private Double totalwage;

	public Double getTotalwage() {
		return totalwage;
	}

	public void setTotalwage(Double totalwage) {
		this.totalwage = totalwage;
	}

	private Date createtime;

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}



	private String creator;

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}
	private int hyid;

	public int getHyid() {
		return hyid;
	}

	public void setHyid(int hyid) {
		this.hyid = hyid;
	}

}
