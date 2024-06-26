package com.ezen.bada.review;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.ezen.bada.member.MemberDTO;

public interface Service {

	MemberDTO input_info(String loginid);

	List<BeachDTO> getBeachList();

	void review_save(
	        @Param("id") String id, 
	        @Param("name") String name, 
	        @Param("visit_day") String visit_day, 
	        @Param("review_title") String review_title, 
	        @Param("review_contents") String review_contents,
	        @Param("fileNames") String[] fileNames, 
	        @Param("thumbnail") String thumbnail, 
	        @Param("review_score") String review_score, 
	        @Param("hashtags") String hashtags, 
	        @Param("beach_code") String beach_code,
	        @Param("re_visit") String re_visit
	    );

	int total();

	ArrayList<AllBoardDTO> page_review_listout_latest(PageDTO dto);

	ArrayList<AllBoardDTO> page_review_listout_popular(PageDTO dto);

	void hit_up(int review_num);

	AllBoardDTO review_detail(int review_num);

	String beach_name(int review_num);

	void review_delete(int review_num);

	AllBoardDTO all_photo(int review_num);

	AllBoardDTO change_view(int review_num);

	String original_thumbnail(int review_num);

	void update_photo(Map<String, Object> params);

	void review_modify(
		    @Param("review_num") Integer review_num,  
		    @Param("visit_day") String visit_day, 
		    @Param("review_title") String review_title, 
		    @Param("review_contents") String review_contents,
		    @Param("review_score") String review_score, 
		    @Param("hashtags") String hashtags, 
		    @Param("beach_code") String beach_code,
		    @Param("re_visit") String re_visit);

	void thumbnail_upload(int review_num, String t_name);


	void reply_save(
			@Param("review_num") Integer review_num, 
            @Param("loginid") String loginid, 
            @Param("reply") String reply,
			@Param("name") String name);

	ArrayList<ReplyDTO> reply_show(int review_num);

	int review_rec_id(int review_num, String loginid);

	void review_recommand(String loginid, int review_num);

	String review_ban_check(String id, int ban_review_num, String category);

	void review_ban_save(String title, String name, String id, int ban_review_num, String ban_name, String ban_id,
			String category, String content, int user_num, int user_num2);

	void reply_update(int review_num);

	void report_up(int ban_review_num);

	void reply_delete(int reply_num);

	void reply_minus(int review_num);

	void reply_modify(int reply_num, String modi_reply);

	ReplyDTO reply_info(int reply_num);

	void reply_report_save(@Param("review_num") int review_num, 
			@Param("reply_num") int reply_num, 
            @Param("id") String id, 
            @Param("ban_id") String ban_id, 
            @Param("reply_contents") String reply_contents,
            @Param("reason") String reason, 
            @Param("detail") String detail, 
            @Param("user_num") int user_num,
            @Param("name") String name, 
            @Param("ban_name") String ban_name, 
            @Param("user_num2") int user_num2);

	String report_check(int reply_num, String id, String reason, String reply_contents);

	// 수정하기
	ArrayList<AllBoardDTO> search_result(String category, String search, int start, int end);

	ArrayList<AllBoardDTO> search_area_result(String area, int start, int end);

	ArrayList<Review_report_DTO> review_report(PageDTO dto);

	int ban_review_total();

	Review_report_DTO review_ban_detail(int ban_review_num);

	int review_ban_count(String ban_id);

	ArrayList<Review_report_DTO> review_ban_list(String ban_id);

	void review_ban_delete(int review_report_num);

	int ban_reply_total();

	ArrayList<Review_reply_report_DTO> reply_report(PageDTO dto);

	int user_num(String id);

	String user_name(String id);

	void report_reply_delete(int reply_num);

	void reply_ban_delete(int review_reply_ban_num);

	void review_comment_delete(int review_num);

	ArrayList<AllBoardDTO> pickbestrec();
	
	
	//나도 한마디 저장
	void say_one_save(String id, String name, String content, String loc);

	//나도 한마디 출력
	ArrayList<OneDTO> say_one_sentence();

	//닉네임 가져오기
	String getnickname(String loginid);

	//한마디 삭제
	void one_delete(int one_num);
	
	//신고 전 중복 신고를 방지하기 위한 체크
	int count_same_ban(int ban_one_num, String id);

	//신고를 위해 신고당한 한마디의 번호로부터 신고당한 사람의 아이디를 찾아옴
	String find_ban_user_id(int ban_one_num);

	//신고를 위해 신고당한 사람의 아이디로부터 신고당한 사람의 유저넘버를 가져옴(나중에 회원정보창으로 넘어가기 위해)
	int ban_user_num(String ban_user_id);
	
	//신고를 위해 신고당한 사람의 아이디로 신고당한 사람의 닉네임을 가져옴
	String find_ban_user_name(String ban_id);
	
	//신고를 위해 신고당한 한마디의 번호로부터 신고당한 한마디의 내용을 가져옴
	String find_ban_content(int ban_one_num);

	//신고한 사람의 아이디로부터 신고한 사람의 닉네임을 가져옴
	String find_name(String id);

	//신고 정보를 저장
	void one_ban_save(String id, String name, int ban_user_num, String ban_id, String ban_name, String ban_content,
			int ban_one_num);

	//신고 내역 페이징 처리를 위한 레코드 갯수 확인
	int one_ban_total();
	
	//신고 내역을 확인(페이징 처리)
	ArrayList<One_ban_DTO> one_ban(PageDTO dto);

	//신고내역 삭제
	void one_ban_delete(int one_ban_num);
	
	
	

  //새 리뷰 6개 불러오기 (순서대로 전체, 지역별(경인,부울), 지역별)
	ArrayList<AllBoardDTO> picknewrec6();

	ArrayList<AllBoardDTO> picknewrec6in2area(String area1, String area2);

	ArrayList<AllBoardDTO> picknewrecinarea(String area);
  
  //한마디 리뷰홈에 불러오기
	ArrayList<OneDTO> getonesentence(String area);
  
  //각 지역 리뷰 전체갯수/새글수 불러오기
	ArrayList<CountreviewDTO> getreviewcount();
	
  // 검색 리뷰 개수
	int search_result_count(String category, String search);

	int area_result_count(String area);

	ArrayList<String> getbestreviewer();

	String findbeachcode(String search);

	// 마이페이지 -> 추천취소
	void unrecommend(@Param("userId") String userId, @Param("reviewNum") int reviewNum);

	void hitdown(int review_num);

	int get_latest_reply_num(String loginid);




}


