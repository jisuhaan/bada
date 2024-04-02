package com.ezen.bada.review;

import java.io.File;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ezen.bada.member.MemberDTO;


@Controller
public class ReviewController {
	
	@Autowired
	SqlSession sqlsession;
	
	String image_path="C:\\이젠디지털12\\spring\\bada\\src\\main\\webapp\\resources\\image_user";
	
	@RequestMapping(value = "review_input")
	public String review1(HttpServletRequest request, Model mo, HttpServletResponse response) throws IOException {

	    String loginid = (String) request.getSession().getAttribute("loginid");
	    if (loginid == null) {
	        response.setContentType("text/html; charset=UTF-8");
	        PrintWriter out = response.getWriter();
	        out.println("<script>alert('로그인한 회원만 이용 가능합니다.'); location.href='login';</script>");
	        out.flush();
	        
	        return null; 
	    }
	   
	    Service ss = sqlsession.getMapper(Service.class);
	    MemberDTO dto = ss.input_info(loginid);
	    List<BeachDTO> beachList = ss.getBeachList();
	    
	    mo.addAttribute("dto", dto);
	    mo.addAttribute("beachList", beachList);
	    
	    return "review_input";
	}
	
	
	@RequestMapping(value = "review_save", method = RequestMethod.POST)
	public String review2(MultipartHttpServletRequest mul) throws IOException {

		String id = mul.getParameter("id");
		System.out.println("확인1 : "+id);
		String name = mul.getParameter("name");
		System.out.println("확인2 : "+name);
		String visit_day = mul.getParameter("visit_day");
		System.out.println("확인3 : "+visit_day);
		String beach_code = mul.getParameter("beach");
		System.out.println("확인4 : "+beach_code);
		String review_title = mul.getParameter("review_title");
		System.out.println("확인5 : "+review_title);
		String review_contents = mul.getParameter("review_contents");
		System.out.println("확인6 : "+review_contents);
		String review_score = mul.getParameter("review_score");
		System.out.println("확인7 : "+review_score);
		String hashtags = mul.getParameter("hashtags");
		System.out.println("확인8 : "+hashtags);
		String re_visit = mul.getParameter("re_visit");
		System.out.println("확인9 : "+re_visit);
		
		List<MultipartFile> files = mul.getFiles("gallery");
		System.out.println("이미지파일 확인 : "+files);

		System.out.println("비어있니?  "+files.size());
		String[] filePaths = new String[5];
		
	    for (int i = 0; i < files.size(); i++) {
	        MultipartFile file = files.get(i);
	        
	        System.out.println("제발 도와줘 : "+file);
	       
	        String file_name =  file.getOriginalFilename();
   
	        System.out.println("파일이름 : " + file_name);
	        
	        String save_path = image_path + File.separator + System.currentTimeMillis() + "_" + file_name;
	        
	        System.out.println("나눠지나? : " + save_path);
	        File destFile = new File(save_path);
	           
	        file.transferTo(destFile);

	        filePaths[i] = save_path; // 실제 저장된 파일 경로 저장

	    }

	    return "main";

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
