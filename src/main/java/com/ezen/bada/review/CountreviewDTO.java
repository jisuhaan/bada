package com.ezen.bada.review;

public class CountreviewDTO {
	
	String area;
	int today_review;
	int all_review;
	
	public CountreviewDTO() {}

	public CountreviewDTO(String area, int today_review, int all_review) {
		super();
		this.area = area;
		this.today_review = today_review;
		this.all_review = all_review;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public int getToday_review() {
		return today_review;
	}

	public void setToday_review(int today_review) {
		this.today_review = today_review;
	}

	public int getAll_review() {
		return all_review;
	}

	public void setAll_review(int all_review) {
		this.all_review = all_review;
	}
	
	

}
