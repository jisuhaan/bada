package com.ezen.bada.member;

import java.util.List;

public class BadaSuggestDTO {
	
	int beach_code;
	String beach,picture1;
	double latitude,longitude,distance;
	double avgscore;
	int reviewsu;
	List<String> hashtags;


	public BadaSuggestDTO() {}

	public int getBeach_code() {
		return beach_code;
	}

	public void setBeach_code(int beach_code) {
		this.beach_code = beach_code;
	}

	public String getBeach() {
		return beach;
	}

	public void setBeach(String beach) {
		this.beach = beach;
	}

	public double getLatitude() {
		return latitude;
	}

	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	public double getLongitude() {
		return longitude;
	}

	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}

	public double getDistance() {
		return distance;
	}

	public void setDistance(double distance) {
		this.distance = distance;
	}

	public String getPicture1() {
		return picture1;
	}

	public void setPicture1(String picture1) {
		this.picture1 = picture1;
	}

	public double getAvgscore() {
		return avgscore;
	}

	public void setAvgscore(double avgscore) {
		this.avgscore = avgscore;
	}

	public int getReviewsu() {
		return reviewsu;
	}

	public void setReviewsu(int reviewsu) {
		this.reviewsu = reviewsu;
	}

	public List<String> getHashtags() {
		return hashtags;
	}

	public void setHashtags(List<String> hashtags) {
		this.hashtags = hashtags;
	}

}
