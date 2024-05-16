package com.ezen.bada.member;

public class BadaSuggestDTO {
	
	int beach_code;
	String beach;
	double latitude,longitude,distance;
	
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

}
