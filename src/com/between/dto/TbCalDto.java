package com.between.dto;

import java.sql.Date;

//커플일정달력 
public class TbCalDto {

 // 일정번호 
 private int calNum;

 // 커플 그룹 번호 
 private int groupNum;

 // 일정제목 
 private String calTitle;

 // 일정내용 
 private String calContent;

 // 일정시간 
 private String calTime;

 // 작성일자 
 private Date calDate;
 
 public TbCalDto() {
	 
 }
 
 

 public TbCalDto(int calNum, int groupNum, String calTitle, String calContent, String calTime, Date calDate) {
	super();
	this.calNum = calNum;
	this.groupNum = groupNum;
	this.calTitle = calTitle;
	this.calContent = calContent;
	this.calTime = calTime;
	this.calDate = calDate;
}



public int getCalNum() {
     return calNum;
 }

 public void setCalNum(int calNum) {
     this.calNum = calNum;
 }

 public int getGroupNum() {
     return groupNum;
 }

 public void setGroupNum(int groupNum) {
     this.groupNum = groupNum;
 }

 public String getCalTitle() {
     return calTitle;
 }

 public void setCalTitle(String calTitle) {
     this.calTitle = calTitle;
 }

 public String getCalContent() {
     return calContent;
 }

 public void setCalContent(String calContent) {
     this.calContent = calContent;
 }

 public String getCalTime() {
     return calTime;
 }

 public void setCalTime(String calTime) {
     this.calTime = calTime;
 }

 public Date getCalDate() {
     return calDate;
 }

 public void setCalDate(Date calDate) {
     this.calDate = calDate;
 }
 

@Override
public String toString() {
	return "TbCalDto [calNum=" + calNum + ", groupNum=" + groupNum + ", calTitle=" + calTitle + ", calContent="
			+ calContent + ", calTime=" + calTime + ", calDate=" + calDate + "]";
}

}