package com.ezen.bada.review;

public class Review_reply_report_DTO {
	
	int review_reply_ban_num, review_num, reply_num,ban_user_number,user_number;
	String id, ban_id,reply_contents,reason,detail,ban_date, name, ban_name;
	
	public Review_reply_report_DTO() {}

	public int getReview_reply_ban_num() {
		return review_reply_ban_num;
	}

	public void setReview_reply_ban_num(int review_reply_ban_num) {
		this.review_reply_ban_num = review_reply_ban_num;
	}

	public int getReview_num() {
		return review_num;
	}

	public void setReview_num(int review_num) {
		this.review_num = review_num;
	}

	public int getReply_num() {
		return reply_num;
	}

	public void setReply_num(int reply_num) {
		this.reply_num = reply_num;
	}

	public int getBan_user_number() {
		return ban_user_number;
	}

	public void setBan_user_number(int ban_user_number) {
		this.ban_user_number = ban_user_number;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getBan_id() {
		return ban_id;
	}

	public void setBan_id(String ban_id) {
		this.ban_id = ban_id;
	}

	public String getReply_contents() {
		return reply_contents;
	}

	public void setReply_contents(String reply_contents) {
		this.reply_contents = reply_contents;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getBan_date() {
		return ban_date;
	}

	public void setBan_date(String ban_date) {
		this.ban_date = ban_date;
	}

	public int getUser_number() {
		return user_number;
	}

	public void setUser_number(int user_number) {
		this.user_number = user_number;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getBan_name() {
		return ban_name;
	}

	public void setBan_name(String ban_name) {
		this.ban_name = ban_name;
	}
	
	
	
	

}
