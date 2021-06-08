package com.bit.yanado.model.dto;

public class TagName {
	private int tagNameSeq;
	private String tagName;
	private int tagCount;
	
	public int getTagNameSeq() {
		return tagNameSeq;
	}
	public void setTagNameSeq(int tagNameSeq) {
		this.tagNameSeq = tagNameSeq;
	}
	public String getTagName() {
		return tagName;
	}
	public void setTagName(String tagName) {
		this.tagName = tagName;
	}
	public int getTagCount() {
		return tagCount;
	}
	public void setTagCount(int tagCount) {
		this.tagCount = tagCount;
	}
	@Override
	public String toString() {
		return "tagName [tagNameSeq=" + tagNameSeq + ", tagName=" + tagName + ", tagCount=" + tagCount + "]";
	}
	
	
	
}
