package com.ezen.bada.weathers;

import com.fasterxml.jackson.annotation.JsonProperty;

public class Bada_list_DTO {
	// 해수욕장 기본 정보
	String beach;
	String state;
	String address;
	double latitude;
	double longitude;
	int grid_x;
	int grid_y;
	
	// 해수욕장 단기 예보 결과
	String beachNum; //해변코드
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

	@JsonProperty("TMN") // 아침 최저기온
	String tmn;

	@JsonProperty("TMX") // 낮 최고기온
	String tmx;

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

	// 수온
	String tm; // 관측시간 년월일시분
	String tw; // 수온

	
	//일출 일몰
	String sunrise;
	String sunset;
	
	public Bada_list_DTO() {}

	public Bada_list_DTO(String beach, String state, String address, double latitude, double longitude, int grid_x,
			int grid_y, String beachNum, String baseDate, String baseTime, String pop, String pty, String pcp,
			String reh, String sno, String sky, String tmp, String tmn, String tmx, String uuu, String vvv, String wav,
			String vec, String wsd, String tm, String tw, String sunrise, String sunset) {
		super();
		this.beach = beach;
		this.state = state;
		this.address = address;
		this.latitude = latitude;
		this.longitude = longitude;
		this.grid_x = grid_x;
		this.grid_y = grid_y;
		this.beachNum = beachNum;
		this.baseDate = baseDate;
		this.baseTime = baseTime;
		this.pop = pop;
		this.pty = pty;
		this.pcp = pcp;
		this.reh = reh;
		this.sno = sno;
		this.sky = sky;
		this.tmp = tmp;
		this.tmn = tmn;
		this.tmx = tmx;
		this.uuu = uuu;
		this.vvv = vvv;
		this.wav = wav;
		this.vec = vec;
		this.wsd = wsd;
		this.tm = tm;
		this.tw = tw;
		this.sunrise = sunrise;
		this.sunset = sunset;
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

	public String getBeachNum() {
		return beachNum;
	}

	public void setBeachNum(String beachNum) {
		this.beachNum = beachNum;
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

	public String getTm() {
		return tm;
	}

	public void setTm(String tm) {
		this.tm = tm;
	}

	public String getTw() {
		return tw;
	}

	public void setTw(String tw) {
		this.tw = tw;
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

