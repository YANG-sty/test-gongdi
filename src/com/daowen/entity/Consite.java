package com.daowen.entity;
import java.util.Date;
import javax.persistence.*;
@Entity
public class Consite
{
@Id
@GeneratedValue(strategy =GenerationType.AUTO)
   private int id ;
   public int getId() 
   {
      return id;
  }
   public void setId(int id) 
   {
      this.id= id;
  }
   private String csno ;
   public String getCsno() 
   {
      return csno;
  }
   public void setCsno(String csno) 
   {
      this.csno= csno;
  }
   private String csname ;
   public String getCsname() 
   {
      return csname;
  }
   public void setCsname(String csname) 
   {
      this.csname= csname;
  }
   private String tupian ;
   public String getTupian() 
   {
      return tupian;
  }
   public void setTupian(String tupian) 
   {
      this.tupian= tupian;
  }
   private String hyid ;
   public String getHyid() 
   {
      return hyid;
  }
   public void setHyid(String hyid) 
   {
      this.hyid= hyid;
  }
   private Date begindate ;
   public Date getBegindate() 
   {
      return begindate;
  }
   public void setBegindate(Date begindate) 
   {
      this.begindate= begindate;
  }
   private String des ;
   public String getDes() 
   {
      return des;
  }
   public void setDes(String des) 
   {
      this.des= des;
  }
}
