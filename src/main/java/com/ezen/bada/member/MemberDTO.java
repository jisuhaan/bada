package com.ezen.bada.member;

public class MemberDTO {
	
	int user_number;
	String id, pw, role, name, email, gender, age;
	
	public MemberDTO() {}
	
	public MemberDTO(int user_number, String id, String pw, String role, String name, String email, String gender,
			String age) {
		super();
		this.user_number = user_number;
		this.id = id;
		this.pw = pw;
		this.role = role;
		this.name = name;
		this.email = email;
		this.gender = gender;
		this.age = age;
		}
	
	public int getUser_number() {
		return user_number;
	}
	public void setUser_number(int user_number) {
		this.user_number = user_number;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	
}
