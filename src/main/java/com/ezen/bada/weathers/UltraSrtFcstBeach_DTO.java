package com.ezen.bada.weathers;

import com.fasterxml.jackson.annotation.JsonProperty;

public class UltraSrtFcstBeach_DTO {
	String fcstDate; // 예보일자
	String fcstTime; // 예보시간
	
	// 어노테이션을 붙여야 json의 key값이 아래 dto 필드명에 정확하게 찾아감
	@JsonProperty("LGT") // 낙뢰
	String lgt;

	@JsonProperty("PTY") // 강수형태 -> 코드 변환 필요
	String pty;

	@JsonProperty("RN1") // 1시간 강수량
	String rn1;

	@JsonProperty("SKY") // 하늘
	String sky;

	@JsonProperty("T1H") // 기온
	String t1h;

	@JsonProperty("REH") // 습도
	String reh;

	@JsonProperty("UUU") // 동서바람성분
	String uuu;

	@JsonProperty("VVV") // 남북바람성분
	String vvv;

	@JsonProperty("VEC") // 풍향
	String vec;
	
	@JsonProperty("WSD") // 풍속
	String wsd;

	public UltraSrtFcstBeach_DTO() {}

	public UltraSrtFcstBeach_DTO(String fcstDate, String fcstTime, String lgt, String pty, String rn1, String sky,
			String t1h, String reh, String uuu, String vvv, String vec, String wsd) {
		super();
		this.fcstDate = fcstDate;
		this.fcstTime = fcstTime;
		this.lgt = lgt;
		this.pty = pty;
		this.rn1 = rn1;
		this.sky = sky;
		this.t1h = t1h;
		this.reh = reh;
		this.uuu = uuu;
		this.vvv = vvv;
		this.vec = vec;
		this.wsd = wsd;
	}

	public String getFcstDate() {
		return fcstDate;
	}

	public void setFcstDate(String fcstDate) {
		this.fcstDate = fcstDate;
	}

	public String getFcstTime() {
		return fcstTime;
	}

	public void setFcstTime(String fcstTime) {
		this.fcstTime = fcstTime;
	}

	public String getLgt() {
		return lgt;
	}

	public void setLgt(String lgt) {
		this.lgt = lgt;
	}

	public String getPty() {
		return pty;
	}

	public void setPty(String pty) {
		this.pty = pty;
	}

	public String getRn1() {
		return rn1;
	}

	public void setRn1(String rn1) {
		this.rn1 = rn1;
	}

	public String getSky() {
		return sky;
	}

	public void setSky(String sky) {
		this.sky = sky;
	}

	public String getT1h() {
		return t1h;
	}

	public void setT1h(String t1h) {
		this.t1h = t1h;
	}

	public String getReh() {
		return reh;
	}

	public void setReh(String reh) {
		this.reh = reh;
	}

	public String getUuu() {
		return uuu;
	}

	public void setUuu(String uuu) {
		this.uuu = uuu;
	}

	public String getVvv() {
		return vvv;
	}

	public void setVvv(String vvv) {
		this.vvv = vvv;
	}

	public String getVec() {
		return vec;
	}

	public void setVec(String vec) {
		this.vec = vec;
	}

	public String getWsd() {
		return wsd;
	}

	public void setWsd(String wsd) {
		this.wsd = wsd;
	}

	
}
