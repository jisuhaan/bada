package com.ezen.bada.review;

public class OneDTO {
	
	int one_num;
	String id, name, content, one_date, loc;
	
	public OneDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public OneDTO(int one_num, String id, String name, String content, String one_date, String loc) {
		super();
		this.one_num = one_num;
		this.id = id;
		this.name = name;
		this.content = content;
		this.one_date = one_date;
		this.loc = loc;
	}
	
	public int getOne_num() {
		return one_num;
	}
	public void setOne_num(int one_num) {
		this.one_num = one_num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getOne_date() {
		return one_date;
	}
	public void setOne_date(String one_date) {
		this.one_date = one_date;
	}
	public String getLoc() {
		return loc;
	}
	public void setLoc(String loc) {
		this.loc = loc;
	}
	
}
