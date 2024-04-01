package com.ezen.bada.weathers;

public class Bada_default_DTO {
	// 해수욕장 기본 정보
	String beach_code; //해변코드
	String beach;
	String state;
	String address;
	double latitude;
	double longitude;
	int grid_x;
	int grid_y;
	
	Bada_list_DTO bada_list_dto;
	
	Bada_tw_DTO bada_tw_dto;
	

	public Bada_default_DTO() {}


	public Bada_default_DTO(String beach_code, String beach, String state, String address, double latitude,
			double longitude, int grid_x, int grid_y, Bada_list_DTO bada_list_dto, Bada_tw_DTO bada_tw_dto) {
		super();
		this.beach_code = beach_code;
		this.beach = beach;
		this.state = state;
		this.address = address;
		this.latitude = latitude;
		this.longitude = longitude;
		this.grid_x = grid_x;
		this.grid_y = grid_y;
		this.bada_list_dto = bada_list_dto;
		this.bada_tw_dto = bada_tw_dto;
	}


	public String getBeach_code() {
		return beach_code;
	}


	public void setBeach_code(String beach_code) {
		this.beach_code = beach_code;
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


	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
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


	public Bada_list_DTO getBada_list_dto() {
		return bada_list_dto;
	}


	public void setBada_list_dto(Bada_list_DTO bada_list_dto) {
		this.bada_list_dto = bada_list_dto;
	}


	public Bada_tw_DTO getBada_tw_dto() {
		return bada_tw_dto;
	}


	public void setBada_tw_dto(Bada_tw_DTO bada_tw_dto) {
		this.bada_tw_dto = bada_tw_dto;
	}

}
	
