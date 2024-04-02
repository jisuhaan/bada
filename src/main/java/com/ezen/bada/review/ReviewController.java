package com.ezen.bada.review;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ezen.bada.member.MemberDTO;


@Controller
public class ReviewController {
	
	@Autowired
	SqlSession sqlsession;
	
	@RequestMapping(value = "review_input")
	public String review1(HttpServletRequest request, HttpServletResponse response, Model mo) throws IOException {
		
		HttpSession hs = request.getSession();
		
		boolean loginstate = (boolean)hs.getAttribute("loginstate");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if(loginstate) {
			
			String loginid = (String) hs.getAttribute("loginid");
			Service ss = sqlsession.getMapper(Service.class);
			MemberDTO dto = ss.input_info(loginid);
			List<BeachDTO> beachList = ss.getBeachList();
			
			mo.addAttribute("dto", dto);
			mo.addAttribute("beachList", beachList);
			
			return "review_input";
			
		}
		
		else {
			
		    out.print("<script type='text/javascript'> alert('로그인이 필요합니다.');");
		    out.print("window.location.href='login';");
		    out.print("</script>");
			
			return null;
		}
		
		
	}
	
	@RequestMapping(value = "review_input2")
	public String review2(HttpServletRequest request, HttpServletResponse response, Model mo) throws IOException {
		
		HttpSession hs = request.getSession();
		
		boolean loginstate = (boolean)hs.getAttribute("loginstate");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if(loginstate) {
			
			String loginid = (String) hs.getAttribute("loginid");
			Service ss = sqlsession.getMapper(Service.class);
			MemberDTO dto = ss.input_info(loginid);
			List<BeachDTO> beachList = ss.getBeachList();
			
			mo.addAttribute("dto", dto);
			mo.addAttribute("beachList", beachList);
			
			return "review_input2";
			
		}
		
		else {
			
		    out.print("<script type='text/javascript'> alert('로그인이 필요합니다.');");
		    out.print("window.location.href='login';");
		    out.print("</script>");
			
			return null;
		}
		
		
	}
	


}
