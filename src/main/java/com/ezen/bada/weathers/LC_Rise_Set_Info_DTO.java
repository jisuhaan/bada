package com.ezen.bada.weathers;

public class LC_Rise_Set_Info_DTO {
	String sunrise;
	String sunset;
	
	public LC_Rise_Set_Info_DTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public LC_Rise_Set_Info_DTO(String sunrise, String sunset) {
		super();
		this.sunrise = sunrise;
		this.sunset = sunset;
	}
	public String getSunrise() {
		return sunrise;
	}
	public void setSunrise(String sunrise) {
		this.sunrise = sunrise;
	}
	public String getSunset() {
		return sunset;
	}
	public void setSunset(String sunset) {
		this.sunset = sunset;
	}
	
	
}
