package com.ezen.bada.weathers;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class WeatherController {
	
	@Autowired
	SqlSession sqlsession;
	

	@RequestMapping(value = "/sea_info")
	public String weather1(Model model) {
		Bada_list_DTO weatherData = fetchWeatherData();
        // 가져온 날씨 정보를 모델에 추가하여 JSP로 전달
        model.addAttribute("weatherData", weatherData);
		return "sea_info";
	}


	private Bada_list_DTO fetchWeatherData() {
		// TODO Auto-generated method stub
		return null;
	}

}
