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

	ArrayList<AllBoardDTO> review_list(PageDTO dto);

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
            @Param("reply") String reply);

	ArrayList<ReplyDTO> reply_show(int review_num);

	int review_rec_id(int review_num, String loginid);

	void review_recommand(String loginid, int review_num);

	String review_ban_check(String id, int ban_review_num, String category, String content);

	void review_ban_save(String title, String name, String id, int ban_review_num, String ban_name, String ban_id,
			String category, String content, int user_num);

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
            @Param("user_num") int user_num);

	String report_check(int reply_num, String id, String reason, String reply_contents);

	ArrayList<AllBoardDTO> search_result(String category, String search);

	int ban_user_num(String ban_id);

	ArrayList<AllBoardDTO> search_area_result(String area);

	

}


