package com.ezen.bada.ranking;

public class RankingBBTIDTO {
	String bbti;
	String bbti_code;
	int count;
	int rank;
	
	public RankingBBTIDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public RankingBBTIDTO(String bbti, String bbti_code, int count, int rank) {
		super();
		this.bbti = bbti;
		this.bbti_code = bbti_code;
		this.count = count;
		this.rank = rank;
	}

	public String getBbti() {
		return bbti;
	}

	public void setBbti(String bbti) {
		this.bbti = bbti;
	}

	public String getBbti_code() {
		return bbti_code;
	}

	public void setBbti_code(String bbti_code) {
		this.bbti_code = bbti_code;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public int getRank() {
		return rank;
	}

	public void setRank(int rank) {
		this.rank = rank;
	}
	
	
	
	
}
