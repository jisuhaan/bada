package com.ezen.bada.member;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.ezen.bada.inquire.InquireDTO;
import com.ezen.bada.inquire.InquireDTO2;
import com.ezen.bada.review.AllBoardDTO;
import com.ezen.bada.review.BeachDTO;


public interface Service {

	String login_check(String id, String pw);

	String idcheck(String id);

	void membersave(String id, String pw, String name, String email, String gender, int age);
	
	int total();
	
	ArrayList<MemberDTO> member_list(PageDTO dto);
	
	ArrayList<MemberDTO> memberout();
	
	
	
	ArrayList<MemberDTO> member_search_num_n_n(String value);
	
	ArrayList<MemberDTO> member_search_num_n_a(String value, int age);
	
	ArrayList<MemberDTO> member_search_num_g_n(String value, String gender);
	
	ArrayList<MemberDTO> member_search_num_g_a(String value, String gender, int age);
	
	ArrayList<MemberDTO> member_search_id_n_n(String value);
	
	ArrayList<MemberDTO> member_search_id_n_a(String value, int age);
	
	ArrayList<MemberDTO> member_search_id_g_n(String value, String gender);
	
	ArrayList<MemberDTO> member_search_id_g_a(String value, String gender, int age);
	
	ArrayList<MemberDTO> member_search_name_n_n(String value);
	
	ArrayList<MemberDTO> member_search_name_n_a(String value, int age);
	
	ArrayList<MemberDTO> member_search_name_g_n(String value, String gender);
	
	ArrayList<MemberDTO> member_search_name_g_a(String value, String gender, int age);
	
	
	
	MemberDTO lookid(String name, String email);
	
	MemberDTO lookpw(String id, String email);
   
	ArrayList<MemberDTO> member_detail_out(int user_number);

	

	String emailcheck(String email);
	
	void member_modify(String id, String pw, String name, String email, String gender, int age, int user_number);
	
	MemberDTO myinfo_main(String loginid);
	
	MemberDTO myinfo_modify(String id);
	

	
	void update_info(String id, String pw, String email, String gender, int age, String name);
	
	void info_update1(String id, String pw, String email, int age, String gender);
	
	void info_update2(String id, String email, int age, String gender);
	
	String admincheck(String admin_pw);
	
	void member_modify(String pw, String name, String email, String gender, int age, String id);
	
	void update_no_pw(String email, String gender, int age, String name, String id);
	   
	String verify_Password(String loginid);
	
	void quit_member(String loginid);

	void insertbbti(String bbti, String id);

	Integer bbticheck(String id);

	void membersavebbti(String id, String pw, String name, String email, String gender, int age, String bbti);

	ArrayList<AllBoardDTO> my_review(@Param("start") int start, 
									@Param("end") int end, 
									@Param("loginid") String loginid);

	ArrayList<InquireDTO> my_inquire(@Param("start") int start, 
									@Param("end") int end, 
									@Param("loginid") String loginid);

	int my_review_total(String loginid);

	int inquire_total(String loginid);

	ArrayList<InquireDTO2> inquire_best3();

	ArrayList<AllBoardDTO> my_favorite(String loginid);

	String havebbti(String id);

	int bookmark_total(String loginid);


	

}