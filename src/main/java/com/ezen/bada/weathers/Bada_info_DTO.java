package com.ezen.bada.weathers;

public class Bada_info_DTO {
	int beach_code;
	String beach_name;
	String state;
	String city;
	String address;
	String infomation;
	String picture1;
	String picture2;
	String picture3;
	String accomodation;
	String special;
	
	public Bada_info_DTO() {}
	
	public Bada_info_DTO(int beach_code, String beach_name, String state, String city, String address,
			String infomation, String picture1, String picture2, String picture3, String accomodation, String special) {
		super();
		this.beach_code = beach_code;
		this.beach_name = beach_name;
		this.state = state;
		this.city = city;
		this.address = address;
		this.infomation = infomation;
		this.picture1 = picture1;
		this.picture2 = picture2;
		this.picture3 = picture3;
		this.accomodation = accomodation;
		this.special = special;
	}
	
	public int getBeach_code() {
		return beach_code;
	}
	public void setBeach_code(int beach_code) {
		this.beach_code = beach_code;
	}
	public String getBeach_name() {
		return beach_name;
	}
	public void setBeach_name(String beach_name) {
		this.beach_name = beach_name;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getInfomation() {
		return infomation;
	}
	public void setInfomation(String infomation) {
		this.infomation = infomation;
	}
	public String getPicture1() {
		return picture1;
	}
	public void setPicture1(String picture1) {
		this.picture1 = picture1;
	}
	public String getPicture2() {
		return picture2;
	}
	public void setPicture2(String picture2) {
		this.picture2 = picture2;
	}
	public String getPicture3() {
		return picture3;
	}
	public void setPicture3(String picture3) {
		this.picture3 = picture3;
	}

	public String getAccomodation() {
		return accomodation;
	}

	public void setAccomodation(String accomodation) {
		this.accomodation = accomodation;
	}

	public String getSpecial() {
		return special;
	}

	public void setSpecial(String special) {
		this.special = special;
	}
	
}
