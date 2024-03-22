package com.ezen.bada.member;

public interface Service {

	String login_check(String id, String pw);

	String idcheck(String id);

	void membersave(String id, String pw, String name, String email, String gender, String age);

}
