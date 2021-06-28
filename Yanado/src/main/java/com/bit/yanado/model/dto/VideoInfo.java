package com.bit.yanado.model.dto;

import java.util.Date;

public class VideoInfo {
	
	private int uniqueNo;
	private  String title;
	private  String link;
	private  int season;
	private  int episode;
	private  Date uploadDate;
	private  String people;
	private  String synop;
	private  String subEng;
	private  String subKor;
	private  String subMix;
	
	
	public int getUniqueNo() {
		return uniqueNo;
	}
	public void setUniqueNo(int uniqueNo) {
		this.uniqueNo = uniqueNo;
	}
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
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public Date getUploadDate() {
		return uploadDate;
	}
	public void setUploadDate(Date uploadDate) {
		this.uploadDate = uploadDate;
	}
	public String getPeople() {
		return people;
	}
	public void setPeople(String people) {
		this.people = people;
	}
	public String getSynop() {
		return synop;
	}
	public void setSynop(String synop) {
		this.synop = synop;
	}
	public String getSubEng() {
		return subEng;
	}
	public void setSubEng(String subEng) {
		this.subEng = subEng;
	}
	public String getSubKor() {
		return subKor;
	}
	public void setSubKor(String subKor) {
		this.subKor = subKor;
	}
	public String getSubMix() {
		return subMix;
	}
	public void setSubMix(String subMix) {
		this.subMix = subMix;
	}
	@Override
	public String toString() {
		return "videoinfo [uniqueNo=" + uniqueNo + ", title=" + title + ", link=" + link + ", uploadDate=" + uploadDate
				+ ", people=" + people + ", synop=" + synop + ", subEng=" + subEng + ", subKor=" + subKor + ", subMix="
				+ subMix + "]";
	}
	
	
	
}
