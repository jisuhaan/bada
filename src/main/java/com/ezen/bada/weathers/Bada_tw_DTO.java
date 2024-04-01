package com.ezen.bada.weathers;

public class Bada_tw_DTO {
	String beachNum;
	String tm;
	double tw;
	
	public Bada_tw_DTO() {}
	
	public Bada_tw_DTO(String beachNum, String tm, double tw) {
		super();
		this.beachNum = beachNum;
		this.tm = tm;
		this.tw = tw;
	}
	
	public String getBeachNum() {
		return beachNum;
	}
	public void setBeachNum(String beachNum) {
		this.beachNum = beachNum;
	}
	public String getTm() {
		return tm;
	}
	public void setTm(String tm) {
		this.tm = tm;
	}
	public double getTw() {
		return tw;
	}
	public void setTw(double tw) {
		this.tw = tw;
	}
	
	
}
