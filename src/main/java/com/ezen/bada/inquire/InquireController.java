package com.ezen.bada.inquire;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ezen.bada.member.MemberDTO;

@Controller
public class InquireController {
	
	
	@Autowired
	SqlSession sqlsession;
	   
	
	String imagepath="C:\\이젠디지탈12\\spring\\bada\\src\\main\\webapp\\resources\\image_user";
	String origin_img;
	
	
	
	@RequestMapping(value = "/inquire_input")
	public String inquireinput(HttpServletRequest request, Model mo, HttpServletResponse response) throws IOException {
	      
		Service ss = sqlsession.getMapper(Service.class);
		HttpSession hs = request.getSession();
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if (hs.getAttribute("loginstate") == null) {
		    out.print("<script type='text/javascript'> alert('로그인이 필요합니다.');");
		    out.print("window.location.href='login';");
		    out.print("</script>");
		    out.flush();
		    
		    return null;
		}
		else {
			
			boolean loginstate = (boolean) hs.getAttribute("loginstate");
			
			if(loginstate) {
				
				String loginid = (String) hs.getAttribute("loginid");
				MemberDTO dto = ss.input_info(loginid);
				    
				mo.addAttribute("dto", dto);
				
				return "inquire_input";
				
			}
			
			else {
			
				out.println("<script>alert('로그인한 회원만 이용 가능합니다.'); location.href='login';</script>");
			    out.flush();
			    
			    return null;
				
			}
	     
	    }

	}
	
	
	@RequestMapping(value = "/inquire_save", method = RequestMethod.POST)
	public String inquiresave(MultipartHttpServletRequest mul) throws IOException {
	    
	    String title = mul.getParameter("title");
	    String category = mul.getParameter("category");
	    String name = mul.getParameter("name");
	    String id = mul.getParameter("id");
	    // 작성 일자는 DB에서 지정
	    String pic1=null, pic2=null, pic3=null, pic4=null, pic5=null;
		String content = mul.getParameter("content");
		String secret = mul.getParameter("secret");
		String secret_pw = mul.getParameter("secret_pw");
		
		MultipartFile mf1=mul.getFile("pic1");
		if(mf1 != null) {
			pic1=mf1.getOriginalFilename();
			pic1=filesave1(pic1, mf1.getBytes());
			}
		else {pic1="nope";}
		
		MultipartFile mf2=mul.getFile("pic2");
		if(mf2 != null) {
			pic2=mf2.getOriginalFilename();
			pic2=filesave2(pic2, mf2.getBytes());
			}
		else {pic2="nope";}
		
		MultipartFile mf3=mul.getFile("pic3");
		if(mf3 != null) {
			pic3=mf3.getOriginalFilename();
			pic3=filesave3(pic3, mf3.getBytes());
			}
		else {pic3="nope";}
		
		MultipartFile mf4=mul.getFile("pic4");
		if(mf4 != null) {
			pic4=mf4.getOriginalFilename();
			pic4=filesave4(pic4, mf4.getBytes());
			}
		else {pic4="nope";}
		
		MultipartFile mf5=mul.getFile("pic5");
		if(mf5 != null) {
			pic5=mf5.getOriginalFilename();
			pic5=filesave5(pic5, mf5.getBytes());
			}
		else {pic5="nope";}
	    
		System.out.println("각종 정보: "+title+category+name+id+content+secret+secret_pw);
	    System.out.println("첫 번째 사진:" + pic1);
	    System.out.println("두 번째 사진:" + pic2);
	    System.out.println("세 번째 사진:" + pic3);
	    System.out.println("네 번째 사진:" + pic4);
	    System.out.println("다섯 번째 사진:" + pic5);
	    
	    if(secret.equals("n")) {secret_pw="free";}

	    Service ss = sqlsession.getMapper(Service.class);
	    ss.inquire_save(title, category, name, id, pic1, pic2, pic3, pic4, pic5, content, secret, secret_pw);

	    return "main";
	}
	private String filesave5(String pic5, byte[] bytes) throws IOException {
		UUID ud=UUID.randomUUID();
		String what5=ud.toString()+"_"+pic5;
		File filename=new File(imagepath+"\\"+what5);
		FileCopyUtils.copy(bytes, filename);
		
		return what5;
	}
	private String filesave4(String pic4, byte[] bytes) throws IOException {
		UUID ud=UUID.randomUUID();
		String what4=ud.toString()+"_"+pic4;
		File filename=new File(imagepath+"\\"+what4);
		FileCopyUtils.copy(bytes, filename);
		
		return what4;
	}
	private String filesave3(String pic3, byte[] bytes) throws IOException {
		UUID ud=UUID.randomUUID();
		String what3=ud.toString()+"_"+pic3;
		File filename=new File(imagepath+"\\"+what3);
		FileCopyUtils.copy(bytes, filename);
		
		return what3;
	}
	private String filesave2(String pic2, byte[] bytes) throws IOException {
		UUID ud=UUID.randomUUID();
		String what2=ud.toString()+"_"+pic2;
		File filename=new File(imagepath+"\\"+what2);
		FileCopyUtils.copy(bytes, filename);
		
		return what2;
	}
	private String filesave1(String pic1, byte[] bytes) throws IOException {
		UUID ud=UUID.randomUUID();
		String what1=ud.toString()+"_"+pic1;
		File filename=new File(imagepath+"\\"+what1);
		FileCopyUtils.copy(bytes, filename);
		
		return what1;
	}


	
	
	
	
}
