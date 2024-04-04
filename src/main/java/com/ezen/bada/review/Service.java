package com.ezen.bada.review;

import java.util.ArrayList;
import java.util.List;

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

	
}


