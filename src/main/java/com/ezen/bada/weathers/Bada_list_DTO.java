package com.ezen.bada.weathers;

import com.fasterxml.jackson.annotation.JsonProperty;

public class Bada_list_DTO {
	// 해수욕장 단기 예보 결과
	String beach_code; //해변코드
	String baseDate; //발표일자
	String baseTime; //발표시간
	// 어노테이션을 붙여야 json의 key값이 아래 dto 필드명에 정확하게 찾아감
	@JsonProperty("POP") // 강수확률
	String pop;

	@JsonProperty("PTY") // 강수형태 -> 코드 변환 필요
	String pty;

	@JsonProperty("PCP") // 1시간 강수량
	String pcp;

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

	public Bada_list_DTO() {}

	public Bada_list_DTO(String beach_code, String baseDate, String baseTime, String pop, String pty, String pcp,
			String reh, String sno, String sky, String tmp, String uuu, String vvv, String wav,
			String vec, String wsd, String tm, String tw, String sunrise, String sunset) {
		super();
		this.beach_code = beach_code;
		this.baseDate = baseDate;
		this.baseTime = baseTime;
		this.pop = pop;
		this.pty = pty;
		this.pcp = pcp;
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

	public String getBeach_code() {
		return beach_code;
	}

	public void setBeach_code(String beach_code) {
		this.beach_code = beach_code;
	}

	public String getBaseDate() {
		return baseDate;
	}

	public void setBaseDate(String baseDate) {
		this.baseDate = baseDate;
	}

	public String getBaseTime() {
		return baseTime;
	}

	public void setBaseTime(String baseTime) {
		this.baseTime = baseTime;
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

	public String getPcp() {
		return pcp;
	}

	public void setPcp(String pcp) {
		this.pcp = pcp;
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