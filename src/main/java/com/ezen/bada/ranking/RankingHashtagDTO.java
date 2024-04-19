package com.ezen.bada.ranking;

public class RankingHashtagDTO {
	String hashtag;
	String most_used_beach;
	String most_used_beach_code;
	int max_hashtag_count;
	String second_used_beach;
	String second_used_beach_code;
	int second_hashtag_count;
	String third_used_beach;
	String third_used_beach_code;
	int third_hashtag_count;
	
	public RankingHashtagDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public RankingHashtagDTO(String hashtag, String most_used_beach, String most_used_beach_code, int max_hashtag_count,
			String second_used_beach, String second_used_beach_code, int second_hashtag_count, String third_used_beach,
			String third_used_beach_code, int third_hashtag_count) {
		super();
		this.hashtag = hashtag;
		this.most_used_beach = most_used_beach;
		this.most_used_beach_code = most_used_beach_code;
		this.max_hashtag_count = max_hashtag_count;
		this.second_used_beach = second_used_beach;
		this.second_used_beach_code = second_used_beach_code;
		this.second_hashtag_count = second_hashtag_count;
		this.third_used_beach = third_used_beach;
		this.third_used_beach_code = third_used_beach_code;
		this.third_hashtag_count = third_hashtag_count;
	}

	public String getHashtag() {
		return hashtag;
	}

	public void setHashtag(String hashtag) {
		this.hashtag = hashtag;
	}

	public String getMost_used_beach() {
		return most_used_beach;
	}

	public void setMost_used_beach(String most_used_beach) {
		this.most_used_beach = most_used_beach;
	}

	public String getMost_used_beach_code() {
		return most_used_beach_code;
	}

	public void setMost_used_beach_code(String most_used_beach_code) {
		this.most_used_beach_code = most_used_beach_code;
	}

	public int getMax_hashtag_count() {
		return max_hashtag_count;
	}

	public void setMax_hashtag_count(int max_hashtag_count) {
		this.max_hashtag_count = max_hashtag_count;
	}

	public String getSecond_used_beach() {
		return second_used_beach;
	}

	public void setSecond_used_beach(String second_used_beach) {
		this.second_used_beach = second_used_beach;
	}

	public String getSecond_used_beach_code() {
		return second_used_beach_code;
	}

	public void setSecond_used_beach_code(String second_used_beach_code) {
		this.second_used_beach_code = second_used_beach_code;
	}

	public int getSecond_hashtag_count() {
		return second_hashtag_count;
	}

	public void setSecond_hashtag_count(int second_hashtag_count) {
		this.second_hashtag_count = second_hashtag_count;
	}

	public String getThird_used_beach() {
		return third_used_beach;
	}

	public void setThird_used_beach(String third_used_beach) {
		this.third_used_beach = third_used_beach;
	}

	public String getThird_used_beach_code() {
		return third_used_beach_code;
	}

	public void setThird_used_beach_code(String third_used_beach_code) {
		this.third_used_beach_code = third_used_beach_code;
	}

	public int getThird_hashtag_count() {
		return third_hashtag_count;
	}

	public void setThird_hashtag_count(int third_hashtag_count) {
		this.third_hashtag_count = third_hashtag_count;
	}

	@Override
	public String toString() {
		return "RankingHashtagDTO [hashtag=" + hashtag + ", most_used_beach=" + most_used_beach
				+ ", most_used_beach_code=" + most_used_beach_code + ", max_hashtag_count=" + max_hashtag_count
				+ ", second_used_beach=" + second_used_beach + ", second_used_beach_code=" + second_used_beach_code
				+ ", second_hashtag_count=" + second_hashtag_count + ", third_used_beach=" + third_used_beach
				+ ", third_used_beach_code=" + third_used_beach_code + ", third_hashtag_count=" + third_hashtag_count
				+ "]";
	}
	

}
