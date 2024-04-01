package com.ezen.bada.suggest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class SuggestController {
	
	
	@RequestMapping(value = "suggest_input")
	public String suggest_input() {

		
		return "suggest_input";
	}

}
