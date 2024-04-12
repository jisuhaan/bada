package com.ezen.bada.inquire;

public class InquireDTO2 {
	
	int inquire_num;
	String title, category, name, id, i_date, pic1, pic2, pic3, pic4, pic5, content, secret, secret_pw;
	int reply, rec, cnt;
	
	public InquireDTO2() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public InquireDTO2(int inquire_num, String title, String category, String name, String id, String i_date,
			String pic1, String pic2, String pic3, String pic4, String pic5, String content, String secret,
			String secret_pw, int reply, int rec, int cnt) {
		super();
		this.inquire_num = inquire_num;
		this.title = title;
		this.category = category;
		this.name = name;
		this.id = id;
		this.i_date = i_date;
		this.pic1 = pic1;
		this.pic2 = pic2;
		this.pic3 = pic3;
		this.pic4 = pic4;
		this.pic5 = pic5;
		this.content = content;
		this.secret = secret;
		this.secret_pw = secret_pw;
		this.reply = reply;
		this.rec = rec;
		this.cnt = cnt;
	}
	
	public int getInquire_num() {
		return inquire_num;
	}
	public void setInquire_num(int inquire_num) {
		this.inquire_num = inquire_num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getI_date() {
		return i_date;
	}
	public void setI_date(String i_date) {
		this.i_date = i_date;
	}
	public String getPic1() {
		return pic1;
	}
	public void setPic1(String pic1) {
		this.pic1 = pic1;
	}
	public String getPic2() {
		return pic2;
	}
	public void setPic2(String pic2) {
		this.pic2 = pic2;
	}
	public String getPic3() {
		return pic3;
	}
	public void setPic3(String pic3) {
		this.pic3 = pic3;
	}
	public String getPic4() {
		return pic4;
	}
	public void setPic4(String pic4) {
		this.pic4 = pic4;
	}
	public String getPic5() {
		return pic5;
	}
	public void setPic5(String pic5) {
		this.pic5 = pic5;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getSecret() {
		return secret;
	}
	public void setSecret(String secret) {
		this.secret = secret;
	}
	public String getSecret_pw() {
		return secret_pw;
	}
	public void setSecret_pw(String secret_pw) {
		this.secret_pw = secret_pw;
	}
	public int getReply() {
		return reply;
	}
	public void setReply(int reply) {
		this.reply = reply;
	}
	public int getRec() {
		return rec;
	}
	public void setRec(int rec) {
		this.rec = rec;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	
}
