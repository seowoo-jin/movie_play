package com.bit.yanado.model.dto;

public class VideoTitle {
	
	private int titleSeq;
	private  String title;
	public int getTitleSeq() {
		return titleSeq;
	}
	public void setTitleSeq(int titleSeq) {
		this.titleSeq = titleSeq;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	@Override
	public String toString() {
		return "videotitle [titleSeq=" + titleSeq + ", title=" + title + "]";
	}
	
	
	
	
}
