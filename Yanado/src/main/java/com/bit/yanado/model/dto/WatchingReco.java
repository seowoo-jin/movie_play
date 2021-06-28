package com.bit.yanado.model.dto;

import java.util.Date;

public class WatchingReco {
	
	private int historySeq;
	private String id;
	private int uniqueNo;
	private  String recentPo;
	private  String iswatch;
	private  Date recentTime;
	public int getHistorySeq() {
		return historySeq;
	}
	public void setHistorySeq(int historySeq) {
		this.historySeq = historySeq;
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
	public String getRecentPo() {
		return recentPo;
	}
	public void setRecentPo(String recentPo) {
		this.recentPo = recentPo;
	}
	public String getIswatch() {
		return iswatch;
	}
	public void setIswatch(String iswatch) {
		this.iswatch = iswatch;
	}
	public Date getRecentTime() {
		return recentTime;
	}
	public void setRecentTime(Date recentTime) {
		this.recentTime = recentTime;
	}
	@Override
	public String toString() {
		return "watchingreco [historySeq=" + historySeq + ", id=" + id + ", uniqueNo=" + uniqueNo + ", recentPo="
				+ recentPo + ", iswatch=" + iswatch + ", recentTime=" + recentTime + "]";
	}
	
	
	
	
}
