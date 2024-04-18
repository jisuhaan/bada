package com.ezen.bada.inquire;


import java.util.ArrayList;
import java.util.Map;

import com.ezen.bada.member.MemberDTO;

public interface Service {

	
	//문의 입력창에 정보 띄우기
	MemberDTO input_info(String loginid);
	
	//문의 입력 시 저장
	void inquire_save(String title, String category, String name, String id, String pic1, String pic2, String pic3,
			String pic4, String pic5, String content, String secret, String secret_pw);
	
	//문의 출력 시 페이징 처리를 위한 총 레코드 갯수 세기
	int inquire_list_total();
	//문의 출력 시 페이징 처리와 리스트 아웃
	ArrayList<InquireDTO> page_inquire_listout_latest(PageDTO dto);
	ArrayList<InquireDTO> page_inquire_listout_popular(PageDTO dto);
	
	//문의 리스트 출력 시 추천순 top3 출력
	ArrayList<InquireDTO2> inquire_best3();
	
	//문의 디테일 출력
	InquireDTO inquire_detail(int inquire_num);
	
	//문의 디테일 열람 시 조회수 증가 메소드
	void inquire_updatecnt(int inquire_num);

	
	//문의 검색의 늪
	ArrayList<InquireDTO> inquire_search_out1(String keyword, String value);
	ArrayList<InquireDTO> inquire_search_out2(String keyword, String value, String i_date);
	ArrayList<InquireDTO> inquire_search_out3(String keyword, String value, String category);
	ArrayList<InquireDTO> inquire_search_out4(String keyword, String value, String category, String i_date);
	
	
	//문의글에 올린 이미지 정보를 가져옴
	InquireDTO all_photo(int inquire_num);

	//문의글을 삭제하는 경우
	void inquire_delete(int inquire_num);
	
	//문의글을 삭제 시 문의글에 달린 답변도 함께 자동 삭제
	void inquire_reply_delete_when_inquire_delete(int inquire_num);

	
	//문의글을 수정하기 위해 수정창을 띄움
	InquireDTO inquire_modify_view(int inquire_num);
	
	//문의글 수정 시 이미지가 수정되면 이미지를 새로 저장
	void update_photo(Map<String, Object> params);
	
	//수정된 문의글을 저장
	void inquire_modify_save(String title, String category, String content, String secret, String secret_pw,
			int inquire_num);
	
	
	//문의에 답변 시 답변 정보를 저장
	void inquire_reply_save(int inquire_num, String content, int inquire_num2);
	
	//문의에 대한 답변을 출력
	ArrayList<Inquire_reply_DTO> inquire_reply_out(int inquire_num);
	
	//문의 답변 갯수를 셈
	int inquire_reply_count(int inquire_num);
	
	//문의 답변 갯수를 반영해 답변 여부를 반영
	void inquire_reply_check(int inquire_num);

	
	//문의글에 달린 답변을 삭제
	void inquire_reply_delete(int inquire_reply_num);

	
	//문의글에 달린 답변을 수정
	void inquire_reply_modify(String newcontent, int inquire_reply_num);
	
	
	//문의 추천 시 추천인 아이디가 중복되었는지 검사
	int inquire_rec_id(int inquire_num, String loginid);
	
	//문의 추천 시 추천인 아이디를 저장
	void inquire_recommand(String loginid, int inquire_num);
	
	
	//신고된 대상의 유저 넘버 가져오기
	int ban_user_number(String ban_id);
	
	//신고 시 신고가 중복인지 확인
	String inquire_ban_check(String id, int ban_inquire_num, String category, String content);
	
	//신고 정보를 저장
	void inquire_ban_save(String title, String name, String id, int ban_inquire_num, String ban_name, String ban_id,
	String category, String content, int ban_user_number);
	
	//페이징 처리를 위해 문의 신고 내역 레코드 갯수 파악
	int inquire_ban_list_total();
	//페이징 처리를 위해 문의 신고 내역 데이터 가져옴
	ArrayList<Inquire_ban_DTO> page_inquire_ban_listout(PageDTO dto);
	
	//신고된 상세내역을 조회
	Inquire_ban_DTO inquire_ban_detail(int i_banned_num);
	
	//상세내역의 신고된 아이디와 같은 정보를 가진 레코드를 갯수를 세 옴
	int inquire_ban_count(String ban_id);
	
	//상세내역의 신고된 아이디와 같은 정보를 가진 레코드를 가져옴
	ArrayList<Inquire_ban_DTO2> inquire_dan_list2(String ban_id);

	
	//신고된 내역 삭제
	void inquire_ban_delete(int i_banned_num);

	
	//1:1 문의 입력창에 정보 띄우기
	MemberDTO inquire_personal_view(String loginid);
	
	//1:1 문의 저장하기
	void inquire_personal_save(String title, String name, String id, String email, String category, String content,
			String pic1, String pic2, String pic3, String pic4, String pic5);
	
	//1:1 문의 페이징을 위한 레코드 갯수 세기
	int inquire_list_total_personal();
	//1:1 문의 페이징
	ArrayList<Inquire_personal_DTO> inquire_personal_out_page(PageDTO dto);

	//1:1 문의 디테일 출력
	Inquire_personal_DTO inquire_personal_detail(int ip_num);

	
	
	//1:1 문의 내역 삭제
	void inquire_personal_delete(int ip_num);
	
	//1:1문의 내역을 삭제할 시 거기에 달린 답 데이터도 함께 삭제
	void inquire_personal_reply_delete(int ip_num);
	
	//1:1 문의 내역 삭제 시 거기에 포함된 사진을 확인
	Inquire_personal_DTO personal_all_photo(int ip_num);
	
	

	//1:1 문의에 답변을 작성할 시 저장
	void inquire_personal_reply_save(String reply, int ip_num);

	//1:1 문의에 답변이 몇 개가 달렸는지 세 봄
	int inquire_personal_reply_count(int ip_num);
	
	//1:1 문의에 답변이 1개 이상일 시 답변 여부가 바뀜
	void inquire_personal_tf_update(int ip_num);
  
  //1:1 문의에 보낸 답을 댓글 형식으로 출력
	ArrayList<Inquire_personal_reply_DTO> inquire_personal_reply_out(int ip_num);

	// 공지사항
	ArrayList<Notice_DTO> notice();

	// 이벤트
	ArrayList<Event_DTO> event();
	

}
