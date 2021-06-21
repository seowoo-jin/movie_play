package com.bit.yanado.model.dto;

public class BookMark {
	
	private int bookmarkSeq;
	private  String id;
	private  int uniqueNo;
	private  String subTimestamp;
	private  String subtitle;
	private String title;
	private int season;
	private int episode;
	
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getSeason() {
		return season;
	}

	public void setSeason(int season) {
		this.season = season;
	}

	public int getEpisode() {
		return episode;
	}

	public void setEpisode(int episode) {
		this.episode = episode;
	}
	
	
	public BookMark() {
		
	}
	
	public BookMark(int bookmarkSeq, String id, int uniqueNo, String subTimestamp, String subtitle) {
		super();
		this.bookmarkSeq = bookmarkSeq;
		this.id = id;
		this.uniqueNo = uniqueNo;
		this.subTimestamp = subTimestamp;
		this.subtitle = subtitle;
	}
	public int getBookmarkSeq() {
		return bookmarkSeq;
	}
	public void setBookmarkSeq(int bookmarkSeq) {
		this.bookmarkSeq = bookmarkSeq;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getUniqueNo() {
		return uniqueNo;
	}
	public void setUniqueNo(int uniqueNo) {
		this.uniqueNo = uniqueNo;
	}
	public String getSubTimestamp() {
		return subTimestamp;
	}
	public void setSubTimestamp(String subTimestamp) {
		this.subTimestamp = subTimestamp;
	}
	public String getSubtitle() {
		return subtitle;
	}
	public void setSubtitle(String subtitle) {
		this.subtitle = subtitle;
	}
	@Override
	public String toString() {
		return "bookmark [bookmarkSeq=" + bookmarkSeq + ", id=" + id + ", uniqueNo=" + uniqueNo + ", subTimestamp="
				+ subTimestamp + ", subtitle=" + subtitle + "]";
	}
	
	
	
	
}
