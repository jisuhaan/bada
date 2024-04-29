package com.ezen.bada.review;

public class One_ban_DTO {
	
	int one_ban_num;
	String id, name;
	int ban_user_num;
	String ban_id, ban_name, ban_date, ban_content;
	int ban_one_num;
	
	public One_ban_DTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public One_ban_DTO(int one_ban_num, String id, String name, int ban_user_num, String ban_id, String ban_name,
			String ban_date, String ban_content, int ban_one_num) {
		super();
		this.one_ban_num = one_ban_num;
		this.id = id;
		this.name = name;
		this.ban_user_num = ban_user_num;
		this.ban_id = ban_id;
		this.ban_name = ban_name;
		this.ban_date = ban_date;
		this.ban_content = ban_content;
		this.ban_one_num = ban_one_num;
	}

	public int getOne_ban_num() {
		return one_ban_num;
	}

	public void setOne_ban_num(int one_ban_num) {
		this.one_ban_num = one_ban_num;
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

	public int getBan_user_num() {
		return ban_user_num;
	}

	public void setBan_user_num(int ban_user_num) {
		this.ban_user_num = ban_user_num;
	}

	public String getBan_id() {
		return ban_id;
	}

	public void setBan_id(String ban_id) {
		this.ban_id = ban_id;
	}

	public String getBan_name() {
		return ban_name;
	}

	public void setBan_name(String ban_name) {
		this.ban_name = ban_name;
	}

	public String getBan_date() {
		return ban_date;
	}

	public void setBan_date(String ban_date) {
		this.ban_date = ban_date;
	}

	public String getBan_content() {
		return ban_content;
	}

	public void setBan_content(String ban_content) {
		this.ban_content = ban_content;
	}

	public int getBan_one_num() {
		return ban_one_num;
	}

	public void setBan_one_num(int ban_one_num) {
		this.ban_one_num = ban_one_num;
	}
	
	

}
