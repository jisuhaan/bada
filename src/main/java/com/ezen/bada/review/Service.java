package com.ezen.bada.review;

import java.util.List;

import com.ezen.bada.member.MemberDTO;

public interface Service {

	MemberDTO input_info(String loginid);

	List<BeachDTO> getBeachList();

}
