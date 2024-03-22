package com.ezen.bada.member;

import java.util.ArrayList;

public interface Service {

	String login_check(String id, String pw);

	String idcheck(String id);

	void membersave(String id, String pw, String name, String email, String gender, String age);

	ArrayList<MemberDTO> memberout();

}
