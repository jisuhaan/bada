package com.ezen.bada.review;

public class AllBoardDTO {

	int review_num;
	String id,name,write_day,visit_day,review_title,review_contents,
			photo1,photo2,photo3,photo4,photo5,thumbnail,hashtag,re_visit,rec_id,beach;
	int hits,recommend,report,review_score,reply,beach_code;
	
	public AllBoardDTO() {}

	public int getReview_num() {
		return review_num;
	}

	public void setReview_num(int review_num) {
		this.review_num = review_num;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getWrite_day() {
		return write_day;
	}

	public void setWrite_day(String write_day) {
		this.write_day = write_day;
	}

	public String getVisit_day() {
		return visit_day;
	}

	public void setVisit_day(String visit_day) {
		this.visit_day = visit_day;
	}

	public String getReview_title() {
		return review_title;
	}

	public void setReview_title(String review_title) {
		this.review_title = review_title;
	}

	public String getReview_contents() {
		return review_contents.replaceAll("\n", "<br>");
	}

	public void setReview_contents(String review_contents) {
		this.review_contents = review_contents;
	}

	public String getPhoto1() {
		return photo1;
	}

	public void setPhoto1(String photo1) {
		this.photo1 = photo1;
	}

	public String getPhoto2() {
		return photo2;
	}

	public void setPhoto2(String photo2) {
		this.photo2 = photo2;
	}

	public String getPhoto3() {
		return photo3;
	}

	public void setPhoto3(String photo3) {
		this.photo3 = photo3;
	}

	public String getPhoto4() {
		return photo4;
	}

	public void setPhoto4(String photo4) {
		this.photo4 = photo4;
	}

	public String getPhoto5() {
		return photo5;
	}

	public void setPhoto5(String photo5) {
		this.photo5 = photo5;
	}

	public String getThumbnail() {
		return thumbnail;
	}

	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}

	public String getHashtag() {
		return hashtag;
	}

	public void setHashtag(String hashtag) {
		this.hashtag = hashtag;
	}

	public String getRe_visit() {
		return re_visit;
	}

	public void setRe_visit(String re_visit) {
		this.re_visit = re_visit;
	}

	public int getHits() {
		return hits;
	}

	public void setHits(int hits) {
		this.hits = hits;
	}

	public int getRecommend() {
		return recommend;
	}

	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}

	public int getReport() {
		return report;
	}

	public void setReport(int report) {
		this.report = report;
	}

	public int getReview_score() {
		return review_score;
	}

	public void setReview_score(int review_score) {
		this.review_score = review_score;
	}

	public int getReply() {
		return reply;
	}

	public void setReply(int reply) {
		this.reply = reply;
	}

	public int getBeach_code() {
		return beach_code;
	}

	public void setBeach_code(int beach_code) {
		this.beach_code = beach_code;
	}

	public String getRec_id() {
		return rec_id;
	}

	public void setRec_id(String rec_id) {
		this.rec_id = rec_id;
	}

	public String getBeach() {
		return beach;
	}

	public void setBeach(String beach) {
		this.beach = beach;
	}
	
	
	
	
}
