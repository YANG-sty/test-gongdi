package com.daowen.entity;

import java.util.Date;
import javax.persistence.*;

@Entity
public class Spcategory {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	private String name;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	private int hyid;

	public int getHyid() {
		return hyid;
	}

	public void setHyid(int hyid) {
		this.hyid = hyid;
	}

}
