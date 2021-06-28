package com.bit.yanado.model.dto;

public class Tag {
	private  int tagSeq;
	private int uniqueNo;
	private  int tagNameSeq;
	public int getTagSeq() {
		return tagSeq;
	}
	public void setTagSeq(int tagSeq) {
		this.tagSeq = tagSeq;
	}
	public int getUniqueNo() {
		return uniqueNo;
	}
	public void setUniqueNo(int uniqueNo) {
		this.uniqueNo = uniqueNo;
	}
	public int getTagNameSeq() {
		return tagNameSeq;
	}
	public void setTagNameSeq(int tagNameSeq) {
		this.tagNameSeq = tagNameSeq;
	}
	@Override
	public String toString() {
		return "tag [tagSeq=" + tagSeq + ", uniqueNo=" + uniqueNo + ", tagNameSeq=" + tagNameSeq + "]";
	}
	
	
}
