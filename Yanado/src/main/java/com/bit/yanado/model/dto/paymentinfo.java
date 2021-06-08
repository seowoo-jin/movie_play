package com.bit.yanado.model.dto;

import java.util.Date;

public class PaymentInfo {

	private String id;
	private int cardNum;
	private int expDate;
	private int cvcNum;
	private  int cardPw;
	private  String memName;
	private  String cardCom;
	private  Date lastPayDate;
	private int paymentCount;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getCardNum() {
		return cardNum;
	}
	public void setCardNum(int cardNum) {
		this.cardNum = cardNum;
	}
	public int getExpDate() {
		return expDate;
	}
	public void setExpDate(int expDate) {
		this.expDate = expDate;
	}
	public int getCvcNum() {
		return cvcNum;
	}
	public void setCvcNum(int cvcNum) {
		this.cvcNum = cvcNum;
	}
	public int getCardPw() {
		return cardPw;
	}
	public void setCardPw(int cardPw) {
		this.cardPw = cardPw;
	}
	public String getMemName() {
		return memName;
	}
	public void setMemName(String memName) {
		this.memName = memName;
	}
	public String getCardCom() {
		return cardCom;
	}
	public void setCardCom(String cardCom) {
		this.cardCom = cardCom;
	}
	public Date getLastPayDate() {
		return lastPayDate;
	}
	public void setLastPayDate(Date lastPayDate) {
		this.lastPayDate = lastPayDate;
	}
	public int getPaymentCount() {
		return paymentCount;
	}
	public void setPaymentCount(int paymentCount) {
		this.paymentCount = paymentCount;
	}
	@Override
	public String toString() {
		return "paymentinfo [id=" + id + ", cardNum=" + cardNum + ", expDate=" + expDate + ", cvcNum=" + cvcNum
				+ ", cardPw=" + cardPw + ", memName=" + memName + ", cardCom=" + cardCom + ", lastPayDate="
				+ lastPayDate + ", paymentCount=" + paymentCount + "]";
	}
	
	
	
	
}
