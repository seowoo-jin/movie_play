package com.bit.yanado.model.dto;

import java.util.Date;

public class MemInfo {
	
	private String id;
	private String pw;
	private String name;
	private String tel;
	private String email;
	private Date joinDate;
	private int isOut;
	private Date outDate;
	private String isPay;
	private String emailAuthNum;
	private Date lastLoginDate;
	private String defaultCap;
	private int phAuthNum;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getJoinDate() {
		return joinDate;
	}
	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}
	public int getIsOut() {
		return isOut;
	}
	public void setIsOut(int isOut) {
		this.isOut = isOut;
	}
	public Date getOutDate() {
		return outDate;
	}
	public void setOutDate(Date outDate) {
		this.outDate = outDate;
	}
	public String getIsPay() {
		return isPay;
	}
	public void setIsPay(String isPay) {
		this.isPay = isPay;
	}
	public String getEmailAuthNum() {
		return emailAuthNum;
	}
	public void setEmailAuthNum(String emailAuthNum) {
		this.emailAuthNum = emailAuthNum;
	}
	public Date getLastLoginDate() {
		return lastLoginDate;
	}
	public void setLastLoginDate(Date lastLoginDate) {
		this.lastLoginDate = lastLoginDate;
	}
	public String getDefaultCap() {
		return defaultCap;
	}
	public void setDefaultCap(String defaultCap) {
		this.defaultCap = defaultCap;
	}
	public int getPhAuthNum() {
		return phAuthNum;
	}
	public void setPhAuthNum(int phAuthNum) {
		this.phAuthNum = phAuthNum;
	}
	@Override
	public String toString() {
		return "meminfo [id=" + id + ", pw=" + pw + ", name=" + name + ", tel=" + tel + ", email=" + email
				+ ", joinDate=" + joinDate + ", isOut=" + isOut + ", outDate=" + outDate + ", isPay=" + isPay
				+ ", emailAuthNum=" + emailAuthNum + ", lastLoginDate=" + lastLoginDate + ", defaultCap=" + defaultCap
				+ ", phAuthNum=" + phAuthNum + "]";
	}
	
	
	
}
