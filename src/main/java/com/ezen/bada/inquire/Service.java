package com.ezen.bada.inquire;


import java.util.ArrayList;

import com.ezen.bada.member.MemberDTO;

public interface Service {

	MemberDTO input_info(String loginid);

	void inquire_save(String title, String category, String name, String id, String pic1, String pic2, String pic3,
			String pic4, String pic5, String content, String secret, String secret_pw);

	int inquire_list_total();

	ArrayList<InquireDTO> page_inquire_listout(PageDTO dto);

	InquireDTO inquire_detail(String inquire_num);


	int inquire_list_total_search(String search_keyword, String search_value, String category, String i_date);

	ArrayList<InquireDTO> page_inquire_listout_search(String search_keyword, String search_value, String category, String i_date,
			int start, int end);

}
