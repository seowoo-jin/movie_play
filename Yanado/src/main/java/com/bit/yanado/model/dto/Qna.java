package com.bit.yanado.model.dto;

import java.util.Date;

public class Qna {
	
	private int qnaSeq;
	private String title;
	private Date writeDate;
	private String cont;
	private String reply;
	private  String isReply;
	private Date replyDate;
	private String replyAdmin;
	private String id;
	
	
	public int getQnaSeq() {
		return qnaSeq;
	}
	public void setQnaSeq(int qnaSeq) {
		this.qnaSeq = qnaSeq;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Date getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}
	public String getCont() {
		return cont;
	}
	public void setCont(String cont) {
		this.cont = cont;
	}
	public String getReply() {
		return reply;
	}
	public void setReply(String reply) {
		this.reply = reply;
	}
	public String getIsReply() {
		return isReply;
	}
	public void setIsReply(String isReply) {
		this.isReply = isReply;
	}
	public Date getReplyDate() {
		return replyDate;
	}
	public void setReplyDate(Date replyDate) {
		this.replyDate = replyDate;
	}
	public String getReplyAdmin() {
		return replyAdmin;
	}
	public void setReplyAdmin(String replyAdmin) {
		this.replyAdmin = replyAdmin;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	
	@Override
	public String toString() {
		return "Qna [qnaSeq=" + qnaSeq + ", title=" + title + ", writeDate=" + writeDate + ", cont=" + cont + ", reply="
				+ reply + ", isReply=" + isReply + ", replyDate=" + replyDate + ", replyAdmin=" + replyAdmin + "]";
	}
	
	
	
}
