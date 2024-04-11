package com.ezen.bada.inquire;


import java.util.ArrayList;
import java.util.Map;

import com.ezen.bada.member.MemberDTO;

public interface Service {

	MemberDTO input_info(String loginid);

	void inquire_save(String title, String category, String name, String id, String pic1, String pic2, String pic3,
			String pic4, String pic5, String content, String secret, String secret_pw);

	int inquire_list_total();

	ArrayList<InquireDTO> page_inquire_listout(PageDTO dto);

	ArrayList<InquireDTO> inquire_search_out1(String keyword, String value);

	ArrayList<InquireDTO> inquire_search_out2(String keyword, String value, String i_date);

	ArrayList<InquireDTO> inquire_search_out3(String keyword, String value, String category);

	ArrayList<InquireDTO> inquire_search_out4(String keyword, String value, String category, String i_date);
	

	InquireDTO inquire_detail(int inquire_num);

	void inquire_updatecnt(int inquire_num);

	int inquire_rec_id(int inquire_num, String loginid);
	
	void inquire_recommand(String loginid, int inquire_num);


	String inquire_ban_check(String id, int ban_inquire_num, String category, String content);
	
	void inquire_ban_save(String title, String name, String id, int ban_inquire_num, String ban_name, String ban_id,
			String category, String content);

	void inquire_reply_save(int inquire_num, String content, int inquire_num2);

	ArrayList<Inquire_reply_DTO> inquire_reply_out(int inquire_num);

	int inquire_reply_count(int inquire_num);

	void inquire_reply_check(int inquire_num);

	InquireDTO all_photo(int inquire_num);

	void inquire_delete(int inquire_num);

	InquireDTO inquire_modify_view(int inquire_num);

	void update_photo(Map<String, Object> params);

	void inquire_modify_save(String title, String category, String content, String secret, String secret_pw,
			int inquire_num);

	void inquire_reply_delete(int inquire_reply_num);

	void inquire_reply_modify(String newcontent, int inquire_reply_num);

	void inquire_reply_delete_when_inquire_delete(int inquire_num);


	
	

}
