package com.ezen.bada;


import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
