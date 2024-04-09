package com.ezen.bada.weathers;

import com.fasterxml.jackson.annotation.JsonProperty;

public class VilageFcstBeach_DTO {
	// 해수욕장 단기 예보 결과
	
	String fcstDate; // 예보일자
	String fcstTime; // 예보시간
	
	String hourlyTimestamps; //시간대
	
	// 어노테이션을 붙여야 json의 key값이 아래 dto 필드명에 정확하게 찾아감
	@JsonProperty("POP") // 강수확률
	String pop;

	@JsonProperty("PTY") // 강수형태 -> 코드 변환 필요
	String pty;

	@JsonProperty("PCP") // 1시간 강수량
	String rn1;

	@JsonProperty("REH") // 습도
	String reh;

	@JsonProperty("SNO") // 1시간 신적설
	String sno;

	@JsonProperty("SKY") // 하늘상태 -> 코드 변환 필요
	String sky;

	@JsonProperty("TMP") // 1시간 기온
	String tmp;

	@JsonProperty("UUU") // 풍속(동서성분)
	String uuu;

	@JsonProperty("VVV") // 풍속(남북성분)
	String vvv;

	@JsonProperty("WAV") // 파고
	String wav;

	@JsonProperty("VEC") // 풍향
	String vec;

	@JsonProperty("WSD") // 풍속
	String wsd;

	public VilageFcstBeach_DTO() {}

	public VilageFcstBeach_DTO(String fcstDate, String fcstTime, String hourlyTimestamps, String pop, String pty,
			String rn1, String reh, String sno, String sky, String tmp, String uuu, String vvv, String wav, String vec,
			String wsd) {
		super();
		this.fcstDate = fcstDate;
		this.fcstTime = fcstTime;
		this.hourlyTimestamps = hourlyTimestamps;
		this.pop = pop;
		this.pty = pty;
		this.rn1 = rn1;
		this.reh = reh;
		this.sno = sno;
		this.sky = sky;
		this.tmp = tmp;
		this.uuu = uuu;
		this.vvv = vvv;
		this.wav = wav;
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

	public String getHourlyTimestamps() {
		return hourlyTimestamps;
	}

	public void setHourlyTimestamps(String hourlyTimestamps) {
		this.hourlyTimestamps = hourlyTimestamps;
	}

	public String getPop() {
		return pop;
	}

	public void setPop(String pop) {
		this.pop = pop;
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

	public String getReh() {
		return reh;
	}

	public void setReh(String reh) {
		this.reh = reh;
	}

	public String getSno() {
		return sno;
	}

	public void setSno(String sno) {
		this.sno = sno;
	}

	public String getSky() {
		return sky;
	}

	public void setSky(String sky) {
		this.sky = sky;
	}

	public String getTmp() {
		return tmp;
	}

	public void setTmp(String tmp) {
		this.tmp = tmp;
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

	public String getWav() {
		return wav;
	}

	public void setWav(String wav) {
		this.wav = wav;
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
