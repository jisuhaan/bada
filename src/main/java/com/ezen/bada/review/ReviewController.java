package com.ezen.bada.review;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

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
	public String review1(HttpServletRequest request, Model mo) {

		String loginid = (String) request.getSession().getAttribute("loginid");
		Service ss = sqlsession.getMapper(Service.class);
		MemberDTO dto = ss.input_info(loginid);
		List<BeachDTO> beachList = ss.getBeachList();
		
		mo.addAttribute("dto", dto);
		mo.addAttribute("beachList", beachList);
		
		return "review_input";
	}
	


}
