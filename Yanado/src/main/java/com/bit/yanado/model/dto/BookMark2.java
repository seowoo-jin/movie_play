package com.bit.yanado.model.dto;

public class BookMark2 {
	
	private int bookmarkSeq;
	private  String id;
	private  int uniqueNo;
	private  String subTimestamp;
	private  String subtitle;
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
