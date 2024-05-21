package com.ezen.bada.ranking;

import com.ezen.bada.weathers.Bada_info_DTO;

public class RankingBeachDTO {
    int beach_code;
    String beach;
    double count;
    int rank;
    String picture;
    Bada_info_DTO bdt;
    
	public RankingBeachDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public RankingBeachDTO(int beach_code, String beach, double count, int rank, String picture, Bada_info_DTO bdt) {
		super();
		this.beach_code = beach_code;
		this.beach = beach;
		this.count = count;
		this.rank = rank;
		this.picture = picture;
		this.bdt = bdt;
	}

	public int getBeach_code() {
		return beach_code;
	}

	public void setBeach_code(int beach_code) {
		this.beach_code = beach_code;
	}

	public String getBeach() {
		return beach;
	}

	public void setBeach(String beach) {
		this.beach = beach;
	}

	public double getCount() {
		return count;
	}

	public void setCount(double count) {
		this.count = count;
	}

	public int getRank() {
		return rank;
	}

	public void setRank(int rank) {
		this.rank = rank;
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	public Bada_info_DTO getBdt() {
		return bdt;
	}

	public void setBdt(Bada_info_DTO bdt) {
		this.bdt = bdt;
	}



}
