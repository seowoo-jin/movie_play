package com.bit.yanado.model.dto;

import java.util.Arrays;

public class Poster {
	
	private int posterSeq;
	private String poster;
	private int titleSeq;
	private int season;
	public int getPosterSeq() {
		return posterSeq;
	}
	public void setPosterSeq(int posterSeq) {
		this.posterSeq = posterSeq;
	}
	public String getPoster() {
		return poster;
	}
	public void setPoster(String poster) {
		this.poster = poster;
	}
	public int getTitleSeq() {
		return titleSeq;
	}
	public void setTitleSeq(int titleSeq) {
		this.titleSeq = titleSeq;
	}
	public int getSeason() {
		return season;
	}
	public void setSeason(int season) {
		this.season = season;
	}
	@Override
	public String toString() {
		return "Poster [posterSeq=" + posterSeq + ", poster=" +poster + ", titleSeq=" + titleSeq
				+ ", season=" + season + "]";
	}
	
	
	
	
}
