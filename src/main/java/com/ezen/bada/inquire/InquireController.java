package com.ezen.bada.inquire;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class InquireController {
	
	
	@Autowired
	SqlSession sqlsession;
	   
	@RequestMapping(value = "/inquire_input")
	public String inquireinput() {
	      
		return "inquire_input";
	}
	

}