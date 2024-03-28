package com.ezen.bada.weathers;

import com.fasterxml.jackson.annotation.JsonProperty;

public class Bada_list_DTO {
	// 해수욕장 기본 정보
	String beach;
	int beach_code;
	String state;
	String address;
	int latitude;
	int longitude;
	int grid_x;
	int gride_y;
	
	// 해수욕장 단기 예보 결과
	String baseDate; //발표일자
	String baseTime; //발표시간
	// 어노테이션을 붙여야 json의 key값이 아래 dto 필드명에 정확하게 찾아감
	@JsonProperty("POP") // 강수확률
    int pop;

    @JsonProperty("PTY") // 강수형태 -> 코드 변환 필요
    String pty;

    @JsonProperty("PCP") // 1시간 강수량
    int pcp;

    @JsonProperty("REH") // 습도
    int reh;

    @JsonProperty("SNO") // 1시간 신적설
    int sno;

    @JsonProperty("SKY") // 하늘상태 -> 코드 변환 필요
    String sky;

    @JsonProperty("TMP") // 1시간 기온
    int tmp;

    @JsonProperty("TMN") // 아침 최저기온
    int tmn;

    @JsonProperty("TMX") // 낮 최고기온
    int tmx;

    @JsonProperty("UUU") // 풍속(동서성분)
    int uuu;

    @JsonProperty("VVV") // 풍속(남북성분)
    int vvv;

    @JsonProperty("WAV") // 파고
    int wav;

    @JsonProperty("VEC") // 풍향
    int vec;

    @JsonProperty("WSD") // 풍속
    int wsd;

	// 수온
	int tm; // 관측시간 년월일시분
	int tw; // 수온
	
	//일출 일몰
	String sunrise;
	String sunset;
	
	public Bada_list_DTO() {}

	public Bada_list_DTO(String beach, int beach_code, String state, String address, int latitude, int longitude,
			int grid_x, int gride_y, String baseDate, String baseTime, int pop, String pty, int pcp, int reh, int sno,
			String sky, int tmp, int tmn, int tmx, int uuu, int vvv, int wav, int vec, int wsd, int tm, int tw,
			String sunrise, String sunset) {
		super();
		this.beach = beach;
		this.beach_code = beach_code;
		this.state = state;
		this.address = address;
		this.latitude = latitude;
		this.longitude = longitude;
		this.grid_x = grid_x;
		this.gride_y = gride_y;
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

	public int getBeach_code() {
		return beach_code;
	}

	public void setBeach_code(int beach_code) {
		this.beach_code = beach_code;
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

	public int getLatitude() {
		return latitude;
	}

	public void setLatitude(int latitude) {
		this.latitude = latitude;
	}

	public int getLongitude() {
		return longitude;
	}

	public void setLongitude(int longitude) {
		this.longitude = longitude;
	}

	public int getGrid_x() {
		return grid_x;
	}

	public void setGrid_x(int grid_x) {
		this.grid_x = grid_x;
	}

	public int getGride_y() {
		return gride_y;
	}

	public void setGride_y(int gride_y) {
		this.gride_y = gride_y;
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

	public int getPop() {
		return pop;
	}

	public void setPop(int pop) {
		this.pop = pop;
	}

	public String getPty() {
		return pty;
	}

	public void setPty(String pty) {
		this.pty = pty;
	}

	public int getPcp() {
		return pcp;
	}

	public void setPcp(int pcp) {
		this.pcp = pcp;
	}

	public int getReh() {
		return reh;
	}

	public void setReh(int reh) {
		this.reh = reh;
	}

	public int getSno() {
		return sno;
	}

	public void setSno(int sno) {
		this.sno = sno;
	}

	public String getSky() {
		return sky;
	}

	public void setSky(String sky) {
		this.sky = sky;
	}

	public int getTmp() {
		return tmp;
	}

	public void setTmp(int tmp) {
		this.tmp = tmp;
	}

	public int getTmn() {
		return tmn;
	}

	public void setTmn(int tmn) {
		this.tmn = tmn;
	}

	public int getTmx() {
		return tmx;
	}

	public void setTmx(int tmx) {
		this.tmx = tmx;
	}

	public int getUuu() {
		return uuu;
	}

	public void setUuu(int uuu) {
		this.uuu = uuu;
	}

	public int getVvv() {
		return vvv;
	}

	public void setVvv(int vvv) {
		this.vvv = vvv;
	}

	public int getWav() {
		return wav;
	}

	public void setWav(int wav) {
		this.wav = wav;
	}

	public int getVec() {
		return vec;
	}

	public void setVec(int vec) {
		this.vec = vec;
	}

	public int getWsd() {
		return wsd;
	}

	public void setWsd(int wsd) {
		this.wsd = wsd;
	}

	public int getTm() {
		return tm;
	}

	public void setTm(int tm) {
		this.tm = tm;
	}

	public int getTw() {
		return tw;
	}

	public void setTw(int tw) {
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
