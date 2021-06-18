package com.bit.yanado.model.dto;

import java.util.Date;

public class Teaser {
	
	private int teaserSeq;
	private  int titleSeq;
	private  String teaserLink;
	private  Date uploadDate;
	private String isMain;
	
	public String getIsMain() {
		return isMain;
	}
	public void setIsMain(String isMain) {
		this.isMain = isMain;
	}
	public int getTeaserSeq() {
		return teaserSeq;
	}
	public void setTeaserSeq(int teaserSeq) {
		this.teaserSeq = teaserSeq;
	}
	public int getTitleSeq() {
		return titleSeq;
	}
	public void setTitleSeq(int titleSeq) {
		this.titleSeq = titleSeq;
	}
	public String getTeaserLink() {
		return teaserLink;
	}
	public void setTeaserLink(String teaserLink) {
		this.teaserLink = teaserLink;
	}
	public Date getUploadDate() {
		return uploadDate;
	}
	public void setUploadDate(Date uploadDate) {
		this.uploadDate = uploadDate;
	}
	@Override
	public String toString() {
		return "Teaser [teaserSeq=" + teaserSeq + ", titleSeq=" + titleSeq + ", teaserLink=" + teaserLink
				+ ", uploadDate=" + uploadDate + "]";
	}
	
	
	
}
