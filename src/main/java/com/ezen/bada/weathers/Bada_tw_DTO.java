package com.ezen.bada.weathers;

public class Bada_tw_DTO {

	String record_time;
	double water_temp;
	
	public Bada_tw_DTO() {}

	public Bada_tw_DTO(String record_time, double water_temp) {
		super();
		this.record_time = record_time;
		this.water_temp = water_temp;
	}

	public String getRecord_time() {
		return record_time;
	}

	public void setRecord_time(String record_time) {
		this.record_time = record_time;
	}

	public double getWater_temp() {
		return water_temp;
	}

	public void setWater_temp(double water_temp) {
		this.water_temp = water_temp;
	}
}
