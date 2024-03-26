package com.ezen.bada.weathers;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class WeatherController {
	
	@Autowired
	SqlSession sqlsession;
	
	
	@RequestMapping(value = "/sea_info")
	public String weather1() {
		
		return "sea_info";
	}

}
