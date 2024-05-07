package com.ezen.bada.weathers;

public class Bada_tw_DTO {
	// 수온, 파고 담은 DTO

	String record_time;
	String water_temp;
	String water_height;
	
	public Bada_tw_DTO() {}

	public Bada_tw_DTO(String record_time, String water_temp, String water_height) {
		super();
		this.record_time = record_time;
		this.water_temp = water_temp;
		this.water_height = water_height;
	}

	public String getRecord_time() {
		return record_time;
	}

	public void setRecord_time(String record_time) {
		this.record_time = record_time;
	}

	public String getWater_temp() {
		return water_temp;
	}

	public void setWater_temp(String water_temp) {
		this.water_temp = water_temp;
	}

	public String getWater_height() {
		return water_height;
	}

	public void setWater_height(String water_height) {
		this.water_height = water_height;
	}

	
}
