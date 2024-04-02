package com.ezen.bada.inquire;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

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
	public String inquireinput() {
	      
		return "inquire_input";
	}
	
	
	@RequestMapping(value = "/inquire_save", method = RequestMethod.POST)
	public String inquiresave(MultipartHttpServletRequest mul) throws IOException {
	    
	    String title = mul.getParameter("title");
	    String category = mul.getParameter("category");
	    String name = mul.getParameter("name");
	    String id = mul.getParameter("id");
	    // 작성 일자는 DB에서 지정
		String content = mul.getParameter("content");
		String secret = mul.getParameter("secret");
		String secret_pw = mul.getParameter("secret_pw");
		
		MultipartFile mf=mul.getFile("pic1");
		//String pic1
	    
	    //System.out.println("첫 번째 사진:" + pic1);
	    //System.out.println("두 번째 사진:" + pic2);
	    //System.out.println("세 번째 사진:" + pic3);
	    //System.out.println("네 번째 사진:" + pic4);
	    //System.out.println("다섯 번째 사진:" + pic5);

	    Service ss = sqlsession.getMapper(Service.class);
	    //ss.inquire_save(title, category, name, id, pic1, pic2, pic3, pic4, pic5, content, secret, secret_pw);

	    return "main";
	}


}
