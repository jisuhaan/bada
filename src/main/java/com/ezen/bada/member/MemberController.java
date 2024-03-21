package com.ezen.bada.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;



@Controller
public class MemberController {

	@Autowired
	SqlSession sqlsession;
	
	@RequestMapping(value = "/member_join")
	public String member1() {
		
		return "member_join";
	}
	
	
	
	@RequestMapping(value = "/login")
	public String login1() {
		
		return "login";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/login_save", method = RequestMethod.POST)
	public String login2(HttpServletRequest request, HttpServletResponse response) {
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		Service ss = sqlsession.getMapper(Service.class);
		String logincount = ss.login_check(id,pw);
		
		System.out.println("로그인 시도 아이디 : "+id);
		System.out.println("로그인 시도 비번 : "+pw);
		System.out.println("로그인 결과 : "+logincount);
		
		
		String result = "";
		
		if(logincount==null) {
			result = "no";
		}
		else {
			
			HttpSession hs = request.getSession();
			hs.setAttribute("loginstate", true);
			hs.setAttribute("loginid", id);
			hs.setAttribute("pw", pw);
			hs.setAttribute("position", logincount);
			hs.setMaxInactiveInterval(600);
			result = "yes";
		}
	
		System.out.println("결과 : "+result);
		
		return result;
	}
	
	
}
