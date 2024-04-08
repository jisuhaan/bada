package com.ezen.bada.weathers;

import com.fasterxml.jackson.annotation.JsonProperty;

public class Bada_tmx_n_DTO {
	// 단기예보에서 분리해낸 최저기온 최고기온
	@JsonProperty("TMN") // 아침 최저기온
	String tmn;
	
	@JsonProperty("TMX") // 낮 최고기온
	String tmx;

	
	public Bada_tmx_n_DTO() {}

	public Bada_tmx_n_DTO(String tmn, String tmx) {
		super();
		this.tmn = tmn;
		this.tmx = tmx;
	}

	public String getTmn() {
		return tmn;
	}

	public void setTmn(String tmn) {
		this.tmn = tmn;
	}

	public String getTmx() {
		return tmx;
	}

	public void setTmx(String tmx) {
		this.tmx = tmx;
	}
	
	
}
