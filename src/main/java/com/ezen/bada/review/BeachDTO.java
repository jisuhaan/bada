package com.ezen.bada.review;

public class BeachDTO {

	String beach,state,pointname,address;
	int beach_code,grid_x,grid_y;
	double latitude, longitude;
	
	public BeachDTO() {	}

	public BeachDTO(String beach, String state, String pointname, String address, int beach_code, int grid_x,
			int grid_y, double latitude, double longitude) {
		super();
		this.beach = beach;
		this.state = state;
		this.pointname = pointname;
		this.address = address;
		this.beach_code = beach_code;
		this.grid_x = grid_x;
		this.grid_y = grid_y;
		this.latitude = latitude;
		this.longitude = longitude;
	}

	public String getBeach() {
		return beach;
	}

	public void setBeach(String beach) {
		this.beach = beach;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getPointname() {
		return pointname;
	}

	public void setPointname(String pointname) {
		this.pointname = pointname;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getBeach_code() {
		return beach_code;
	}

	public void setBeach_code(int beach_code) {
		this.beach_code = beach_code;
	}

	public int getGrid_x() {
		return grid_x;
	}

	public void setGrid_x(int grid_x) {
		this.grid_x = grid_x;
	}

	public int getGrid_y() {
		return grid_y;
	}

	public void setGrid_y(int grid_y) {
		this.grid_y = grid_y;
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
}
