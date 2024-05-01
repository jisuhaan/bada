package com.ezen.bada.weathers;

import java.util.ArrayList;

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
	
	// 저장해올 API 정보들
	ArrayList<VilageFcstBeach_DTO> bada_list_dto; // 단기 예보 24시간
	
	Bada_tw_DTO bada_tw_dto; // 수온과 파고
	
	Bada_tmx_n_DTO bada_tmx_n_dto; // 최고, 최저
	
	UltraSrtFcstBeach_DTO ultraSrtFcstBeach_dto; // 초단기예보

	LC_Rise_Set_Info_DTO lc_rise_set_info_dto; // 일출, 일몰
	
	
	public Bada_default_DTO() {}


	public Bada_default_DTO(String beach_code, String beach, String state, String address, double latitude,
			double longitude, int grid_x, int grid_y, ArrayList<VilageFcstBeach_DTO> bada_list_dto,
			Bada_tw_DTO bada_tw_dto, Bada_tmx_n_DTO bada_tmx_n_dto, UltraSrtFcstBeach_DTO ultraSrtFcstBeach_dto,
			LC_Rise_Set_Info_DTO lc_rise_set_info_dto) {
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
		this.bada_tmx_n_dto = bada_tmx_n_dto;
		this.ultraSrtFcstBeach_dto = ultraSrtFcstBeach_dto;
		this.lc_rise_set_info_dto = lc_rise_set_info_dto;
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


	public ArrayList<VilageFcstBeach_DTO> getBada_list_dto() {
		return bada_list_dto;
	}


	public void setBada_list_dto(ArrayList<VilageFcstBeach_DTO> bada_list_dto) {
		this.bada_list_dto = bada_list_dto;
	}


	public Bada_tw_DTO getBada_tw_dto() {
		return bada_tw_dto;
	}


	public void setBada_tw_dto(Bada_tw_DTO bada_tw_dto) {
		this.bada_tw_dto = bada_tw_dto;
	}


	public Bada_tmx_n_DTO getBada_tmx_n_dto() {
		return bada_tmx_n_dto;
	}


	public void setBada_tmx_n_dto(Bada_tmx_n_DTO bada_tmx_n_dto) {
		this.bada_tmx_n_dto = bada_tmx_n_dto;
	}


	public UltraSrtFcstBeach_DTO getUltraSrtFcstBeach_dto() {
		return ultraSrtFcstBeach_dto;
	}


	public void setUltraSrtFcstBeach_dto(UltraSrtFcstBeach_DTO ultraSrtFcstBeach_dto) {
		this.ultraSrtFcstBeach_dto = ultraSrtFcstBeach_dto;
	}


	public LC_Rise_Set_Info_DTO getLc_rise_set_info_dto() {
		return lc_rise_set_info_dto;
	}


	public void setLc_rise_set_info_dto(LC_Rise_Set_Info_DTO lc_rise_set_info_dto) {
		this.lc_rise_set_info_dto = lc_rise_set_info_dto;
	}

	
}