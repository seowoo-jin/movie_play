package com.bit.yanado.model.dto;

import java.util.Date;

public class AdminInfo {
	private  int adminSeq;
	private  String adminId;
	private  String adminPw;
	private  String adminName;
	private Date adminDate;
	public int getAdminSeq() {
		return adminSeq;
	}
	public void setAdminSeq(int adminSeq) {
		this.adminSeq = adminSeq;
	}
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getAdminPw() {
		return adminPw;
	}
	public void setAdminPw(String adminPw) {
		this.adminPw = adminPw;
	}
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	public Date getAdminDate() {
		return adminDate;
	}
	public void setAdminDate(Date adminDate) {
		this.adminDate = adminDate;
	}
	@Override
	public String toString() {
		return "admininfo [adminSeq=" + adminSeq + ", adminId=" + adminId + ", adminPw=" + adminPw + ", adminName="
				+ adminName + ", adminDate=" + adminDate + "]";
	}
	
	
}
