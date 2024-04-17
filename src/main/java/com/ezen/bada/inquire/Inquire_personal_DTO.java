package com.ezen.bada.inquire;

public class Inquire_personal_DTO {
	
	int ip_num;
	String title, name, id, email, category, content, ip_date, pic1, pic2, pic3, pic4, pic5, tf;
	
	public Inquire_personal_DTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Inquire_personal_DTO(int ip_num, String title, String name, String id, String email, String category,
			String content, String ip_date, String pic1, String pic2, String pic3, String pic4, String pic5,
			String tf) {
		super();
		this.ip_num = ip_num;
		this.title = title;
		this.name = name;
		this.id = id;
		this.email = email;
		this.category = category;
		this.content = content;
		this.ip_date = ip_date;
		this.pic1 = pic1;
		this.pic2 = pic2;
		this.pic3 = pic3;
		this.pic4 = pic4;
		this.pic5 = pic5;
		this.tf = tf;
	}

	public int getIp_num() {
		return ip_num;
	}

	public void setIp_num(int ip_num) {
		this.ip_num = ip_num;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getIp_date() {
		return ip_date;
	}

	public void setIp_date(String ip_date) {
		this.ip_date = ip_date;
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

	public String getTf() {
		return tf;
	}

	public void setTf(String tf) {
		this.tf = tf;
	}

	

}