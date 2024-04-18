package com.ezen.bada.inquire;

public class Inquire_personal_reply_DTO {

	int ip_r_num;
	String reply, ip_r_date;
	int ip_num;
	
	public Inquire_personal_reply_DTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Inquire_personal_reply_DTO(int ip_r_num, String reply, String ip_r_date, int ip_num) {
		super();
		this.ip_r_num = ip_r_num;
		this.reply = reply;
		this.ip_r_date = ip_r_date;
		this.ip_num = ip_num;
	}

	public int getIp_r_num() {
		return ip_r_num;
	}

	public void setIp_r_num(int ip_r_num) {
		this.ip_r_num = ip_r_num;
	}

	public String getReply() {
		return reply;
	}

	public void setReply(String reply) {
		this.reply = reply;
	}

	public String getIp_r_date() {
		return ip_r_date;
	}

	public void setIp_r_date(String ip_r_date) {
		this.ip_r_date = ip_r_date;
	}

	public int getIp_num() {
		return ip_num;
	}

	public void setIp_num(int ip_num) {
		this.ip_num = ip_num;
	}
	
	
}
