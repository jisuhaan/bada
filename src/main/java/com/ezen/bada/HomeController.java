package com.ezen.bada;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ezen.bada.review.Service;

@Controller
public class HomeController {
	

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home1() {

		
		return "main";
	}
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String home2() {


		return "main";
	}
	
	
}
