package com.ezen.bada.weathers;

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
	int baseDate; //발표일자
	int baseTime; //발표시간
	int POP; //강수확률
	String PTY; //강수형태 -> 코드 변환 필요
	int PCP; //1시간 강수량
	int REH; //습도
	int SNO; //1시간 신적설
	String SKY; //하늘상태 -> 코드 변환 필요
	int TMP; //1시간 기온
	int TMN; //아침 최저기온
	int TMX; //낮 최고기온
	int UUU; //풍속(동서성분)
	int VVV; //풍속(남북성분)
	int WAV; //파고
	int VEC; //풍향
	int WSD; //풍속

	// 수온
	int tm; // 관측시간 년월일시분
	int tw; // 수온
	
	//일출 일몰
	String sunrise;
	String sunset;
	
	public Bada_list_DTO() {}

	public Bada_list_DTO(String beach, int beach_code, String state, String address, int latitude, int longitude,
			int grid_x, int gride_y, int baseDate, int baseTime, int pOP, String pTY, int pCP, int rEH, int sNO,
			String sKY, int tMP, int tMN, int tMX, int uUU, int vVV, int wAV, int vEC, int wSD, int tm, int tw,
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
		POP = pOP;
		PTY = pTY;
		PCP = pCP;
		REH = rEH;
		SNO = sNO;
		SKY = sKY;
		TMP = tMP;
		TMN = tMN;
		TMX = tMX;
		UUU = uUU;
		VVV = vVV;
		WAV = wAV;
		VEC = vEC;
		WSD = wSD;
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

	public int getBaseDate() {
		return baseDate;
	}

	public void setBaseDate(int baseDate) {
		this.baseDate = baseDate;
	}

	public int getBaseTime() {
		return baseTime;
	}

	public void setBaseTime(int baseTime) {
		this.baseTime = baseTime;
	}

	public int getPOP() {
		return POP;
	}

	public void setPOP(int pOP) {
		POP = pOP;
	}

	public String getPTY() {
		return PTY;
	}

	public void setPTY(String pTY) {
		PTY = pTY;
	}

	public int getPCP() {
		return PCP;
	}

	public void setPCP(int pCP) {
		PCP = pCP;
	}

	public int getREH() {
		return REH;
	}

	public void setREH(int rEH) {
		REH = rEH;
	}

	public int getSNO() {
		return SNO;
	}

	public void setSNO(int sNO) {
		SNO = sNO;
	}

	public String getSKY() {
		return SKY;
	}

	public void setSKY(String sKY) {
		SKY = sKY;
	}

	public int getTMP() {
		return TMP;
	}

	public void setTMP(int tMP) {
		TMP = tMP;
	}

	public int getTMN() {
		return TMN;
	}

	public void setTMN(int tMN) {
		TMN = tMN;
	}

	public int getTMX() {
		return TMX;
	}

	public void setTMX(int tMX) {
		TMX = tMX;
	}

	public int getUUU() {
		return UUU;
	}

	public void setUUU(int uUU) {
		UUU = uUU;
	}

	public int getVVV() {
		return VVV;
	}

	public void setVVV(int vVV) {
		VVV = vVV;
	}

	public int getWAV() {
		return WAV;
	}

	public void setWAV(int wAV) {
		WAV = wAV;
	}

	public int getVEC() {
		return VEC;
	}

	public void setVEC(int vEC) {
		VEC = vEC;
	}

	public int getWSD() {
		return WSD;
	}

	public void setWSD(int wSD) {
		WSD = wSD;
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
