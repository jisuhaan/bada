package com.ezen.bada.ranking;

public class RankingBeachDTO {
    String beach_code;
    String beach;
    int view_count;
    int rank;
    
	public RankingBeachDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public RankingBeachDTO(String beach_code, String beach, int view_count, int rank) {
		super();
		this.beach_code = beach_code;
		this.beach = beach;
		this.view_count = view_count;
		this.rank = rank;
	}
	public String getBeach_code() {
		return beach_code;
	}
	public void setBeach_code(String beach_code) {
		this.beach_code = beach_code;
	}
	public String getBeach() {
		return beach;
	}
	public void setBeach(String beach) {
		this.beach = beach;
	}
	public int getView_count() {
		return view_count;
	}
	public void setView_count(int view_count) {
		this.view_count = view_count;
	}
	public int getRank() {
		return rank;
	}
	public void setRank(int rank) {
		this.rank = rank;
	}
	@Override
	public String toString() {
		return "RankingBeachDTO [beach_code=" + beach_code + ", beach=" + beach + ", view_count=" + view_count
				+ ", rank=" + rank + "]";
	}
    

    
    
}
