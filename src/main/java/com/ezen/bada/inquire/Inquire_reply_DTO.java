package com.ezen.bada.inquire;

public class Inquire_reply_DTO {
	
	int inquire_reply_num;
	String content, inquire_reply_date;
	int inquire_num;
	
	public Inquire_reply_DTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Inquire_reply_DTO(int inquire_reply_num, String content, String inquire_reply_date, int inquire_num) {
		super();
		this.inquire_reply_num = inquire_reply_num;
		this.content = content;
		this.inquire_reply_date = inquire_reply_date;
		this.inquire_num = inquire_num;
	}

	public int getInquire_reply_num() {
		return inquire_reply_num;
	}

	public void setInquire_reply_num(int inquire_reply_num) {
		this.inquire_reply_num = inquire_reply_num;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getInquire_reply_date() {
		return inquire_reply_date;
	}

	public void setInquire_reply_date(String inquire_reply_date) {
		this.inquire_reply_date = inquire_reply_date;
	}

	public int getInquire_num() {
		return inquire_num;
	}

	public void setInquire_num(int inquire_num) {
		this.inquire_num = inquire_num;
	}
	
	
}
