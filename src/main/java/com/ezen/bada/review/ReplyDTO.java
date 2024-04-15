package com.ezen.bada.review;

public class ReplyDTO {
	
	int review_num,reply_num;
	String id, reply_day, reply_contents;
	
	public ReplyDTO() {}

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

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getReply_day() {
		return reply_day;
	}

	public void setReply_day(String reply_day) {
		this.reply_day = reply_day;
	}

	public String getReply_contents() {
		return reply_contents.replaceAll("\n", "<br>");
	}

	public void setReply_contents(String reply_contents) {
		this.reply_contents = reply_contents;
	}
	
	
	

}
